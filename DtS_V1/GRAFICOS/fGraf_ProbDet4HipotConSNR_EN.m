% Function to graph probability of detection 4 Hypothesis
%)
function fGraf_ProbDet4HipotConSNR(snrVec,rPdH1_RH1,rPdH0_RH0,rPdH1_RH0,rPdH0_RH1,figNum)
	L_snrVec=length(snrVec);
	Xfin=snrVec(L_snrVec);
	Xin=snrVec(1);
   	%%Grafica
	figure(figNum);
	plot(snrVec,rPdH1_RH1,'-x',snrVec,rPdH0_RH0,'-o',snrVec,rPdH1_RH0,'-*',snrVec,rPdH0_RH1,'-+');
	%parametros Figura
	xlabel('SNR (dB)','FontSize',12);
	ylabel('Pd','FontSize',10);
	title('Pd Variants hypothesis according to SNR','FontSize',10);
	%axis([0,Xfin,-0.2,1.2]);
    % axis([Xin,Xfin,-inf,inf]);%Con el uso de inf se establece el limite
	axis([Xin,Xfin,0,1]);%Con el uso de inf se establece el limite
	%automatico
	grid on;
	%legend('A_iProm','Umbr','PreSx','Orientation','horizontal');
	
	legend('PdH1_RH1','PdH0_RH0','PdH1_RH0','PdH0_RH1');%,'Location','northeastoutside'
	%legend('boxoff');
    %
 
end% Función fGraf_ProbDet4HipotConSNR
% JORGE Y. HERNÁNDEZ GARCÍA


