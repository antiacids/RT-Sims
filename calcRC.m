function [V,T] = calcRC(AR, S, CL)

    K=.011;
    g=9.8;
    rhof=32;
    rho=1.225;
    
    V=((0.6*K*g*rhof*(S^3*AR)^(.5))/(.5*rho*S*CL))^(.5);
    CD=.004/S+(.02+.1*K*AR+.04*(1-CL)^2)+CL^2/(pi*AR*1);
    T=.5*S*rho*X^2*CD;
end

% You need to do a bunch of calculations in this script to find V
% (flight speed) and T (required thrust).



