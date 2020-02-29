%Se�al DSSS de pulso
% NbitOut=100;%Numero de bit que se generaran por ejemplo 30 
% (
% g=fGenPN(NbitOut);% Secuencia seudoaleatoria
% fy =200; %Frecuencia portadora de la se�al a generar
% fs=1e3;%Frecuencia de muestreo en Hz, 1e3 es 1KHz
% Th=0.4;%Tiempo de duraci�n de la Se�al con amplitud m�xima
% Toff=0.4;%Tiempo de duraci�n de la Se�al con amplitud 0
% Npuls=1;% Cantidad de pulsos
% ) 
%) 
function [SxDSSSpuls,mod,ValMagInst] =fGenDSSSPuls_2(g,fy,fs,Th,Toff,Npuls) 
%PARAMETROS
clear fDSSS;
Ts=1/fs;%Tiempo de Muestreo
% td=1;%Tiempo de duraci�n de la generaci�n en S
td=(Npuls*(Th+Toff));%floor(Npuls*(Th+Toff))
t=0:Ts:(td-Ts);%Conjunto de intervalos de tiempo (recomendado td-Ts para ajusta la cantidad de elementos iguales de Sx_Puls SxDSSS  )
Ly=length(t);%determina la cantidad de elementos de y
Lg=length(g);
DurBit=floor(Ly/Lg);%determina la duraci�n de un bit del c�digo PN
th_c=0:Ts:(Th-Ts);%Tiempo de duraci�n de salto
toff_c=0:Ts:(Toff-Ts);%Tiempo entre saltos
%
% Generaci�n de se�al de pulso
%Para crear los espacios de tiempo entre salto se mide la cantidad de
%elemento del vector toff y se crea un vector vac�o con L elementos
Lth=length(th_c);%Determina la cantidad de elementos de th_c 
Ltoff=length(toff_c);
%Soff=zeros(1,Ltoff);
Tao=Lth+Ltoff;
Lsx=Npuls*Tao;
 
%Se crea un arreglo vac�o para ir colocando las se�ales
Sx_Puls=zeros(1,Lsx);
FrP_i=zeros(1,Lsx);
i_fri=1;%Indice para almacenar los valores de frecuencia instant�nea
for n=1:Npuls
   for i_fri=i_fri:n*Tao
        if((i_fri-((n-1)*Tao))<(Tao-Ltoff))%Comprueba siempre en el intervalo desde 1 hasta Tao/2 en cada iteraci�n de n
            FrP_i(i_fri)=fy;
            Sx_Puls(i_fri)=1;
        else
           FrP_i(i_fri)=0;
           Sx_Puls(i_fri)=0;
        end
    end
end
%
%Generaci�n del vector con la se�al moduladora seudoaleatoria PN
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
SxDSSS=cos(w*t+Fas);%Se;al portadora
SxDSSSpuls=Sx_Puls.*SxDSSS;
 
%Recopilaci�n de los valores instant�neos de las magnitudes b�sicas para 
%comprobar en el receptor los errores en el procesamiento de los mismos.
%Amplitud Instant�nea
AmP_i=Sx_Puls;
%Fase instant�nea
Sh=hilbert(SxDSSSpuls);
I=real(Sh);
Q=imag(Sh);
FaP_i=atan2(Q,I);
%
ValMagInst=[AmP_i;FaP_i;FrP_i];%ValMagInst=[AmP_i;FaP_i;FrP_i]; 3filas length(AmP_i) Columnas 
 
end
 
% %%GR�FICOS
% Sx=SxDSSSpuls;
% figNum=1;
% fGrafRepreSx(Sx,fs,mod,figNum);
% JORGE Y. HERN�NDEZ GARC�A
