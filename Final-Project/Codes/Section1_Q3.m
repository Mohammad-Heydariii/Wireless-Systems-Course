N=10^6;
bits=randi([0,1],1,N);
count=0;
for i=1:1:length(bits)
count=count+1;
if(bits(i)==0)
xm(count)=-1;
else
xm(count)=1;
end
end
hm = (1/sqrt(2))*(wgn(1,N,0)+1i*wgn(1,N,0));
alpha=conj(hm)./(abs(hm));
SNR_db=-10:1:10;
n = 1./(10.^(SNR_db./10));
for i=1:1:21
noise(i,:)=((n(i)./2).^(0.5))*(randn(1,length(hm))+1i*randn(1,length(hm)));
ym(i,:)=noise(i,:)+xm.*hm;
ym(i,:)=ym(i,:).*alpha;
end
threshold=0;
for i=1:1:21
row_sample=ym(i,:);
for j=1:1:N
if(real(row_sample(j))<threshold)
detected_symbols(i,j)=-1;
else if(real(row_sample(j))>threshold)
detected_symbols(i,j)=1;
end
end
end  
end
count=0;
idx=0;
for i=1:1:21
idx=idx+1;
for j=1:1:length(bits)
if(xm(j) ~= detected_symbols(i,j))
count=count+1;
end
end
data_number_of_error(idx)=count;
count=0;
end
Error1=data_number_of_error/N;
Error2=(1-sqrt((db2pow(SNR_db))./(1+db2pow(SNR_db))))/2;
Error3=[0.476484000000000	0.469835000000000	0.462750000000000	0.455951000000000	0.444146000000000	0.431658000000000	0.417239000000000	0.399216000000000	0.379866000000000	0.357519000000000	0.332905000000000	0.306764000000000	0.278834000000000	0.249351000000000	0.221176000000000	0.193811000000000	0.167710000000000	0.142453000000000	0.120142000000000	0.100871000000000	0.0837400000000000];
figure(1)
semilogy(SNR_db,Error1,'-o',SNR_db,Error2,'-*',SNR_db,Error3,'-o')
grid on
title('The BER Performance of Binary PAM');
ylabel('Bit Error Rate')
xlabel('E_b/\eta in dB');
legend({'Simulation Result PART C','Theoretical Result','Simulation Result PART B'},'FontSize',12)