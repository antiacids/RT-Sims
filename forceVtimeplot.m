function [forceVtimeplot] = forceVtimeplot(mass,simtable)
    vel=simtable.Total_velocity_ft_sec_;
    time=simtable.Time_sec_;
    a=diff(vel)./diff(time);
    force=a.*mass;
    forceVtimeplot = plot(simtable.Time_sec_(start,end-1), force);
end