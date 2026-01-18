%Section2: Pipe Distribution Network --- Pressure Tap 1
clear all
close all
clc

%%%%%%%%%%%%%%%%%%%%%%%%%%
%  specify input values  %
%%%%%%%%%%%%%%%%%%%%%%%%%%
%flow rate in L/min
Qo = 9
%pipe length in m
L = 5+1.25+4+6.25+7.8+0.5+0.5
%pipe ID in m
ID =38.5/1000
%fluid density in kg/m3
rho = 998
%fluid viscosity in Pa.s
mu = 0.89e-3
%epsilon/absolute roughness 
AR = 0.0015/1000 %m


%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Calculation  %
%%%%%%%%%%%%%%%%%%%%%%%%%%

%convert L/min to m3/s
Q = Qo/60000
g = 9.81 %m/s
%calculate pipe Cross sectional area
A = pi*ID^2/4

%calculate flow velocity
v = Q/A

%calculate Reynold's number
Re = rho*v*ID/mu

%Determine laminar or turbulent flow and calculate f accordingly
if Re > 2000 % check if Re is turbulent or laminar
    % Use Haaland Correlation
    f = (1/(-1.8*log10(6.9/Re+((AR/ID)/3.7)^1.11)))^2;
    a = 1
else
    % If laminar, use Darcy
    f = 64/Re;
    a = 2
end
%Frictional loss from pipes - a.k.a pressure drop in pipe flow in m
h_pipe = f*L/ID*(v^2)/(2*9.81)

%Frictional loss from fittings 
Ksum = 0.75 + 5*0.75 + 1*1 +1 %sum of all values of K across the pipe
h_fitting = 0.5*v^2/9.81*Ksum

%Total frictional loss
FrictionalLoss_total = h_pipe + h_fitting

%Height difference
h_1 = 0 
h_2 = -8.5
height_difference = h_1 - h_2

%Pump
pump_power = 1187.11/1000; %[kWatts]
h_pump = (pump_power/(rho*g*Q));

%Atmospheric Pressure
P_atm = 101325 %Pa

%Absolute Pressure [Pa]
Pressure_Tap1 = (height_difference +h_pump - FrictionalLoss_total + P_atm/(rho*g))*(rho*g)

%Gauge Pressure [Pa]
Gauge_Pressure1 = Pressure_Tap1 - P_atm

