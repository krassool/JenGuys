%% Main JenGuys Robot
addpath('functions') %folder functions should be in the path

%% Options
PLOT=0;

%% Robot Params
%Robot paramters in mm
b   = 125; %plus half the box
L1  = 180;
L2  = 172;
L3  = 110;
R_Params = [b, L1, L2, L3];

%DH table defined within ForKinLean function

%physical vars
t_step = .2; %keep it so you'll get integers from your time. this could be a failure mode :s
t_step_loop = 0.0; %keep it so you'll get integers from your time. this could be a failure mode :s

%% Arduino set up

if exist('ardUno')==0;
    try
        ardUno = arduino('/dev/tty.usbmodem1421','uno', 'Libraries', 'Servo');
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

%% Temporary cut position vector
Position=Position(1:150,:);


%% Loop
num_traj=length(Position); %number of trajectory points in total

%initilaise output matrices
QmatStore       =   zeros(num_traj,5)   ;
QmatAdjStore    =   QmatStore           ;

% num_traj=1;


for kk=1:num_traj;
    [Qmat] = InvKinLean( Position(kk,1) , Position(kk,2) , Position(kk,3) ,R_Params );
%     QmatMat=[ 0, 34.0688 , -8.3879 , 42 , 0 ];
%     QmatMat=[ 0, 34.0688 , 34.0688 , 0 , 0 ];
%     QmatMat=[ 0, 41.8314, 9.4078 , -51.2392 , 0 ];
    
    QmatAdj = AdjustAngles( Qmat , MotorStruct );
    
    
    QmatStore(kk,:)     =   Qmat    ;
    QmatAdjStore(kk,:)  =   QmatAdj ;
    
    if arduino_connect
        TurnServos(QmatAdj,servoObj);
        Qdecimal = (QmatAdj+90)/180; %this is becuse the input angles have the range -90 to +90
        QmatAdj;
        Qmat;
        if kk>1;
%             turn_stepper(QmatAdjStore(kk,1) , QmatAdjStore(kk-1,1) , ardUno )
        else
%             turn_stepper(QmatAdjStore(kk,1) , 0 , ardUno )
        end
        
        
    end
    
    pause(t_step_loop)
    
end

% close all
% plot(OUTPUTmatAdj)

%% Plot

%Choose if to plot or not.
if PLOT==1;
    %generate plot points
    LPVO=zeros(3,6,length(Position));
    for g=1:length(Position)
        [T LPVO(:,:,g)] = ForKinLean(QmatStore(g,1),QmatStore(g,2),...
            QmatStore(g,3),QmatStore(g,4),QmatStore(g,5),R_Params);
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

