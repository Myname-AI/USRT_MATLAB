function [Y, Time] = second_order_parametrized(Y0, systemFunc, velocityFunc, odeParam)
%% Second order parametarized solver function. alfa [1 => Heun's method; 1/2 => mid-point methode; 2/3 => Ralston's methode]
% inputs: 
% Y0 - initial raw values (M) in defined single column
% alfa - coeff b in the RK solution (applicable for 2-order system) 
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
    slope1 = Y(:, iter) + (odeParam.h*odeParam.alfa)* k1;
    k2 = systemFunc(slope1, velocityFunc, odeParam.epsilon);
    Y(:, iter+1) = Y(:, iter) + odeParam.h*(1-1/(2*odeParam.alfa)).*k1 + (1/(2*odeParam.alfa))*odeParam.h*k2;
    
    time = time + odeParam.h;
    Time = [ Time, time]; 
    iter = iter + 1 ;

end
end


