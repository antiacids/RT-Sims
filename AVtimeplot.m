function [Avtimeplot] = AVtimeplot(simtable,masscolor,thrustspec)
    A = simtable.Accel_ft_sec_2_;
    Avtimeplot = plot(simtable.Time_sec_, A, 'Color',[0,0,masscolor],'LineWidth',thrustspec);
    title('A vs. Time');
    xlabel('t (s)')
    ylabel('Acceleration (m/s^2)');
end

