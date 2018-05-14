% write serial


JenGuysMainAdj
%QmatAdjStore=QmatAdjStore(1,:);

if ~isempty(instrfind)
     fclose(instrfind);
     delete(instrfindall);
end

s = serial('COM6','BaudRate',115200);
fopen(s);
readData = fscanf(s);

for j=1:length(QmatAdjStore)
    current_qs=strcat('t',num2str(QmatAdjStore(j,1)),'x','t',num2str(QmatAdjStore(j,2)),'x','t',num2str(QmatAdjStore(j,3)),'x','t',num2str(QmatAdjStore(j,4)),'x','t',num2str(QmatAdjStore(j,5)),'x');
    fwrite(s,current_qs);
    for i=1:5
    readData = fscanf(s)
    end
end

fclose(s);
% 
% fclose(s)
% delete(s)