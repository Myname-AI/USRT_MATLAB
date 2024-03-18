function [Y, Time] = DormandPrince(Y0, systemFunc, velocityFunc, odeParam)
%% DormandPrince ODE45 solver function
% inputs: 
% Y0 - initial raw values (M) in defined single column
% systemFunc - Function solver for spacial differential equations on dx and px
% velocityFunc - function of ray propagations; mathematical form
% h - time change step
% Tmax - propagation time
% epsilon - spacial partial derivation constant
% outputs: 
% Y - matrix of MxN; 2D: M=4; 3D: M=6 !!! 2D: 1,2 raws - x, y vectors data; 3,4 slownesses sx sy 
% 3D: 1,2,3 raws - x, y, z vectors data; 4, 5, 6 slownesses sx sy sz
% Time - propagation time vector
%% Input
Y = Y0(:);
time=0;
Time = [time];

%% Main loop for ray tracing
iter = 1;
while time <  odeParam.tmax

    %% Update positions 2-ordre methode:
    k1 = systemFunc(Y(:, iter), velocityFunc, odeParam.epsilon);
    k2 = systemFunc(Y(:, iter) + odeParam.h*(1/5)* k1, velocityFunc, odeParam.epsilon);
    k3 = systemFunc(Y(:, iter) + odeParam.h*(3/40)* k1 + odeParam.h*(9/40)* k2, velocityFunc, odeParam.epsilon);
    k4 = systemFunc(Y(:, iter) + odeParam.h*(44/45)* k1 + odeParam.h*(-56/15)* k2 + odeParam.h*(32/9)* k3, velocityFunc, odeParam.epsilon);
    k5 = systemFunc(Y(:, iter) + odeParam.h*(19372/6561)* k1 + odeParam.h*(-25360/2187)* k2 + odeParam.h*(64448/6561)* k3...
       + odeParam.h*(-212/729)* k4, velocityFunc, odeParam.epsilon);
    k6 = systemFunc(Y(:, iter) + odeParam.h*(9017/3168)* k1 + odeParam.h*(-355/33)* k2 + odeParam.h*(46732/5247)* k3...
        + odeParam.h*(49/176)* k4 + odeParam.h*(-5103/18656)* k5, velocityFunc, odeParam.epsilon);
   k7 = systemFunc(Y(:, iter) + odeParam.h*(35/384)* k1 + odeParam.h*(0)* k2 + odeParam.h*(500/1113)* k3...
        + odeParam.h*(125/192)* k4 + odeParam.h*(-2187/6784)* k5 + odeParam.h*(-11/84)* k6, velocityFunc, odeParam.epsilon);
    
    Y(:, iter+1) = Y(:, iter) + odeParam.h*(35/384)*k1 + odeParam.h*(0)*k2 + odeParam.h*(500/1113) *k3 + odeParam.h*(125/192)*k4...
        + odeParam.h*(-2187/6784)* k5 + odeParam.h*(-11/84)* k6 + odeParam.h*(0)* k7;
    time = time + odeParam.h;
    Time = [ Time, time]; 
    iter = iter + 1;
end

%k1=k7;
end


