N=2*10^6;
SNR_db=-10:1:10;
[Error1]=time_diversity(1);
[Error1_t]=theory5_func(1);
[Error2]=time_diversity(2);
[Error2_t]=theory5_func(2);
[Error3]=time_diversity(3);
[Error3_t]=theory5_func(3);
[Error4]=time_diversity(4);
[Error4_t]=theory5_func(4);
[Error5]=time_diversity(5);
[Error5_t]=theory5_func(5);
figure(1)
semilogy(SNR_db,Error1,'-o',SNR_db,Error1_t,'-*')
grid on
title('The BER Performance of Binary PAM');
ylabel('Bit Error Rate')
xlabel('E_b/\eta in dB');
legend({'L=1 sim','L=1 theory'},'FontSize',12)
figure(2)
semilogy(SNR_db,Error2,'-o',SNR_db,Error2_t,'-*')
grid on
title('The BER Performance of Binary PAM');
ylabel('Bit Error Rate')
xlabel('E_b/\eta in dB');
legend({'L=2 sim','L=2 theory'},'FontSize',12)
'-*'
figure(3)
semilogy(SNR_db,Error3,'-o',SNR_db,Error3_t,'-*')
grid on
title('The BER Performance of Binary PAM');
ylabel('Bit Error Rate')
xlabel('E_b/\eta in dB');
legend({'L=3 sim','L=3 theory'},'FontSize',12)
figure(4)
semilogy(SNR_db,Error4,'-o',SNR_db,Error4_t,'-*')
grid on
title('The BER Performance of Binary PAM');
ylabel('Bit Error Rate')
xlabel('E_b/\eta in dB');
legend({'L=4 sim','L=4 theory'},'FontSize',12)
figure(5)
semilogy(SNR_db,Error5,'-o',SNR_db,Error5_t,'-*')
grid on
title('The BER Performance of Binary PAM');
ylabel('Bit Error Rate')
xlabel('E_b/\eta in dB');
legend({'L=5 sim','L=5 theory'},'FontSize',12)
figure(6)
semilogy(SNR_db,Error1,'-o',SNR_db,Error2,'-o',SNR_db,Error3,'-o',SNR_db,Error4,'-o',SNR_db,Error5,'-o');
grid on
title('The BER Performance of Binary PAM');
ylabel('Bit Error Rate')
xlabel('E_b/\eta in dB');
legend({'L=1 sim','L=2 sim','L=3 sim','L=4 sim','L=5 sim'},'FontSize',12)
ylim([10^-7,10^0]);
figure(7)
semilogy(SNR_db,Error1_t,'-o',SNR_db,Error2_t,'-o',SNR_db,Error3_t,'-o',SNR_db,Error4_t,'-o',SNR_db,Error5_t,'-o');
grid on
title('The BER Performance of Binary PAM');
ylabel('Bit Error Rate')
xlabel('E_b/\eta in dB');
legend({'L=1 theory','L=2 theory','L=3 theory','L=4 theory','L=5 theory'},'FontSize',12)
function [BER]=time_diversity(L)
N=2*10^6;
bits=randi([0,1],1,N);
for j=1:1:N
if(bits(j)==0)
xm(j)=-1;
else
xm(j)=+1;
end
end
temp=zeros(1,N);
for i=1:1:L
hm(i,:)= (1/sqrt(2))*(wgn(1,N,0)+1i*wgn(1,N,0));
temp=temp+abs(hm(i,:)).^2;
end
for i =1:1:L
alpha(i,:)=conj(hm(i,:))./sqrt(temp);
end
SNR_db=-10:1:10;
n = 1./(10.^(SNR_db./10));
for l=1:1:L
for i=1:1:21
noise(i,:)=((n(i)./2).^(0.5))*(randn(1,length(xm))+1i*randn(1,length(xm)));
ym(l,i,:)=(noise(i,:)+xm.*hm(l,:)).*alpha(l,:);
end
end
out_vector=zeros(1,21,N);
for i=1:1:L
out_vector=out_vector+ym(i,:,:);
end
threshold=0;
for i=1:1:21
row_sample=out_vector(1,i,:);
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
for i=1:1:21
for j=1:1:N
if(xm(j) ~= detected_symbols(i,j))
count=count+1;
end
end
data_number_of_error(i)=count;
count=0;
end
Error1=data_number_of_error/N;
BER=Error1;
end

function [Pe]=theory5_func(L)
SNR_db=-10:1:10;
SNR=db2pow(SNR_db);
for i = 1 : length(SNR)
u = sqrt(SNR(i)/(1+SNR(i)));
temp = 0;
for k = 0 : L - 1
temp = temp + nchoosek(L -1 +k , k) * ((1+u)/2)^k;
end
Pe(i) = ((1-u)/2)^L *temp;
end 
end