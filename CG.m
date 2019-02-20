function [CG] = CG(mMotor, lMotor, mOther, lOther)
% CG distance from the nose. Assumes that non-motor mass is all in front of
% the motor and distributed equally.

l = lMotor + lOther; % Total Length
m = mMotor + mOther; % Total Mass
moment = mMotor*(l - lMotor/2) + mOther*(lOther/2);
CG = moment/m;

