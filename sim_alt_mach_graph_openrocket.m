num_files = 18;
csvtemplate = '~/Desktop/SimFiles/s%ga%gm%gn%g.csv';

while num_files > 0

    readSimTable = @(stage,angle,mass_lower,mass_upper) readtable(sprintf(csvtemplate,stage,angle,mass_lower,mass_upper));

    stagerange = [1 2];
    anglerange = [0 5 10];
    massrange_lower = [35 55];
    massrange_upper = [7 17 27];

    figure(1);
    hold on;
    maxalt = 10000; %feet
    minalt = 0;
    maxM = .2; % mach number
    launch_alt = 0;
    xlim([minalt,maxalt]);
    ylim([0,maxM]);
    xlabel('Altitude (ft)');
    ylabel('Mach Number');
    title('Hermes II Sims');
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
%     legend('dynamic pressure (lbf/f^2)');
    % legend('steady state descent (ft/s)');

    % Ascent Lines
    mass_scale = max(massrange_lower) - min(massrange_upper);
    timeregion = 100; 
    flight_string = '%glb %g*';
    for stage = stagerange
        for angle = anglerange
            for mass_upper = massrange_upper
                for mass_lower = massrange_lower
                    try
                        sim = readSimTable(stage,angle,mass_lower,mass_upper);
                        masscolor = (max(massrange_lower)-mass_lower) / mass_scale;
                        [apogee_alt,apogee] = max(sim.Altitude_ft_);
                        plot(sim.Altitude_ft_(apogee:apogee+timeregion)+launch_alt, sim.MachNumber___(apogee:apogee+timeregion), 'Color',[0,0,masscolor]);
                        num_files = num_files - 1;
                    catch ME % continues when errors occur (file does not exist)
                        continue
                    end
                end
            end
        end
    end
end
