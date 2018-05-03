function servoObj = ServoSetup( MotorStruct , ardUno )

s2 = servo(ardUno, MotorStruct(2).pin, 'MinPulseDuration', MotorStruct(2).minp, 'MaxPulseDuration', MotorStruct(2).maxp); 
s3 = servo(ardUno, MotorStruct(3).pin, 'MinPulseDuration', MotorStruct(3).minp, 'MaxPulseDuration', MotorStruct(3).maxp); 
s4 = servo(ardUno, MotorStruct(4).pin, 'MinPulseDuration', MotorStruct(4).minp, 'MaxPulseDuration', MotorStruct(4).maxp); 
s5 = servo(ardUno, MotorStruct(5).pin, 'MinPulseDuration', MotorStruct(5).minp, 'MaxPulseDuration', MotorStruct(5).maxp); 

servoObj=[s2,s3,s4,s5];

end





