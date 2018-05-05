function MotorStruct = MotorInit();
% initialises motors by setting up variables
%stores in a struct, usage: MotorStruct(1).pin will give the pin of the
%stepper

%Stepper 1, Q1 (Stepper)
St1.name = 'St1'     ;
St1.pin  = 'D9'      ;
St1.minp = 544*10^-6 ;
St1.maxp = 2400*10^-6;

%Servo 2, Q2 (Shoulder)
s2.name = 's2'      ;
s2.pin  = 'D9'      ;
s2.minp = 544*10^-6 ;
s2.maxp = 2400*10^-6;

%Servo 3, Q3 (Elbow)
s3.name = 's3'      ;
s3.pin  = 'D8'      ;
s3.minp = 600*10^-6 ;
s3.maxp = 2500*10^-6;

%Servo 4, Q4 (Wrist)
s4.name = 's4'      ;
s4.pin  = 'D7'      ;
s4.minp = 544*10^-6 ;
s4.maxp = 2400*10^-6;

%Servo 5, Q5 (End Effector)
s5.name = 's5'      ;
s5.pin  = 'D6'      ;
s5.minp = 544*10^-6 ;
s5.maxp = 2400*10^-6;

MotorStruct = [St1, s2, s3, s4, s5];

end
