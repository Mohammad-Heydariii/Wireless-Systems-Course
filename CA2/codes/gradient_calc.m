function grad=gradient_calc(P,G,N0)
[~,Ri,SINR_vector]=f(P,G,N0);
for i=1:1:length(P)
collector=(SINR_vector(i)/((log(10)^2)*Ri(i)*(1+SINR_vector(i))))/P(i);
for k=1:1:length(P)
if i~=k
collector=collector+(1/((log(10)^2)*Ri(k)*(1+SINR_vector(k))))*((-SINR_vector(k)^2*G(k,i))/(G(k,k)*P(k)));
end
end
grad(i)=collector;
end
end

