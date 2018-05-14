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
ChunkLength=10;

%initial time step for trajectories
t_step = .2; %keep it so you'll get integers from your time. this could be a failure mode :s

%intila positions fro tower
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
if prod(A(1:end-2)=='I') %the logical returns a 1 for each char that is right. Product checks that all the values are 1.
    'successful read'
end

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



for ll=1:LoopEnd
    QSend=QmatAdjStore(ll:ll+ChunkLength,:);
    
    %%%%% Checks to find start and end of the loop %%%%%%
    if(ll>NumChunks) %if it's on the 'leftovers' loop. Cut the number of qs to be sent to the remained (what's left)
        ChunkLength=Remainder;
    end
    
    if ll==1 %send this on the first time round
        ChunkStr = strcat( 'h' , num2str(ChunkLength) )
        fwrite(s,ChunkStr);   %write the qs to arduino
    end
    
    
    %%%%%%% send single q matrix via serial %%%%%%%
    for kk=1:ChunkLength
        current_qs=strcat('t',num2str(QSend(kk,1)),'x','t',num2str(QSend(kk,2)), 'x', ...
            't',num2str(QSend(kk,3)),'x','t',num2str(QSend(kk,4)),'x','t',num2str(QSend(kk,5)),'x');
        fwrite(s,current_qs);   %write the qs to arduino
        
        
%         for i=1:5
%             readData = fscanf(s); %read the data back from the arduino
%             %             str_recieve = strcat(sprintf(' q %d   =  ',i), readData )
%         end
        
    end
    
    %When current chunk is over send a terminator statement
    FooterStr = strcat( 'f' , '1' ) %send a random number... because I'm lazy and I don't know if it needs a number
    fwrite(s,FooterStr);   %write the qs to arduino
    
    ll %temp. print the current
    
    
    
    %%% Check is the arduino is ready for more information
    [A,count] = fscanf(s); %read the buffer, save as A
    while A(1:end-2)=='R'; %the logical returns a 1 for each char that is right. Product checks that all the values are 1.
        %do nothing
    end
    
end


fclose(s);




