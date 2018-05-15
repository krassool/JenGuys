%% 

if ~isempty(instrfind)
     fclose(instrfind);
     delete(instrfindall);
end


%% Start serial


s = serial('/dev/tty.usbmodem1411','BaudRate',115200);
fopen(s);



