% Realiza filtrado por promedio con ventana deslizante
%(
%Vect=;%Vector o señal que será filtrada
%K=2;%Longitud de la ventana deslizante
%ActFilt=1;%indica si el filtro se activa o no
%)
function [VectProm] = fFiltProm_VD(Vect,K,ActFilt)
    %Media con ventana deslizante
    if (ActFilt)
    VectProm=movmean(Vect,K);% Promedio con ventana deslizante de longitud k
    else
    VectProm=Vect;
end
% JORGE Y. HERNÁNDEZ GARCÍA