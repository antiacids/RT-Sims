csvtemplate = '/home/god/Documents/rocket-team/4-2-18Sims/a%gm%g.CSV';
% readSimTable = @(angle,mass) readtable(sprintf(csvtemplate,angle,mass));
readSimCSV = @(angle,mass) csvread(sprintf(csvtemplate,angle,mass),1,3);

anglerange = [ 10 5  0];
massrange = [135 149 165];




figure(1);
hold on;
maxalt = 64000; %feet
minalt = 50000;
maxM = .5; % mach number
launch_alt = 4600;
xlim([minalt,maxalt]);
ylim([0,maxM]);
xlabel('Altitude above Launch Site (ft)');
ylabel('Mach Number');
title('Hermes RASareo Sims Launched from 4600 ft in 5.5 mph Winds')
grid on;
% grid minor;

% Ascent Lines
mass_scale = max(massrange) - min(massrange);

for angle = anglerange
    for mass = massrange
        sim = readSimCSV(angle,mass);
        masscolor = (max(massrange)-mass) / mass_scale;
        [apogee_alt,apogee_index] = max(sim(:,20));
        plot(sim(1:apogee_index,20), sim(1:apogee_index,1), 'Color',[0,0,masscolor]); 
        % plot whole sim
        apogeestr = sprintf('\n%g \n%g deg',round(apogee_alt/1000,3,'significant'),angle);
        text(apogee_alt, sim(apogee_index,1),apogeestr,'HorizontalAlignment','right');
    end
end

legend('135 lbs','149 lbs', '165 lbs');
