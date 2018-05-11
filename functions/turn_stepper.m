function turn_stepper(nxt_q,prev_q,ardUno)
% Turn Stepper

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

%set up
stp='D2';
dir='D8';
MS1='D7';
MS2='D11';
EN='D12';

writeDigitalPin(a,EN,0)

%step size
writeDigitalPin(a,MS1,0)
writeDigitalPin(a,MS2,1)

%fix negative direction logic
while 1
    switch prev_q
        case 1000
            num_moves = nxt_q/1.675;
            writeDigitalPin(a,dir,1)
        otherwise
            
            if nxt_q<prev_q
                writeDigitalPin(a,dir,0)
                q_moves = abs(nxt_q-prev_q)+nxt_q;
            else
                writeDigitalPin(a,dir,1)
                q_moves = nxt_q-prev_q;
            end
            num_moves = q_moves/1.675;
    end
    ang_rng = linspace(prev_q,nxt_q,num_moves);
    for i = length(ang_rng)
        writeDigitalPin(a,stp,1)
        writeDigitalPin(a,stp,0)
        pause(.0021)
    end
end



end