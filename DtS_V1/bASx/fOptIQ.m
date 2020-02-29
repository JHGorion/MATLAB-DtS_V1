%Calcula la transformada de Hilbert para extraer de una se�al compleja su
%parte real e imaginaria Ejemplo de llamado [Sh,I,Q]=fOptIQ(Sx_fhss); Sx_fhss
%es una se�al generada
function [Sh,I,Q] = fOptIQ(Sx)
Sh=hilbert(Sx);
I=real(Sh);
Q=imag(Sh);
end%Funcion fOptIQ 
% JORGE Y. HERN�NDEZ GARC�A