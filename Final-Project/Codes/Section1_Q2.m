N=10^6;
a=1;
bits=randi([0,1],1,N);
count=0;
for i=1:1:length(bits)
count=count+1;
if(bits(i)==0)
xm(2*count-1)=a;
xm(2*count)=0;
else
xm(2*count-1)=0;
xm(2*count)=a;
end
end
hm = (1/sqrt(2))*(wgn(1,2*N,0)+1i*wgn(1,2*N,0));
SNR_db=-20:1:20;
n = 1./(10.^(SNR_db./10));
for i=1:1:41
noise(i,:)=((n(i)./2).^(0.5))*(randn(1,length(hm))+1i*randn(1,length(hm)));
ym(i,:)=noise(i,:)+xm.*hm;
end
threshold=0;
for i=1:1:41
row_sample=ym(i,:);
for j=1:1:length(bits)
if(abs(row_sample(2*j-1))>abs(row_sample(2*j)))
detected_symbols(i,j)=0;
else if(abs(row_sample(2*j-1))<abs(row_sample(2*j)))
detected_symbols(i,j)=1;
end
end  
end 
end
count=0;
idx=0;
for i=1:1:41
idx=idx+1;
for j=1:1:length(bits)
if(bits(j) ~= detected_symbols(i,j))
count=count+1;
end
end
data_number_of_error(idx)=count;
count=0;
end
Error1=data_number_of_error/N;
Error2=1./(2+db2pow(SNR_db));
figure(1)
semilogy(SNR_db,Error1,'-o',SNR_db,Error2,'-*')
grid on
title('The BER Performance of Binary PAM');
ylabel('Bit Error Rate')
xlabel('E_b/\eta in dB');
legend({'Simulation Result','Theoretical Result'},'FontSize',12)