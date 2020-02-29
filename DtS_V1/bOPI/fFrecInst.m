%Calcula la Frecuencia instantánea
function [Fr_i] = fFrecInst(Sh,Ts)%Sh es la transformada de Hilbert y Ts es el periodo de muestreo
    clear Fr_i;
    Sh_Sinc=[0 Sh];%Para igualar la cantidad de muestra de A_i y de Fa_i
    dg= diff (Sh_Sinc)/ Ts; % Derivada aproximada
    w=abs(dg ); % Frecuencia en rad/s
    Fr_i=w /(2* pi); %Frecuencia en Hz
end%Funcion
% JORGE Y. HERNÁNDEZ GARCÍA 