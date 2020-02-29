%Scrip para implementación del módulo de detección basado en le procesamiento estadístico de las magnitudes instantáneas.
clear variables;
% clear functions;
%PARÁMETROS
fs=2e3;
Ts=1/fs;
fy =20; %Frecuencia de la señal a generar
snr=20; %Relación señal a ruido para la señal
%ADICIONAR CARPETAS TEMPORALES
addpath('Sx','bASx','bOPI','bDIEP\mPEVD','bDIEP\mDtS','GRAFICOS','Test');% Adiciona la carpeta en los path de MATLAB para ejecutar la función en su interior
 
%%********************* GENERADOR DE SEÑALES DE PRUEBA
% 1 % Señal de FHSS; 
% 2 % Señal LFM con control del ancho de banda 
% 3 % Señal DSSS
% 4 % Señal Pulso CW
% 5 % Señal BPSK
% 6 % Señal CW Coseno
% 7 % Señal CW Seno
% 8 % Señal DSSS Pulso
% 9 % Señal de FHSS continua; 
% otherwise %Señal VCO Frecuencia variable
TipSx=1;% selecciones el tipo de señal
Ruid=1;% Si es 1 adiciona ruido a la señal con valor de snr, 0 sin ruido
 
[Sx_n,Mod,AmP_i,FaP_i,FrP_i] = fTestGenSx(TipSx,fy,fs,Ruid,snr);% (Tipo Señal, frecuencia, frecuencia muestreo, Habilita Ruido, relación señal ruido  
 
%%********************* BLOQUE DE ACONDICIONAMIENTO DE SEÑALES 
 %%****************************** (bASx)**********************************
%Obtención de IQ de la señal generada
[Sh,I,Q]=fOptIQ(Sx_n);
 
%%********************* BLOQUE DE OBTENCIÓN DE PARÁMETROS INSTANTÁNEOS
%%****************************** (bOPI)**********************************
[N,A_i,Fa_i,Fr_i] = fOPI(Sh,Ts,I,Q);
 
%%*********** BLOQUE DE DETECCIÓN IDENTIFICACIÓN Y ESTIMACIÓN DE PARÁMETROS
%%****************************** (bDIEP)**********************************
 
%%************ MÓDULO DE PROCESAMIENTO ESTADÍSTICO CON VENTANA DESLIZANTE
%%******************************* (mPEVD) *******************************
%******CALCULO DE PARÁMETROS ESTADÍSTICOS
%PARÁMETROS
%AMPLITUD INSTANTÁNEA 
% Cálculo estadístico con ventana deslizante 
k_AiPro=30;%longitud ventana promedio Ai % Para [movmean(A,k)] Cada promedio se calcula sobre una ventana deslizante de longitud k 
[Am_iProm] = fEstVentDes_Am(A_i,k_AiPro);
 
%FASE INSTANTÁNEA 
% Cálculo estadístico con ventana deslizante 
k_FaiDAMe=3;%longitud ventana para Desviación absoluta respecto a la mediana (DEM) Fa_i
k_FaiPrDAMe=27;%longitud ventana promedio de DAM
k_FaiDE=3;
k_FaiPro=3;
[Fa_iDesAbsMed,Fa_iDAMprom,Fa_iDesEst,Fa_iProm] = fEstVentDes_Fa(Fa_i, k_FaiDAMe,k_FaiPrDAMe,k_FaiDE,k_FaiPro);
 
%FRECUENCIA INSTANTÁNEA
% Cálculo estadístico con ventana deslizante 
k_FriPro=30;
k_FriDE=3;
[Fr_iProm,Fr_iDesEst,Fr_iPromDesEst] = fEstVentDes_Fr(Fr_i,k_FriPro,k_FriDE);%
%
 
%********** MÓDULO DE DETECCIÓN
%PARÁMETROS
%Control del Umbral de la forma U+A*Fa_iDAMprom
U=0.2;%Constante que se suma con Fa_iDAMprom(i))para modificar el umbral de decisión  U=0.2;
A=1.3;% Constante que controla la amplitud de Fa_iDAMprom  A=1;
%
[PreSxTemp,Umbr] = fmDTSxParInst(N,Am_iProm,Fa_iDAMprom,U,A);%PreSxTemp=PreSx
 
 
%*******************************************************************************************
 
%%GRÁFICAS
figNum=1;%figNum = figNum+1;%Para incrementar el número de la figura
%fGraf3x1_DetEnCompAmpReal(Sx_n,N,AmP_i,Am_iProm,PreSxTemp,Umbr,figNum);figNum = figNum+1;

%GRAPHICS IN ENGLISH
fGraf3x1_DetEnCompAmpReal_EN(Sx_n,N,AmP_i,Am_iProm,PreSxTemp,Umbr,figNum);figNum = figNum+1;
% %
rmpath('Sx','bASx','bOPI','bDIEP\mPEVD','bDIEP\mDtS','GRAFICOS','Test');% Elimina la carpeta en los path de MATLAB
% JORGE Y. HERNÁNDEZ GARCÍA


