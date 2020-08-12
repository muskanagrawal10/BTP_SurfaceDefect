imshow('E:\BTP_4thSEM\apple_with_a_gap.jpg');
e = imellipse;
mask = createMask(e);
% ------------------------------------------------------------------
i= imread('E:\BTP_4thSEM\apple_with_a_gap.jpg');
input = rgb2gray(i);
% ------------------------------------------------------------------
tol           = 1e-5;
maxiter       = 50;
dt            = 0.1;
param.M       = 40; % number of steps of the inpainting procedure;
param.N       = 2;  % number of steps of the anisotropic diffusion;
param.eps     = 1e-10;
% ------------------------------------------------------------------
[M,N,C] = size(input);
u       = reshape(input,M*N,C);

% GRID INTERVAL FOR AXIS ij
h1 = 1; h2 = 1;

% FORWARD AND BACKWARD
d1i_forward  = spdiags([-ones(M,1),ones(M,1)],[0,1],M,M)/h1;
d1j_forward  = spdiags([-ones(N,1),ones(N,1)],[0,1],N,N)/h2;
d1i_backward = spdiags([-ones(M,1),ones(M,1)],[-1,0],M,M)/h1;
d1j_backward = spdiags([-ones(N,1),ones(N,1)],[-1,0],N,N)/h2;

% FOR BOUNDARY CONDITIONS
d1i_forward(end,:) = 0;
d1j_forward(end,:) = 0;
d1i_backward(1,:)  = 0;
d1j_backward(1,:)  = 0;

matrices.Dif  = kron(speye(N),d1i_forward);
matrices.Djf  = kron(d1j_forward,speye(M));
matrices.Dib  = kron(speye(N),d1i_backward);
matrices.Djb  = kron(d1j_backward,speye(M));

% CENTERED
d1i_centered  = spdiags([-ones(M,1),ones(M,1)],[-1,1],M,M)/(2*h1);
d1j_centered  = spdiags([-ones(N,1),ones(N,1)],[-1,1],N,N)/(2*h2);
% border not taken into account
d1i_centered([1 end],:) = 0;
d1j_centered([1 end],:) = 0;
matrices.Dic  = kron(speye(N),d1i_centered);
matrices.Djc  = kron(d1j_centered,speye(M));

d2i = toeplitz(sparse([1,1],[1,2],[-2,1],1,M))/h1^2;
d2j = toeplitz(sparse([1,1],[1,2],[-2,1],1,N))/h2^2;
% PERIODIC BOUNDARY CONDITIONS
d2i(1,end) = 1/h1^2;
d2i(end,1) = 1/h1^2;
d2j(end,1) = 1/h2^2;
d2j(1,end) = 1/h2^2;
matrices.L = (kron(speye(N),d2i)+kron(d2j,speye(M)));

% LAPLACIAN second derivatives with other bc
d2i = toeplitz(sparse([1,1],[1,2],[-2,1],1,M))/h1^2;
d2j = toeplitz(sparse([1,1],[1,2],[-2,1],1,N))/h2^2;
d2i([1 end],:) = 0;
d2j([1 end],:) = 0;
matrices.M2i = kron(speye(N),d2i);
matrices.M2j = kron(d2j,speye(M));
matrices.M2ij = matrices.Djc*matrices.Dic;

clear d1i_forward d1j_forward
clear d1i_backward d1j_backward
clear d1i_centered d1j_centered
clear d2i d2j

SE           = strel('ball',6,0,0);
maskeps      = 1-mask;
lambdaeps    = reshape(imdilate(maskeps,SE)-maskeps,M*N,C);
channel_mask = reshape(mask,M*N,C);
maskeps      = reshape(maskeps,M*N,C);
geps         = maskeps;

Dlap   = zeros(M*N,2);
normal = zeros(M*N,2);



% FOR EACH COLOR CHANNEL
for c = 1:C
    
    % just interpolate g_{epsilon} with a few steps of linear diffusion within the strip
    for t = 1:5
        geps(:,c) = geps(:,c) + dt*(matrices.L*geps(:,c)) + lambdaeps(:,c).*(maskeps(:,c)-geps(:,c));
    end
    
    % ANISOTROPIC DIFFUSION PREPROCESSING STEP
    for i=1:N
    ux  = matrices.Dic*u;
    uy  = matrices.Djc*u;
    uxx = matrices.M2i*u;
    uyy = matrices.M2j*u;
    uxy = matrices.M2ij*u;
    
    squared_normgrad = ux.^2 + uy.^2 + eps;
    u = u + dt*geps.*(uyy.*ux.^2 + uxx.* uy.^2 - 2*ux.*uy.*uxy)./squared_normgrad;
    end
    
    % ITERATION
    for iter = 1:maxiter
        
        % param.M steps of the inpainting procedure:
        for m=1:param.M
            lap         = matrices.L*u(:,c);
            Dlap(:,1)   = matrices.Dic*lap;
            Dlap(:,2)   = matrices.Djc*lap;
            normal(:,1) = matrices.Dic*u(:,c);
            normal(:,2) = matrices.Djc*u(:,c);
            
            normal  = bsxfun(@rdivide,normal,sqrt(sum(normal.^2,2) + param.eps));
            
            beta    = Dlap(:,1).*(-normal(:,2)) + Dlap(:,2).*normal(:,1) ;
            betapos = (beta>0);
            
            uxf = matrices.Dif*u(:,c);
            uxb = matrices.Dib*u(:,c);
            uyf = matrices.Djf*u(:,c);
            uyb = matrices.Djb*u(:,c);
            
            slopelim = betapos .* sqrt(min(uxb,0).^2 + max(uxf,0).^2 + min(uyb,0).^2 + max(uyf,0).^2)...
                + (~betapos) .* sqrt(max(uxb,0).^2 + min(uxf,0).^2 + max(uyb,0).^2 + min(uyf,0).^2);
            
            update = beta .* slopelim;
            
            % OPTIONAL:
            % Nonlinear scaling of the equation proposed by Bertalmio in 
            % his thesis. It might cause instabilities when choosing dt 
            % too large.
            %         signo = sign(update);
            %         update = signo.*sqrt(sqrt(signo.*update));
            
            % UPADTE ONLY PIXELS INSIDE THE INPAINTING DOMAIN (BY MASK)
            u(:,c) = u(:,c) + dt * ~channel_mask(:,c).*update;
        end
        
        % param.N steps of anisotropic diffusion
        for i=1:N
    ux  = matrices.Dic*u;
    uy  = matrices.Djc*u;
    uxx = matrices.M2i*u;
    uyy = matrices.M2j*u;
    uxy = matrices.M2ij*u;
    
    squared_normgrad = ux.^2 + uy.^2 + eps;
    un = u + dt*geps.*(uyy.*ux.^2 + uxx.* uy.^2 - 2*ux.*uy.*uxy)./squared_normgrad;
        end
        
        diff = norm(un-u(:,c))/norm(un);
        
        % UPDATE
        u(:,c) = ~channel_mask(:,c).*un + channel_mask(:,c).*u(:,c);
         
        % TEST EXIT CONDITION
        if diff<tol
            break
        end
        
    end
    
end

u = reshape(u,M,N,C);

imshow(u);
imwrite(u,'E:\BTP_4thSEM\amle_output.png');

