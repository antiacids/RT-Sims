%function [] = simplots()
% Wrapper for plotting. Makes plots for a range of sims. 

dir =  '/home/god/Documents/rocket-team/4-2-18Sims/';
% dir = 'directory with simfiles' e.g. '/home/god/Documents/rocket-team/4-2-18Sims'


anglerange = [ 10 5  0];
massrange = [135 149 165];
mass_scale = max(massrange) - min(massrange);


% Clean up old plots
close all;

% readsim() -> matlab table
% graphxyz(table,xyz) -> xyz graph
% makethemall(); 

% Initialize bound maximums
Mmax = 0;

for angle = anglerange
    for mass = massrange
        % Try to read the file. If it DNE, skip to the next one.
        try
            simtable = readsim(angle,mass,dir);
        catch ME
            disp('READ ERROR')
            disp(ME)
            continue
        end
        
        % Find bounds
        thisSimMax = max(simtable.MachNumber);
        if thisSimMax > Mmax
            Mmax = thisSimMax;
        end
        
        % Formatting for all plots
        masscolor = (max(massrange)-mass) / mass_scale;
        % TODO add to function parameters:  'Color',[0,0,masscolor]
        
        % machVtimeplot
        figure(1);
        hold on;
        machVtimeplot(simtable, 'color', masscolor);
        
        % machValtplot
        figure(2);
        hold on;
        QVtimeplot(simtable);
        
        % forceVtimeplot
        figure(3);
        hold on;
        forceVtimeplot(mass,simtable);
        
        
            
    end
end
