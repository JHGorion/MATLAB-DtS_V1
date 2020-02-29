%Scrip para implementaci�n del m�dulo de detecci�n basado en le procesamiento estad�stico de las magnitudes instant�neas.
clear variables;
% clear functions;
%PAR�METROS
fs=2e3;
Ts=1/fs;
fy =20; %Frecuencia de la se�al a generar
snr=20; %Relaci�n se�al a ruido para la se�al
%ADICIONAR CARPETAS TEMPORALES
addpath('Sx','bASx','bOPI','bDIEP\mPEVD','bDIEP\mDtS','GRAFICOS','Test');% Adiciona la carpeta en los path de MATLAB para ejecutar la funci�n en su interior
 
%%********************* GENERADOR DE SE�ALES DE PRUEBA
% 1 % Se�al de FHSS; 
% 2 % Se�al LFM con control del ancho de banda 
% 3 % Se�al DSSS
% 4 % Se�al Pulso CW
% 5 % Se�al BPSK
% 6 % Se�al CW Coseno
% 7 % Se�al CW Seno
% 8 % Se�al DSSS Pulso
% 9 % Se�al de FHSS continua; 
% otherwise %Se�al VCO Frecuencia variable
TipSx=1;% selecciones el tipo de se�al
Ruid=1;% Si es 1 adiciona ruido a la se�al con valor de snr, 0 sin ruido
 
[Sx_n,Mod,AmP_i,FaP_i,FrP_i] = fTestGenSx(TipSx,fy,fs,Ruid,snr);% (Tipo Se�al, frecuencia, frecuencia muestreo, Habilita Ruido, relaci�n se�al ruido  
 
%%********************* BLOQUE DE ACONDICIONAMIENTO DE SE�ALES 
 %%****************************** (bASx)**********************************
%Obtenci�n de IQ de la se�al generada
[Sh,I,Q]=fOptIQ(Sx_n);
 
%%********************* BLOQUE DE OBTENCI�N DE PAR�METROS INSTANT�NEOS
%%****************************** (bOPI)**********************************
[N,A_i,Fa_i,Fr_i] = fOPI(Sh,Ts,I,Q);
 
%%*********** BLOQUE DE DETECCI�N IDENTIFICACI�N Y ESTIMACI�N DE PAR�METROS
%%****************************** (bDIEP)**********************************
 
%%************ M�DULO DE PROCESAMIENTO ESTAD�STICO CON VENTANA DESLIZANTE
%%******************************* (mPEVD) *******************************
%******CALCULO DE PAR�METROS ESTAD�STICOS
%PAR�METROS
%AMPLITUD INSTANT�NEA 
% C�lculo estad�stico con ventana deslizante 
k_AiPro=30;%longitud ventana promedio Ai % Para [movmean(A,k)] Cada promedio se calcula sobre una ventana deslizante de longitud k 
[Am_iProm] = fEstVentDes_Am(A_i,k_AiPro);
 
%FASE INSTANT�NEA 
% C�lculo estad�stico con ventana deslizante 
k_FaiDAMe=3;%longitud ventana para Desviaci�n absoluta respecto a la mediana (DEM) Fa_i
k_FaiPrDAMe=27;%longitud ventana promedio de DAM
k_FaiDE=3;
k_FaiPro=3;
[Fa_iDesAbsMed,Fa_iDAMprom,Fa_iDesEst,Fa_iProm] = fEstVentDes_Fa(Fa_i, k_FaiDAMe,k_FaiPrDAMe,k_FaiDE,k_FaiPro);
 
%FRECUENCIA INSTANT�NEA
% C�lculo estad�stico con ventana deslizante 
k_FriPro=30;
k_FriDE=3;
[Fr_iProm,Fr_iDesEst,Fr_iPromDesEst] = fEstVentDes_Fr(Fr_i,k_FriPro,k_FriDE);%
%
 
%********** M�DULO DE DETECCI�N
%PAR�METROS
%Control del Umbral de la forma U+A*Fa_iDAMprom
U=0.2;%Constante que se suma con Fa_iDAMprom(i))para modificar el umbral de decisi�n  U=0.2;
A=1.3;% Constante que controla la amplitud de Fa_iDAMprom  A=1;
%
[PreSxTemp,Umbr] = fmDTSxParInst(N,Am_iProm,Fa_iDAMprom,U,A);%PreSxTemp=PreSx
 
 
%*******************************************************************************************
 
%%GR�FICAS
figNum=1;%figNum = figNum+1;%Para incrementar el n�mero de la figura
%fGraf3x1_DetEnCompAmpReal(Sx_n,N,AmP_i,Am_iProm,PreSxTemp,Umbr,figNum);figNum = figNum+1;

%GRAPHICS IN ENGLISH
fGraf3x1_DetEnCompAmpReal_EN(Sx_n,N,AmP_i,Am_iProm,PreSxTemp,Umbr,figNum);figNum = figNum+1;
% %
rmpath('Sx','bASx','bOPI','bDIEP\mPEVD','bDIEP\mDtS','GRAFICOS','Test');% Elimina la carpeta en los path de MATLAB
% JORGE Y. HERN�NDEZ GARC�A


