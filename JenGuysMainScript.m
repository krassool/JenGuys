%% Main JenGuys Robot
clear
addpath('functions') %folder functions should be in the path


%% Robot Params
%Robot paramters in mm
b   = 160;
L1  = 180;
L2  = 240;
L3  = 50;
R_Params = [b, L1, L2, L3];

%DH table defined within ForKinLean function

%physical vars
t_step = 0.5; %keep it so you'll get integers from your time. this could be a failure mode :s


%% Arduino set up

ardUno = arduino('/dev/tty.usbmodem1411','uno', 'Libraries', 'Servo');
MotorStruct = MotorParams();
servoObj = ServoSetup(MotorStruct,ardUno);

%% Set up
[ Orientation , Position , Velocity ] = TrajectoryPlanFn(t_step); % plan trajectory

%% Loop
num_traj=length(Position); %number of trajectory points in total

% OUTPUTmat=zeros(num_traj,5);
for kk=1:num_traj;
    [Qmat] = InvKinLean( Position(kk,1) , Position(kk,2) , Position(kk,3) ,R_Params );
    %     OUTPUTmat(kk,:)=Qmat;
    
    TurnServos(Qmat,ardUno,servoObj);
    pause(t_step)
    
    
    
    
end


Pot2q(ardUno); %NEEDS CALIBRATION, takes your analog reads and outputs q
% end


% LPVO=zeros(3,6,length(Position_Long));
% for g=1:length(Position_Long)
%     [T LPVO(:,:,g)] = ForKinLean(Q1(g),Q2(g),Q3(g),Q4(g),Q5(g),R_Params);
% end

