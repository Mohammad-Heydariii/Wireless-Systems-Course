function [P_optimum,P_lists,f_lists,iterations_Num] = GA(P0,alpha,G,N0,P_max)
tolerance = 1e-4;
max_iterations = 200000;
P = P0; 
iterations_Num = 0; 
dx=10;
while ( iterations_Num <= max_iterations)
    g =gradient_calc(P,G,N0).';
    direction=+g;
    iterations_Num = iterations_Num + 1;
    P_lists(iterations_Num,:)=P;
    [f_res,~,~]=f(P,G,N0);
    f_lists(iterations_Num)=f_res;
    Pnew = P + alpha*direction;  
    for i=1:1:length(P)
    if P_max(i) < Pnew(i)
    Pnew(i)=P_max(i);
    else
    Pnew(i)=Pnew(i);
    end
    end
    
    if (all(abs(Pnew - P) < tolerance))
        break;
    end
    %dx = norm(Pnew-P);
    P = Pnew; 
end
P_optimum = P;
end