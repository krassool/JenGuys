function [T LPVO] = ForKinLean(q1,q2,q3,q4,q5,R_Params)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
% params
b   =   R_Params(1);
L1  =   R_Params(2);
L2  =   R_Params(3);
L3  =   R_Params(4);

%DH Table
alph    =    [0   -90    0     0     -90 ];
a       =    [0    0     L1    L2    0   ];
d       =    [b    0     0     0     L3  ];
theta   =    [q1 q2-90 q3+90   q4    q5  ];
% combined
% DH      =    [alpha' , a' , d' , theta'];
 
 %Transformation matrices
   for i=1:5
      A(:,:,i)=TranMat(a(i),alph(i),d(i),theta(i));
   end
   
 %Transformation matrices relative to base
   T=A;
%loop which creates the T matrix, where T(1) is _0^1-T and T(n) is _n-1^n-T
 for k=2:5
    T(:,:,k)=T(:,:,k-1)*A(:,:,k);
 end

 %X Y Z vector extraction
X_vec=T(1,4,:);
Y_vec=T(2,4,:);
Z_vec=T(3,4,:);

X_vec=reshape(X_vec,1,(numel(X_vec)));
Y_vec=reshape(Y_vec,1,(numel(Y_vec)));
Z_vec=reshape(Z_vec,1,(numel(Z_vec)));

LPV=[X_vec;Y_vec;Z_vec] ; %Link position vector
LPVO=[[0;0;0] , LPV]    ; %%Link position vector with Origin

% %shift up by L1 (also called 'b' in our report) NO LONGER REQUIRED. FIXED
% DH
% LPVO(3,3:6,:)=LPVO(3,3:6,:);
%% Plot 3d
% 
% cla
% %Draw Jenga Tower 
% p1=[180 37.5 0];
% p2=[255 37.5 0];
% p3=[255 -37.5 0];
% p4=[180 -37.5 0];
% p5=[180 37.5 270];
% p6=[255 37.5 270];
% p7=[255 -37.5 270];
% p8=[180 -37.5 270];
% 
% poly_rectangle(p1,p2,p3,p4)
% poly_rectangle(p1,p5,p8,p4)
% poly_rectangle(p1,p2,p6,p5)
% poly_rectangle(p3,p7,p6,p2)
% poly_rectangle(p4,p8,p7,p3)
% poly_rectangle(p8,p5,p6,p7)
% 
% plot3(LPVO(1,:),LPVO(2,:),LPVO(3,:),'-o','LineWidth',3);
% 
% % very over-the-top axis defintion
% sqr_mag=350;
% xmin= -sqr_mag ; xmax = sqr_mag; ymin = -sqr_mag; ymax = sqr_mag; zmin = -sqr_mag; zmax = sqr_mag;
% axis([xmin xmax ymin ymax zmin zmax]);
% xlabel('X');    ylabel('Y');    zlabel('Z') %set the axis labels
% view(45, 45); %set isometric view
% grid on
% hold on
% 
% %draw the floor
% [x,y] = meshgrid(-sqr_mag:100:sqr_mag); % Generate x and y data
% z = zeros(size(x, 1)); % Generate z data
% surf(x, y, z) % Plot the surface
% alpha 0.3
% hold on

end

