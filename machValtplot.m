function [machvaltplot] = machValtplot(simtable,masscolor)
    machvaltplot = plot(simtable.Altitude_ft_, simtable.MachNumber, 'Color',[0,0,masscolor]);
end