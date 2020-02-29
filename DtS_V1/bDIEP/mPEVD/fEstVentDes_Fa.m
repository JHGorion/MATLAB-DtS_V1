%Cálculo estadísticos mediante ventana deslizante Fase instantánea
function [Fa_iDesAbsMed,Fa_iDAMprom,Fa_iDesEst,Fa_iProm] = fEstVentDes_Fa(Fa_i, k_FaiDAMe,k_FaiPrDAMe,k_FaiDE,k_FaiPro)
   
   %FASE INSTANTÁNEA
    Fa_iDesAbsMed=movmad(Fa_i,k_FaiDAMe);% Desviación absoluta respecto a la mediana con ventana deslizante de longitud k
    Fa_iDAMprom=movmean(Fa_iDesAbsMed,k_FaiPrDAMe);%movmax(Fa_iDesAbsMed,k_prDAM);
    Fa_iDesEst=movstd(Fa_i,k_FaiDE);% Desviación Estándar con ventana deslizante de longitud k
    Fa_iProm=movmean(Fa_i,k_FaiPro);% Promedio con ventana deslizante de longitud k

    
    %SxProm=movmean(Var,k);% Promedio con ventana deslizante de longitud k
    %SxMed= movmedian(Var,k);% Mediana con ventana deslizante de longitud k
    %SxVar=movvar(Var,k);% Varianza con ventana deslizante de longitud k
    %SxDesEst=movstd(Var,k);% Desviación Estándar con ventana deslizante de longitud k
    %SxMedDes=(movmad(Var,k));% Desviación absoluta respecto a la mediana con ventana deslizante de longitud k
end% Función fEstVentDes_Fa
% JORGE Y. HERNÁNDEZ GARCÍA
