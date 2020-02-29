%Se�al FHSS con intervalos de tiempo entre saltos Ejemplo fGenSxFHSS_2(1e3,0.4,0.4);
function [Sx_fhss,Mod,ValMagInst] = fGenSxFHSS_3(fs,th,toff)
%clear fGenSxFHSS_3;
 
%%PAR�METROS
%Par�metros externos
% fs=1e3;%Frecuencia de muestreo en Hz, 1e3 es 1KHz
% th=0.4;
% toff=0.4;
%Par�metros internos
Ts=1/fs;%Periodo de muestreo
th_c=0:Ts:(th-Ts);%Tiempo de duraci�n de salto
toff_c=0:Ts:(toff-Ts);%Tiempo entre saltos
Nfrec=6;%Indica el n�mero de frecuencias, no se varia al menos que se creen nuevas portadoras
 
%% Preparaci�n de 6 nuevas portadoras
%Valores de las frecuencias portadoras de las se�ales en Hz. para fs=1e3
%los valores son:
f1=fs/20;%50 Hz
f2=fs/30;%33,33 Hz
f3=fs/40;%25 Hz
f4=fs/50;%20 Hz
f5=fs/60;%16,67 Hz
f6=fs/70;%14,29 Hz
 
%Creaci�n de las 6 se�ales
%S1
A1=1; %Amplitud de la sx
w1=2*pi*f1; % Frecuencia de la Se�al rad/s
S1=A1*sin(w1*th_c); %Se�al
%S2
A2=1; %Amplitud de la sx
w2=2*pi*f2; % Frecuencia de la Se�al rad/s
S2=A2*sin(w2*th_c); %Se�al
%S3
A3=1; %Amplitud de la sx
w3=2*pi*f3; % Frecuencia de la Se�al rad/s
S3=A3*sin(w3*th_c); %Se�al
%S4
A4=1; %Amplitud de la sx
w4=2*pi*f4; % Frecuencia de la Se�al rad/s
S4=A4*sin(w4*th_c); %Se�al
%S5
A5=1; %Amplitud de la sx
w5=2*pi*f5; % Frecuencia de la Se�al rad/s
S5=A5*sin(w5*th_c); %Se�al
%S6
A6=1; %Amplitud de la sx
w6=2*pi*f6;% Frecuencia de la Se�al rad/s
S6=A6*sin(w6*th_c); %Se�al
 
%Para crear los espacios de tiempo entre salto se mide la cantidad de
%elemento del vector toff y se crea un vector vacio con L elementos
Lth=length(th_c);
Ltoff=length(toff_c);
Son=ones(1,Lth);
%Soff=zeros(1,Ltoff);
Tao=Lth+Ltoff;
Lsx=Nfrec*Tao;
%Se;al moduladora
Mod=zeros(1,Lsx);
%Areglo para almacenar los valores de la frecuencia instant�nea
FrP_i=zeros(1,Lsx);
 
%% Generaci�n de saltos aleatorios de la frecuencia portadora
%Se crea un arreglo vac�o para ir colocando las se�ales
Sx_fhss=zeros(1,Lsx);
%n=zeros(1,6);% Prelocalizaci�n de una memoria para n inicializada con 0
i_fri=1;%Indice para almacenar los valores de frecuencia instant�nea
for n=1:Nfrec
    c=randi([1 6]);% Uniformly distributed pseudorandom integers, matrix de 1x1 con valores m�nimos 1 y m�ximo 6
    switch(c)
    case(1)
        i=1;
        for i_fri=i_fri:n*Tao
            if((i_fri-((n-1)*Tao))<(Tao-Ltoff))%Comprueba siempre en el intervalo desde 1 hasta Tao/2 en cada iteraci�n de n
                FrP_i(i_fri)=f1;
                Mod(i_fri)=Son(i);
                Sx_fhss(i_fri)=S1(i);
                i=i+1;
            else
               FrP_i(i_fri)=0;
               Mod(i_fri)=0;
               Sx_fhss(i_fri)=0;
            end
         end
     case(2)
        i=1;
        for i_fri=i_fri:n*Tao
            if((i_fri-((n-1)*Tao))<(Tao-Ltoff))%Comprueba siempre en el intervalo desde 1 hasta Tao/2 en cada iteraci�n de n
                FrP_i(i_fri)=f2;
                Mod(i_fri)=Son(i);
                Sx_fhss(i_fri)=S2(i);
                i=i+1;
            else
               FrP_i(i_fri)=0;
               Mod(i_fri)=0;
               Sx_fhss(i_fri)=0;
            end
         end
     case(3)
        i=1;
        for i_fri=i_fri:n*Tao
            if((i_fri-((n-1)*Tao))<(Tao-Ltoff))%Comprueba siempre en el intervalo desde 1 hasta Tao/2 en cada iteraci�n de n
                FrP_i(i_fri)=f3;
                Mod(i_fri)=Son(i);
                Sx_fhss(i_fri)=S3(i);
                i=i+1;
            else
               FrP_i(i_fri)=0;
               Mod(i_fri)=0;
               Sx_fhss(i_fri)=0;
            end
         end
     case(4)
        i=1;
        for i_fri=i_fri:n*Tao
            if((i_fri-((n-1)*Tao))<(Tao-Ltoff))%Comprueba siempre en el intervalo desde 1 hasta Tao/2 en cada iteraci�n de n
                FrP_i(i_fri)=f4;
                Mod(i_fri)=Son(i);
                Sx_fhss(i_fri)=S4(i);
                i=i+1;
            else
               FrP_i(i_fri)=0;
               Mod(i_fri)=0;
               Sx_fhss(i_fri)=0;
            end
         end
     case(5)
        i=1;
        for i_fri=i_fri:n*Tao
            if((i_fri-((n-1)*Tao))<(Tao-Ltoff))%Comprueba siempre en el intervalo desde 1 hasta Tao/2 en cada iteraci�n de n
                FrP_i(i_fri)=f5;
                Mod(i_fri)=Son(i);
                Sx_fhss(i_fri)=S5(i);
                i=i+1;
            else
               FrP_i(i_fri)=0;
               Mod(i_fri)=0;
               Sx_fhss(i_fri)=0;
            end
         end
     case(6)
        i=1;
        for i_fri=i_fri:n*Tao
            if((i_fri-((n-1)*Tao))<(Tao-Ltoff))%Comprueba siempre en el intervalo desde 1 hasta Tao/2 en cada iteraci�n de n
                FrP_i(i_fri)=f6;
                Mod(i_fri)=Son(i);
                Sx_fhss(i_fri)=S6(i);
                i=i+1;
            else
               FrP_i(i_fri)=0;
               Mod(i_fri)=0;
               Sx_fhss(i_fri)=0;
            end
        end
    end 
end
 
%Recopilaci�n de los valores instant�neos de las magnitudes b�sicas para 
%comprobar en el receptor los errores en el procesamiento de los mismos.
%Amplitud Instant�nea
AmP_i=Mod;
%Fase instant�nea
Sh=hilbert(Sx_fhss);
I=real(Sh);
Q=imag(Sh);
FaP_i=atan2(Q,I);
 
ValMagInst=[AmP_i;FaP_i;FrP_i];%ValMagInst=[AmP_i;FaP_i;FrP_i]; 3filas length(AmP_i) Columnas 
 
end%Funcion 
%%GR�FICOS
% Sx=Sx_fhss;
% mod=FrP_i;
% figNum=1;
% fGrafRepreSx(Sx,fs,mod,figNum);
% JORGE Y. HERN�NDEZ GARC�A

