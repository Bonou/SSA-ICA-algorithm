%----------------------------------------------------------------
% Program: SSA-ICA.m
% Author: Pinjun Zheng
% Date: 2020-04-01
% Description: This is a demo of SSA-ICA algorithm.
% Revision / Filing Date / Modified By / Modified Content
% V1.0 / 2020-04-01 / Pinjun Zheng / Create the program.
% V2.0 / 2020-04-03 / Pinjun Zheng / Change to the form of calling a sub-function
%----------------------------------------------------------------
clc
clear all
%% --------------------------------- Set Parameters
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

%% --------------------------------- Call SSA-ICA algorithm
M = 200;
Sest = SSA_ICA(Yobs,Ns,M);

%% ---------------------------------  Show results
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

