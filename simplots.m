function [] = simplots(dir)
% Wrapper for plotting. Makes plots for a range of sims. 

% dir =  '/home/god/RT-Sims/sims/';
% dir = '/Users/shannon/Documents/GitHub/RT-Sims/Simname/';
% dir = 'directory with simfiles' e.g. '/home/god/Documents/rocket-team/4-2-18Sims'


anglerange = [2 5 10];
massrange = [150 170 190];
thrustrange = [69 72 76];
mass_scale = max(massrange) - min(massrange);
thrust_scale = max(thrustrange) - min(thrustrange);

%mass before different elements to get compressive loads
masses.dry = 0;
masses.payload_bulkhead=6.596;
masses.av_bulkhead=9.317;
masses.recovery_coupler=28.539;
masses.motor_case=28.539;

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
                 disp('READ ERROR')
                 disp(ME)
                continue
            end
             disp('NO ERROR');
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

            % Qvtimeplot
            figure(2);
            hold on;
            QVtimeplot(simtable,masscolor,thrustspec);

            %AVtimeplot
            figure(3);
            AVtimeplot(simtable,masscolor,thrustspec);
            hold on;
            
            
            % forceVtimeplot
%             figure(4);
%             hold on;
%             masses.dry = mass;
%             
%             subplot(2,2,1);
%             forceVtimeplot(simtable,masscolor,masses.payload_bulkhead,thrustspec);
%             title('Payload Bulkhead Compressive Load');
%             axis([0 20 -15000 25000]);
%             hold on;
%             
%             subplot(2,2,2);
%             forceVtimeplot(simtable,masscolor,masses.av_bulkhead,thrustspec);
%             title('Avionics Bulkhead Compressive Load');
%             axis([0 20 -15000 25000]);
%             hold on;
%             
%             subplot(2,2,3);
%             forceVtimeplot(simtable,masscolor,masses.recovery_coupler,thrustspec);
%             title('Recovery Coupler Compressive Load');
%             axis([0 20 -15000 25000]);
%             hold on;
%             
%             subplot(2,2,4);
%             forceVtimeplot(simtable,masscolor,masses.motor_case,thrustspec);
%             axis([0 20 -15000 25000]);
%             title('Start of Motor Case Compressive Load');    
%             
%             sgtitle('Compressive loads')
            
                       
            % altVtimeplot
            figure(5);
            hold on; 
            altVtimeplot(simtable,masscolor,thrustspec);
            
            
        
        
        end
    end
end
