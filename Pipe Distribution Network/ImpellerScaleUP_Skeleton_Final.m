%% This is the skeleton m-file for Section 1 Impeller Scale up
% Scaling up an impeller to meet a flow specification

% system curve data flow rate (L/s), Head loss (m)
flowrate = [0.2,0.5,0.7,0.9,1.2,1.4,1.6];
headloss = [20.1,20.6,21.2,21.8,22.3,22.9,23.5];

% pump curve data pump flow rate (L/s), performance (m), 
% Student put in their best pump curve from Workshop 4
pumpflowmin = [13.26,12.245,11.085,9.92,8.61,7.005,5.68,3.74,2.54,1.49,];
pumpflow = pumpflowmin / 60;
perform = [1.4504,1.6445,1.7466,1.8590,1.9611,2.0939,2.2267,2.3697,2.4616,2.5535]; 

% Operating Fluid point in  L/s
opflowpoint= 0.75947;   % insert the operating point of your system
opflow=[opflowpoint opflowpoint];
opheight=[0 max(headloss)];

%Current Impeller Diameter in mm from student design
D1=33.144; 

% New impeller diam in mm . will change iteratively
%Using infinity law
D2 =121;
dratio = (D2/D1);

%New Pump Curve . scale old pump data with ratio, remember to use .*
%operator,   scale according to Affinity laws 
pumpflownew = pumpflow * dratio;
performnew = perform * (dratio^2);

%plot curves
plot(flowrate,headloss,'ro-')
grid on
hold on
plot(pumpflow,perform,'k^-')
plot(pumpflownew,performnew,'bs-')
plot(opflow,opheight,'g-')
xlabel('Flow rate (L/s)')
ylabel('System head (m)')
title('Scaling Up Impeller-Section 1 Design Project')
%Decide legend location after looking at plot
legend('System curve','Pump curve','New Pump Curve','Op Flow','location','northeast')
hold off


