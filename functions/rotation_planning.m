function  [ padded_Ot, padded_Ot_dot ] = rotation_planning(deg_0, deg_f, times , t_step);
%creates a rotation in one axis over a set time.
%allows for the roattion to not take the total time, creates a duplciate
%positions to account for the required pause.

tot_time=sum(times); %total time for going from loading bay to block pos
num_steps = tot_time/t_step;


%Orientation - Just rotate q5 from 0-->90 to drop off and then reverese to
%pick up again

t_orient=0:t_step:times(1)+times(2); %time to finish orient
[a_o, b_o, c_o, d_o] = cubic_trajectory_zero_crap(deg_0,deg_f,0,0,times(1)+times(2)); %cubics
[Ot,Ot_dot] = my_polyval(a_o, b_o, c_o, d_o, t_orient);



%add the final value to create a puase and link up with the timing of the
%rest of the system
Ot_padding=ones(num_steps+1,1)*Ot(end);
Ot_dot_padding=zeros(num_steps+1,1);

padded_Ot=Ot_padding;
padded_Ot_dot=Ot_dot_padding;

padded_Ot(1:length(Ot))         =Ot;
padded_Ot_dot(1:length(Ot_dot)) =Ot_dot;

% padded_Ot=padded_Ot'
% padded_Ot_dot=padded_Ot_dot'








