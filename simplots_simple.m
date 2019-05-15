function [] = simplots_simple()
% Wrapper for plotting. Makes plots for a range of sims. 
%make sure line 4 and 56 have the right directory to your files. also make
%sure the angle mass and thrust range contain the parameters for your sim
do_thermal_nose_cone_tip = 1;
if do_thermal_nose_cone_tip %if you want to perform thermal analysis, we need the thermal data
    
    load thermal_sim_inputs.mat %load the thermal sim inputs mat file
    
end
filename='C:\Users\shannon\Documents\GitHub\RT-Sims\sims\spaceshot\csvs\SD.12.csv';

simtable=readtable(filename);
masscolor=1;
thrustspec=1;
 % machVtimeplot
    figure(1);
    hold on;
    machVtimeplot(simtable,masscolor,thrustspec); %, 'color', masscolor);

    % Qvtimeplot
    figure(2);
    hold on;
    QVtimeplot(simtable,masscolor,thrustspec);

    %AVtimeplot
    figure(3);
    AVtimeplot(simtable,masscolor,thrustspec);
    hold on;

    % altVtimeplot
    figure(4);
    hold on; 
    altVtimeplot(simtable,masscolor,thrustspec);


    if do_thermal_nose_cone_tip ==1
        simname = 'thermal sim';
        load('thermal_sim_inputs');
        nose_cone_thermal_analysis(simtable,thermal_sim_inputs,simname,masscolor,thrustspec)
    end
    
    figure(6);
    yyaxis right;
    plot(simtable.Time_sec_, simtable.Thrust_lb_)
    title('Thrust, Mass flow vs. Time');
    xlabel('Time (s)');
    ylabel('Thrust (lbs)');

    yyaxis left;
    weights=simtable.Weight_lb_;
    times=simtable.Time_sec_;
    massflow=-(weights(2:end)-weights(1:end-1))/(times(2:end)-times(1:end-1));
    massflow(massflow==0)=nan;
    plot(times(1:end-1), massflow);
    ylabel('Mass flow (lbs/s)');

    figure(7);
    hold on;
    yyaxis right;
    plot(simtable.Time_sec_, simtable.CG_in_)
    title('CG, Mass vs. Time');
    xlabel('Time (s)');
    ylabel('CG (in)');

    yyaxis left;
    plot(simtable.Time_sec_, simtable.Weight_lb_)
    xlabel('Time (s)');
    ylabel('Weight (lbs)');

    figure(8);
    hold on;
    plot(simtable.Time_sec_, simtable.CP_in_)
    title('CP vs. Time');
    xlabel('Time (s)');
    ylabel('CP (in)');


    figure(9);
    hold on;
    yyaxis right;
    a1=plot(simtable.MachNumber, simtable.CP_in_);
    title('CP, CG, Mass vs. Mach');
    xlabel('Mach');
    ylabel('CP/CG (in)');
    a2=plot(simtable.MachNumber, simtable.CG_in_);
    xlabel('Mach');

    hold on;
    yyaxis left;
    a3=plot(simtable.MachNumber, simtable.Weight_lb_);
    ylabel('Weight (lbs)');
    legend([a1;a2;a3],'CP','CG','Mass');


    figure(10);
    hold on;
    yyaxis right;
    plot(simtable.MachNumber, simtable.CP_in_)
    title('CP, Drag vs. Mach');
    xlabel('Mach');
    ylabel('CP (in)');

    yyaxis left;
    plot(simtable.MachNumber, simtable.Drag_lb_);
    xlabel('Mach');
    ylabel('Drag (lbs)');

    figure(11);
    hold on;
    plot(simtable.Time_sec_,simtable.CP_in_-simtable.CG_in_);
    title('Stability Margin vs. Time');
    xlabel('Time (sec)');
    ylabel('Stability Margin (in)');
end

