function [] = Plot3dJenga(LPVO,Position_Long)


%% block planning

num_blocks=54;
tower_y=-37.5;
tower_x= 180 ;
[ BlMat ] = block_planning(tower_y, tower_x); %returns a matrix with 54x3 elements. 54 blocks with there respective x y and z positions


%% plotting


figure(33);
figure_format(1)
% very over-the-top axis defintion
sqr_mag=350;
xmin= -sqr_mag ; xmax = sqr_mag; ymin = -sqr_mag; ymax = sqr_mag; zmin = -sqr_mag; zmax = sqr_mag;
axis([xmin xmax ymin ymax zmin zmax]);
xlabel('X');    ylabel('Y');    zlabel('Z') %set the axis labels
grid on
view(90,90)
hold on

%draw the floor
[x y] = meshgrid(-sqr_mag:100:sqr_mag); % Generate x and y data
z = zeros(size(x, 1)); % Generate z data

%initlaise tower
block_num=0; %zero blocks stacked to start with
blackout_counter=0;
vals_per_traj= length(Position_Long)/4;

hold on

for h=1:length(Position_Long);%numel(Position_Long)
    
    hold off
    surf(x, y, z) % Plot the surface
    sqr_mag=350;
    xmin= -sqr_mag ; xmax = sqr_mag; ymin = -sqr_mag; ymax = sqr_mag; zmin = -sqr_mag; zmax = sqr_mag;
    axis([xmin xmax ymin ymax zmin zmax]);
    alpha 0.3
    
    hold on
    plot3(LPVO(1,:,h),LPVO(2,:,h),LPVO(3,:,h),'-o','LineWidth',3);
    block_plot_rot([LPVO(1,end,h),LPVO(2,end,h),LPVO(3,end,h)],40);
    tower_plot(block_num,BlMat);
    
    pause(0.01)
    
    
    
    %check if the current position satisfies that of a block location
    if any(sum(  Position_Long(h,:)==round(BlMat(1:block_num+2,:))  ,2)  ==3 ) %%%%TEMPORARY ROUNDING
        if (blackout_counter > vals_per_traj/2)
            blackout_counter=0; %this counter provides a 'blackout' period where the program will not increment the block number.
            % This is to ensure it doesn't invrement the block number twice
            % when the suction cup is only in the vacinity once
            block_num=block_num+1;
            
            
        end
    end
    blackout_counter=blackout_counter+1;
    
end

end

