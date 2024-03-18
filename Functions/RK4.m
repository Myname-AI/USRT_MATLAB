function [Y, Time] = RK4( Y0, systemFunc, velocityFunc, odeParam)
%% RK solver function
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
    k2 = systemFunc(Y(:, iter) + odeParam.h*(1/2)* k1, velocityFunc, odeParam.epsilon);
    k3 = systemFunc(Y(:, iter) + odeParam.h*(0)* k1 + odeParam.h*(1/2)* k2, velocityFunc, odeParam.epsilon);
    k4 = systemFunc(Y(:, iter) + odeParam.h*(0)* k1 + odeParam.h*(0)* k2 + odeParam.h*(1)* k3, velocityFunc, odeParam.epsilon);
    Y(:, iter+1) = Y(:, iter) + odeParam.h*(1/6)*k1 + (1/3)*odeParam.h*k2 + odeParam.h*(1/3) *k3 + (1/6)*odeParam.h*k4;
    time = time + odeParam.h;
    Time = [ Time, time]; 
    iter = iter + 1 ;
end

end


