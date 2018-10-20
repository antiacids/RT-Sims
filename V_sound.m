function [v_sound] = V_sound(altitude)
altitude = (altitude)*0.3048000097536;
[T,v_sound,P,rho] = atmoscoesa(altitude);
v_sound = v_sound* 3.28084;
