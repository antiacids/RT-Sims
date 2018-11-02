function [altvtimeplot] = altVtimeplot(simtable)
% Plots Altitude vs. Time
    altvtimeplot = plot(simtable.Time_sec_, simtable.Altitude_ft_);
    title('Altitude vs. Time');
    xlabel('Time (s)');
    ylabel('Altitude (ft)');
    
end