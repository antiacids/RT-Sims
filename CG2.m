function [CG2] = CG2(mMotor1, lMotor1, mOther1, lOther1, mMotor2, lMotor2, mOther2, lOther2 )
% CG distance from the nose of a 2 stage rocket on the pad. Assumes that non-motor mass is all in front of
% the motor and distributed equally.

l1 = lMotor1 + lOther1; % Total length of the booster
l2 = lMotor2 + lOther2; % Total length of the sustainer
