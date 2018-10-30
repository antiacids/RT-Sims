function [ temp2 ] = stagHeatFlux( Ta,temp1, dt )
%helper function for tempVtime plott
    h=5; %heat transfer coefficient
    g=5; %gamma
    m=5; %mass
    Mach=1; %mach number
    C=5; %specific heat
    T0=Ta*(1-(g-1)/2*Mach^2); %stagnation temperature
    A=area;
    Q=h*(T0-temp1)*A*dt;
    temp2=temp1+Q/(m*C);

end

