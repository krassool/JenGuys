%%Master script controlling serial comms to arduino and does trajectories.

%initialise workspace
clc
clear
addpath('functions') %folder functions should be in the path
if ~isempty(instrfind)
    fclose(instrfind);
    delete(instrfindall);
end

%define data chunk length
ChunkLength=3;

%initial time step for trajectories
t_step = 1; %keep it so you'll get integers from your time. this could be a failure mode :s

%initial positions for tower
LoadingX    =  220;
LoadingY    =  150;
TowerX      = -220;
TowerY      =  150;


%run initial trajectories
[QmatAdjStore , vals_per_traj] = JenGuysQFunc(LoadingX,LoadingY,TowerX,TowerY);

%% Start serial connection

s = serial('/dev/tty.usbmodem1411','BaudRate',9600);
fopen(s);

% Send number of trajectories
trajstr = strcat('m',vals_per_traj,'x')
fwrite(s,trajstr);

%% Accounting for the data
% Lengths of data
OverallLength = length(QmatAdjStore);

%% Loop over each chunk to deliver it the arduino when asked
for ll=1:OverallLength    
    
    %%% Check is the arduino is ready for more information
    %%%% WAIT FOR READY FROM ARDUINO %%%%%
    buff=''; %define buff as blank
    
    while sum(buff=='N')==0; %sees if the currne.
        [buff,count] = fscanf(s); %read the buffer, save as buff
        
        %do nothing
    end
    
    %Define current chunk to send
    QSend=QmatAdjStore(ll,:);
    
    %%%%%%% SEND HEADER %%%%%%%
%     if ll==0 %send this on the first time round
%         ChunkStr = strcat( 'h' , num2str(ChunkLength) )
%         fwrite(s,ChunkStr);   %write the qs to arduino
%     end
    
    %%%%%%% SEND DATA CHUNK %%%%%%%
    current_qs=strcat('t',num2str(QSend(1)),'x','t',num2str(QSend(2)), 'x', ...
        't',num2str(QSend(3)),'x','t',num2str(QSend(4)),'x','t',num2str(QSend(5)),'x');
    fwrite(s,current_qs);   %write the qs to arduino
    
    %%%%%%% SEND FOOTER %%%%%%%
    FooterStr = strcat( 'f' , '1' ); %send a random number... because I'm lazy and I don't know if it needs a number
    fwrite(s,FooterStr);   %write the qs to arduino
    
end


fclose(s);




