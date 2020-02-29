%Función para graficar la probabilidad de detección de la hipótesis H1 y H0 para distintos valores de SNR
%)
function fGraf_ProbDetH1yH0conSNR(snrVec,rPdH1,rPdH0,figNum)
    L_snrVec=length(snrVec);
    Xfin=snrVec(L_snrVec);
    Xin=snrVec(1);
    %%Grafica
    figure(figNum);
    plot(snrVec,rPdH1,'-x',snrVec,rPdH0,'-o');
    %parámetros Figura
    xlabel('SNR (dB)');
    ylabel('Probabilidad detección');
    title('Probabilidad de detección para Hipótesis H1 y H0 segun SNR');
    %axis([0,Xfin,-0.2,1.2]);
    % axis([Xin,Xfin,-inf,inf]);%Con el uso de inf se establece el limite
    axis([Xin,Xfin,0,1]);%Con el uso de inf se establece el limite
    %automático
    grid on;
    %legend('A_iProm','Umbr','PreSx','Orientation','horizontal');
    
    legend('PdH1','PdH0');%,'Location','northeastoutside'
    legend('boxoff');
    %
 
end% Función fGraf_ProbDetH1yH0conSNR
% JORGE Y. HERNÁNDEZ GARCÍA


