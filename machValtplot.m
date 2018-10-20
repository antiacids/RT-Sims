function [machvaltplot] = machValtplot(simtable)
    machvaltplot = plot(simtable.Altitude_ft_, simtable.MachNumber);
end