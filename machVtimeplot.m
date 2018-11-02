function [machvtimeplot] = machVtimeplot(simtable)
    title('Mach vs Time');
    machvtimeplot = plot( simtable.Time_sec_,simtable.MachNumber);
    xlabel('Time (s)');
    ylabel('Mach Number');
end