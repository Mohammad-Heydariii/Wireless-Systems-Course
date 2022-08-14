SNR_db=-20:1:40;
Error1=[0.492376851851852	0.492103703703704	0.490251851851852	0.489681481481482	0.488743518518519	0.486566666666667	0.485350000000000	0.482564814814815	0.482304629629630	0.479123148148148	0.477266666666667	0.473839814814815	0.470463888888889	0.466181481481482	0.463027777777778	0.457862037037037	0.452486111111111	0.446964814814815	0.442085185185185	0.434578703703704	0.425790740740741	0.417564814814815	0.408233333333333	0.397637962962963	0.384121296296296	0.372137037037037	0.357288888888889	0.342325925925926	0.325950000000000	0.306278703703704	0.287016666666667	0.266014814814815	0.244237962962963	0.223001851851852	0.201345370370370	0.179375000000000	0.157579629629630	0.136869444444444	0.117957407407407	0.100475000000000	0.0842462962962963	0.0703768518518519	0.0581768518518519	0.0471935185185185	0.0387481481481482	0.0315259259259259	0.0252537037037037	0.0200018518518519	0.0159935185185185	0.0129166666666667	0.00991388888888889	0.00796574074074074	0.00634722222222222	0.00507222222222222	0.00395000000000000	0.00314722222222222	0.00259259259259259	0.00205462962962963	0.00161296296296296	0.00130000000000000	0.00107685185185185];
Error2=[0.493389814814815	0.492929629629630	0.492050000000000	0.491264814814815	0.489337962962963	0.488460185185185	0.487055555555556	0.485133333333333	0.484193518518519	0.481456481481481	0.479254629629630	0.476634259259259	0.473910185185185	0.470569444444444	0.467238888888889	0.462387962962963	0.458543518518519	0.453799074074074	0.447977777777778	0.442046296296296	0.434578703703704	0.426451851851852	0.417943518518519	0.408774074074074	0.398004629629630	0.385525925925926	0.373208333333333	0.358450925925926	0.342915740740741	0.325777777777778	0.307554629629630	0.288992592592593	0.268162037037037	0.247700925925926	0.225309259259259	0.203412962962963	0.182205555555556	0.160820370370370	0.140569444444444	0.121486111111111	0.103962962962963	0.0886305555555556	0.0745657407407407	0.0624805555555556	0.0520537037037037	0.0430759259259259	0.0354694444444444	0.0289592592592593	0.0238712962962963	0.0198064814814815	0.0158675925925926	0.0130453703703704	0.0105731481481481	0.00870277777777778	0.00702037037037037	0.00573425925925926	0.00472129629629630	0.00392314814814815	0.00325740740740741	0.00269444444444444	0.00222870370370370];
figure(1)
semilogy(SNR_db,Error1,'-o',SNR_db,Error2,'-*')
grid on
title('The BER Performance of BPSK OFDM');
ylabel('Bit Error Rate')
xlabel('E_b/\eta in dB');
legend({'MMSE without cliping','MMSE with cliping'},'FontSize',12)