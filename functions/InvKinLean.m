function [Qmat] = InvKinLean(X,Y,Z,R_Params)
% Inverse kinematics for robot
% output in degrees

b   =   R_Params(1);
L1  =   R_Params(2);
L2  =   R_Params(3);
L3  =   R_Params(4);

%% Inv Kin 
Q1 = atan2d(Y,X);
x1 = X/cosd(Q1);
Q3 = (real(acosd((x1^2+(Z-b+L3)^2-(L1^2+L2^2))/(2*L1*L2))))-90;%180 - acos(((Z+L5+L3)^2+X^2-L2^2-L1^2)/(-2*L1*L2));
Q2 = -(real(atand((Z-b+L3)/x1)+asind(L2*sind(90-Q3)/sqrt(x1^2+(Z-b+L3)^2))))+90;%acos((L2^2-L1^2-(Z+L5+L3)^2-X^2)/(-2*L1*sqrt((Z+L5+L3)^2+X^2)))+atan((Z+L5+L3)/X);
Q4 =  -Q2-Q3;
Q5 = Q1;

Qmat=[Q1,Q2,Q3,Q4,Q5];

end

