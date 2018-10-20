function [rho] = Rho(altitude)
% Given altidude in ft, returns air pressure in slugs/ft^3
altitude = (altitude)*0.3048000097536;
[T,a,P,rho] = atmoscoesa(altitude);
rho = rho*0.00194032;

