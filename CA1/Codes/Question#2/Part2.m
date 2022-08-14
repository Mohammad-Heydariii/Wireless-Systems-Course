clc;
clear;
rng(1);
t=1e05;
v=30;
N=15;
wavelength=0.1;
tetha = unifrnd(0,pi/2,t,N);
Delay=unifrnd(1,10,t,N);
f_DI=(v*cos(tetha))/wavelength;
Phi_DI=2*pi*f_DI;
Doppler_Shift=2*pi*(3*(10^9))*(Delay*(10^-6))-Phi_DI;
sigma= sqrt(0.5./(1000*(Delay.^4)));
r = abs(sigma.*randn(t,N) + 1i*sigma.*randn(t,N));
for i=1:1:t
hh(i)=sum(r(i,:).*exp(-1i*Doppler_Shift(i,:)));
end
h2_amp=abs(hh).^2;
expected_h2=mean(h2_amp)
figure(1)
cdfplot(h2_amp)
h=0;
Hf=0;
f=1:1:1e06;
count=0;
for j=1:1:N
Hf=Hf+r(1,j)*exp(-1i*Doppler_Shift(1,j))*exp(-1i*2*pi*f*Delay(1,j)*10^-6);
end
figure(2)
plot(f,abs(Hf))
title('Frequency Response')
ylabel('H(f)')
xlabel('frequency')