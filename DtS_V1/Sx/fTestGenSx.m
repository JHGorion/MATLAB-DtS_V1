%%Funci�n para generar diferentes se�ales de prueba para sistemas de sensado de espectro 
%(
% TipSx=1;% Tipo de se�al a generar  
% fy =200;% Frecuencia de la se�al a generar
% fs=1e3;% Frecuencia de muestreo
% Ruid=1;% Si es =1 la se�al tiene ruido =0 Se�al sin ruido
% snr=30;%Relaci�n se�al a ruido para la se�al de FHSS mesclado con ruido mediante la funci�n awgn
%)
function [Sx_n,Mod,AmP_i,FaP_i,FrP_i] = fTestGenSx(TipSx,fy,fs,Ruid,snr)%[Sx_n] = fGenSxTest(TipSx,fy,fs,awgn,snr)
clear fGenSxTest;%Limpia los valores de las variables 
%PARAMETROS
%Ts=1/fs;%Tiempo de Muestreo
%fs=1e3;%Frecuencia de muestreo
%Ts=1/fs;%Tiempo de muestreo
%N=2;%Valor final del intervalo de tiempo
%Tset=0:Ts:N;%Conjunto de tiempo para la duraci�n de la se�al
 
switch (TipSx)
    case 1 %Se�al de FHSS
        %PAR�METROS
        th=0.4;%Tiempo duraci�n de salto
        toff=0.4;%Tiempo entre saltos
        %SE:AL
        %Sx_int=fGenSxFHSS(fs,th,toff);
        [Sx_int,Mod,ValMagInst] = fGenSxFHSS_3(fs,th,toff);
        %ValMagInst=[0 0 0];%ValMagInst=[AmP_i FaP_i FrP_i];
    case 2 % Se�al LFM con control del ancho de banda
        %PAR�METROS
        th=1;%Valor recomendado, no poner valores mayores de 1.
        toff=0.4;%Tiempo entre impulso
        Npuls=6;%n�mero de pulsos
        B=2*fy;%50 %Ancho de banda de la se�al LFM, determina la Fmin y Fmax a partir de fy
        %SE�AL
        [Sx_int,Mod,ValMagInst] = fGenSxPulsiLFMcABVar_2(fs,fy,B,th,toff,Npuls);
        %ValMagInst=[0 0 0];%ValMagInst=[AmP_i FaP_i FrP_i];
    case 3 % Se�al DSSS
        %PAR�METROS
        %fs=1e3;
        %Ts=1/fs;
        fy =200; %Frecuencia de la se�al a generar
        NbitOut=100;%Numero de bit que se generaran por ejemplo 30 
        %td=1;%Tiempo de duraci�n de la generaci�n en S
        %SE�AL
        %Generar la se�al de prueba
        PNcode=fGenPN(NbitOut);
        %[Sx_int,Mod]=fGenDSSS(PNcode,fy,fs);
        [Sx_int,Mod,ValMagInst]=fGenDSSS_2(PNcode,fy,fs);
        %Mod=0;
        %FrPort_i=fy;
        
    case 4 % Se�al Pulso CW
        %PAR�METROS
        th=0.4;
        toff=0.4;
        Npuls=6;
        %SE:AL
        [Sx_int,Mod,ValMagInst] = fGenSxPulsiCW_2(fs,fy,th,toff,Npuls);
        %Mod=0;
    case 5 % Se�al BPSK
        %PAR�METROS
        g=[1 0 1 1 0 ];
        %SE�AL
        Sx_int=fGenBpskd(g,15);
        Mod=0;
        ValMagInst=[0;0;fy];%ValMagInst=[AmP_i;FaP_i;FrP_i];
    case 6 % Se�al CW Coseno
        %PARAMETROS
        Ts=1/fs;%Tiempo de Muestreo
        td=1;%Tiempo de duraci�n de la generaci�n en S
        t=0:Ts:(td-Ts);
        %SE�AL
        Sx_int=fGenSxCosCw(fy,t);
        Mod=0;
        ValMagInst=[0;0;fy];%ValMagInst=[AmP_i;FaP_i;FrP_i];
    case 7 % Se�al CW Seno
        %PAR�METROS
        Ts=1/fs;%Tiempo de Muestreo
        td=1;%Tiempo de duraci�n de la generaci�n en S
        t=0:Ts:(td-Ts);
        %SE�AL
        Sx_int=fGenSxSinCw(fy,t);
        Mod=0;
        ValMagInst=[0;0;fy];%ValMagInst=[AmP_i;FaP_i;FrP_i];
    case 8 % Se�al DSSS de pulso
        %PAR�METROS
        %fs=1e3;
        %Ts=1/fs;
        fy =200; %Frecuencia de la se�al a generar
        NbitOut=100;%Numero de bit que se generaran por ejemplo 30 
        %td=1;%Tiempo de duraci�n de la generaci�n en S
        Th=0.6;
        Toff=0.2;
        Npuls=1;
        %SE�AL
        %Generar la se�al de prueba
        PNcode=fGenPN(NbitOut); 
        [Sx_int,Mod,ValMagInst] =fGenDSSSPuls_2(PNcode,fy,fs,Th,Toff,Npuls);
        %Mod=0;
    case 9 %Se�al de FHSS continua
        %PAR�METROS
        th=0.4;%Tiempo duraci�n de salto
        toff=0;%Tiempo entre saltos
        %SE:AL
        %Sx_int=fGenSxFHSS(fs,th,toff);
        [Sx_int,Mod,ValMagInst] = fGenSxFHSS_3(fs,th,toff);
        %ValMagInst=[0 0 0];%ValMagInst=[AmP_i FaP_i FrP_i];
        
    otherwise %Se�al VCO Frecuencia variable
        %PAR�METROS
        %Ts=1/fs;%Tiempo de Muestreo
        %td=2;%Tiempo de duraci�n de la generaci�n en S
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
     Sx_n=awgn(Sx_int,snr,'measured');%Adiciona ruido gaussiano a la se�al con relaci�n se�al a ruido impuesta por snr
else
    Sx_n=Sx_int;
end
%Extracci�n de los valores de las magnitudes instant�neas
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
% JORGE Y. HERN�NDEZ GARC�A




