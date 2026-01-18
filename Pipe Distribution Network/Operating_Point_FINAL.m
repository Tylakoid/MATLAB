%%%%%%%%%%%%%%%%%%%%%%%%%%
%  specify input values  %
%%%%%%%%%%%%%%%%%%%%%%%%%%
%flow rate in L/s
Qo = [0:10:200]
%pipe length in m
L = 42+16+20+1
%pipe ID in m
ID = 0.25
%fluid density in kg/m3
rho = 789
%fluid viscosity in Pa.s
mu = 1.2e-3
%epsilon/absolute roughness 
AR = 2e-7
% gravity in m/s^2
g = 9.81

%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Calculation  %
%%%%%%%%%%%%%%%%%%%%%%%%%%

%convert Q to m3/s
Q = Qo/1000

%calculate pipe Cross sectional area
A = pi*ID^2/4

%calculate flow velocity
v = Q/A

%calculate Reynold's number
Re = (rho*v*ID)./mu

%Determine laminar or turbulent flow and calculate f accordingly
f = (1./(-1.8*log10(6.9./Re+((AR./ID)./3.7).^1.11))).^2

% frictional loss from pipes - a.k.a pressure drop in pipe flow in m
h_pipe = (f.*L.*(v.^2))./(2*9.81*ID)

% frictional loss from fittings 
Ksum = 0.17+0.35+0.35+0.75+(1+0.75)%sum of all values of K across the pipe
h_fittings = (Ksum*v.^2)./(9.81*2)

% height
h1 = 2
h2 = 20
h_height= h2-h1

%velocity
v1 = 0
v2 = 0
h_vel = v2^2/(2*9.81)-v1^2/(2*9.81)

% Add all the loss
%calculate pump head in m, and pressure drop in Pa and shaft work
h = h_pipe+h_fittings+h_height

plot(Q,h,"r-s")
title("head loss (m)vs Q(m^3/s)")
legend

h_pump = [21.0 20.2 18.8 16.9 14.6 11.7 8.3 4.4 0]
q_pump0 = [0 25 50 75 100 125 150 175 200]
Q_pump = q_pump0./1000
hold on
xlabel("Q(m^3/s)")
ylabel("head loss (m)")
plot(Q_pump, h_pump, "b-o")

h_quadratic = polyfit(Q,h,2)
h_pump_quadratic = polyfit(Q_pump,h_pump,2)
difference = h_quadratic - h_pump_quadratic
q_op = roots(difference)
%Use q_op to get the possible operating points, and select reasonbly/ trial
%and error. Then, sub in to get h_op ==> Q_op is flow rate, so sub it in
%the get v and use that v to work out h.

