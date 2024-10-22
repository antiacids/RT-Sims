function [forceVtimeplot,maxforce] = forceVtimeplot(simtable,masscolor,loc,thrustspec)
    time=simtable.Time_sec_;
    a=simtable.Accel_ft_sec_2_;
    force=a.*loc/32;
    maxforce=max(force);
    forceVtimeplot = plot(simtable.Time_sec_, force, 'Color',[0,0,masscolor],'LineWidth',thrustspec);
    xlabel('Time (s)');
    ylabel('Force (lbs)');
    maxstr=sprintf('%0.5e',maxforce);
    text(10,0,maxstr,'HorizontalAlignment','center');
end