function [Sest] = Fast_ICA(Xobs,C)
%% Preprocessing, Centering
SX = size(Xobs);
N = SX(1);
M = SX(2);

X = Xobs';                                  %X is the transpose of the matrix of M samples of N mixtures, used in subsequent calculations

Xmean = mean(X);                            %Xmean is the mean vector of the matrix X

for i = 1:N
    X(:,i) = X(:,i) - Xmean(i);             %The matrix X is centered by subtracting each of the N mixtures by their corresponding sample averages
end

%% Preprocessing, Whitening

ExxT    = cov(X);                           %The covariance matrix of X is computed and stored in ExxT
[E,D]   = eig(ExxT);                        %Eigenvalue decomposition is applied on the covariance matrix of X, ExxT

Z = E*1/sqrt(D)*E'*X';                      %The matrix X is whitened to Z

%% FastICA algorithm

W = 0.5*ones(C,N);                          %Initializing W, a matrix consisting of columns corresponding with the inverse of the (transformed) mixing Amix

iterations = 100;                           %The amount of iterations used in the fastICA algorithm

for p = 1:C
    
wp = ones(N,1)*0.5;
wp = wp / sqrt(wp'*wp);

    for i = 1:iterations
        
        G       = tanh(wp'*Z);
        Gder    = 1-tanh(wp'*Z).^2;
        
        wp      = 1/M*Z*G' - 1/M*Gder*ones(M,1)*wp;
        
        dumsum  = zeros(C,1);
        
        for j = 1:p-1
            dumsum = dumsum + wp'*W(:,j)*W(:,j);
        end
        
        wp      = wp - dumsum;        
        wp      = wp / sqrt(wp'*wp);
    end
    
    W(:,p) = wp; 
end

%% Output Results
W = W/sqrt(2);    %The factor sqrt(2) is an emirical constant added to make the predictions fit the data properly. The source of the factor has yet to be determined.
Sest = W'*Z;
end

