N = 10^6; 
SNR_db=[-10:1:15]; 
SNR_db_linear = 10.^(SNR_db/10);
Error1_simulation = Alamouti_Error(SNR_db); 
Error1_theory = (1/2 - 1/2*(1+2./SNR_db_linear).^(-1/2)).^2.*(1+2*(1-(1/2 - 1/2*(1+2./SNR_db_linear).^(-1/2)))); 
Error2_theory = 0.5.*(1-1*(1+1./SNR_db_linear).^(-0.5)); 
figure(1)
semilogy(SNR_db,Error1_simulation,'-o',SNR_db,Error1_theory,'-*',SNR_db,Error2_theory,'-*');
grid on
legend('sim (nTx=2, nRx=1, Alamouti)','theory (nTx=2, nRx=1, Alamouti)','theory (nTx=1,nRx=1)');
xlabel('E_b/\eta in dB');
ylabel('Bit Error Rate')
title('BER for BPSK modulation with Alamouti nTx=2,nRx=1 vs nTx=1,nRx=1   (Rayleigh channel)');
function [Pe]=Alamouti_Error(SNR_db)
N = 10^6; 
SNR_db_linear = 10.^(SNR_db/10);
for i = 1:length(SNR_db)
bits=randi([0,1],1,N);
xm(bits<0.5)=-1;
xm(0.5<bits)=1;
st = zeros(2,N);
st(:,1:2:end) = (1/sqrt(2))*reshape(xm,2,N/2); 
st(:,2:2:end) = (1/sqrt(2))*(kron(ones(1,N/2),[-1;1]).*flipud(reshape(conj(xm),2,N/2))); 
hm = (1/sqrt(2))*(wgn(1,N,0)+1i*wgn(1,N,0));
ht = kron(reshape(hm,2,N/2),ones(1,2)); 
n = (1/sqrt(2))*(randn(1,length(xm))+1i*randn(1,length(xm))); 
ym = sum(ht.*st,1) + 10^(-SNR_db(i)/20)*n;
yt = kron(reshape(ym,2,N/2),ones(1,2)); 
yt(2,:) = conj(yt(2,:));
hEq = zeros(2,N);
hEq(:,[1:2:end]) = reshape(hm,2,N/2); 
hEq(:,[2:2:end]) = kron(ones(1,N/2),[1;-1]).*flipud(reshape(hm,2,N/2)); 
hEq(1,:) = conj(hEq(1,:));
hEqPower = sum(hEq.*conj(hEq),1);
y_pass = sum(hEq.*yt,1)./hEqPower; 
y_pass(2:2:end) = conj(y_pass(2:2:end));
detected_symbols = real(y_pass)>0;
data_number_of_error(i) = size(find([bits-detected_symbols]),2);
end
Pe=data_number_of_error/N;
end