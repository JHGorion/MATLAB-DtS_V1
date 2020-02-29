%Generador polinomio usando función commsrc.pn
%(
%NbitOut Numero de bit que se generaran por ejemplo 30
%)  
function [PNcode] = fGenPN(NbitOut)
    clear fGenPN;
    vPoly=[1 1 0 0 0 0 0 1];%vPoly=[7 6 0];%'z^7 + z^6 + 1'
    vCurSt=[0 0 0 0 0 0 1 ];%Deben tener un valor menos en la longitud de vPoly 
    vMask=[0 0 0 0 0 0 1 ];%A mask vector of binary 0 and 1 values is used to specify which shift register state bits are XORed to produce the resulting output bit value.
    vNbitOutPN=NbitOut;%Numero de bit que se generaran por ejemplo 30 
    %Construct CRC generator object crc.generator('Polynomial', vPoly,'InitialState', vIntSt,'FinalXOR', vFinXor);
    %Se puede usar también commsrc.pn(property1,value1,...)% Create PN sequence generator objec
    srcpn =  commsrc.pn('GenPoly', vPoly,'CurrentStates', vCurSt,'Mask', vMask,'NumBitsOut',vNbitOutPN);
    pn=generate(srcpn);
    PNcode=pn';
    %plot(h);
end
% JORGE Y. HERNÁNDEZ GARCÍA