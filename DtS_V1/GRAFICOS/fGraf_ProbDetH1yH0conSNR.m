%Funci�n para graficar la probabilidad de detecci�n de la hip�tesis H1 y H0 para distintos valores de SNR
%)
function fGraf_ProbDetH1yH0conSNR(snrVec,rPdH1,rPdH0,figNum)
    L_snrVec=length(snrVec);
    Xfin=snrVec(L_snrVec);
    Xin=snrVec(1);
    %%Grafica
    figure(figNum);
    plot(snrVec,rPdH1,'-x',snrVec,rPdH0,'-o');
    %par�metros Figura
    xlabel('SNR (dB)');
    ylabel('Probabilidad detecci�n');
    title('Probabilidad de detecci�n para Hip�tesis H1 y H0 segun SNR');
    %axis([0,Xfin,-0.2,1.2]);
    % axis([Xin,Xfin,-inf,inf]);%Con el uso de inf se establece el limite
    axis([Xin,Xfin,0,1]);%Con el uso de inf se establece el limite
    %autom�tico
    grid on;
    %legend('A_iProm','Umbr','PreSx','Orientation','horizontal');
    
    legend('PdH1','PdH0');%,'Location','northeastoutside'
    legend('boxoff');
    %
 
end% Funci�n fGraf_ProbDetH1yH0conSNR
% JORGE Y. HERN�NDEZ GARC�A


