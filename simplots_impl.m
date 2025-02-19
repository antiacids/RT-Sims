function [Mmax] = simplots_impl(simtable, mass, massrange, mass_scale, masses, thrust, thrustrange, Mmax)
do_thermal_nose_cone_tip = 1;
thisSimMax = max(simtable.MachNumber);
            if thisSimMax > Mmax
                Mmax = thisSimMax;
            else
                Mmax = Mmax;
            end

            % Formatting for all plots
            masscolor = (max(massrange)-mass) / mass_scale;
            idthrust = find(sort(thrustrange)==thrust);
            thrustspec = idthrust;
            % TODO add to function parameters:  'Color',[0,0,masscolor]

            % machVtimeplot
            figure(1);
            hold on;
            machVtimeplot(simtable,masscolor,thrustspec); %, 'color', masscolor);
            export_fig machVtime.pdf;


            % Qvtimeplot
            figure(2);
            hold on;
            QVtimeplot(simtable,masscolor,thrustspec);
            export_fig QVtime.pdf;
            append_pdfs ('compiled.pdf','machVtime.pdf', 'QVtime.pdf')

            %AVtimeplot
            figure(3);
            AVtimeplot(simtable,masscolor,thrustspec);
            export_fig AVtime.pdf;
            hold on;
            
            
            % forceVtimeplot
%             figure(4);
%             hold on;
%             masses.dry = mass;
%             
%             subplot(2,2,1);
%             forceVtimeplot(simtable,masscolor,masses.bulkhead,thrustspec);
%             title('Payload Bulkhead Compressive Load');
%             axis([0 20 -300 600]);
%             hold on;
% 
%             subplot(2,2,2);
%             forceVtimeplot(simtable,masscolor,masses.fin_can,thrustspec);
%             title('Fin Can Compressive Load');
%             axis([0 20 -300 600]);
%             hold on;
%             
% %             subplot(2,2,3);
% %             forceVtimeplot(simtable,masscolor,masses.recovery_coupler,thrustspec);
% %             title('Recovery Coupler Compressive Load');
% %             axis([0 20 -40000 90000]);
% %             hold on;
%             
%             subplot(2,2,4);
%             forceVtimeplot(simtable,masscolor,masses.motor_case,thrustspec);
%             axis([0 20 -300 600]);
%             title('Start of Motor Case Compressive Load');    
%             
%             title('Compressive loads')
%             
                       
            % altVtimeplot
            figure(5);
            hold on; 
            altVtimeplot(simtable,masscolor,thrustspec);
            export_fig altVtime.pdf
            
            
            if do_thermal_nose_cone_tip ==1
                simname = 'thermal sim';
                load('thermal_sim_inputs');
                nose_cone_thermal_analysis(simtable,thermal_sim_inputs,simname,masscolor,thrustspec)
            end