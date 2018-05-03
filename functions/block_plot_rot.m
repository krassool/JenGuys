function block_plot_rot(block_top_centre,thetad)
%jenga block size
l=75;
w=25;
h=15;

%rotation matrix
R       = [cosd(thetad) -sind(thetad); sind(thetad) cosd(thetad)];

%points offset from centre
P1 = [-0.5*w, -0.5*l, -h];
P2 = [ 0.5*w, -0.5*l, -h];
P3 = [ 0.5*w,  0.5*l, -h];
P4 = [-0.5*w,  0.5*l, -h];
P5 = [-0.5*w, -0.5*l,  0];
P6 = [ 0.5*w, -0.5*l,  0];
P7 = [ 0.5*w,  0.5*l,  0];
P8 = [-0.5*w,  0.5*l,  0];

%offset matrix
P_off=[P1;P2;P3;P4;P5;P6;P7;P8];

%rotate offsets in x and y
XY=P_off(:,1:2)  ;
XY_rot=R*XY'     ;

%put together, create vertice matrix
v=block_top_centre+[XY_rot',P_off(:,3)];

%face definition
f=[1 2 3 4; 1 2 6 5; 2 3 7 6; 3 4 8 7; 4 1 5 8; 5 6 7 8];
patch('Faces',f,'Vertices',v,'FaceAlpha',0.2); % plotting the prism with face and vertex data

end



