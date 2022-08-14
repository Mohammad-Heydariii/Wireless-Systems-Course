function [G,N0,P_max]=loading(filename)
G=load(filename).G;
N0=load(filename).N0;
P_max=load(filename).P_max;
end