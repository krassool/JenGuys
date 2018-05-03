function Qread = Pot2q(a)
%reads the pots, applies a calibration and returns the angle
%THIS MIGHT NEED SOME AVERAGING/SMOOTHING on the analog read.

PotRead = zeros(1,5); %initialise
for l = 0:4         %reading loop
    intnum=num2str(ZZ,'%i'); %input pin string
    PotRead = readVoltage(a,strcat('A',intnum); %analog read value
end
%calibration
PotMax      = [ 2.5 , 2.5 , 2.5 , 2.5 , 2.5 ];
PotMin      = [ 0.5 , 0.5 , 0.5 , 0.5 , 0.5 ];
PotRange    = PotMax - PotMin; 

Qread = 180 * (PotRead - PotMin) / PotMin;  

end





