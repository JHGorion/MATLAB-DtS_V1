%Modulaci�n BPSK para DSSS
%Ejemplo:
% NbitOut=100;%Numero de bit que se generaran por ejemplo 30 
% % (
% g=fGenPN(NbitOut);% Secuencia seudoaleatoria
% fy =200; %Frecuencia portadora de la se�al a generar
% fs=1e3;%Frecuencia de muestreo en Hz, 1e3 es 1KHz
% ) 
function [SxDSSS,mod,ValMagInst] =fGenDSSS_2(g,fy,fs) 
%PARAMETROS
clear fGenDSSS_2;
Ts=1/fs;%Tiempo de Muestreo
td=1;%Tiempo de duraci�n de la generaci�n en S
t=0:Ts:(td-Ts);%Conjunto de intervalos de tiempo
Ly=length(t);%determina la cantidad de elementos de y
Lg=length(g);
DurBit=floor(Ly/Lg);%determina la duraci�n de un bit del c�digo PN
%Generaci'on del vector con la se�al moduladora seudoaleatoria PN
mod=zeros(1,Ly);
i=1;%indice del for para colocar los valores en mod
for n=1:Lg 
    if g(n)==1
        for i=i:n*DurBit
            mod(i)=1;
        end
    else % g(n)==0 
        for i=i:n*DurBit
            mod(i)=0;
        end
    end
end
% para que mod y Y tengan la misma dimensi�n
Comp=zeros(1,(Ly-length(mod)));
mod=[mod Comp];
 
Fas=pi/2*mod;
%crear portadora con manipulaci�n de fase
w=2*pi*fy;%Frecuencia angular
SxDSSS=sin(w*t+Fas);%Se;al portadora
 
%Crear vector con los valores instant�neos de la frecuencia
Lsx=length(SxDSSS);
FrP_i=zeros(1,Lsx);
AmPInt_i=zeros(1,Lsx);
for i_fri=1:Lsx
    AmPInt_i(i_fri)=1;
    FrP_i(i_fri)=fy;        
end
 
%Recopilaci�n de los valores instant�neos de las magnitudes b�sicas para 
%comprobar en el receptor los errores en el procesamiento de los mismos.
%Amplitud Instant�nea
AmP_i=AmPInt_i;
%Fase instant�nea
Sh=hilbert(SxDSSS);
I=real(Sh);
Q=imag(Sh);
FaP_i=atan2(Q,I);
 
ValMagInst=[AmP_i;FaP_i;FrP_i];%ValMagInst=[AmP_i;FaP_i;FrP_i]; 3filas length(AmP_i) Columnas 
end
 
% %%GR�FICOS
% Sx=SxDSSS;
% figNum=1;
% fGrafRepreSx(Sx,fs,mod,figNum);
% JORGE Y. HERN�NDEZ GARC�A
