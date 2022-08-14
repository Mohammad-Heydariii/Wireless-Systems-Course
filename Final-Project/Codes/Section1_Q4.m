N=10000;
bits=randi([0,1],1,N);
cnt1=0;
cnt2=0;
cnt3=0;
cnt4=0;
xm(bits<=0.25)=1;
xm(0.25<bits<=0.5)=1i;
xm(0.5<bits<=0.75)=-1;
xm(0.75<bits<=1)=-1i;
hm = (1/sqrt(2))*(wgn(1,N,0)+1i*wgn(1,N,0));
SNR_db=-20:1:20;
n = 1./(10.^(SNR_db./10));
for i=1:1:41
noise(i,:)=((n(i)./2).^(0.5))*(randn(1,length(hm))+1i*randn(1,length(hm)));
ym(i,:)=noise(i,:)+xm.*abs(hm);
end
for i=1:1:41
row_sample=ym(i,:);
for j=1:1:N 
if(((phase(row_sample(j))*180)/pi)<=45 && -45<=((phase(row_sample(j))*180)/pi))  
detected_symbols(i,j)=1;
cnt1=cnt1+1
end
if(((phase(row_sample(j))*180)/pi)<=135 && 45<=((phase(row_sample(j))*180)/pi))
detected_symbols(i,j)=1i;
cnt2=cnt2+1
end
if(((phase(row_sample(j))*180)/pi)<=-135 && 135<=((phase(row_sample(j))*180)/pi))
detected_symbols(i,j)=-1;
cnt3=cnt3+1
end
if(((phase(row_sample(j))*180)/pi)<=-45 && -135<=((phase(row_sample(j))*180)/pi))
detected_symbols(i,j)=-1i;
cnt4=cnt4+1
end
end
end
count=0;
for i=1:1:41
for j=1:1:N
if(xm(j) ~= detected_symbols(i,j))
count=count+1;
end
end
data_number_of_error(i)=count;
count=0;
end
Error1=data_number_of_error/N;
Error2=(1-sqrt((db2pow(SNR_db)/2)./(1+db2pow(SNR_db)/2)))/2;
Error3=[0.497639000000000	0.495552000000000	0.496690000000000	0.494337000000000	0.493613000000000	0.493022000000000	0.490658000000000	0.488456000000000	0.484818000000000	0.481447000000000	0.476154000000000	0.470632000000000	0.463129000000000	0.454027000000000	0.443781000000000	0.431581000000000	0.417335000000000	0.399622000000000	0.379694000000000	0.358417000000000	0.333059000000000	0.305899000000000	0.279459000000000	0.250655000000000	0.221861000000000	0.194118000000000	0.166920000000000	0.143231000000000	0.120266000000000	0.100229000000000	0.0833430000000000	0.0684070000000000	0.0560990000000000	0.0453460000000000	0.0367350000000000	0.0298020000000000	0.0242840000000000	0.0193760000000000	0.0153380000000000	0.0124430000000000	0.0100350000000000]
figure(1)
semilogy(SNR_db,Error1,'-o',SNR_db,Error2,'-o',SNR_db,Error3,'-o')
grid on
title('The BER Performance of QPSK');
ylabel('Bit Error Rate')
xlabel('E_b/\eta in dB');
legend({'Simulation Result PART D','Theoretical Result','Simulation Result PART B'},'FontSize',12)