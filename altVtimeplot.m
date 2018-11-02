function [altvtimeplot] = altVtimeplot(simtable,masscolor,thrustspec)
% Plots Altitude vs. Time
    altvtimeplot = plot(simtable.Time_sec_, simtable.Altitude_ft_, 'Color',[0,0,masscolor],'LineWidth',thrustspec);
    title('Altitude vs. Time');
    xlabel('Time (s)');
    ylabel('Altitude (ft)');
    
end