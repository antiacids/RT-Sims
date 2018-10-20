
csvtemplate = '/home/god/Documents/rocket-team/4-2-18Sims/a%gm%g.CSV';
readSimTable = @(angle,mass) readtable(sprintf(csvtemplate,angle,mass));
readSimCSV = @(angle,mass) csvread(sprintf(csvtemplate,angle,mass),1,3);

anglerange = [ 10 5  0];
massrange = [135 149 165];


figure(1);
hold on;
maxalt = 70000; %feet
minalt = 54000;
maxM = .6; % mach number
launch_alt = 4600;
xlim([minalt,maxalt]);
ylim([0,maxM]);
xlabel('Altitude (ft)');
ylabel('Mach Number');
title('Hermes RASareo Sims Weighing 135, 149, & 165 lbs Launched from 4600 ft in 5.5 mph Winds at 0, 5, & 10 degrees at apogees \pm 10s')
grid on;

alt = linspace(minalt,maxalt);
m_num = linspace(0,maxM); 
[Alt,M_num] = meshgrid(alt,m_num);

% % dynamic pressure(m,alt)  = 1/2 p(alt) v
Q = 1/2*arrayfun(@(alti,m_number) (m_number*V_sound(alti))^2 * Rho(alti) ,Alt,M_num); 
[qContours,hq] = contour(Alt,M_num,Q,'Color',[.9,.2,.9]);
max_q_contour = 35;
qLevels = 2:2:max_q_contour;
% % qLevels = logspace(0,4,25);
hq.LevelList = qLevels;
clabel(qContours,hq,qLevels,'LabelSpacing',100000);

% % steady state descent
% % v0 = m*ss*sqrt(r)/sqrt(rho(0))
% V0 = arrayfun(@(alti,m_number) m_number*V_sound(alti) * sqrt(Rho(alti)/Rho(launch_alt)) ,Alt,M_num);
% [v0Contours,hv0] = contour(Alt,M_num,V0,'Color',[.2,.9,.9]);
% max_v0_contour = 150;
% v0Levels = 75:25:max_v0_contour;
% hv0.LevelList = v0Levels;
% clabel(v0Contours,hv0,v0Levels,'LabelSpacing',100000);%,'Color',[0,1,0]);
legend('dynamic pressure (lbf/f^2)');%, 'steady state descent (ft/s)');
% legend('steady state descent (ft/s)');

% Ascent Lines
mass_scale = max(massrange) - min(massrange);
timeregion = 1000; % in 1/100 seconds
flight_string = '%glb %g*';
for angle = anglerange
    for mass = massrange
        sim = readSimTable(angle,mass);
        masscolor = (max(massrange)-mass) / mass_scale;
        [apogee_alt,apogee] = max(sim.Altitude_ft_);
        
        plot(sim.Altitude_ft_(apogee-timeregion:apogee)+launch_alt, sim.MachNumber(apogee-timeregion:apogee), 'Color',[0,0,masscolor]); 
% % % %         plot(sim.Altitude_ft_(apogee-timeregion:apogee+timeregion)+launch_alt, sim.MachNumber(apogee-timeregion:apogee+timeregion), 'Color',[0,0,masscolor]); 

        %         plot(sim.Altitude_ft_+launch_alt, sim.MachNumber, 'Color',[0,0,masscolor])
        % Descent Only
%         plot(sim.Altitude_ft_(apogee:end)+launch_alt, sim.MachNumber(apogee:end), 'Color',[0,0,masscolor]); 

%        axis = [minalt maxalt 0 maxM];
%         xlim([minalt,maxalt]);
%         ylim([0,maxM]);
        % label(p,sprintf(flight_string,mass,angle));

%         grid on;
%         hold on;

    end
end


% Dynamic Pressure lines

% q_line = @(q) arrayfun(@(r) sqrt(2*q/r), rho);
% q_line_mach = @(q) arrayfun(@(vel, speed_sound) vel/speed_sound, q_line(q), a);
% 
% max_q_line = 10;
% for const_q =  0:1:max_q_line
%     plot(alt,q_line_mach(const_q), 'Color', [1,.7,.7]); % [const_q/max_q_line,0,0]);
% end
% const_q =  0:1:max_q_line
% 
% Descent Lines
alt = 0:10:0.3048000097536*maxalt;
[T,a,P,rho] = atmoscoesa(alt);

alt = alt/0.3048000097536;
rho = rho*0.00194032;
a = a * 3.28084;


rhoscaled = arrayfun(@(r) sqrt(rho(1)/r), rho);
descent_v = @(v0) arrayfun(@(rs,speed_sound) v0*rs/(speed_sound), rhoscaled, a);

% v(alt,m) = sqrt(2*m/(CdS *rho(alt))
% w = 1/2CdS p v^2
% 2w/(cds) = p(alt) v(m(alt))
max_descent_v = 150;
% for const_q =  50:25:max_descent_v
%     plot(alt,descent_v(const_q),'LineStyle','--', 'Color', [0,0,1]);
% end


q_line = @(q) arrayfun(@(r) sqrt(2*q/r), rho);
q_line_mach = @(q) arrayfun(@(vel, speed_sound) vel/speed_sound, q_line(q), a);
% 
% max_q_line = 10;
% for const_q =  0:1:max_q_line
%     plot(alt,q_line_mach(const_q), 'Color', [1,.7,.7]); % [const_q/max_q_line,0,0]);
% end
% alt = linspace(80000,150000);
% vel = linspace(0,10000);
% [Alt,Vel] = meshgrid(alt,vel);
% Q = 1/2*arrayfun(@(alti,veloci) ^2 * Rho(alti),Alt,Vel); % dynamic pressure(m,alt)  = 1/2 p(alt) v
% 

% 
% 
% figure(2);
% for angle = anglerange
%     for mass = massrange
%         sim = readSimCSV(angle,mass)
%         plot(sim(:,20), sim(:,1)); 
%         xlim([80000,maxalt]);
%         ylim([0,maxM]);
%         grid on;
%         grid minor;
%         hold on;
%     end
% end
% 
