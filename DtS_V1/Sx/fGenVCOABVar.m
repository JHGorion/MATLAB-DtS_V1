%Se�al generada por VCO, configuraci�n de frecuencia m�nima y m�xima 
function [y] = fGenVCOABVar(fmin,fmax,fs)%fy Frecuencia central en Hz, 
%fsnFrecuencia de muestreo en hz, Tset es Conjunto de intervalo de tiempo 
Ts=1/fs;%Periodo de muestreo
t=0:Ts:(1-Ts);%Tiempo de duraci�n de salto
a=-1;
b=2000/length(t);% c�lculo para garantizar que la rampa siempre est� entre -1 y 1
x=a+b*t; %x es la rampa de control de frecuencia (-1 a 1)
y=vco(x,[fmin fmax],fs); % signal data set
end%fVCOABVar
% JORGE Y. HERN�NDEZ GARC�A