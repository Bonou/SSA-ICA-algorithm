function Sest = SSA_ICA(Yobs,Ns,M)
%% --------------------------------- SSA
% Decomposition
L = length(Yobs)-M+1;
Y = hankel(Yobs(1:M),Yobs(M:end));
C = Y*Y';
[eVector,eValue] = eig(C);
eValue = diag(eValue);     
[Bv,Iv]=sort(eValue,'descend');
Ysub = zeros(M,L,M);
for i = 1:M
    Ysub(:,:,i) = eVector(:,Iv(i))*(eVector(:,Iv(i)))'*Y;
end
% Rebuild by grouping
Bv
p = input('How many of the first group: ');
Y1 = zeros(M,L);
Y2 = Y1;
for j = 1:p
    Y1 = Y1 + Ysub(:,:,j);
end
for k = p+1:M
   Y2 = Y2 + Ysub(:,:,k);
end
% Diagonal average
R1 = A02_diag_average(Y1);
R2 = A02_diag_average(Y2);
Xobs = [R1;R2];
%% --------------------------------- call FastICA algorithm
Sest = A01_Fast_ICA(Xobs,Ns);
end

