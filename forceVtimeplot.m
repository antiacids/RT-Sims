function [forceVtimeplot,maxforce] = forceVtimeplot(simtable,masscolor,m,thrustspec)
    time=simtable.Time_sec_;
    a=simtable.Accel_ft_sec_2_;
    aSI = a.*0.3048; %convert into meters per section
    drag_lbs = simtable.Drag_lb_; %assumes all the drag force acts on the nose cone, and the compression due to drag exists in every section.
    drag_newtons = drag_lbs.*4.44822; 
    %mass of component is m
    g = 9.81;
    compressive_force= m*(aSI+g) + drag_newtons;
    maxforce=max(compressive_force);
    forceVtimeplot = plot(simtable.Time_sec_, compressive_force, 'Color',[0,0,masscolor],'LineWidth',thrustspec);
    xlabel('Time (s)');
    ylabel('Force (N)');
end