%Calculo estadísticos mediante ventana deslizante Amplitud instantánea
function [A_iProm] = fEstVentDes_Am(A_i,k_AiPro)%
    %AMPLITUD INSTANTANEA
    A_iProm=movmean(A_i,k_AiPro);% Promedio con ventana deslizante de longitud k
    
    
    %SxProm=movmean(Var,k);% Promedio con ventana deslizante de longitud k
    %SxMed= movmedian(Var,k);% Mediana con ventana deslizante de longitud k
    %SxVar=movvar(Var,k);% Varianza con ventana deslizante de longitud k
    %SxDesEst=movstd(Var,k);% Desviación Estándar con ventana deslizante de longitud k
    %SxMedDes=(movmad(Var,k));% Desviación absoluta respecto a la mediana con ventana deslizante de longitud k
end% Función fEstVentDes_Am
% JORGE Y. HERNÁNDEZ GARCÍA
