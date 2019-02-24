function [CG2] = CG2(mMotor1, lMotor1, mOther1, lOther1, mMotor2, lMotor2, mOther2, lOther2 )
% CG distance from the nose of a 2 stage rocket on the pad. Assumes that non-motor mass is all in front of
% the motor and distributed equally.

l1 = lMotor1 + lOther1; % Total length of the booster
l2 = lMotor2 + lOther2; % Total length of the sustainer
l_total = l1 + l2; % Combined length of booster and sustainer

m1 = mMotor1 + mOther1; % Total mass of booster
m2 = mMotor2 + mOther2; % Total mass of sustainer
m_total = m1 + m2; % Combined mass of booster and sustainer

moment1 = mMotor1*(l1 - lMotor1/2) + mOther1*(lOther1/2);
CG_1 = moment1/m1;
moment2 = mMotor2*(l2 - lMotor2/2) + mOther2*(lOther2/2);
CG_2 = moment2/m2;

moment = m1*(l_total - CG_1) + m2*CG_2;
CG2 = moment/m_total
end