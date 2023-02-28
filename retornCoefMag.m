function coefMag = retornCoefMag (im)
% Transformo la imatge al domini de Fourier
    imDFT = fft2(im); 
    imDFTshift = fftshift(imDFT); % Traslladem els coeficients de baixa freqüència al centre
    
    % Separem els coeficients de magnitud dels coeficients de fase
    coefMag = abs(imDFTshift); % Mòdul o magnitud complexa 
end
