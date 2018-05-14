function [QmatAdjStore] = JenGuysQFunc(LoadingX,LoadingY,TowerX,TowerY)

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

%% Can remove Motor Struct If required (put it on Arduino instead?)
MotorStruct = MotorParams();

%% Set up
[ Orientation , Position , Velocity ] = TrajectoryPlanFn(t_step,LoadingX,LoadingY,TowerX,TowerY); % plan trajectory

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


