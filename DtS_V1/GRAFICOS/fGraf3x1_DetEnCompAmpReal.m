%Función para graficar la señal detectada y compararla con la envolvente de amplitud de la señal real
function fGraf3x1_DetEnCompAmpReal(Sx,N,AmP_i,A_iProm,PreSx,Umbr,figNum)
    Xfin=length(Sx);
    %%1 Grafica
    figure(figNum);%figNum=figNum+1;%Para incrementar el número de la figura
    subplot(3,1,1);
    plot(Sx);
    %parámetros Figura
    xlabel('Num Muestra','FontSize',12);
    ylabel('Amplitud','FontSize',12);
    title('a) Señal','FontSize',12);
    axis([0,Xfin,-1.2,1.2]);
    %axis([0,Xfin,-inf,inf]);%Con el uso de inf se establece el limite
    % automático
    grid on;
    %
    subplot(3,1,2);
    plot(N,A_iProm,N,Umbr);%plot(N,A_i,N,Umbr);
    % Parámetros Figura
    xlabel('Num Muestra','FontSize',12);
    ylabel('Amplitud','FontSize',12);
    title('b) Amplitud Instantánea promedio + Umbral de decisión','FontSize',12);
    %axis('auto y');
    axis([0,Xfin,0,inf]);
    grid on;
    legend('Am_i(Calc)','Umbr','Location','southeast');%,'Location','northeastoutside'
    %legend('boxoff');
    %
    subplot(3,1,3);
    plot(N,PreSx,N,AmP_i);% Presencia de señal
    %parámetros Figura
    xlabel('Num Muestra','FontSize',12);
    ylabel('Amplitud','FontSize',12);
    title('c) Presencia de señal y Amplitud Real','FontSize',12);
    % axis('auto y');
    axis([0,Xfin,0,1.2]);
    grid on;
    legend('PreSx','Am_i(ideal)','Location','southeast');%,'Location','northeastoutside'
    %legend('boxoff');
    %
end% Funcion fGraf3x1_DetEnCompAmpReal
% JORGE Y. HERNÁNDEZ GARCÍA


