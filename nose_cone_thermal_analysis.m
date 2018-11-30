function nose_cone_thermal_analysis(simtable,thermal_sim_inputs,simname,masscolor,thrustspec)


% Function calculates the thermal loads on the nose cone and performs a 1D transient thermal analysis on the nose cone.
%
% inputs
%   simtable: contains the full sim data.
%   thermal_sim_inputs: .mat file containing all the parameters needed
%   for the thermal sim
%   simname,masscolor,thrustspec: simulation details used for naming and
%   coloring plots.
%
% output: 
%   figures that show the heating. To actually export the heating results,
%   export (x,t,Tstore) that are generated at the bottom of this function.

% Written by Dev Agrawal (30 Nov 2018) [devansh@mit.edu]





%% find apogee time
[~,apogee_index]=max(simtable.Altitude_ft_);

%% calculate qdot
% requires rho V and nose cone radius
qdot_nc = calcNoseConeQdot(simtable, thermal_sim_inputs.rn);

figure(6);
hold on
plot(simtable.Time_sec_(1:apogee_index), qdot_nc(1:apogee_index), 'Color',[0,0,masscolor],'LineWidth',thrustspec);
title('Nose Cone heat flux against time')
xlabel('Time (s)')
ylabel('Heat Flux (W/m^2)')

%% create plot placeholds

figure(7); %to show the max temp comparisons


%% run 1D heat solver

[x, t, Tstore] = run_1D_heat_solver(simtable, thermal_sim_inputs,simtable.Time_sec_(1:apogee_index), qdot_nc(1:apogee_index),simname);

%% plot min max temp 
figure(7);
hold on;
plot(x, Tstore(end,:)-273,'--','Color',[0,0,masscolor],'LineWidth',thrustspec)
plot(x, max(Tstore)-273,'Color',[0,0,masscolor],'LineWidth',thrustspec)
xlabel('Position along wall thickness (in)')
ylabel('Temperature (C)')
grid on
title('Max (solid) and Apogee (dashed) Temp in wall');


%% plot temp contours
figure; %to show the contour plots;
contourf(x,t,Tstore-273)
xlabel('Position along wall thickness (m)')
ylabel('Time (s)')
colorbar
title(strcat(simname,' Temp Profile (deg C)'));

end
