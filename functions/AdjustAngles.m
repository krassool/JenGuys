function QmatAdj = AdjustAngles( Qmat , MotorStruct )


QplusOffset = Qmat.*([MotorStruct.dir]) - [MotorStruct.offset];
QmatAdj = QplusOffset;

end





