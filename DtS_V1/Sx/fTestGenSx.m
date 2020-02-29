%%Función para generar diferentes señales de prueba para sistemas de sensado de espectro 
%(
% TipSx=1;% Tipo de señal a generar  
% fy =200;% Frecuencia de la señal a generar
% fs=1e3;% Frecuencia de muestreo
% Ruid=1;% Si es =1 la señal tiene ruido =0 Señal sin ruido
% snr=30;%Relación señal a ruido para la señal de FHSS mesclado con ruido mediante la función awgn
%)
function [Sx_n,Mod,AmP_i,FaP_i,FrP_i] = fTestGenSx(TipSx,fy,fs,Ruid,snr)%[Sx_n] = fGenSxTest(TipSx,fy,fs,awgn,snr)
clear fGenSxTest;%Limpia los valores de las variables 
%PARAMETROS
%Ts=1/fs;%Tiempo de Muestreo
%fs=1e3;%Frecuencia de muestreo
%Ts=1/fs;%Tiempo de muestreo
%N=2;%Valor final del intervalo de tiempo
%Tset=0:Ts:N;%Conjunto de tiempo para la duración de la señal
 
switch (TipSx)
    case 1 %Señal de FHSS
        %PARÁMETROS
        th=0.4;%Tiempo duración de salto
        toff=0.4;%Tiempo entre saltos
        %SE:AL
        %Sx_int=fGenSxFHSS(fs,th,toff);
        [Sx_int,Mod,ValMagInst] = fGenSxFHSS_3(fs,th,toff);
        %ValMagInst=[0 0 0];%ValMagInst=[AmP_i FaP_i FrP_i];
    case 2 % Señal LFM con control del ancho de banda
        %PARÁMETROS
        th=1;%Valor recomendado, no poner valores mayores de 1.
        toff=0.4;%Tiempo entre impulso
        Npuls=6;%número de pulsos
        B=2*fy;%50 %Ancho de banda de la señal LFM, determina la Fmin y Fmax a partir de fy
        %SEÑAL
        [Sx_int,Mod,ValMagInst] = fGenSxPulsiLFMcABVar_2(fs,fy,B,th,toff,Npuls);
        %ValMagInst=[0 0 0];%ValMagInst=[AmP_i FaP_i FrP_i];
    case 3 % Señal DSSS
        %PARÁMETROS
        %fs=1e3;
        %Ts=1/fs;
        fy =200; %Frecuencia de la señal a generar
        NbitOut=100;%Numero de bit que se generaran por ejemplo 30 
        %td=1;%Tiempo de duración de la generación en S
        %SEÑAL
        %Generar la señal de prueba
        PNcode=fGenPN(NbitOut);
        %[Sx_int,Mod]=fGenDSSS(PNcode,fy,fs);
        [Sx_int,Mod,ValMagInst]=fGenDSSS_2(PNcode,fy,fs);
        %Mod=0;
        %FrPort_i=fy;
        
    case 4 % Señal Pulso CW
        %PARÁMETROS
        th=0.4;
        toff=0.4;
        Npuls=6;
        %SE:AL
        [Sx_int,Mod,ValMagInst] = fGenSxPulsiCW_2(fs,fy,th,toff,Npuls);
        %Mod=0;
    case 5 % Señal BPSK
        %PARÁMETROS
        g=[1 0 1 1 0 ];
        %SEÑAL
        Sx_int=fGenBpskd(g,15);
        Mod=0;
        ValMagInst=[0;0;fy];%ValMagInst=[AmP_i;FaP_i;FrP_i];
    case 6 % Señal CW Coseno
        %PARAMETROS
        Ts=1/fs;%Tiempo de Muestreo
        td=1;%Tiempo de duración de la generación en S
        t=0:Ts:(td-Ts);
        %SEÑAL
        Sx_int=fGenSxCosCw(fy,t);
        Mod=0;
        ValMagInst=[0;0;fy];%ValMagInst=[AmP_i;FaP_i;FrP_i];
    case 7 % Señal CW Seno
        %PARÁMETROS
        Ts=1/fs;%Tiempo de Muestreo
        td=1;%Tiempo de duración de la generación en S
        t=0:Ts:(td-Ts);
        %SEÑAL
        Sx_int=fGenSxSinCw(fy,t);
        Mod=0;
        ValMagInst=[0;0;fy];%ValMagInst=[AmP_i;FaP_i;FrP_i];
    case 8 % Señal DSSS de pulso
        %PARÁMETROS
        %fs=1e3;
        %Ts=1/fs;
        fy =200; %Frecuencia de la señal a generar
        NbitOut=100;%Numero de bit que se generaran por ejemplo 30 
        %td=1;%Tiempo de duración de la generación en S
        Th=0.6;
        Toff=0.2;
        Npuls=1;
        %SEÑAL
        %Generar la señal de prueba
        PNcode=fGenPN(NbitOut); 
        [Sx_int,Mod,ValMagInst] =fGenDSSSPuls_2(PNcode,fy,fs,Th,Toff,Npuls);
        %Mod=0;
    case 9 %Señal de FHSS continua
        %PARÁMETROS
        th=0.4;%Tiempo duración de salto
        toff=0;%Tiempo entre saltos
        %SE:AL
        %Sx_int=fGenSxFHSS(fs,th,toff);
        [Sx_int,Mod,ValMagInst] = fGenSxFHSS_3(fs,th,toff);
        %ValMagInst=[0 0 0];%ValMagInst=[AmP_i FaP_i FrP_i];
        
    otherwise %Señal VCO Frecuencia variable
        %PARÁMETROS
        %Ts=1/fs;%Tiempo de Muestreo
        %td=2;%Tiempo de duración de la generación en S
        %t=0:Ts:(td-Ts);
        fmin=fy-(fy/2);
        fmax=fy+(fy/2);
        %SE:AL
        %Sx_int=fVCOfrcVar(fy,fs,t);
        Sx_int=fGenVCOABVar(fmin,fmax,fs);
        Mod=0;
        ValMagInst=[0;0;fy];%ValMagInst=[AmP_i;FaP_i;FrP_i];
        
end
 
if (Ruid==1)
     Sx_n=awgn(Sx_int,snr,'measured');%Adiciona ruido gaussiano a la señal con relación señal a ruido impuesta por snr
else
    Sx_n=Sx_int;
end
%Extracción de los valores de las magnitudes instantáneas
%ValMagInst=[AmP_i FaP_i FrP_i]
AmP_i= ValMagInst(1,:); 
FaP_i= ValMagInst(2,:); 
FrP_i= ValMagInst(3,:);
 
end%Funcion fGenSxTest
%%GRAFICOS
% Sx=Sx_n;
% mod=AmP_i;
% figNum=1;
% fGrafRepreSx(Sx,fs,mod,figNum);
% JORGE Y. HERNÁNDEZ GARCÍA




