function [machvtimeplot] = machVtimeplot(simtable,masscolor,thrustspec)
    title('Mach vs Time');
    machvtimeplot = plot( simtable.Time_sec_,simtable.MachNumber, 'Color',[0,0,masscolor],'LineWidth',thrustspec);
    xlabel('Time (s)');
    ylabel('Mach Number');
    [max_mach,mach_index] = max(simtable.MachNumber)
    apogeestr = sprintf('     %g',round(max_mach,3,'significant'))
    text(mach_index/100,max_mach ,apogeestr,'HorizontalAlignment','left');
end