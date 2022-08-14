%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Obtaining & Plotting The BER Error
N=1080000;
nc=90000;
W=20e06;
Tc=5e-03;
Td=10e-06;
Pmax=10000;
L=200;
cp=L-1;
Block_Num=ceil(N/nc);
bits=randi([0,1],1,N);
xm(bits<0.5)=-1;
xm(0.5<bits)=1;
[res]=Data_Divider(xm,N,nc);
SNR_db=-20:1:40;
n = Pmax./((10.^(SNR_db./10))*nc);
ym=zeros(length(SNR_db),Block_Num*nc);
hm= (1/sqrt(2))*(wgn(1,L,0)+1i*wgn(1,L,0));
Hm=fft(hm,nc);
[Wk,~,Pi]=waterfilling(SNR_db,L,nc,Pmax,Hm);
for p = 1:1:length(n)
Y=[];
for i=1:1:Block_Num
A=ifft(res(i,:).*Wk(p,:),nc);
noise(p,:)=((n(p)./2).^(0.5))*(randn(1,nc+2*cp)+1i*randn(1,nc+2*cp));
channel_in=addcp(A,cp,nc);
channel_out=conv(channel_in,hm)+noise(p,:);
y=removecp(channel_out,cp,nc);
Yk=fft(y);
Y=[Y,Yk];
end
ym(p,:)=Y;
end
[Error1]=BER_calc(SNR_db,Block_Num,nc,N,xm,ym);
figure(1)
semilogy(SNR_db,Error1,'-o')
grid on
title('The BER Performance of BPSK OFDM');
ylabel('Bit Error Rate')
xlabel('E_b/\eta in dB');
function [Wk,C,Pi]=waterfilling(SNR_db,L,nc,Pmax,Hm)
n = Pmax./((10.^(SNR_db./10))*nc);
for p = 1:1:length(n)
func=@(landa) Pmax-sum(max((1/landa)-(n(p)./(abs(Hm).^2)),0));
a1=max(n(p)./(abs(Hm).^2));
a2=min(n(p)./(abs(Hm).^2));
x0=[0.0001,1/a2];
roots(p)= fzero(func,x0);
Pi(p,:)=max((1/roots(p))-(n(p)./(abs(Hm).^2)),0);
C(p)=sum(log10((1+(Pi(p,:).*(abs(Hm).^2))/n(p))));
Wk(p,:)=sqrt(Pi(p,:)).*(exp(-1i*phase(Hm)));
end
end
function [res]=addcp(data,cp,nc)
vec=data(nc-cp+1:end);
res=[vec,data];
end
function [res]=removecp(data,cp,nc)
res=data(cp+1:cp+nc);
end
function [res]=Data_Divider(xm,N,nc)
Block_Num=ceil(N/nc);
vec=[xm,zeros(1,nc-(N-(Block_Num-1)*nc))];
res=zeros(Block_Num,nc);
for i=1:1:Block_Num
res(i,:)=vec((i-1)*nc+1:i*nc);
end
end
function [Error]=BER_calc(SNR_db,Block_Num,nc,N,xm,ym)
detected=zeros(length(SNR_db),Block_Num*nc);
for p=1:1:length(SNR_db)
for j=1:1:Block_Num*nc
if real(ym(p,j))>0
detected(p,j)=1;
else
detected(p,j)=-1;
end
end
end
idx=0;
for i=1:1:length(SNR_db)
for j=1:1:N
if(xm(j) ~= detected(i,j))
idx=idx+1;
end
end
data_number_of_error(i)=idx;
idx=0;
end
Error=data_number_of_error/N;
end