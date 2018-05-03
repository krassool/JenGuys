function Angles = Pot2q(a)
%jenga block size
% 
% pot_read = zeros(1,5)
% for l = 0:4
%     intnum=num2str(ZZ,'%i')
%     readVoltage(a,strcat('A',intnum)
% end
% 
% PotMax = [ 2.5 , 2.5 , 2.5 , 2.5 , 2.5 ];
% PotMin = [ 0.5 , 0.5 , 0.5 , 0.5 , 0.5 ];

Pot1_read= readVoltage(a,'A0');
Pot1_max = 2.5;
Pot1_min = 0.5;
Pot1_range = Pot1_max- Pot1_min;
Q1angle = (Pot1_read-Pot1_min) * 180 /  Pot1_range;


Pot2_read= readVoltage(a,'A1');
Pot2_max = 2.5;
Pot2_min = 0.5;
Pot2_range = Pot1_max- Pot1_min;
Q2angle = (Pot1_read-Pot1_min) * 180 /  Pot2_range;


Pot3_read= readVoltage(a,'A2');
Pot3_max = 2.5;
Pot3_min = 0.5;
Pot3_range = Pot1_max- Pot1_min;
Q3angle = (Pot1_read-Pot1_min) * 180 /  Pot3_range;


Pot4_read= readVoltage(a,'A3');
Pot4_max = 2.5;
Pot4_min = 0.5;
Pot4_range = Pot1_max- Pot1_min;
Q4angle = (Pot1_read-Pot1_min) * 180 /  Pot4_range;


Pot5_read= readVoltage(a,'A4');
Pot5_max = 2.5;
Pot5_min = 0.5;
Pot5_range = Pot1_max- Pot1_min;
Q5angle = (Pot1_read-Pot1_min) * 180 /  Pot5_range;

Angles = [ Q1angle, Q2angle, Q3angle, Q4angle, Q5angle];

end





