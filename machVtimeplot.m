function [machvtimeplot] = machVtimeplot(simtable,masscolor)
    title('Mach vs Time');
<<<<<<< HEAD
    machvtimeplot = plot( simtable.Time_sec_,simtable.MachNumber, 'Color',[0,0,masscolor]);
=======
    machvtimeplot = plot( simtable.Time_sec_,simtable.MachNumber);
    xlabel('Time (s)');
    ylabel('Mach Number');
>>>>>>> ff3a3c564e9d88de0980207b3b4ed6bd650c2fb4
end