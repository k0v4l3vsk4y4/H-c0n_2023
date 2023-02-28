clear

% Dibuixa dos cercles, un definit i l'altre difuminat, i compara els coef
% de mag
% VARIABLES
rMin= 0; %Valor del paper r = 175
rMax= 15;

M=100;
N=100;

% Preparo les imatges per marcar

im1 = zeros(M,N);
for r = 0:M/4
    L = 2*pi*r;
    for k = 1:L
    % Marca L punts distribuïts uniformemente entre [-pi,pi] (comença per
    % -pi!) en el radi r
    x = fix(M/2+1)+fix(r*cos(k*pi/L));
    y = fix(N/2+1)+fix(r*sin(k*pi/L));
    
            im1(x,y) = 255;

    end
end


for m= 1:M
    for n = 1:fix(N/2)
        im1(m+1,n) = im1(M+1-m,N+1-n);
    end
end


pix=255;
im2 = zeros(M,N);
for r = 0:M/4
    
    pix = pix-10;
    L = 2*pi*r;
    for k = 1:L
    % Marca L punts distribuïts uniformemente entre [-pi,pi] (comença per
    % -pi!) en el radi r
    x = fix(M/2+1)+fix(r*cos(k*pi/L));
    y = fix(N/2+1)+fix(r*sin(k*pi/L));
    
    im2(x,y) = pix;

    end

end


for m= 1:M
    for n = 1:fix(N/2)
        im2(m+1,n) = im2(M+1-m,N+1-n);
    end
end

% Transformo la imatge al domini de Fourier
im1DFT = fft2(im1); 
im1DFTshift = fftshift(im1DFT); % Traslladem els coeficients de baixa freqüència al centre

im2DFT = fft2(im2); 
im2DFTshift = fftshift(im2DFT); % Traslladem els coeficients de baixa freqüència al centre


% Separem els coeficients de magnitud dels coeficients de fase
coefMag1 = abs(im1DFTshift); % Mòdul o magnitud complexa 
coefMag2 = abs(im2DFTshift); % Mòdul o magnitud complexa 


% Transforma de nou al domini espacial (Inverteix la transformada de
% Fourier)
figure(1)
Fs = mat2gray(im1,[0 5000]);
subplot(3,2,1); imshow(Fs,[]); 
Fs = mat2gray(im2,[0 5000]);
subplot(3,2,2); imshow(Fs,[]); 

subplot(3,2,3); s1=surf(im1); s1.EdgeColor = 'none';

subplot(3,2,4); s2=surf(im2); s2.EdgeColor = 'none';

Fs = mat2gray(coefMag1,[0 5000]);
subplot(3,2,5); imshow(Fs,[]); 

Fw = mat2gray(coefMag2,[0 5000]);
subplot(3,2,6); imshow(Fw,[]); 


