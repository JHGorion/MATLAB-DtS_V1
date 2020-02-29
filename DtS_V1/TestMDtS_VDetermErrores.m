%Scrip para la comprobar los errores en la detecci�n. Se realiza L_snr=length(snrVec)iteraciones para el c�lculo a una frecuencia de muestreo de 2e3Hz 
clear variables;
%clear functions;
%PAR�METROS
fs=2e3;
Ts=1/fs;
fy =20; %Frecuencia de la se�al a generar
snr=20; %Relaci�n se�al a ruido para la se�al
%ADICIONAR CARPETAS TEMPORALES
addpath('Sx','bASx','bOPI','bDIEP','bDIEP\mPEVD','bDIEP\mDtS','GRAFICOS','Test');% Adiciona la carpeta en los path de MATLAB para ejecutar la funci�n en su interior
 
%%INICIO CICLO PARA EVALUACI�N DE COMPORTAMIENTO ALGORITMO
snrVec=-10:1:70;%Vector con los valores de SNR. En pruebas para valores mayores de 50 los errores son constantes
% snrVec= 20;
L_snr=length(snrVec);
 
%Almacena los valores de probabilidad detecci�n y falsa alarma
rProbDet=zeros(1,L_snr);%
rProbFaAl=zeros(1,L_snr);%
rPdH1_RH1=zeros(1,L_snr);%Valores de probabilidad de detecci�n de H1 cuando se�al real es H1(Se�al m�s ruido)
rPdH0_RH0=zeros(1,L_snr);%Valores de probabilidad de detecci�n de H0 cuando se�al real es H0(ruido)
rPdH1_RH0=zeros(1,L_snr);%Valores de probabilidad de detecci�n de H1 cuando se�al real es H0(ruido)
rPdH0_RH1=zeros(1,L_snr);%Valores de probabilidad de detecci�n de H0 cuando se�al real es H1(Se�al m�s ruido)
 
%Para evaluar el error de frecuencia con variaci�n frecuencia de muestreo
 
% FsVec= [0.3e3 0.4e3 0.5e3 0.6e3 0.8e3 1e3 2e3 3e3 4e3 5e3];% para ajustar los valores de fs/fy
FsVec= 2e3; %Se pone una sola frecuencia para que el algoritmo se ejecute una sola ves
L_fr=length(FsVec);
 
 
% CICLO PARA EVALUAR LOS ERRORES DE CALCULO FRECUENCIA SEG�N FRECUENCIA DE
% MUESTREO
for k_fr = 1:L_fr
    %Para evaluar el error de frecuencia con variaci�n frecuencia portadora
    % fy=FrVec(k_fr);
    %
    %Para evaluar el error de frecuencia con variaci�n frecuencia de muestreo
    fs=FsVec(k_fr);
    Ts=1/fs;
    fy=100;
    %
    %CICLO PARA EVALUACI�N DE COMPORTAMIENTO ALGORITMO OPI
    for k_snr = 1:L_snr 
        snr=snrVec(k_snr);
 
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
        TipSx=4;% selecciones el tipo de se�al
        Ruid=1;% Si es 1 adiciona ruido a la se�al con valor de snr, 0 sin ruido
 
        [Sx_n,Mod,AmP_i,FaP_i,FrP_i] = fTestGenSx(TipSx,fy,fs,Ruid,snr);% (Tipo Se�al, frecuencia, frecuencia muestreo, Habilita Ruido, relaci�n se�al ruido  
 
        %%********************* BLOQUE DE ACONDICIONAMIENTO DE SE�ALES 
        %%****************************** (bASx)**********************************
        % Obtenci�n de IQ de la se�al generada
        [Sh,I,Q]=fOptIQ(Sx_n);
 
        %%********************* BLOQUE DE OBTENCI�N DE PAR�METROS INSTANT�NEOS
        %%****************************** (bOPI)**********************************
        [N,A_i,Fa_i,Fr_i] = fOPI(Sh,Ts,I,Q);
 
        %%*********** BLOQUE DE DETECCI�N IDENTIFICACI�N Y ESTIMACI�N DE PAR�METROS
        %%****************************** (bDIEP)**********************************
 
        %%************ M�DULO DE PROCESAMIENTO ESTAD�STICO CON VENTANA DESLIZANTE
        %%******************************* (mPEVD) *******************************
        %****** C�LCULO DE PAR�METROS ESTAD�STICOS
        %PAR�METROS
        % AMPLITUD INSTANT�NEA 
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
 
        %********** MODULO DE DETECCI�N
        %PAR�METROS
        %Control del Umbral de la forma U+A*Fa_iDAMprom
        U=0.2;%Constante que se suma con Fa_iDAMprom(i))para modificar el umbral de decisi�n  U=0.2;
        A=1.3;%Constante que controla la amplitud de Fa_iDAMprom  A=1;
        %
        [PreSxTemp,Umbr] = fmDTSxParInst(N,Am_iProm,Fa_iDAMprom,U,A);%PreSxTemp=PreSx
       
        
        %SENTENCIAS TEMPORALES PARA EL C�LCULO DE LOS ERRORES
        %*********Calculo del comportamiento temporal, de amplitud y frecuencia IDEALES de la se�al para comparaci�n
        PreSx=AmP_i; %Se realiza esta asignaci�n temporalmente para garantizar detecci�n con ruido para calcular los errores en determinaci�n de los PI 
        %PreSxIdeal=AmP_i; % Se le asigna el valor de AmP_i que representa el comportamiento temporal de la se�al sin ruido
        
        %An�lisis de las probabilidades de detecci�n y respuesta del
        %detector
        EnvIdealSx=AmP_i;
        SxDetec=PreSxTemp;
        
        [PdT,PfaT,PdH1_RH1,PdH0_RH0,PdH1_RH0,PdH0_RH1]= fEvalDetecSx (EnvIdealSx,SxDetec);
        
        
        %*** AN�LISIS DE LOS ERRORES DE C�LCULO PARA DISTINTOS SNR
        % Almacena los errores en el c�lculo de la Iteraci�n (para cada valor snr)
        
        %Actualizaci�n de registro para cada ciclo L_snr
        rProbDet(k_snr)=PdT;%
        rProbFaAl(k_snr)=PfaT;%
        rPdH1_RH1(k_snr)=PdH1_RH1;%
        rPdH0_RH0(k_snr)=PdH0_RH0;%
        rPdH1_RH0(k_snr)=PdH1_RH0;%
        rPdH0_RH1(k_snr)=PdH0_RH1;%
        
        %************** FIN ****AN�LISIS DE LOS ERRORES DE CALCULO PARA DISTINTOS SNR******************
    end %(for k_snr = 1:L_snr) CICLO PARA EVALUACI�N DE COMPORTAMIENTO ALGORITMO    
    
end % (for k_fr = 1:L_fr) CICLO PARA EVALUAR LOS ERRORES DE CALCULO FRECUENCIA SEG�N FRECUENCIA DE
% MUESTREO

    
    
    
%*******************************************************************************************
 
%% GR�FICAS
figNum=1;%figNum = figNum+1;%Para incrementar el n�mero de la figura
% fGraf_ProbDetProbFAconSNR(snrVec,rProbDet,rProbFaAl,figNum);figNum = figNum+1;%Para incrementar el n�mero de la figura
% fGraf_ProbDetH1yH0conSNR(snrVec,rPdH1_RH1,rPdH0_RH0,figNum);figNum = figNum+1;%Para incrementar el n�mero de la figura
% fGraf_ProbDet4HipotConSNR(snrVec,rPdH1_RH1,rPdH0_RH0,rPdH1_RH0,rPdH0_RH1,figNum);figNum = figNum+1;%Para incrementar el n�mero de la figura

%GRAPHICS IN ENGLISH
fGraf_ProbDetProbFAconSNR_EN(snrVec,rProbDet,rProbFaAl,figNum);figNum = figNum+1;%Para incrementar el n�mero de la figura
fGraf_ProbDetH1yH0conSNR_EN(snrVec,rPdH1_RH1,rPdH0_RH0,figNum);figNum = figNum+1;%Para incrementar el n�mero de la figura
fGraf_ProbDet4HipotConSNR_EN(snrVec,rPdH1_RH1,rPdH0_RH0,rPdH1_RH0,rPdH0_RH1,figNum);figNum = figNum+1;%Para incrementar el n�mero de la figura

% %
rmpath('Sx','bASx','bOPI','bDIEP','bDIEP\mPEVD','bDIEP\mDtS','GRAFICOS','Test');% Elimina la carpeta en los path de MATLAB
% JORGE Y. HERN�NDEZ GARC�A

