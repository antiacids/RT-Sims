function [altvtimeplot] = altVtimeplot(simtable,masscolor,thrustspec)
% Plots Altitude vs. Time
    altvtimeplot = plot(simtable.Time_sec_, simtable.Altitude_ft_, 'Color',[0,0,masscolor],'LineWidth',thrustspec);
    title('Altitude vs. Time');
    xlabel('Time (s)');
    ylabel('Altitude (ft)');
    [apogee_alt,apogee_index] = max(simtable.Altitude_ft_)
    apogeestr = sprintf('\n\n%g',round(apogee_alt/1000,3,'significant'));
    text(apogee_index/100,apogee_alt ,apogeestr,'HorizontalAlignment','center');
    
end