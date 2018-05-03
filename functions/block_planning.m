function [ loc_matrix ] = block_planning(tower_y, tower_x);


%block planning
%all values in mm

%% Constants def
%'bottom left' corner of the tower at tower_y and tower_x

%size of jenga blocks
J_l = 75;
J_w = 25;
J_h = 15;
%structer of jenga tower
num_blocks = 54;
blocks_per_level=3;
num_levels = num_blocks/blocks_per_level;

%% Pattern of jenga stacking, bottom left at origin (x,y) = (0,0)
z_base_p = 1:num_levels; %base pattern for z
z_pattern = repelem(z_base_p,blocks_per_level); %full tower pattern for z
z_loc=z_pattern*J_h; %real z values in mm

%base pattern for x and y
x_base_p = [1 2 3 2 2 2]-0.5;
y_base_p = [2 2 2 1 2 3]-0.5;

%full tower pattern for x and y
x_pattern = repmat(x_base_p,1,num_levels/2); % divide by two because pattern accounts for 2 levels
y_pattern = repmat(y_base_p,1,num_levels/2); % divide by two because pattern accounts for 2 levels

% real values for x and y in mm
x_loc=x_pattern*J_w; %create location matrix
y_loc=y_pattern*J_w; 

%% offset the the values and build matrix 
x_loc=x_loc+tower_x;
y_loc=y_loc+tower_y;

loc_matrix=[x_loc' , y_loc' , z_loc'];



