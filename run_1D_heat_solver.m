function [x, t, Tstore] = run_1D_heat_solver(simtable, thermal_sim_inputs,timevec, qdotvec,simname)



% Function perfroms a 1D transient thermal analysis on the nose cone given
% the thermal loads it should experience.
%
% inputs
%   simtable: contains the full sim data.
%   thermal_sim_inputs: .mat file containing all the parameters needed
%   for the thermal sim
%   timevec: time vector (in secs) used when interpolating the heatflux.
%   Also defines how long the sim runs for.
%   qdotvec: heat flux into the material as a function of timevec. (in
%   W/m^2)
%   simname: simulation name used for naming plots.
%
% output: 
%   x: vector of positions along the wall
%   t: vector of times that are solved for
%   Tstore: temperature at given (x,t) in Kelvin.

% Written by Dev Agrawal (30 Nov 2018) [devansh@mit.edu]

%% reload structures into workspace;

liveplot = thermal_sim_inputs.liveplot;
save_to_animation = thermal_sim_inputs.save_to_animation;

if save_to_animation == 1 %force it to plot if a animation is desired;
    liveplot = 1;
end

if liveplot
    figure;
    fignum = get(gcf,'Number');
end

%load geometry
L = thermal_sim_inputs.L; %thickness of material to solve over;
Tinitial = thermal_sim_inputs.Tinitial;

%load material properties
conductivity = thermal_sim_inputs.conductivity;
heatcapacity = thermal_sim_inputs.heatcapacity;
density = thermal_sim_inputs.density;
emiss = thermal_sim_inputs.emiss;

kappa = conductivity/(heatcapacity*density); %diffusivity
sb = 5.67e-8; %stephan boltzman constant


%% get freestream air temp as function of time
h_m = simtable.Altitude_ft_.*0.3048; %convert altitude to meters
[Tatmvec,~,~,~]=atmoscoesa(h_m);

Tatmvec = Tatmvec(1:length(timevec));
%% determine step size
nx = 81; %assume we want 81 points along x axis

x = linspace(0,L,nx); %row vector in wall direction

dx = x(2)-x(1); %get the position step size.

% dx^2/(2*kappa) is the largest time step that would be stable so take 80%
% of that as the default time step to use in the simulator
tmax = max(timevec);
dt = 0.8*(dx^2/(2*kappa));
t = 0:dt:tmax; % create time vector used to store simulation results
nt = length(t)-1;


%% initialize temperature matrices
T = ones(size(x))*Tinitial;  %temporary storage of temperature vector at each sim step.

Tstore(1,:) = T; %overall storage of temperature 

%% set up the wait bar if not live animating
if ~liveplot
    f = waitbar(0,'1','Name',strcat('Solving ',simname),...
        'CreateCancelBtn','setappdata(gcbf,''canceling'',1)');

    setappdata(f,'canceling',0);
end

%% set up animation

if save_to_animation
    v = VideoWriter(strcat('thermal_animation_',simname,'.avi'));
    open(v);
end

%% %%%%%%%%% solve  %%%%%%%%%%%
time = 0;

for n=1:nt % Timestep loop
    
    %update waitbar
    if ~liveplot
        if getappdata(f,'canceling')
           break
        end
        waitbar(n/nt,f,sprintf('%.1f',100*n/nt))
    end
    
    % Compute new temperature Tnew = zeros(1,nx); for i=2:nx-1
    Tnew = zeros(1,nx);
    for i=2:nx-1
        Tnew(i) = T(i) +  kappa*(dt/dx.^2).*(T(i+1)-2*T(i)+T(i-1));
    end
    
    %step time
    time = time + dt;
    
    %determine nose cone heating
    qdotnc = interp1(timevec,qdotvec,time); %linear interpolation of qdot vector
    
    %get atmospheric free stream temperature
    
    Tatm = interp1(timevec,Tatmvec,time);
    
    %set boundary conditions 
    Tnew(1) = Tnew(2)-(dx/conductivity)*(-qdotnc + emiss*sb*(T(1)^4-Tatm^4)); %uses one step 
    Tnew(nx) = Tnew(nx-1); %0 gradient in the back surface
    
    %update temp and time
    T = Tnew;
    
    Tstore(n+1,:) = T;
    
    if liveplot
        figure(fignum)
        if max(Tnew)>(700+273)
            plot(x, Tnew-273,'r')
        else
           plot(x, Tnew-273,'b')
        end
        title(strcat(simname, sprintf(' - t = %.1f',time)))
        xlabel('Wall Thickness (m)')
        ylabel('Temperature (C)')
        grid on
        %xlim([0,4]);
        %ylim([0,1600]);
        drawnow 
        if save_to_animation
            frame = getframe(gcf);
            writeVideo(v,frame)
        end
    end
    
end


if ~liveplot
    delete(f)
end
if save_to_animation
    close(v);
end
