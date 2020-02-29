function [y] =fGenBpskd(g,f) 
%Modulación BPSK
%Ejemplo:
%fBpskd([1 0 1 1 0],2)
if nargin > 2 
    error('Demasiados argumentos de entrada');%'Too many input arguments'   
elseif nargin==1 
    f=1; 
end
if f<1
    error('La frecuencia debe ser mayor que 1');%'Frequency must be bigger than 1' 
end
t=0:2*pi/99:2*pi; 
cp=[];sp=[]; 
mod=[];mod1=[];bit=[]; 
for n=1:length(g) 
if g(n)==0
    die=-ones(1,100);  %Modulante
    se=zeros(1,100);  %Señal
else g(n)=1; 
    die=ones(1,100);  %Modulante
    se=ones(1,100);  %Señal
end
c=sin(f*t); 
cp=[cp die]; 
mod=[mod c]; 
bit=[bit se]; 
end
 
bpsk=cp.*mod;
y=bpsk;
