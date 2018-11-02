function [machvaltplot] = machValtplot(simtable,masscolor,thrustspec)
    machvaltplot = plot(simtable.Altitude_ft_, simtable.MachNumber, 'Color',[0,0,masscolor],'LineWidth',thrustspec);
    xlabel('Altitude (ft)');
    ylabel('Mach Number');
end