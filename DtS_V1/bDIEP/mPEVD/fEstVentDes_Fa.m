%C�lculo estad�sticos mediante ventana deslizante Fase instant�nea
function [Fa_iDesAbsMed,Fa_iDAMprom,Fa_iDesEst,Fa_iProm] = fEstVentDes_Fa(Fa_i, k_FaiDAMe,k_FaiPrDAMe,k_FaiDE,k_FaiPro)
   
   %FASE INSTANT�NEA
    Fa_iDesAbsMed=movmad(Fa_i,k_FaiDAMe);% Desviaci�n absoluta respecto a la mediana con ventana deslizante de longitud k
    Fa_iDAMprom=movmean(Fa_iDesAbsMed,k_FaiPrDAMe);%movmax(Fa_iDesAbsMed,k_prDAM);
    Fa_iDesEst=movstd(Fa_i,k_FaiDE);% Desviaci�n Est�ndar con ventana deslizante de longitud k
    Fa_iProm=movmean(Fa_i,k_FaiPro);% Promedio con ventana deslizante de longitud k

    
    %SxProm=movmean(Var,k);% Promedio con ventana deslizante de longitud k
    %SxMed= movmedian(Var,k);% Mediana con ventana deslizante de longitud k
    %SxVar=movvar(Var,k);% Varianza con ventana deslizante de longitud k
    %SxDesEst=movstd(Var,k);% Desviaci�n Est�ndar con ventana deslizante de longitud k
    %SxMedDes=(movmad(Var,k));% Desviaci�n absoluta respecto a la mediana con ventana deslizante de longitud k
end% Funci�n fEstVentDes_Fa
% JORGE Y. HERN�NDEZ GARC�A
