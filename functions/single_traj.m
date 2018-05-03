function [ u_traj_pos, u_traj_vel ] = single_traj(posies, vels, times , t_step);




%Do trajectory planning for one point
u_0      =  posies(1);  %point
u_p1     =  posies(2);
u_p2     =  posies(3);         %function of block planning
u_f      =  posies(4);          %function of block planning
u_0_dot  =  vels(1);  %velocity at point
u_p1_dot =  vels(2);
u_p2_dot =  vels(3);
u_f_dot  =  vels(4);
t_p1     =  times(1); %delta time to complete arc
t_p2     =  times(2);
t_f      =  times(3);

%%%%%% FIRST ARC (u) Loading bay to P1
t_a1=0:t_step:t_p1-t_step; %define time for this arc. the -t_step at the end is so that the next arc doesn't double up
[a1, b1, c1, d1] = cubic_trajectory_zero_crap(u_0,u_p1,u_0_dot,u_p1_dot,t_p1);
[u_a1,u_dot_a1] = my_polyval(a1, b1, c1, d1, t_a1);


%%%%%% SECOND ARC (u) P1 to P2
t_a2=0:t_step:t_p2-t_step; %define time for this arc. the -t_step at the end is so that the next arc doesn't double up
[a2, b2, c2, d2] = cubic_trajectory_zero_crap(u_p1,u_p2,u_p1_dot,u_p2_dot,t_p2);
[u_a2,u_dot_a2] = my_polyval(a2, b2, c2, d2, t_a2);

%%%%%% Third ARC (u) P2 to F
t_a3=0:t_step:t_f;  %define time for this arc. no -t_step required as it's the final arc
[a3, b3, c3, d3] = cubic_trajectory_zero_crap(u_p2,u_f,u_p2_dot,u_f_dot,t_f);
[u_a3,u_dot_a3] = my_polyval(a3, b3, c3, d3, t_a3);

u_traj_pos=[u_a1';u_a2';u_a3'];
u_traj_vel=[u_dot_a1';u_dot_a2';u_dot_a3'];
