function QmatAdj = AdjustAngles( Qmat , MotorStruct )


QplusOffset = Qmat.*([MotorStruct.dir]) - [MotorStruct.offset];
QmatAdj = QplusOffset;
QmatAdj(3)=QmatAdj(3)+Qmat(2);
QmatAdj(4)=-QmatAdj(4);
% QmatAdj(4)=-QmatAdj(4);

end





