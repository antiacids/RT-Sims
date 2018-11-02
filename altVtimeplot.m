function [altvtimeplot] = altVtimeplot(simtable,masscolor)
% Plots Altitude vs. Time
    altvtimeplot = plot(simtable.Time_sec_, simtable.Altitude_ft_, 'Color',[0,0,masscolor]);
    title('Altitude vs. Time');
    xlabel('Time (s)');
    ylabel('Altitude (ft)');
end