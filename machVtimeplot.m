function [machvtimeplot] = machVtimeplot(simtable,masscolor)
    title('Mach vs Time');
    machvtimeplot = plot( simtable.Time_sec_,simtable.MachNumber, 'Color',[0,0,masscolor]);
    xlabel('Time (s)');
    ylabel('Mach Number');
end