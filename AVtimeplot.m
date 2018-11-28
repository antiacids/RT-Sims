function [Avtimeplot] = AVtimeplot(simtable,masscolor,thrustspec)
    title('A vs. Time');
    xlabel('t (s)')
    ylabel('Acceleration (m/s^2)');
    A = simtable.Accel_ft_sec_2_;
    Avtimeplot = plot(simtable.Time_sec_, A, 'Color',[0,0,masscolor],'LineWidth',thrustspec);

end

