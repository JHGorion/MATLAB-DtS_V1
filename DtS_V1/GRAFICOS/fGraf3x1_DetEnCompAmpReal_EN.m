%Function to graph the detected signal and compare it with the amplitude envelope of the real signal
function fGraf3x1_DetEnCompAmpReal(Sx,N,AmP_i,A_iProm,PreSx,Umbr,figNum)
    Xfin=length(Sx);
    %% Graph
    figure(figNum);
    subplot(3,1,1);
    plot(Sx);
    % Parameters Figure
    xlabel('Num Sample','FontSize',12);
    ylabel('Amplitude','FontSize',10);
    title('a) Signal','FontSize',10);
    axis([0,Xfin,-1.2,1.2]);
    %axis([0,Xfin,-inf,inf]);% With the use of inf the limit is set
     % automatic
    grid on;
    %
    subplot(3,1,2);
    plot(N,A_iProm,N,Umbr);%plot(N,A_i,N,Umbr);
    % Parameters Figure
    xlabel('Num Sample','FontSize',12);
    ylabel('Amplitude','FontSize',10);
    title('b) Average instantaneous amplitude+Decision threshold (Umbr)','FontSize',10);
    %axis('auto y');
    axis([0,Xfin,0,inf]);
    grid on;
    legend('Am_i(Calc)','Umbr','Location','southeast');%,'Location','northeastoutside'
    %legend('boxoff');
    %
    subplot(3,1,3);
    plot(N,PreSx,N,AmP_i);% Signal Presence
    % parameters Figure
    xlabel('Num Sample','FontSize',12);
    ylabel('Amplitude','FontSize',10);
    title('c) Signal Presence and Real Amplitude','FontSize',10);
    % axis('auto y');
    axis([0,Xfin,0,1.2]);
    grid on;
    legend('PreSx','Am_i(ideal)','Location','southeast');%,'Location','northeastoutside'
    %legend('boxoff');
    %
end% Funcion fGraf3x1_DetEnCompAmpReal
% JORGE Y. HERNÁNDEZ GARCÍA


