% This script assists in servo calibration
% KR May 2018 
%
% requires: Arduino + MATLAB server on it
%           Servo
%           Protractor/angle measuring device
%
% Usage:
%       Define min/max PWM signal for servo
%       Define angles to check (angledeg)
%       loop through angles, write the position on the servo
%       read the voltage for a given position
%       human input: note down the ACTUAL (real) angle
%       save desired angle, voltage read, and actual angle in a matrix
%
%
% If you see an error and your not getting a full range of motion it is
% likely that your pwm range is TOO SMALL
% OR
%  if you are getting a pause and flat line (there is no 'real angle'
% difference between angledeg = 2 deg OR 0 deg) it is likely that your pwm
% range is TOO BIG
%
% PWM range = max_pulse - min_pulse

clear
close all
%% Servo set up
%create connection to ardunio
a = arduino('/dev/tty.usbmodem1411','uno', 'Libraries', 'Servo');

servoName = 'Q1Servo' %change this to reflected which servo

%CHAGE THESE... min max pulse
min_pulse=    800;      %%in micro seconds. Normal min ~= 1000 us.
max_pulse=    2200;     %%in micro seconds. Normal max ~= 2000 us.
%create servo object
s = servo(a, 'D9', 'MinPulseDuration', min_pulse*10^-6, 'MaxPulseDuration', max_pulse*10^-6); %convert to seconds

%% calibration angles
angledeg    = 0:1:180; %define sweep angles CHANGE THESE
n_angs      = length(angledeg); %number of angles total
% initilaise ouput
calibration_matrix=zeros(n_angs,3); %initilaise output matrix
%% loop
for kk=1:n_angs %%kk is the counting integer
    inputang =    angledeg(kk)/180; %convert angle to fraction between 0 and 1
    writePosition(s, inputang); %write position to servo
    pot_read=readVoltage(a,'A0'); %read voltage from potentiometer    
    prompt = 'What is the angle in degrees? (From Protractor):    ';
    theta = input(prompt); 
    %     pause(0.001);    
    calibration_matrix(kk,:) = [angledeg,pot_read,theta];
end

%% output

%save as .csv file with 3 decimal point precision
output_filename=strcat(servoName,'_calibration_data.csv',)
dlmwrite(output_filename,calibration_matrix,'precision','%.3f')

% save as .mat
save_filename=strcat(servoName,'_calibration_data.mat',)
save(save_filename,'calibration_matrix')


