function [ tempVtimeplot,maxtemp ] = tempVtime( simtable )
%using stagnation temperature calculations, finds max temperature by
%integrating heat flux over time 
    Ta=50; %static temperature of air
    tsecs=simtable.Time_sec_;
    temps=zeros(1,length(tsecs)+1);
    temps(1)=Ta;
        for j=1:length(tsecs)
            dt=tsecs(j+1)-tsecs(j);
            temps(j+1)=temps(j)+stagHeatFlux( Ta,temps(j), dt );
        end
    maxtemp=max(temps);
    tempVtimeplot=plot(tsecs,temps);

end

