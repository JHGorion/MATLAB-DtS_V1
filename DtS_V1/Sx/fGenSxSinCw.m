%Se�al CW Seno 
function [y] = fGenSxSinCw(fy,Tset)%fy Frecuencia central en Hz, 
%fs Frecuencia de muestreo en hz,Tset es Conjunto de intervalo de tiempo 
w=2*pi*fy;
y=sin(w*Tset);
end%fVCOfrcVar
% JORGE Y. HERN�NDEZ GARC�A