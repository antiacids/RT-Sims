function [forceVtimeplot,maxforce] = forceVtimeplot(simtable,mass,masscolor,thrustspec)
    time=simtable.Time_sec_;
    a=simtable.Accel_ft_sec_2_;
    force=a.*mass;
    maxforce=max(force);
    forceVtimeplot = plot(simtable.Time_sec_, force, 'Color',[0,0,masscolor],'LineWidth',thrustspec);
end