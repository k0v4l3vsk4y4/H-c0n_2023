
N = 200;
numfiles = 500;

for k = 1:numfiles
    string = "marques/marca" + k + ".txt";
    fileID = fopen(string,'w');
    
    v = round(rand(1,N));
    nbytes = fprintf(fileID,'%5d\n',v);
    fclose(fileID);
end

string = "marques/marca" + 34 + ".txt";
fileID = fopen("marques/marca23.txt",'r');
[v,count] = fscanf(fileID, ['%5d\n']);
fclose(fileID);

