rng(1)
[G1,N0_1,P_max_1]=loading('a1.mat');
[G2,N0_2,P_max_2]=loading('a2.mat');
[G3,N0_3,P_max_3]=loading('a3.mat');
[G4,N0_4,P_max_4]=loading('a4.mat');
[G5,N0_5,P_max_5]=loading('a5.mat');

P0 = rand(1,50).';
alpha = 0.01;
[P_optimum1,P_lists1,f_lists1,iterations_Num1] = GA(P0,alpha,G1,N0_1,P_max_1);
[P_optimum2,P_lists2,f_lists2,iterations_Num2] = GA(P0,alpha,G2,N0_2,P_max_2);
[P_optimum3,P_lists3,f_lists3,iterations_Num3] = GA(P0,alpha,G3,N0_3,P_max_3);
[P_optimum4,P_lists4,f_lists4,iterations_Num4] = GA(P0,alpha,G4,N0_4,P_max_4);
P0 = rand(1,500).';
[P_optimum5,P_lists5,f_lists5,iterations_Num5] = GA(P0,alpha,G5,N0_5,P_max_5);


%%% data1



figure(1)
iteration1=1:1:iterations_Num1;
plot(iteration1,f_lists1,'LineWidth',2)
title('target-values during epochs','FontSize',12)
xlabel('epochs','FontSize',12)
ylabel('Data1','FontSize',12)

figure(2)
stem(P_optimum1)
title('optimum P values')
xlabel('user index')
ylabel('Data1')


figure(3)
stem(abs(P_optimum1.'-P_max_1))
title('Difference between optimum and maximum P values')
xlabel('user index')
ylabel('Data1')


%%% data2


figure(4)
iteration2=1:1:iterations_Num2;
plot(iteration2,f_lists2,'LineWidth',2)
title('target-values during epochs','FontSize',12)
xlabel('epochs','FontSize',12)
ylabel('Data2','FontSize',12)

figure(5)
stem(P_optimum2)
title('optimum P values')
xlabel('user index')
ylabel('Data2')

figure(6)
stem(abs(P_optimum2.'-P_max_2))
title('Difference between optimum and maximum P values')
xlabel('user index')
ylabel('Data2')

%%% data3




figure(7)
iteration3=1:1:iterations_Num3;
plot(iteration3,f_lists3,'LineWidth',2)
title('target-values during epochs','FontSize',12)
xlabel('epochs','FontSize',12)
ylabel('Data3','FontSize',12)
figure(8)
stem(P_optimum3)
title('optimum P values')
xlabel('user index')
ylabel('Data3')

figure(9)
stem(abs(P_optimum3.'-P_max_3))
title('Difference between optimum and maximum P values')
xlabel('user index')
ylabel('Data3')

%%% data4



figure(10)
iteration4=1:1:iterations_Num4;
plot(iteration4,f_lists4,'LineWidth',2)
title('target-values during epochs','FontSize',12)
xlabel('epochs','FontSize',12)
ylabel('Data4','FontSize',12)

figure(11)
stem(P_optimum4)
title('optimum P values')
xlabel('user index')
ylabel('Data4')

figure(12)
stem(abs(P_optimum4.'-P_max_4))
title('Difference between optimum and maximum P values')
xlabel('user index')
ylabel('Data4')


%%% data5

figure(13)
iteration5=1:1:iterations_Num5;
plot(iteration5,f_lists5,'LineWidth',2)
title('target-values during epochs','FontSize',12)
xlabel('epochs','FontSize',12)
ylabel('Data5','FontSize',12)

figure(14)
stem(P_optimum5)
title('optimum P values')
xlabel('user index')
ylabel('Data5')

figure(15)
stem(abs(P_optimum5.'-P_max_5))
title('Difference between optimum and maximum P values')
xlabel('user index')
ylabel('Data5')


fvalue_p_opt1=f(P_optimum1,G1,N0_1);
fvalue_p_max1=f(P_max_1,G1,N0_1);
improvement1=fvalue_p_opt1-fvalue_p_max1;
Save_Power1=sum(P_max_1)-sum(P_optimum1);
Iteratation_Num1=iterations_Num1;

fvalue_p_opt2=f(P_optimum2,G2,N0_2);
fvalue_p_max2=f(P_max_2,G2,N0_2);
improvement2=fvalue_p_opt2-fvalue_p_max2;
Save_Power2=sum(P_max_2)-sum(P_optimum2);
Iteratation_Num2=iterations_Num2;

fvalue_p_opt3=f(P_optimum3,G3,N0_3);
fvalue_p_max3=f(P_max_3,G3,N0_3);
improvement3=fvalue_p_opt3-fvalue_p_max3;
Save_Power3=sum(P_max_3)-sum(P_optimum3);
Iteratation_Num3=iterations_Num3;

fvalue_p_opt4=f(P_optimum4,G4,N0_4);
fvalue_p_max4=f(P_max_4,G4,N0_4);
improvement4=fvalue_p_opt4-fvalue_p_max4;
Save_Power4=sum(P_max_4)-sum(P_optimum4);
Iteratation_Num4=iterations_Num4;

fvalue_p_opt5=f(P_optimum5,G5,N0_5);
fvalue_p_max5=f(P_max_5,G5,N0_5);
improvement5=fvalue_p_opt5-fvalue_p_max5;
Save_Power5=sum(P_max_5)-sum(P_optimum5);
Iteratation_Num5=iterations_Num5;

disp(['f-optimum1: ',num2str(fvalue_p_opt1)])
disp(['f-max1: ',num2str(fvalue_p_max1)])
disp(['improvement1: ',num2str(improvement1)])
disp(['Save_Power1: ',num2str(Save_Power1)])
disp(['Iteratation_Num1: ',num2str(Iteratation_Num1)])

disp("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%")
disp(['f-optimum2: ',num2str(fvalue_p_opt2)])
disp(['f-max2: ',num2str(fvalue_p_max2)])
disp(['improvement2: ',num2str(improvement2)])
disp(['Save_Power2: ',num2str(Save_Power2)])
disp(['Iteratation_Num2: ',num2str(Iteratation_Num2)])

disp("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%")
disp(['f-optimum3: ',num2str(fvalue_p_opt3)])
disp(['f-max3: ',num2str(fvalue_p_max3)])
disp(['improvement3: ',num2str(improvement3)])
disp(['Save_Power3: ',num2str(Save_Power3)])
disp(['Iteratation_Num3: ',num2str(Iteratation_Num3)])

disp("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%")
disp(['f-optimum4: ',num2str(fvalue_p_opt4)])
disp(['f-max4: ',num2str(fvalue_p_max4)])
disp(['improvement4: ',num2str(improvement4)])
disp(['Save_Power4: ',num2str(Save_Power4)])
disp(['Iteratation_Num4: ',num2str(Iteratation_Num4)])

disp("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%")
disp(['f-optimum5: ',num2str(fvalue_p_opt5)])
disp(['f-max5: ',num2str(fvalue_p_max5)])
disp(['improvement5: ',num2str(improvement5)])
disp(['Save_Power5: ',num2str(Save_Power5)])
disp(['Iteratation_Num5: ',num2str(Iteratation_Num5)])

disp("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%")

