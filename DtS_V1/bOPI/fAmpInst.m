%Calcula la magnitud instant�nea
function [A_i] = fAmpInst(I,Q)
    clear A_i;
    A_i=sqrt(I.^2+Q.^2);
end%Funcion fAmpInst
%NOTA
%Ai=abs(Sh);% abs(x) devuelve el modulo complejo (magnitud) de x que es lo mismo que sqrt(real(x).^2+imag(x).^2)
%Sh es una variable compleja
% JORGE Y. HERN�NDEZ GARC�A