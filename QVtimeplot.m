function [Qvtimeplot] = QVtimeplot(simtable,masscolor,thrustspec)
    title('q vs. Time');
    xlabel('t (s)')
    ylabel('q  (psf)');
    rho = Rho(simtable.Altitude_ft_);
    v = simtable.Velocity_ft_sec_;
    Q = .5 * rho .* v.^2;
    Qvtimeplot = plot(simtable.Time_sec_, Q, 'Color',[0,0,masscolor],'LineWidth',thrustspec);
end