function TurnServos(Qmat,a)

% PotRead = zeros(1,5); %initialise




min_pulseQ1=    800;      %%in micro seconds. Normal min ~= 1000 us.
max_pulseQ2=    2200;     %%in micro seconds. Normal max ~= 2000 us.
s1 = servo(a, 'D9', 'MinPulseDuration', min_pulse*10^-6, 'MaxPulseDuration', max_pulse*10^-6); %convert to seconds

kk=1;
for angle = 0:0.2:1
    writePosition(s, angle);
    current_pos = readPosition(s);
    current_pos = current_pos*180;
    fprintf('Current motor position is %d degrees\n', current_pos);
    fprintf('Current motor write postion is %d degrees\n', angle*180);
    pause(2);
    
    
    input1(kk)=readVoltage(a,'A0');
    kk=kk+1;
    
end