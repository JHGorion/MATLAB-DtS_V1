%Obtiene los par�metros instant�neos de una se�al
%(Sh, transformada de Hilbert de la se�al
%Ts, periodo de muestreo para calcular la frecuencia instant�nea
%I, Componente I de la se�al
%Q Componente Q de la se�al
%)
%[n, N�mero de muestra de la Se�al
%A_i, Amplitud instant�nea
%Fa_i, Fase instant�nea
%Fr_i Frecuencia instant�nea
%]
function [N,A_i,Fa_i,Fr_i] = fOPI(Sh,Ts,I,Q)%Sh es la transformada de Hilbert y Ts es el periodo de 
    %%Calculo de par�metros instant�neos
    Ln= length (Sh);%Determina la cantidad de muestras de la Se�al
    N= 1:1:Ln;%Crea un vector no el �ndice con el n�mero de muestra
    %Amplitud Instant�nea
    A_i=fAmpInst(I,Q);
    %Fase Instant�nea
    Fa_i=fFasInst(I,Q);
    %Frecuencia Instant�nea
    Fr_i= fFrecInst(Sh,Ts);
end% Funcion
% JORGE Y. HERN�NDEZ GARC�A