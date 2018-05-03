

clear
close all
%create connection to ardunio
a = arduino('/dev/tty.usbmodem1411','uno');


kk=1
hold on
while 1
    
    input1(kk)=readVoltage(a,'A0');
%     input2(kk)=readVoltage(a,'A1');
    plot(input1);
%     plot(input2);
    pause(.02);
    kk=kk+1;
%     
%     if(input1>2)
%         writeDigitalPin(a,'D3',1)
%     else
%         writeDigitalPin(a,'D3',0)
%     end
%     
%     if(input1>3)
%         writeDigitalPin(a,'D2',1)
%     else
%         writeDigitalPin(a,'D2',0)
%     end
    
    
    writePWMDutyCycle(a, 'D5', .5)
    
end
