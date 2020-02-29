%Obtiene los parámetros instantáneos de una señal
%(Sh, transformada de Hilbert de la señal
%Ts, periodo de muestreo para calcular la frecuencia instantánea
%I, Componente I de la señal
%Q Componente Q de la señal
%)
%[n, Número de muestra de la Señal
%A_i, Amplitud instantánea
%Fa_i, Fase instantánea
%Fr_i Frecuencia instantánea
%]
function [N,A_i,Fa_i,Fr_i] = fOPI(Sh,Ts,I,Q)%Sh es la transformada de Hilbert y Ts es el periodo de 
    %%Calculo de parámetros instantáneos
    Ln= length (Sh);%Determina la cantidad de muestras de la Señal
    N= 1:1:Ln;%Crea un vector no el índice con el número de muestra
    %Amplitud Instantánea
    A_i=fAmpInst(I,Q);
    %Fase Instantánea
    Fa_i=fFasInst(I,Q);
    %Frecuencia Instantánea
    Fr_i= fFrecInst(Sh,Ts);
end% Funcion
% JORGE Y. HERNÁNDEZ GARCÍA