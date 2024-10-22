function [] = faa(dir)
% Wrapper for plotting. Makes plots for a range of sims. 

% dir =  './sims/10.30/'

addpath('./sims/2.14/');

anglerange = [0 2];
massrange = [227 232];
thrustrange = [2 8];
mass_scale = max(massrange) - min(massrange);
thrust_scale = max(thrustrange) - min(thrustrange);

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
            figure(1);
            yyaxis right;
            plot(simtable.Time_sec_, simtable.Thrust_lb_)
            title('Thrust, Mass flow vs. Time');
            xlabel('Time (s)');
            ylabel('Thrust (lbs)');
            
            yyaxis left;
            weights=simtable.Weight_lb_;
            times=simtable.Time_sec_;
            massflow=-(weights(2:end)-weights(1:end-1))/(times(2:end)-times(1:end-1));
            massflow(massflow==0)=nan;
            plot(times(1:end-1), massflow);
            ylabel('Mass flow (lbs/s)');

            figure(2);
            hold on;
            yyaxis right;
            plot(simtable.Time_sec_, simtable.CG_in_)
            title('CG, Mass vs. Time');
            xlabel('Time (s)');
            ylabel('CG (in)');
            
            yyaxis left;
            plot(simtable.Time_sec_, simtable.Weight_lb_)
            xlabel('Time (s)');
            ylabel('Weight (lbs)');
            
            figure(3);
            hold on;
            plot(simtable.Time_sec_, simtable.CP_in_)
            title('CP vs. Time');
            xlabel('Time (s)');
            ylabel('CP (in)');
            
            
            figure(4);
            hold on;
            yyaxis right;
            a1=plot(simtable.MachNumber, simtable.CP_in_);
            title('CP, CG, Mass vs. Mach');
            xlabel('Mach');
            ylabel('CP/CG (in)');
            a2=plot(simtable.MachNumber, simtable.CG_in_);
            xlabel('Mach');
            
            hold on;
            yyaxis left;
            a3=plot(simtable.MachNumber, simtable.Weight_lb_);
            ylabel('Weight (lbs)');
            legend([a1;a2;a3],'CP','CG','Mass');
            
            
            figure(5);
            hold on;
            yyaxis right;
            plot(simtable.MachNumber, simtable.CP_in_)
            title('CP, Drag vs. Mach');
            xlabel('Mach');
            ylabel('CP (in)');
            
            yyaxis left;
            plot(simtable.MachNumber, simtable.Drag_lb_);
            xlabel('Mach');
            ylabel('Drag (lbs)');
            
            figure(6);
            hold on;
            plot(simtable.Time_sec_,simtable.CP_in_-simtable.CG_in_);
            title('Stability Margin vs. Time');
            xlabel('Time (sec)');
            ylabel('Stability Margin (in)');
            
        
        
        end
    end
end
