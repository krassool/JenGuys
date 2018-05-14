% write serial


JenGuysMainAdj
QmatAdjStore=QmatAdjStore(1,:);

s = serial('/dev/tty.usbmodem1411');
fopen(s)


myfl = 1.111;



for kk=1:1 %length(QmatAdjStore)
%     Qmatstring = mat2str( QmatAdjStore(kk,:) ,8)
    fprintf(s , QmatAdjStore(1))
    fprintf(s , QmatAdjStore(2))
    fprintf(s , QmatAdjStore(3))
    fprintf(s , QmatAdjStore(4))
    fprintf(s , QmatAdjStore(5))    
    fprintf(s , QmatAdjStore(1))
    fprintf(s , QmatAdjStore(2))
    fprintf(s , QmatAdjStore(3))
    fprintf(s , QmatAdjStore(4))
    fprintf(s , QmatAdjStore(5))
    kk
end

outp=fscanf(s)

fclose(s)