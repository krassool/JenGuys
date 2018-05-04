function TurnServos(Qmatrix,a,servoObj)

% PotRead = zeros(1,5); %initialise

Qdecimal = (Qmatrix+90)/180;

for s_num=1:length(servoObj)
    writePosition( servoObj(s_num), Qdecimal(s_num+1) ); %+1 in here is becasue the first q relates to the stepper.
end