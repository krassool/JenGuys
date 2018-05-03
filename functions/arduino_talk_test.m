

clear
close all
%create connection to ardunio
a = arduino('/dev/tty.usbmodem1411','uno');

%turn off all leds
writeDigitalPin(a,'D2',0)
writeDigitalPin(a,'D3',0)
writeDigitalPin(a,'D4',0)
writeDigitalPin(a,'D5',0)

pause(1)
writeDigitalPin(a,'D2',1)
pause(1)

writeDigitalPin(a,'D3',1)
pause(1)

writeDigitalPin(a,'D4',1)
pause(1)

writeDigitalPin(a,'D5',1)