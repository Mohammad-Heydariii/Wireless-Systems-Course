z = 0:0.001:20;
[cdf_rician1,cdf_nakagami1,Pr_rician1,Pr_nakagami1]=cdf_finder_func(1);
[cdf_rician2,cdf_nakagami2,Pr_rician2,Pr_nakagami2]=cdf_finder_func(2);
[cdf_rician3,cdf_nakagami3,Pr_rician3,Pr_nakagami3]=cdf_finder_func(3);
figure(1)
plot(z,Pr_rician1)
hold on
plot(z,Pr_rician2)
hold on
plot(z,Pr_rician3)
title('PDF')
ylabel('Rician')
legend('K=1','K=5','K=10')
hold off
figure(2)
plot(z,cdf_rician1)
hold on
plot(z,cdf_rician2)
hold on
plot(z,cdf_rician3)
title('CDF')
ylabel('Rician')
legend('K=1','K=5','K=10')
hold off
figure(3)
plot(z,Pr_nakagami1)
hold on
plot(z,Pr_nakagami2)
hold on
plot(z,Pr_nakagami3)
title('PDF')
ylabel('Nakagami')
legend('K=1','K=5','K=10')
hold off
figure(4)
plot(z,cdf_nakagami1)
hold on
plot(z,cdf_nakagami2)
hold on
plot(z,cdf_nakagami3)
title('CDF')
ylabel('Nakagami')
legend('K=1','K=5','K=10')
hold off
figure(5)
plot(z,cdf_nakagami1-cdf_rician1)
hold on
plot(z,cdf_nakagami2-cdf_rician2)
hold on
plot(z,cdf_nakagami3-cdf_rician3)
title('Error between Nakagami & Rician : |Nakagami-Rician|')
ylabel('CDF')
xlabel('Different Gamma values')
legend('K=1','K=5','K=10')
hold off