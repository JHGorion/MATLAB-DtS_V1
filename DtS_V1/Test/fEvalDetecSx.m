%Análisis de las probabilidades de detección y respuesta del detector
%EnvIdealSx=AmP_i;%Envolvente de amplitud ideal de la señal
%SxDetec=PreSxTemp;% Señal detectada por el detector para su comparación
%con la ideal
function [PdT,PfaT,PdH1_RH1,PdH0_RH0,PdH1_RH0,PdH0_RH1]= fEvalDetecSx (EnvIdealSx,SxDetec)
    LSx=length(EnvIdealSx);%Determina el número de elementos
    Det_Corr=0;
    Det_Incrr=0;
    NoDet_Corr=0;
    NoDet_Incrr=0;  
    LSxH1=0;
    LSxH0=0;
    %Análisis muestra a muestra de la detección
    for n=1:LSx
      if (EnvIdealSx(n))%Si la señal ideal es 1
          LSxH1=LSxH1+1;%Cantidad de valores en que la señal ideal es 1
          if (SxDetec(n))%Si la señal detectada también es 1
             Det_Corr=Det_Corr+1;%Detección correcta
          else
             Det_Incrr=Det_Incrr+1;%Detección Incorrecta 
          end
 
      else% Si la se;al ideal es 0
           LSxH0=LSxH0+1;%Cantidad de valores en que la señal ideal es 0
          if (SxDetec(n))%Si la señal detectada por el contrario es 1
             NoDet_Incrr=NoDet_Incrr+1;%Error Detección (Falsa Alarma)
          else
             NoDet_Corr=NoDet_Corr+1;%No Detección correcta 
          end
      end
    end
    %Resumen
    TotDet_Corr=Det_Corr+NoDet_Corr;%Total de detecciones correctas 
    TotDet_Incrr=Det_Incrr+NoDet_Incrr;%Total de detecciones incorrectas 
    PdT=TotDet_Corr/LSx;%Probabilidad de detección. Analiza el porciento de detecciones correctas con respecto al total
    PfaT=TotDet_Incrr/LSx;%Probabilidad de falsa alarma. Analiza el porciento de detecciones incorrectas con respecto al total
 
    PdH1_RH1=Det_Corr/LSxH1;%Probabilidad de detección H1. Analiza cuantas detecciones fueron acertadas mientras la señal real es 1 
    PdH0_RH0=NoDet_Corr/LSxH0;%Probabilidad de detección H0. Analiza cuantas detecciones fueron acertadas mientras la señal real es 0 
    % PdH0_RH1=Det_Incrr/LSxH1;%Probabilidad de detección H0. Analiza cuantas detecciones no fueron acertadas mientras la señal real es 1 
    PdH0_RH1=1-PdH1_RH1;
    %PdH1_RH0=NoDet_Incrr/LSxH0;%Probabilidad de detección H1. Analiza cuantas detecciones no fueron acertadas mientras la señal real es 0 
    PdH1_RH0=1-PdH0_RH0;
 
end %function fEvalDetecSx
% JORGE Y. HERNÁNDEZ GARCÍA