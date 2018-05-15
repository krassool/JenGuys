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
t_step = .2; %keep it so you'll get integers from your time. this could be a failure mode :s

%initial positions for tower
LoadingX    = 120;
LoadingY    = -70;
TowerX      = 120;
TowerY      = 0;


%run initial trajectories
[QmatAdjStore] = JenGuysQFunc(LoadingX,LoadingY,TowerX,TowerY);

%% Start serial connection

s = serial('/dev/tty.usbmodem1411','BaudRate',115200);
fopen(s);

[A,count] = fscanf(s); %read the buffer, save as A
if prod(A(1:end-2)=='N') %the logical returns a 1 for each char that is right. Product checks that all the values are 1.
    'successful read'
end


%% Accounting for the data
% Lengths of data
OverallLength = length(QmatAdjStore);

% How many chunks?
NumChunks = floor(OverallLength/ChunkLength);
Remainder = rem(OverallLength,ChunkLength); %remainder to be pushed in the last iteration of loop


%if the remainder is zero, don't try to add 1 to the loop
if Remainder
    LoopEnd = NumChunks+1;
else
    LoopEnd = NumChunks;
    
end


%% Loop over each chunk to deliver it the arduino when asked
for ll=1:LoopEnd
    %Define current chunk to send
    QSend=QmatAdjStore(ll,:);
    
    %%%%% Checks if it's the last loop 
    if(ll>NumChunks) %if it's on the 'leftovers' loop. Cut the number of qs to be sent to the remaineder (what's left)
        ChunkLength=Remainder;
    end
    
    %%%%%%% SEND HEADER %%%%%%%
    if ll==0 %send this on the first time round
        ChunkStr = strcat( 'h' , num2str(ChunkLength) )
        fwrite(s,ChunkStr);   %write the qs to arduino
    end
    
    %%%%%%% SEND DATA CHUNK %%%%%%%
    for kk=1:ChunkLength
        current_qs=strcat('t',num2str(QSend(kk,1)),'x','t',num2str(QSend(kk,2)), 'x', ...
            't',num2str(QSend(kk,3)),'x','t',num2str(QSend(kk,4)),'x','t',num2str(QSend(kk,5)),'x');
        fwrite(s,current_qs);   %write the qs to arduino        
    end

    %%%%%%% SEND FOOTER %%%%%%%
    FooterStr = strcat( 'f' , '1' ) %send a random number... because I'm lazy and I don't know if it needs a number
    fwrite(s,FooterStr);   %write the qs to arduino
    
    
    %%%%%%% WAIT FOR INFORMATION FROM ARDUINO %%%%%%%
    buff=''; %define buff as blank
    %%% Check is the arduino is ready for more information
    while sum(buff=='N')==0; %sees if the currne.
            [buff,count] = fscanf(s); %read the buffer, save as buff
            
            %do nothing
    end
    
    
    
end


fclose(s);




