function [] = simplots(dir)
% Wrapper for plotting. Makes plots for a range of sims. 

% dir =  '/home/god/RT-Sims/sims/';
% dir = '/Users/shannon/Documents/GitHub/RT-Sims/Simname/';
% dir = 'directory with simfiles' e.g. '/home/god/Documents/rocket-team/4-2-18Sims'


anglerange = [ 2 5 10];
massrange = [130 150 170];
thrustrange = [69 72 76];
mass_scale = max(massrange) - min(massrange);
thrust_scale = max(thrustrange) - min(thrustrange);

%mass before different elements to get compressive loads
payload_bulkhead=6.596;
avionics_bulkhead=15.317;
recovery_coupler=34.539;
motor_case=34.539;
thrust_ring=77.088;

% Clean up old plots
close all;

% readsim() -> matlab table
% graphxyz(table,xyz) -> xyz graph
% makethemall(); 

% Initialize bound maximums
Mmax = 0;

for angle = anglerange
    for mass = massrange
        for thrust = thrustrange
            % Try to read the file. If it DNE, skip to the next one.
            try
                simtable = readsim(angle,mass,thrust,dir);
            catch ME
%                 disp('READ ERROR')
%                 disp(ME)
                continue
            end
%             disp('NO ERROR');
            % Find bounds
            thisSimMax = max(simtable.MachNumber);
            if thisSimMax > Mmax
                Mmax = thisSimMax;
            end

            % Formatting for all plots
            masscolor = (max(massrange)-mass) / mass_scale;
            idthrust = find(sort(thrustrange)==thrust);
            thrustspec = idthrust;
            % TODO add to function parameters:  'Color',[0,0,masscolor]

            % machVtimeplot
            figure(1);
            hold on;
            machVtimeplot(simtable,masscolor,thrustspec); %, 'color', masscolor);

            % machValtplot
            figure(2);
            hold on;
            QVtimeplot(simtable,masscolor,thrustspec);

            % forceVtimeplot
            figure(3);
            hold on;
            %forceVtimeplot(simtable,mass,masscolor,thrustspec);

            % altVtimeplot
            figure(4);
            hold on; 
            altVtimeplot(simtable,masscolor,thrustspec);
        
        
        end
    end
end
