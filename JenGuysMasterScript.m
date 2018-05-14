function [] = JenGuysQFunc(LoadingX,LoadingY,TowerX,TowerY)


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

MotorStruct = MotorParams();

%% Set up
[ Orientation , Position , Velocity ] = TrajectoryPlanFn(t_step,LoadingX,LoadingY,TowerX,TowerY); % plan trajectory

%% Temporary cut position vector
Position=Position(1:50,:);

%% Loop
num_traj=length(Position); %number of trajectory points in total

%initilaise output matrices
QmatStore       =   zeros(num_traj,5)   ;
QmatAdjStore    =   QmatStore           ;

for kk=1:num_traj;
    [Qmat] = InvKinLean( Position(kk,1) , Position(kk,2) , Position(kk,3) ,R_Params );
    QmatAdj = AdjustAngles( Qmat , MotorStruct );
    QmatStore(kk,:)     =   Qmat    ;
    QmatAdjStore(kk,:)  =   QmatAdj ;
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

export =0;
%Export
if export==1;
    
    %%HACKY TEMP FIX
    QmatAdjStore(:,2)=-QmatAdjStore(:,2);
    
    ExpMatrix = [ QmatAdjStore ];
    output_filename=strcat('exportqs','.csv');
    dlmwrite(output_filename,ExpMatrix','precision','%.1f')
end


