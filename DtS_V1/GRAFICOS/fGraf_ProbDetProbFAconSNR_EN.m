%Function to graph the probability of detection and false alarm for different SNR values
%)
function fGraf_ProbDetProbFAconSNR(snrVec,rProbDet,rProbFaAl,figNum)
    L_snrVec=length(snrVec);
    Xfin=snrVec(L_snrVec);
    Xin=snrVec(1);
    %%Grafica
    % Crear figura
    figure1 = figure(figNum);
    % crear ejes
    axes1 = axes('Parent',figure1);
    % hold(axes1,'on');
    plot1 = plot(snrVec,rProbDet,'-x',snrVec,rProbFaAl,'-o','Parent',axes1);
    %parámetros Figura
    xlabel('SNR (dB)','FontSize',12);
    ylabel('Total Pd','FontSize',10);
    title('Total probability of detection (Pd) and false alarm (Pfa) for SNR','FontSize',10);
    %axis([0,Xfin,-0.2,1.2]);
    % axis([Xin,Xfin,-inf,inf]);%Con el uso de inf se establece el limite
    axis([Xin,Xfin,0,1]);%Con el uso de inf se establece el limite
    %automático
    grid on;
    %legend('A_iProm','Umbr','PreSx','Orientation','horizontal');
    
    legend('Pd','Pfa');%,'Location','northeastoutside'
    legend('boxoff');
    %
 
end% Función fGraf_ProbDetProbFAconSNR
% JORGE Y. HERNÁNDEZ GARCÍA

