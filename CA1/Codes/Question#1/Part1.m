rng(1);
N=1e05;
D=1000;
d = 10 + (D-10) .* rand(N,1);
d0=10;
P0=-30;
Pn=-115;
n=4;
Pr=P0-10*n*log10(sort(d)/d0);
figure(1)
cdfplot(Pr)
SNR=Pr-Pn;
grid on
figure(2)
plot(log10(sort(d)),SNR)
title('SNR')
xlabel('log d')
grid on
mu=0;
sigma=5;
X= normrnd(mu,sigma,N,1);
Pr_new=Pr+X;
figure(3)
cdfplot(Pr_new)
SNR_new=Pr_new-Pn;
grid on
figure(4)
plot(log10(sort(d)),SNR_new)
title('SNR')
xlabel('d')
grid on
SNR_min=18;
Pmin=SNR_min+Pn;
Otage_Probability=1-qfunc((SNR_min-(SNR-10*n*log10(sort(d)/d0)))/sigma);
figure(5)
plot(log10(sort(d)),Otage_Probability)
title('Outage Probability')
xlabel('log d')
ylabel('P(r)')
grid on
d_sort=sort(d);
for i=1:1:length(SNR)
if SNR_new(i)<18
index=i;
index=50930;
break
end
end
coverage_percent=(sum(d_sort(1:index)))/(sum(d_sort))