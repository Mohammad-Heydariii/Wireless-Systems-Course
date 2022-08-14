%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plotting The Capacity
rng(1)
SNR_db=-20:1:20;
W=20e06;
Tc=5e-03;
Td=10e-06;
N=10^8;
nc=90000;
Block_Num=1112;
L=200;
cp=L-1;
Pmax=10000;
[Wk,C,hm]=waterfilling(SNR_db,L,nc,Pmax);
figure(2)
semilogy(SNR_db,C)
grid on
xlabel('E_b/\eta in dB');
ylabel('capacity');
title('Channel Capacity During SNR (Rayleigh channel)');
function [Wk,C,hm]=waterfilling(SNR_db,L,nc,Pmax)
n = Pmax./((10.^(SNR_db./10))*nc);
hm=(1/sqrt(2))*(wgn(1,L,0)+1i*wgn(1,L,0));
hmnew=[hm,zeros(1,nc-L)];
Hm=fft(hmnew,nc);
for p = 1:1:length(n)
func=@(landa) Pmax-sum(max((1/landa)-(n(p)./(abs(Hm).^2)),0));
a1=max(n(p)./(abs(Hm).^2));
a2=min(n(p)./(abs(Hm).^2));
x0=[1/a1,1/a2-20];
roots(p)= fzero(func,x0);
Pi(p,:)=max((1/roots(p))-(n(p)./(abs(Hm).^2)),0);
C(p)=sum(log10((1+(Pi(p,:).*(abs(Hm).^2))/n(p))));
Wk(p,:)=sqrt(Pi(p,:)).*(exp(-phase(Hm)));
end
end