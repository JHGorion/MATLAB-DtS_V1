%Calculo estad�sticos mediante ventana deslizante Amplitud instant�nea
function [A_iProm] = fEstVentDes_Am(A_i,k_AiPro)%
    %AMPLITUD INSTANTANEA
    A_iProm=movmean(A_i,k_AiPro);% Promedio con ventana deslizante de longitud k
    
    
    %SxProm=movmean(Var,k);% Promedio con ventana deslizante de longitud k
    %SxMed= movmedian(Var,k);% Mediana con ventana deslizante de longitud k
    %SxVar=movvar(Var,k);% Varianza con ventana deslizante de longitud k
    %SxDesEst=movstd(Var,k);% Desviaci�n Est�ndar con ventana deslizante de longitud k
    %SxMedDes=(movmad(Var,k));% Desviaci�n absoluta respecto a la mediana con ventana deslizante de longitud k
end% Funci�n fEstVentDes_Am
% JORGE Y. HERN�NDEZ GARC�A
