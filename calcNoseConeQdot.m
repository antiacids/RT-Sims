function qdot_nc = calcNoseConeQdot(simtable, rn)
% Function calculates the nose cone convective heat flux as a function of
% time.
%
% inputs
%   simtable: contains the full sim data.
%   rn: nose cone radius (in m)
%
% output: 
%   qdot: heat flux per unit area (in W/m^2)


%ref Aerothermodynamics of Transatmospheric Vehicles by Michael E.
%Tauber and Gene P. Meneesf and Henry G. Adelmant
%(https://arc.aiaa.org/doi/pdf/10.2514/3.45483)

% Written by Dev Agrawal (28 Nov 2018) [devansh@mit.edu]


%% define empirical constants
N = 0.5;
M = 3;
gw = 0; %ratio of wall enthalpy to total enthalpy (assumed 0 in worst case)
C = 1.83*10^(-8) * (1/sqrt(rn)) * (1-gw); %rn in meters

%% get sim data
% get rho from altitude
h_m = simtable.Altitude_ft_.*0.3048; %convert altitude to meters
[~,~,~,rho]=atmoscoesa(h_m);

% get velocity
V = simtable.Velocity_ft_sec_.*0.3048; %velocity in m/s


%% calculate heat flux
qdot_nc = (100^2) .* C .* rho.^N .* V.^M; %in W/m^2


end