%Detector de energ�a basado en el procesamiento estad�stico de magnitudes instant�neas
%Esta variante requiere que los par�metros estad�stico A_iProm,Fa_iDesAbsMed,Fa_iDAMprom, se calculen externamente 
%A_i(Amplitud instantanea),Fas_i(Fase instant�nea),k_ai(Longitud ventana promedio amplitud),k_fai(Longitud ventana promedio Fase)
%(
%N;%vector con los n�meros de muestra (entre N y N+1 el tiempo es el periodo do muestreo Ts)
%A_iProm,
%Fa_iDAMprom,
%U, Constante que se multiplica con Fa_iDAMprom(i))para modificar el umbral de decisi�n
%A %Se trabaja con expresi�n A+U*Fa_iDAMprom para mejoras en detecci�n SNR<0
%)
 
function [PreSx,Umbr] = fmDTSxParInst(N,A_iProm,Fa_iDAMprom,U,A)
    clear fmDTSxParInst
    Nsamp=length(N);
    %Se crea vector con valores 0 para ir d�ndole valores en el ciclo for
    Umbr=zeros(1,Nsamp);
    PreSx=zeros(1,Nsamp);
    for i=1:Nsamp  
        %Selector del umbral de decisi�n
        Umbr(i)=U+(A*Fa_iDAMprom(i));%Se trabaja con expresi�n a+bx para pruebas de mejoras en detecci�n SNR<0
        %Detection de se�al
        if (A_iProm(i) > Umbr(i))%Detecci�n de presencia de se�al
            PreSx(i)=1;
        else
            PreSx(i)=0;
        end
    end
end% Funci�n fmDTSxParInst
% JORGE Y. HERN�NDEZ GARC�A
