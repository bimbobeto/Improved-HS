function [ ]=initialize( )
% Initializes the parameters for both the algorithm
% and the specific problem

global Vars; global R_accept; global R_pa; global Harmonies;
global MaxImprovisations; global Range; global Evaluations; 
global Bw; global Restric; global A; global R_ia;

    Vars=8;
    Restric=7;
    R_accept=0.85;
    R_pa=0.7;
    A=0.7;
    R_ia=0.5;
    Harmonies=10;       % Number of harmonies
    MaxImprovisations=220000;
    Evaluations=0;
    Range=[0 150
       0 50
       0 50
       0 150
       0 150
       0 150
       0 150
       pi/2 pi]; % limits for variables
    for J=1:Vars
       Bw(J,1)=(Range(J,2)-Range(J,1))*0.001;  % Bw min
       Bw(J,2)=(Range(J,2)-Range(J,1))*0.1;   % Bw max
    end
end