function QmatAdj = AdjustAngles( Qmat , MotorStruct )


QplusOffset = Qmat.*([MotorStruct.dir]) - [MotorStruct.offset];
QmatAdj = QplusOffset;
QmatAdj(3)=QmatAdj(3)+Qmat(2);

end





