
% Aquesta funcio marca una imatge donat una imatge B/N, un radi, una alpha la longitud de la marca i un archiu que
% guarda la marca en bits


function [imWM, coefMagWM] = marcaImFunction(im,r,alpha,L,v)
    % Transformo la imatge al domini de Fourier
    imDFT = fft2(im); 
    imDFTshift = fftshift(imDFT); % Traslladem els coeficients de baixa freqüència al centre
    
    % Separem els coeficients de magnitud dels coeficients de fase
    coefMag = abs(imDFTshift); % Mòdul o magnitud complexa 
    coefPhase = angle(imDFTshift); % Angle de fase
    
    % Definim marca
    wm = zeros (size(coefMag));
    [M,N] = size(coefMag);
    
    for k = 1:L
        % Marca L punts distribuïts uniformemente entre [-pi,pi] (comença per
        % -pi!) en el radi r
        x = fix(M/2+1)+fix(r*cos(k*pi/L));
        y = fix(N/2+1)+fix(r*sin(k*pi/L));
        
        for s =-1:1
            for t=-1:1
                wm(x,y)= wm(x,y) + coefMag(x+s,y+t);
            end
        end
        wm(x,y) = v(k)*wm(x,y)/9;
    end
    
    % Omple el costat esquerra de la matriu amb simetria inversa
    for m= 1:M
        for n = 1:fix(N/2)
            wm(m,n) = wm(M+1-m,N+1-n);
        end
    end
    
    % Incrustem la marca en la matriu
    coefMagWM = coefMag + alpha * wm;
    
    % Combinem els coeficients de magnitud amb els coeficients de fase
    imDFTwm = zeros(size(coefMagWM));
    for m = 1:M
        for n = 1:N
            imDFTwm(m,n) = coefMagWM(m,n)*exp(i*coefPhase(m,n));
        end
    end
    
    % Transforma de nou al domini espacial (Inverteix la transformada de
    % Fourier)
    imWM = ifft2(ifftshift(imDFTwm)); 
    imWM = uint8(real(imWM));
end