<<<<<<< HEAD
function [machvaltplot] = machValtplot(simtable,masscolor)
    machvaltplot = plot(simtable.Altitude_ft_, simtable.MachNumber, 'Color',[0,0,masscolor]);
=======
function [machvaltplot] = machValtplot(simtable)
    machvaltplot = plot(simtable.Altitude_ft_, simtable.MachNumber);
    xlabel('Altitude (ft)');
    ylabel('Mach Number');
>>>>>>> ff3a3c564e9d88de0980207b3b4ed6bd650c2fb4
end