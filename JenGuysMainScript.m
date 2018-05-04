%% Main JenGuys Robot
addpath('functions') %folder functions should be in the path


%% Robot Params
%Robot paramters in mm
b   = 160;
L1  = 180;
L2  = 240;
L3  = 50;
R_Params = [b, L1, L2, L3];

%DH Table
alph    =    [0   -90    0     0     -90 ];
a       =    [0    0     L1    L2    0   ];
d       =    [b    0     0     0     L3  ];
theta   =    [q1 q2-90 q3+90   q4    q5  ];
% combined
DH      =    [alpha' , a' , d' , theta'];

%% Arduino set up

ardUno = arduino('/dev/tty.usbmodem1411','uno', 'Libraries', 'Servo');
MotorStruct = MotorParams();
ServoSetup(MotorStruct,ardUno);

return



%% Set up
[ Orientation , Position , Velocity ] = TrajectoryPlanFn(); % plan trajectory

%% Loop
for kk=1:100
    
    [Qmat] = InvKinLean( Position(kk,1) , Position(kk,2) , Position(kk,3) ,R_Params );
    TurnServos(Qmat,ardUno);
    




Pot2q(ardUno); %NEEDS CALIBRATION, takes your analog reads and outputs q
end




%
%
% %% Initlaise qs
% [Q1,Q2,Q3,Q4,Q5]=deal(zeros(length(Position_Long),1));
%
% for l=1:length(Position_Long)
%     %     inverse kinematics
%     [Q1(l),Q2(l),Q3(l),Q4(l),Q5(l)] = InvKinLean( Position_Long(l,1) , Position_Long(l,2) , Position_Long(l,3) ,R_Params );
% end
%
% LPVO=zeros(3,6,length(Position_Long));
% for g=1:length(Position_Long)
%     [T LPVO(:,:,g)] = ForKinLean(Q1(g),Q2(g),Q3(g),Q4(g),Q5(g),R_Params);
% end

