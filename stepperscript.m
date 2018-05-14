
% 
% if exist('ardUno')==0;
%     try
%         ardUno = arduino('/dev/tty.1411','uno', 'Libraries', 'Servo');
%         arduino_connect=1;
%     catch
%         fprintf('No arduino found')
%         arduino_connect=0;
%     end
% end



a = ardUno;

%Steps 6.7
%MS1 MS2 Stepsize
% L   L    Full
% H   L    Half
% L   H    Quarter
% H   H    Eigth

% %pin set up
% stp='D5';
% dir='D8';
% MS1='D7';
% MS2='D9';
% EN='D6';

%set up none need PWM, just digital
%blue wire to ground

%green
stp='D7';
%yellow
dir='D8';
%purple
MS1='D10';
%white
MS2='D12';
%gray
EN='D11';

%enable = low
writeDigitalPin(a,EN,0)

%step size
writeDigitalPin(a,MS1,0)
writeDigitalPin(a,MS2,0)

%temp dierction low
writeDigitalPin(a,dir,0)


%fix negative direction logic
% switch prev_q
%     case 1000
%         num_moves = nxt_q/1.675;
%         writeDigitalPin(a,dir,1)
%     otherwise
%
%         if nxt_q<prev_q
%             writeDigitalPin(a,dir,0)
%             q_moves = abs(nxt_q-prev_q)+nxt_q;
%         else
%             writeDigitalPin(a,dir,1)
%             q_moves = nxt_q-prev_q;
%         end
%         num_moves = round(q_moves/1.675);
% end
num_moves=1000;
prev_q = 0;
nxt_q = 20;
ang_rng = linspace(prev_q,nxt_q,num_moves);
% 
tic
for i = 1:length(ang_rng)
    tic
    writeDigitalPin(a,stp,1)
    pause(.001)
    writeDigitalPin(a,stp,0)
    pause(.001)
    toc
end
toc
writeDigitalPin(a,EN,1)