%Calculo estad�sticos mediante ventana deslizante fara la frecuencia instant�nea
function [Fr_iProm,Fr_iDesEst,Fr_iPromDesEst] = fEstVentDes_Fr(Fr_i,k_FriPro,k_FriDE)%
        
    %FRECUENCIA INSTANT�NEA
    Fr_iProm=movmean(Fr_i,k_FriPro);% Promedio con ventana deslizante de longitud k
    Fr_iDesEst=movstd(Fr_i,k_FriDE);% Desviaci�n Est�ndar con ventana deslizante de longitud k
    Fr_iPromDesEst=movstd(Fr_iProm,k_FriDE);% Desviaci�n Est�ndar con ventana deslizante de longitud k de la frecuencia instant�nea promedio
    
    %SxProm=movmean(Var,k);% Promedio con ventana deslizante de longitud k
    %SxMed= movmedian(Var,k);% Mediana con ventana deslizante de longitud k
    %SxVar=movvar(Var,k);% Varianza con ventana deslizante de longitud k
    %SxDesEst=movstd(Var,k);% Desviaci'on Estandar con ventana deslizante de longitud k
    %SxMedDes=(movmad(Var,k));% Desviaci'on absoluta de la mediana con ventana deslizante de longitud k
end% Function fEstVentDes_Fr
% JORGE Y. HERN�NDEZ GARC�A
