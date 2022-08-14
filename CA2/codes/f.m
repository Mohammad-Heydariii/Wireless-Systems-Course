function [f_res,Ri,SINR_vector]=f(P,G,N0)
signal=0;
for i=1:1:length(P)
signal=G(i,i)*P(i);
ISI=0;
for j=1:1:length(P)
if i ~=j
ISI=ISI+G(i,j)*P(j);
end
end
SINR(i)=signal/(N0(i)+ISI);
end
SINR_vector=SINR;
Ri=log10(1+SINR);
f_res=sum(log10(Ri));
end