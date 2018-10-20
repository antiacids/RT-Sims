maxalt = 100000; %feet
vsea = 100; %ft/s
alt = 0:10:0.3048000097536*maxalt;
[T,a,P,rho] = atmoscoesa(alt);

alt = alt/0.3048000097536;
rho = rho*0.00194032;
a = a * 3.28084;

rhoscaled = arrayfun(@(r) sqrt(rho(1)/r), rho);
mach =  arrayfun(@(r,ss) vsea*r/(ss), rhoscaled, a);
altkft = alt./1000;

% Parachute Parameters
CdS_main = 92.55;
Cd_S_drogue_corr = 7.453217499; %body Corrected Drogue CdS
Cd_S_drogue_corr_max = 7.885186489;
Cd_S_drogue_corr_min = 7.02124851;
rho_launchsite = 0.00198; % slugs/ft^3
Wtypical = 87.65;
Wuncertainty = 12.14;

Wmax = Wtypical + Wuncertainty;
Wmin = Wtypical - Wuncertainty;

%DROGUE
figure(3);
vKin = @(ww,CdS) arrayfun(@(rr) sqrt(2*ww/CdS/rr), rho);
% vKin = @(w,Cds)  sqrt(2*w/(CdS*rho))

mKin = @(ww,CdS) arrayfun(@(vk,aa) vk/aa, vKin(ww,CdS),a);
annotation('textbox','String','F_{max}={C_x {1/2} \rho C_dS m v^2}','FitBoxToText','on' );

subplot(1,2,1);
co = get(gca,'ColorOrder'); % Initial
% Change to new colors.
set(gca, 'ColorOrder',  ...
    [0,1,.5;  1,0,.5;...
    .2,.2,.2; .2,.2,.2; .2,.2,.2; .2,.2,.2; .2,.2,.2; .2,.2,.2; .2,.2,.2; .2,.2,.2; .2,.2,.2;],...
    'NextPlot', 'replacechildren');
co = get(gca,'ColorOrder'); % Verify it changed

plot(...
    altkft,mKin(Wtypical,Cd_S_drogue_corr),...
    altkft,mKin(Wmax,Cd_S_drogue_corr_min),...
    altkft,mKin(Wmin,Cd_S_drogue_corr_min));
title('Drogue Deployment Conditions');
legend('Typical Drogue Descent','Max Variation in Drogue C_dS','Min Variation in Drogue C_dS',...
    'Most Recent Ascent Simulation',  'Main','Example Max q at Apogee')
xlabel('Altitude (kft)');
ylabel('Mach');
grid on;
xticks( [0,4,10,20,30,40,50,60,70,80,90,100])
xlim([0,100]);
ylim([0,1]);
point0001 = linspace(1e-4,1e-4,length(alt));

% Cx Force plot
subplot(1,2,2);
grid on;
plot(altkft, rho*Cd_S_drogue_corr^(3/2)/Wtypical,...
    altkft, rho*Cd_S_drogue_corr_min^(3/2)/Wmax,...
   altkft, rho*Cd_S_drogue_corr_max^(3/2)/Wmin,...
    altkft,point0001);
title('Drogue Mass Ratio vs Altitude');
ylabel('Mass Ratio R_m = \rho(C_dS)_0^{3/2}/m_{total}');
xlabel('Altitude (kft)');
legend('Typical Descent','Fastest Foreseeable Descent','Slowest Foreseeable Descent','R_m < 1e-4: range where 1.2 < C_x < 2 and constant');
xlim([20,80]);
% plottools;


% MAIN
figure(7);
transsonic = linspace(.8,.8,length(alt));
vKin = @(initalt) arrayfun(@(alti) sqrt(2*32.17*(initalt-alti)), alt);
mKin = @(initalt) arrayfun(@(vk,aa) vk/aa, vKin(initalt),a);

subplot(1,2,1);
co = get(gca,'ColorOrder'); % Initial
% Change to new colors.
set(gca, 'ColorOrder',  ...
    [0,1,.5;  1,0,.5; .2,.2,.2; .2,.2,.2;],...
    'NextPlot', 'replacechildren');
co = get(gca,'ColorOrder'); % Verify it changed

plot(...
    altkft,rhoscaled*100*.35,altkft,rhoscaled*100*.2,...
   altkft,rhoscaled*100*.75,altkft,rhoscaled*100*1.5);
title('Main Deployment Conditions');
legend('Max Variation in Main C_dS','Min Variation in Main C_dS',...
    'Max Variation in Drogue C_dS','Min Variation in Drogue C_dS');
xlabel('Altitude (kft)');
ylabel('Velocity ft/s');
grid on;
xticks( [0,4.9,4.9+1.5,10])
xlim([0,10]);
ylim([0,180]);

%92.55
subplot(1,2,2);
plot(altkft, rho*92.55^(3/2)/Wmin, altkft, rho*92.55^(3/2)/Wmax );
title('Main Mass Ratio vs Altitude');
ylabel('Mass Ratio R_m = \rho(C_dS)_0^{3/2}/m_{total}');
xlabel('Altitude (kft)');
legend('Fastest Foreseeable Descent','Slowest Foreseeable Descent');
% xticks( [0,4.9,4.9+1.5,10])
grid on; 
xlim([4.6,10]);
annotation('textbox','String','F_{max}={C_x(R_m) {1/2} \rho C_dS m v^2}     .5<C_x<.9' ,'FitBoxToText','on' );
