%Señal pulso de CW con frecuencia fija
function [Sx_Puls,Mod,ValMagInst] = fGenSxPulsiCW_2(fs,fy,th,toff,Npuls)%(Frecuencia muestreo, Frecuencia portadora, Duración Pulso, Duración pausa, Cantidad pulsos)
clear fGenSxPulsiCW_2;
%%PARÁMETROS
%Parámetros externos
% fs=1e3;%Frecuencia de muestreo en Hz, 1e3 es 1KHz
% fy =200; %Frecuencia de la señal a generar
% Td=0.4;
% Toff=0.4;
% Npuls=6;
%Parámetros internos
Ts=1/fs;%Periodo de muestreo
th_c=0:Ts:th;%Tiempo de duración de salto
toff_c=0:Ts:toff;%Tiempo entre saltos
 
%Valores de las frecuencias portadoras de las señales en Hz
f1=fy;
%Creación de la señal portadora
%S1
A1=1; %Amplitud de la sx
w1=2*pi*f1; % Frecuencia de la Señal rad/s
S1=A1*sin(w1*th_c); %Señal
 
%Para crear los espacios de tiempo entre salto se mide la cantidad de
%elemento del vector toff y se crea un vector vacío con L elementos
Lth=length(th_c);
Ltoff=length(toff_c);
Son=ones(1,Lth);
%Soff=zeros(1,Ltoff);
Tao=Lth+Ltoff;
Lsx=Npuls*Tao;
%Se;al moduladora
Mod=zeros(1,Lsx);
%Areglo para almacenar los valores de la frecuencia instantánea
FrP_i=zeros(1,Lsx);
 
%Se crea un arreglo vacío para ir colocando las señales
Sx_Puls=zeros(1,Lsx);
 
i_fri=1;%Indice para almacenar los valores de frecuencia instantánea
for n=1:Npuls
    i=1;
    for i_fri=i_fri:n*Tao
        if((i_fri-((n-1)*Tao))<(Tao-Ltoff))%Comprueba siempre en el intervalo desde 1 hasta Tao/2 en cada iteración de n
            FrP_i(i_fri)=fy;
            Mod(i_fri)=Son(i);
            Sx_Puls(i_fri)=S1(i);
            i=i+1;
        else
           FrP_i(i_fri)=0;
           Mod(i_fri)=0;
           Sx_Puls(i_fri)=0;
        end
    end
end
 
%Recopilación de los valores instantáneos de las magnitudes básicas para 
%comprobar en el receptor los errores en el procesamiento de los mismos.
%Amplitud Instantánea
AmP_i=Mod;
%Fase instantánea
Sh=hilbert(Sx_Puls);
I=real(Sh);
Q=imag(Sh);
FaP_i=atan2(Q,I);
%
ValMagInst=[AmP_i;FaP_i;FrP_i];%ValMagInst=[AmP_i;FaP_i;FrP_i]; 3filas length(AmP_i) Columnas 
end%Funcion 

%%GRÁFICOS
% Sx=Sx_Puls;
% mod=Mod;
% figNum=1;
% fGrafRepreSx(Sx,fs,mod,figNum);
% JORGE Y. HERNÁNDEZ GARCÍA