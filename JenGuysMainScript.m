%% Main JenGuys Robot


addpath('functions') %folder functions should be in the path

%% Options
PLOT=1;


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
t_step_loop = .02; %keep it so you'll get integers from your time. this could be a failure mode :s


%% Arduino set up

if exist('ardUno')==0;
    try
        ardUno = arduino('/dev/tty.usbmodem1411','uno', 'Libraries', 'Servo');
        arduino_connect=1;
    catch
        fprintf('No arduino found')
        arduino_connect=0;
    end
end

MotorStruct = MotorParams();

if (exist('servoObj')==0) && arduino_connect
    servoObj = ServoSetup(MotorStruct,ardUno);
end

%% Set up
[ Orientation , Position , Velocity ] = TrajectoryPlanFn(t_step); % plan trajectory




%% Loop
num_traj=length(Position); %number of trajectory points in total

%initilaise output matrices
OUTPUTmat       =   zeros(num_traj,5)   ;
OUTPUTmatAdj    =   OUTPUTmat           ;


for kk=1:num_traj;
    [Qmat] = InvKinLean( Position(kk,1) , Position(kk,2) , Position(kk,3) ,R_Params );
    
    
    QmatAdj = AdjustAngles( Qmat , MotorStruct );
    
    OUTPUTmat(kk,:)     =   Qmat    ;
    OUTPUTmatAdj(kk,:)  =   QmatAdj ;
    
    if arduino_connect
        TurnServos(QmatAdj,ardUno,servoObj);
    end
    %     pause(t_step_loop)
    
    
    
    
end

close all
% plot(OUTPUTmatAdj)

%% Plot

%Choose if to plot or not.
if PLOT==1;
    %generate plot points
    LPVO=zeros(3,6,length(Position));
    for g=1:length(Position)
        [T LPVO(:,:,g)] = ForKinLean(OUTPUTmat(g,1),OUTPUTmat(g,2),...
            OUTPUTmat(g,3),OUTPUTmat(g,4),OUTPUTmat(g,5),R_Params);
    end
    
    %plot in 3d
    Plot3dJenga(LPVO,Position)
end

% Pot2q(ardUno); %NEEDS CALIBRATION, takes your analog reads and outputs q
% end


% LPVO=zeros(3,6,length(Position_Long));
% for g=1:length(Position_Long)
%     [T LPVO(:,:,g)] = ForKinLean(Q1(g),Q2(g),Q3(g),Q4(g),Q5(g),R_Params);
% end

