function [] = simplots(mass, angle, thrust)
% Wrapper for plotting. Makes plots for a range of sims. 
%make sure line 4 and 56 have the right directory to your files. also make
%sure the angle mass and thrust range contain the parameters for your sim
addpath('/sims/spaceshotA');
dir='./sims/spaceshotA/';

situation=[];
situation(1)=(2,170)
anglerange = [0 2];
massrange = [0 227];
thrustrange = [0 8];

mass_scale = max(massrange) - min(massrange);
thrust_scale = max(thrustrange) - min(thrustrange);

%mass before different elements to get compressive loads
masses.dry = 0;
masses.bulkhead = 5.45;
masses.motor_case=172-138.88;
masses.fin_can=4.415;



do_thermal_nose_cone_tip = 1;
if do_thermal_nose_cone_tip %if you want to perform thermal analysis, we need the thermal data
    
    load thermal_sim_inputs.mat %load the thermal sim inputs mat file
    
end


% Clean up old plots
close all;

% readsim() -> matlab table
% graphxyz(table,xyz) -> xyz graph
% makethemall(); 

% Initialize bound maximums
Mmax = 0;

% for angle = anglerange
%     for mass = massrange
%         for thrust = thrustrange
%             % Try to read the file. If it DNE, skip to the next one.
% Copied from MathWorks
selectedFiles = uigetfile('*.CSV', 'Multiselect', 'on');

%             try
%                 simtable = readsim(angle,mass,thrust,dir);
%             catch ME
%                  disp('READ ERROR')
%                  disp(ME)
%                 continue
%             end
disp(selectedFiles)
disp(isa(selectedFiles, 'char'))
if isa(selectedFiles, 'char')
    simtable = readtable(char(strcat('./sims/spaceshotA/', selectedFiles)));
    simplots_impl(simtable, mass, massrange, mass_scale, masses, thrust, thrustrange, 0);
else
    for file = selectedFiles
            simtable = readtable(char(strcat(dir, file)));
             disp('NO ERROR');
            % Find bounds
            MMax=0;
            MMax = simplots_impl(simtable, mass, massrange, mass_scale, masses, thrust, thrustrange, MMax);

%         end
   end
end
