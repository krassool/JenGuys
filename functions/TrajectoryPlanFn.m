function [ Orientation_Long , Position_Long , Velocity_Long ] =  TrajectoryPlanFn(t_step)

%% block planning

num_blocks=54;
tower_y= 0;
tower_x=  230.50 ;
[ BlMat ] = block_planning(tower_y, tower_x); %returns a matrix with 54x3 elements. 54 blocks with there respective x y and z positions

%% Trajectory Planning %%%%%%%%%%%%%%%

% Fixed parameters
Via1xy=[ 217.5, 67.5 ]; %x,y position of first via point
suction_pause = 3; %in seconds

%fixed vectors
PL     =[217.5,67.5,15]  ; %loading bay position
vels_x =[0, 50, 0, 0] ; %velocoity at (PL, P1, P2, Pf) in mm/s
vels_y =[0, 50, 0, 0] ; %velocoity at (PL, P1, P2, Pf) in mm/s
vels_z =[0, 50, 10, 0]; %velocoity at (PL, P1, P2, Pf) in mm/s
times  =[ 2, 4, 2 ]   ; %time for each arc (PL -> P1, then P1 -> P2, then P2 -> Pf
via_clear=75;
deg_0=0;
deg_f=90;

%caluclated values
tot_time=sum(times)+ (suction_pause); %total time for going from loading bay to block pos
% assumes the same time to get back and therefore assumes the same pause time at 'pickup' and 'dropoff'
suction_pause_cycle = round(suction_pause/t_step);
vals_per_traj = tot_time/t_step+1; %number of values in each trajectory **ONE WAY**
vals_per_return = vals_per_traj*2; %number of values in each trajectory **RETURN **

%initialise output matrix
BFM_Position = zeros(vals_per_return,3,num_blocks); %54 blocks
BFM_Velocity = zeros(vals_per_return,3,num_blocks); %54 blocks
BFM_Rotation = zeros(vals_per_return,1,num_blocks); %54 blocks
BFM_AngulVel = zeros(vals_per_return,1,num_blocks); %54 blocks

% Loop to find all the trajectories, store them in BFMs
for k=1:num_blocks
    
    P1 = [Via1xy , BlMat(k,3)+ via_clear]; %first via point is some x,y and the z height of the block plus some offset in the z
    Pf = BlMat(k,:); %final location is that of the block
    P2 = [BlMat(k,1:2) , BlMat(k,3) + via_clear]; %second via point is the block location plus some offset in z
    
    posies_x=[PL(1),P1(1),P2(1),Pf(1)];
    posies_y=[PL(2),P1(2),P2(2),Pf(2)];
    posies_z=[PL(3),P1(3),P2(3),Pf(3)];
    
    [ x_traj_pos, x_traj_vel ] = single_traj(posies_x, vels_x, times , t_step);
    [ y_traj_pos, y_traj_vel ] = single_traj(posies_y, vels_y, times , t_step);
    [ z_traj_pos, z_traj_vel ] = single_traj(posies_z, vels_z, times , t_step);
    [ Ot, Ot_dot ]             = rotation_planning(deg_0, deg_f, times , t_step);
    
    
    %create x,y,z matrices
    POS_traj = [x_traj_pos,y_traj_pos,z_traj_pos];
    VEL_traj = [x_traj_vel,y_traj_vel,z_traj_vel];
    
    %create reverse path, back to the loading bay
    
    REV_POS_traj = flipud(POS_traj);
    REV_VEL_traj = flipud(VEL_traj);
    REV_Ot = flipud(Ot);
    REV_Ot_dot = flipud(Ot_dot);
    
    %add pauses (optional)
    %translation/velocity
    POS_traj = [POS_traj ; (ones(suction_pause_cycle,3).*Pf)];
    VEL_traj = [VEL_traj ; zeros(suction_pause_cycle,3)];
    REV_POS_traj = [REV_POS_traj ; (ones(suction_pause_cycle,3).*PL)];
    REV_VEL_traj = [REV_VEL_traj ; zeros(suction_pause_cycle,3)];
    %rotation
    Ot          =    [Ot ; (ones(suction_pause_cycle,1).*deg_f)];
    Ot_dot      =    [Ot_dot ; zeros(suction_pause_cycle,1)];
    REV_Ot      =    [REV_Ot ; (ones(suction_pause_cycle,1).*deg_0)];
    REV_Ot_dot  =    [REV_Ot_dot ; zeros(suction_pause_cycle,1)];
    
    
    
    
    BFM_Position(:,:,k) =   [POS_traj;REV_POS_traj];
    BFM_Velocity(:,:,k) =   [VEL_traj;REV_VEL_traj];
    %     BFM_Rotation(:,:,k) = [Ot;REV_Ot];
    %     BFM_AngulVel(:,:,k) =   [Ot_dot;REV_Ot_dot]
    
    Orientation_layer1=[zeros(38,1)];
    Orientation_layer2=[Ot;REV_Ot];
    Orientation_2Layer=[repmat(Orientation_layer1,3,1); repmat(Orientation_layer2,3,1)]; %David's hacky method
    Orientation_Long=repmat(Orientation_2Layer,num_blocks/6,1);
end

%% Rearrange the BFMs
%this rearranges the 3d BFMs in to 2d long matrices.
%complicated to actually do this, see:
%https://au.mathworks.com/matlabcentral/answers/282896-change-a-3d-matrix-to-a-stacked-2d-matrix
Position_Long = reshape(permute(BFM_Position, [2 1 3]), size(BFM_Position, 2), [])';
Velocity_Long = reshape(permute(BFM_Velocity, [2 1 3]), size(BFM_Velocity, 2), [])';

end
