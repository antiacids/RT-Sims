function [Qvtimeplot] = QVtimeplot(simtable)
    rho = Rho(simtable.Altitude_ft_);
    v = simtable.Velocity_ft_sec_;
    Q = .5 * rho * v.^2;
    Qvtimeplot = plot(simtable.Time_sec_, Q);
end