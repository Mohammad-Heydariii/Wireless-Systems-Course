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
hm1 = (1/sqrt(2))*(wgn(1,N,0)+1i*wgn(1,N,0));
hm2 = ones(1,N);
SNR_db=-20:1:20;
n = 1./(10.^(SNR_db./10));
for i=1:1:41
noise(i,:)=((n(i)./2).^(0.5))*(randn(1,length(xm))+1i*randn(1,length(xm)));
ym1(i,:)=noise(i,:)+xm.*hm1;
ym2(i,:)=noise(i,:)+xm.*hm2;
end
threshold=0;
for i=1:1:41 
row_sample1=ym1(i,:);
row_sample2=ym2(i,:);
for j=1:1:N
if(real(row_sample1(j))<threshold)
detected_symbols1(i,j)=-1;
else if(real(row_sample1(j))>threshold)
detected_symbols1(i,j)=1;
end
end
if(real(row_sample2(j))<threshold)
detected_symbols2(i,j)=-1;
else if(real(row_sample2(j))>threshold)
detected_symbols2(i,j)=1;
end
end
end
end
count1=0;
count2=0;
idx=0;
for i=1:1:41
idx=idx+1;
for j=1:1:length(xm)
if(xm(j) ~= detected_symbols1(i,j))
count1=count1+1;
end
if(xm(j) ~= detected_symbols2(i,j))
count2=count2+1;
end
end
data_number_of_error1(idx)=count1;
data_number_of_error2(idx)=count2;
count1=0;
count2=0;
end
Error1=data_number_of_error1/N;
Error2=data_number_of_error2/N;
figure(1)
semilogy(SNR_db,Error1,'-o',SNR_db,Error2,'-o')
grid on
title('The BER Performance of Binary PAM');
ylabel('Bit Error Rate')
xlabel('E_b/\eta in dB');
legend({'With Fading Effect','No fading'},'FontSize',12)
