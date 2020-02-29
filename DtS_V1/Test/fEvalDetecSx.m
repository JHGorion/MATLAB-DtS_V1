%An�lisis de las probabilidades de detecci�n y respuesta del detector
%EnvIdealSx=AmP_i;%Envolvente de amplitud ideal de la se�al
%SxDetec=PreSxTemp;% Se�al detectada por el detector para su comparaci�n
%con la ideal
function [PdT,PfaT,PdH1_RH1,PdH0_RH0,PdH1_RH0,PdH0_RH1]= fEvalDetecSx (EnvIdealSx,SxDetec)
    LSx=length(EnvIdealSx);%Determina el n�mero de elementos
    Det_Corr=0;
    Det_Incrr=0;
    NoDet_Corr=0;
    NoDet_Incrr=0;  
    LSxH1=0;
    LSxH0=0;
    %An�lisis muestra a muestra de la detecci�n
    for n=1:LSx
      if (EnvIdealSx(n))%Si la se�al ideal es 1
          LSxH1=LSxH1+1;%Cantidad de valores en que la se�al ideal es 1
          if (SxDetec(n))%Si la se�al detectada tambi�n es 1
             Det_Corr=Det_Corr+1;%Detecci�n correcta
          else
             Det_Incrr=Det_Incrr+1;%Detecci�n Incorrecta 
          end
 
      else% Si la se;al ideal es 0
           LSxH0=LSxH0+1;%Cantidad de valores en que la se�al ideal es 0
          if (SxDetec(n))%Si la se�al detectada por el contrario es 1
             NoDet_Incrr=NoDet_Incrr+1;%Error Detecci�n (Falsa Alarma)
          else
             NoDet_Corr=NoDet_Corr+1;%No Detecci�n correcta 
          end
      end
    end
    %Resumen
    TotDet_Corr=Det_Corr+NoDet_Corr;%Total de detecciones correctas 
    TotDet_Incrr=Det_Incrr+NoDet_Incrr;%Total de detecciones incorrectas 
    PdT=TotDet_Corr/LSx;%Probabilidad de detecci�n. Analiza el porciento de detecciones correctas con respecto al total
    PfaT=TotDet_Incrr/LSx;%Probabilidad de falsa alarma. Analiza el porciento de detecciones incorrectas con respecto al total
 
    PdH1_RH1=Det_Corr/LSxH1;%Probabilidad de detecci�n H1. Analiza cuantas detecciones fueron acertadas mientras la se�al real es 1 
    PdH0_RH0=NoDet_Corr/LSxH0;%Probabilidad de detecci�n H0. Analiza cuantas detecciones fueron acertadas mientras la se�al real es 0 
    % PdH0_RH1=Det_Incrr/LSxH1;%Probabilidad de detecci�n H0. Analiza cuantas detecciones no fueron acertadas mientras la se�al real es 1 
    PdH0_RH1=1-PdH1_RH1;
    %PdH1_RH0=NoDet_Incrr/LSxH0;%Probabilidad de detecci�n H1. Analiza cuantas detecciones no fueron acertadas mientras la se�al real es 0 
    PdH1_RH0=1-PdH0_RH0;
 
end %function fEvalDetecSx
% JORGE Y. HERN�NDEZ GARC�A