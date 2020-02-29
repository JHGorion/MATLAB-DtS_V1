%Señal generada por VCO, configuración de frecuencia mínima y máxima 
function [y] = fGenVCOABVar(fmin,fmax,fs)%fy Frecuencia central en Hz, 
%fsnFrecuencia de muestreo en hz, Tset es Conjunto de intervalo de tiempo 
Ts=1/fs;%Periodo de muestreo
t=0:Ts:(1-Ts);%Tiempo de duración de salto
a=-1;
b=2000/length(t);% cálculo para garantizar que la rampa siempre esté entre -1 y 1
x=a+b*t; %x es la rampa de control de frecuencia (-1 a 1)
y=vco(x,[fmin fmax],fs); % signal data set
end%fVCOABVar
% JORGE Y. HERNÁNDEZ GARCÍA