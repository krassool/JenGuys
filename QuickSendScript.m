

trajstr = strcat('m',vals_per_traj,'x');
fwrite(s,trajstr);

Qmat = [0,0,0,15,0];

MotorStruct = MotorParams();
QmatAdj             =   AdjustAngles( Qmat , MotorStruct );

QSend=QmatAdj;


% Convert qs and write
current_qs=strcat('t',num2str(QSend(1)),'x','t',num2str(QSend(2)), 'x', ...
    't',num2str(QSend(3)),'x','t',num2str(QSend(4)),'x','t',num2str(QSend(5)),'x');
fwrite(s,current_qs);   %write the qs to arduino