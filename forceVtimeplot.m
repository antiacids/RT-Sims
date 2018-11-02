function [forceVtimeplot,maxforce] = forceVtimeplot(simtable,mass,masscolor,thrustspec)
    vel=simtable.Total_velocity_ft_sec_;
    time=simtable.Time_sec_;
    a=diff(vel)./diff(time);
    force=a.*mass;
    maxforce=max(force);
    forceVtimeplot = plot(simtable.Time_sec_(start,end-1), force, 'Color',[0,0,masscolor],'LineWidth',thrustspec);
end