%Scrip para la comprobar los errores en la detección. Se realiza L_snr=length(snrVec)iteraciones para el cálculo a una frecuencia de muestreo de 2e3Hz 
clear variables;
%clear functions;
%PARÁMETROS
fs=2e3;
Ts=1/fs;
fy =20; %Frecuencia de la señal a generar
snr=20; %Relación señal a ruido para la señal
%ADICIONAR CARPETAS TEMPORALES
addpath('Sx','bASx','bOPI','bDIEP','bDIEP\mPEVD','bDIEP\mDtS','GRAFICOS','Test');% Adiciona la carpeta en los path de MATLAB para ejecutar la función en su interior
 
%%INICIO CICLO PARA EVALUACIÓN DE COMPORTAMIENTO ALGORITMO
snrVec=-10:1:70;%Vector con los valores de SNR. En pruebas para valores mayores de 50 los errores son constantes
% snrVec= 20;
L_snr=length(snrVec);
 
%Almacena los valores de probabilidad detección y falsa alarma
rProbDet=zeros(1,L_snr);%
rProbFaAl=zeros(1,L_snr);%
rPdH1_RH1=zeros(1,L_snr);%Valores de probabilidad de detección de H1 cuando señal real es H1(Señal más ruido)
rPdH0_RH0=zeros(1,L_snr);%Valores de probabilidad de detección de H0 cuando señal real es H0(ruido)
rPdH1_RH0=zeros(1,L_snr);%Valores de probabilidad de detección de H1 cuando señal real es H0(ruido)
rPdH0_RH1=zeros(1,L_snr);%Valores de probabilidad de detección de H0 cuando señal real es H1(Señal más ruido)
 
%Para evaluar el error de frecuencia con variación frecuencia de muestreo
 
% FsVec= [0.3e3 0.4e3 0.5e3 0.6e3 0.8e3 1e3 2e3 3e3 4e3 5e3];% para ajustar los valores de fs/fy
FsVec= 2e3; %Se pone una sola frecuencia para que el algoritmo se ejecute una sola ves
L_fr=length(FsVec);
 
 
% CICLO PARA EVALUAR LOS ERRORES DE CALCULO FRECUENCIA SEGÚN FRECUENCIA DE
% MUESTREO
for k_fr = 1:L_fr
    %Para evaluar el error de frecuencia con variación frecuencia portadora
    % fy=FrVec(k_fr);
    %
    %Para evaluar el error de frecuencia con variación frecuencia de muestreo
    fs=FsVec(k_fr);
    Ts=1/fs;
    fy=100;
    %
    %CICLO PARA EVALUACIÓN DE COMPORTAMIENTO ALGORITMO OPI
    for k_snr = 1:L_snr 
        snr=snrVec(k_snr);
 
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
        TipSx=4;% selecciones el tipo de señal
        Ruid=1;% Si es 1 adiciona ruido a la señal con valor de snr, 0 sin ruido
 
        [Sx_n,Mod,AmP_i,FaP_i,FrP_i] = fTestGenSx(TipSx,fy,fs,Ruid,snr);% (Tipo Señal, frecuencia, frecuencia muestreo, Habilita Ruido, relación señal ruido  
 
        %%********************* BLOQUE DE ACONDICIONAMIENTO DE SEÑALES 
        %%****************************** (bASx)**********************************
        % Obtención de IQ de la señal generada
        [Sh,I,Q]=fOptIQ(Sx_n);
 
        %%********************* BLOQUE DE OBTENCIÓN DE PARÁMETROS INSTANTÁNEOS
        %%****************************** (bOPI)**********************************
        [N,A_i,Fa_i,Fr_i] = fOPI(Sh,Ts,I,Q);
 
        %%*********** BLOQUE DE DETECCIÓN IDENTIFICACIÓN Y ESTIMACIÓN DE PARÁMETROS
        %%****************************** (bDIEP)**********************************
 
        %%************ MÓDULO DE PROCESAMIENTO ESTADÍSTICO CON VENTANA DESLIZANTE
        %%******************************* (mPEVD) *******************************
        %****** CÁLCULO DE PARÁMETROS ESTADÍSTICOS
        %PARÁMETROS
        % AMPLITUD INSTANTÁNEA 
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
 
        %********** MODULO DE DETECCIÓN
        %PARÁMETROS
        %Control del Umbral de la forma U+A*Fa_iDAMprom
        U=0.2;%Constante que se suma con Fa_iDAMprom(i))para modificar el umbral de decisión  U=0.2;
        A=1.3;%Constante que controla la amplitud de Fa_iDAMprom  A=1;
        %
        [PreSxTemp,Umbr] = fmDTSxParInst(N,Am_iProm,Fa_iDAMprom,U,A);%PreSxTemp=PreSx
       
        
        %SENTENCIAS TEMPORALES PARA EL CÁLCULO DE LOS ERRORES
        %*********Calculo del comportamiento temporal, de amplitud y frecuencia IDEALES de la señal para comparación
        PreSx=AmP_i; %Se realiza esta asignación temporalmente para garantizar detección con ruido para calcular los errores en determinación de los PI 
        %PreSxIdeal=AmP_i; % Se le asigna el valor de AmP_i que representa el comportamiento temporal de la señal sin ruido
        
        %Análisis de las probabilidades de detección y respuesta del
        %detector
        EnvIdealSx=AmP_i;
        SxDetec=PreSxTemp;
        
        [PdT,PfaT,PdH1_RH1,PdH0_RH0,PdH1_RH0,PdH0_RH1]= fEvalDetecSx (EnvIdealSx,SxDetec);
        
        
        %*** ANÁLISIS DE LOS ERRORES DE CÁLCULO PARA DISTINTOS SNR
        % Almacena los errores en el cálculo de la Iteración (para cada valor snr)
        
        %Actualización de registro para cada ciclo L_snr
        rProbDet(k_snr)=PdT;%
        rProbFaAl(k_snr)=PfaT;%
        rPdH1_RH1(k_snr)=PdH1_RH1;%
        rPdH0_RH0(k_snr)=PdH0_RH0;%
        rPdH1_RH0(k_snr)=PdH1_RH0;%
        rPdH0_RH1(k_snr)=PdH0_RH1;%
        
        %************** FIN ****ANÁLISIS DE LOS ERRORES DE CALCULO PARA DISTINTOS SNR******************
    end %(for k_snr = 1:L_snr) CICLO PARA EVALUACIÓN DE COMPORTAMIENTO ALGORITMO    
    
end % (for k_fr = 1:L_fr) CICLO PARA EVALUAR LOS ERRORES DE CALCULO FRECUENCIA SEGÚN FRECUENCIA DE
% MUESTREO

    
    
    
%*******************************************************************************************
 
%% GRÁFICAS
figNum=1;%figNum = figNum+1;%Para incrementar el número de la figura
% fGraf_ProbDetProbFAconSNR(snrVec,rProbDet,rProbFaAl,figNum);figNum = figNum+1;%Para incrementar el número de la figura
% fGraf_ProbDetH1yH0conSNR(snrVec,rPdH1_RH1,rPdH0_RH0,figNum);figNum = figNum+1;%Para incrementar el número de la figura
% fGraf_ProbDet4HipotConSNR(snrVec,rPdH1_RH1,rPdH0_RH0,rPdH1_RH0,rPdH0_RH1,figNum);figNum = figNum+1;%Para incrementar el número de la figura

%GRAPHICS IN ENGLISH
fGraf_ProbDetProbFAconSNR_EN(snrVec,rProbDet,rProbFaAl,figNum);figNum = figNum+1;%Para incrementar el número de la figura
fGraf_ProbDetH1yH0conSNR_EN(snrVec,rPdH1_RH1,rPdH0_RH0,figNum);figNum = figNum+1;%Para incrementar el número de la figura
fGraf_ProbDet4HipotConSNR_EN(snrVec,rPdH1_RH1,rPdH0_RH0,rPdH1_RH0,rPdH0_RH1,figNum);figNum = figNum+1;%Para incrementar el número de la figura

% %
rmpath('Sx','bASx','bOPI','bDIEP','bDIEP\mPEVD','bDIEP\mDtS','GRAFICOS','Test');% Elimina la carpeta en los path de MATLAB
% JORGE Y. HERNÁNDEZ GARCÍA

