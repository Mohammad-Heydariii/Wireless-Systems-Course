SNR_db=[-10:1:15]; 
Alamouti_Error=load('Alamouti_Error_sim_Tx2.mat').Error1_simulation;
Time_diversity_Error=load('Time_diversity_Error_sim_L2.mat').Error2;
figure(1)
semilogy(SNR_db,Alamouti_Error,'-o',SNR_db,Time_diversity_Error,'-o')
grid on
title('The compare of BER Performance between L=2 Time Diversity & Tx=2 Alamouti');
ylabel('Bit Error Rate')
xlabel('E_b/\eta in dB');
legend({'L=2 simulation','Tx=2 simulation'},'FontSize',12)