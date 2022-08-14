function [cdf_rician,cdf_nakagami,Pr_rician,Pr_nakagami]=cdf_finder_func(i)
K=[1,5,10];
N=1e05;
Pr=18;
m=(K+1).^2./(2.*K+1);
z = 0:0.001:20;
Pr_rician =((2*z)*(K(i)+1)/Pr).*exp(-K(i)-((K(i)+1).*(z.^2))/Pr).*besseli(0,(2*z.*sqrt((K(i)*(K(i)+1))/Pr)));    
Pr_nakagami =(2*(m(i)^m(i))*(z.^(2*m(i)-1)).*exp((-m(i)*(z.^2))/Pr))/((Pr^m(i))*gamma(m(i)));
cdf_rician = zeros(1,length(z));
cdf_nakagami = zeros(1,length(z));
cdf_nakagami(1) = Pr_nakagami(1);
cdf_rician(1) = Pr_rician(1);
for i=2:1:length(z)
    cdf_rician(i) = Pr_rician(i) + cdf_rician(i-1);
    cdf_nakagami(i) = Pr_nakagami(i) + cdf_nakagami(i-1);
end
cdf_rician = cdf_rician * 0.001;
cdf_nakagami = cdf_nakagami * 0.001;
end