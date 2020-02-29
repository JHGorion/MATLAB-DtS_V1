%Detector de energía basado en el procesamiento estadístico de magnitudes instantáneas
%Esta variante requiere que los parámetros estadístico A_iProm,Fa_iDesAbsMed,Fa_iDAMprom, se calculen externamente 
%A_i(Amplitud instantanea),Fas_i(Fase instantánea),k_ai(Longitud ventana promedio amplitud),k_fai(Longitud ventana promedio Fase)
%(
%N;%vector con los números de muestra (entre N y N+1 el tiempo es el periodo do muestreo Ts)
%A_iProm,
%Fa_iDAMprom,
%U, Constante que se multiplica con Fa_iDAMprom(i))para modificar el umbral de decisión
%A %Se trabaja con expresión A+U*Fa_iDAMprom para mejoras en detección SNR<0
%)
 
function [PreSx,Umbr] = fmDTSxParInst(N,A_iProm,Fa_iDAMprom,U,A)
    clear fmDTSxParInst
    Nsamp=length(N);
    %Se crea vector con valores 0 para ir dándole valores en el ciclo for
    Umbr=zeros(1,Nsamp);
    PreSx=zeros(1,Nsamp);
    for i=1:Nsamp  
        %Selector del umbral de decisión
        Umbr(i)=U+(A*Fa_iDAMprom(i));%Se trabaja con expresión a+bx para pruebas de mejoras en detección SNR<0
        %Detection de señal
        if (A_iProm(i) > Umbr(i))%Detección de presencia de señal
            PreSx(i)=1;
        else
            PreSx(i)=0;
        end
    end
end% Función fmDTSxParInst
% JORGE Y. HERNÁNDEZ GARCÍA
