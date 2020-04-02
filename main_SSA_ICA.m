%----------------------------------------------------------------
% Program: SSA-ICA.m
% Author: Pinjun Zheng
% Date: 2020-04-01
% Description: This is a demo of SSA-ICA algorithm.
% Revision / Filing Date / Modified By / Modified Content
% V1.0 / 2020-04-01 / Pinjun Zheng / Create the program
%----------------------------------------------------------------
clc
clear all
%% --------------------------------- set Parameters
N = 1;                              %The number of observed mixtures
Ns = 2;                             %The number of independent sources
Ls = 1000;                          %Sample size, i.e.: number of observations
finalTime = 40*pi;                  %Final sample time (s)
initialTime = 0;                    %Initial sample time (s)

%% --------------------------------- Generating Data for SSA-ICA
Amix = rand(N,Ns);                      %Amix is a random N x Ns mixing matrix
timeVector = initialTime:(finalTime-initialTime)/(Ls-1):finalTime;  %Vector of time coordinates
source1 = sin(1.1*timeVector);          %Independent source component 1, sin(a * t)
source2 = cos(0.25*timeVector);         %Independent source component 2, cos(b * t)
S = [source1;source2];                  %Source Matrix

figure
plot(timeVector,source1)                    %Plotting the N independent sources vs. time
xlabel('time (s)')
ylabel('Signal Amplitude') 
legend('source 1')

figure
plot(timeVector,source2)                    %Plotting the N independent sources vs. time
xlabel('time (s)')
ylabel('Signal Amplitude') 
legend('source 2')

Yobs = Amix*S;                              %Matrix consisting of M samples of N observed mixtures

figure
plot(timeVector,Yobs)                       %Plotting the observed signal vs. time
xlabel('time (s)')
ylabel('Signal Amplitude') 
legend('observed signal')
%% --------------------------------- SSA
% Decomposition
M = 10;
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
p = input('How much in the first group£º');
Y1 = zeros(M,L);
Y2 = Y1;
for j = 1:p
    Y1 = Y1 + Ysub(:,:,j);
end
for k = p+1:M
   Y2 = Y2 + Ysub(:,:,k);
end
% Diagonal average
R1 = diag_average(Y1);
R2 = diag_average(Y2);
Xobs = [R1;R2];
%% --------------------------------- call FastICA algorithm
[Sest] = Fast_ICA(Xobs,Ns);
%% ---------------------------------  show
figure
plot(timeVector, Sest(1,:))
xlabel('time (s)') 
ylabel('Signal Amplitude') 
legend('Source Estimation 1')

figure
plot(timeVector, Sest(2,:))
xlabel('time (s)') 
ylabel('Signal Amplitude') 
legend('Source Estimation 2')

