%Se�al pulso de CW con frecuencia fija
function [Sx_Puls,Mod,ValMagInst] = fGenSxPulsiLFMcABVar_2(fs,fy,B,th,toff,Npuls)%(Frecuencia muestreo, Frecuencia portadora, Ancho de banda, Duraci�n Pulso, Duraci�n pausa, Cantidad pulsos)
%clear fGenSxPulsiLFMcABVar;
clear fGenSxPulsiLFMcABVar_2;
%%PARAMETROS
%Par�metros externos
% fs=1e3;%Frecuencia de muestreo en Hz, 1e3 es 1KHz
% fy =200; %Frecuencia de la se�al a generar
% toff=0.4;%Tiempo entre impulso
% Npuls=6;%n�mero de pulsos
% B=2*fy;% B=2*fy; 50 %Ancho de banda de la se�al LFM, determina la Fmin y Fmax a partir de fy
% toff=0.4;
%Par�metros internos
%th=1;%Tiempo duraci�n del impulso
Ts=1/fs;%Periodo de muestreo
th_c=0:Ts:(th-Ts);%Tiempo de duraci�n de salto
toff_c=0:Ts:(toff-Ts);%Tiempo entre saltos
 
 
%Generaci�n de se�al rampa
% Calculo de la frecuencia m�nima y m�xima del VCO a partir del ancho de banda 
Fmin=fy-(B/2);
Fmax=fy+(B/2);
%x=(2*th_c) -1; %Variante x es la rampa de control de frecuencia (-1 a 1) x=(th_c/2) -1;
a=-1;
b=2000/length(th_c);% c�lculo para garantizar que la rampa siempre est� entre -1 y 1
x=a+b*th_c;
 
y=vco(x,[Fmin Fmax],fs); % signal data set
 
%FIN Ejemplo
%Creaci�n de la se�al
%S1
A1=1; %Amplitud de la sx
S1=A1*y;%Se�al
 
%Para crear los espacios de tiempo entre salto se mide la cantidad de
%elemento del vector toff y se crea un vector vac�o con L elementos
Lth=length(th_c);
Ltoff=length(toff_c);
Son=ones(1,Lth);
%Soff=zeros(1,Ltoff);
Tao=Lth+Ltoff;
Lsx=Npuls*Tao;
%Se;al moduladora
Mod=zeros(1,Lsx);
%Arreglo para almacenar los valores de la frecuencia instant�nea
FrP_i=zeros(1,Lsx);
 
%Se crea un arreglo vac�o para ir colocando las se�ales
Sx_Puls=zeros(1,Lsx);
i_fri=1;%Indice para almacenar los valores de frecuencia instant�nea
for n=1:Npuls
    i=1;
    for i_fri=i_fri:n*Tao
        if((i_fri-((n-1)*Tao))<(Tao-Ltoff))%Comprueba siempre en el intervalo desde 1 hasta Tao/2 en cada iteraci�n de n
            FrP_i(i_fri)=Fmin+(i*((Fmax-Fmin)/length(x)));% 1ro. para que x tome valores positivo se suma 1 .: x [0 2] 2do. como bx(i)=2=Fmax y bx(i)=1=Fmax/2 b=(Fmax*(1+x(i)))/2
            % FrPort_i(i_fri)=Fmin+((Fmax*(1+x(i)))/2);% 1ro. para que x tome valores positivo se suma 1 .: x [0 2] 2do. como bx(i)=2=Fmax y bx(i)=1=Fmax/2 b=(Fmax*(1+x(i)))/2
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
 
%Recopilaci�n de los valores instant�neos de las magnitudes b�sicas para 
%comprobar en el receptor los errores en el procesamiento de los mismos.
%Amplitud Instant�nea
AmP_i=Mod;
%Fase instant�nea
Sh=hilbert(Sx_Puls);
I=real(Sh);
Q=imag(Sh);
FaP_i=atan2(Q,I);
 
ValMagInst=[AmP_i;FaP_i;FrP_i];%ValMagInst=[AmP_i;FaP_i;FrP_i]; 3filas length(AmP_i) Columnas 
end%Funcion 
 
% %%GR�FICOS
% Sx=Sx_Puls;
% Sx=S1;
%figNum=1;
%fGrafRepreSx(Sx,fs,mod,figNum);
% JORGE Y. HERN�NDEZ GARC�A
