clear

%VARIABLES
rMin=140; %Valors definits al paper 140
rMax=180; %Valors definits al paper 180
r = 175; 
L = 200; % Valor del paper L = 200
numberfiles = 500;

% PREPAREM LA IMATGE
% Llegim la imatge que volem testejar
im = imread('degas_L200_r175_alpha5.png');          

% Redimensionem la imatge al tamany 512x512
% De moment no hem fet aquest cas perque la imatge ja te la mida esperada
[M,N] = size(im);

% DFT
% Transformo la imatge al domini de Fourier
imDFT = fft2(im); 
imDFTshift = fftshift(imDFT);

% EXTRACCIÓ DEL VECTOR
% Separem els coeficients de magnitud dels coeficients de fase
coefMag = abs(imDFTshift); % Mòdul o magnitud complexa 
coefPhase = angle(imDFTshift); % Angle de fase

%Extreu els radis

arrayVectors = zeros(rMax-rMin+1,L);
cont = 1;
for r = rMin:rMax
    aux = zeros(1,L);
    for k = 1:L
        x = fix(M/2+1)+fix(r*cos(k*pi/L)); %És possible q estigui llegint el vector del reves
        y = fix(N/2+1)+fix(r*sin(k*pi/L));
        aux(1,k) = coefMag(x,y);
    end 
    arrayVectors(cont,:) = aux;
    cont = cont+1;
end

% Normalitzem els vectors
arrayNr = zeros(size(arrayVectors));
for k = 1:rMax-rMin+1
    arrayNr(k,:) = normalize(arrayVectors(k,:),'range');
end

%{
radii = zeros(1,L);


for k = 1:L
    x = fix(M/2+1)+fix(r*cos(k*pi/L)); %És possible q estigui llegint el vector del reves
    y = fix(N/2+1)+fix(r*sin(k*pi/L));
    radii(1,k) = coefMag(x,y);
end 

% Normalitzem els vectors
arrayNr= normalize(radii,'range');
%}

% Comparem els vectors de la imatge amb 100 marques diferents
%{
arrayCov = zeros(1,numberfiles);
for k = 1:numberfiles
    string = "marques/marca" + k + ".txt";
    fileID = fopen(string,'r');
    [v,count] = fscanf(fileID, ['%5d\n']);
    fclose(fileID);
    arrayCov(1,k)=max(xcov(v,arrayNr));
end
%}

arrayCov = zeros(rMax-rMin+1,numberfiles);
for r = 1:rMax-rMin+1
    for k = 1:numberfiles
        string = "marques/marca" + k + ".txt";
        fileID = fopen(string,'r');
        [v,count] = fscanf(fileID, ['%5d\n']);
        fclose(fileID);
        arrayCov(r,k)=max(xcov(v,arrayNr(r,:)));
    end
end

figure(3)
hold on
for r = 1:rMax-rMin+1
    plot(arrayCov(r,:)); 
end
yline(2.6,'-.b');
ylim([0 8])
hold off
