function [Y, Time] = eulerRichardson(Y0, systemFunc, velocityFunc, odeParam)
%% Euler-Richardson with adaptive step size :solver function:
%inputs:
% Y0 - initial raw values (M) in defined single column
% velocityFunc - function of ray propagations of mathematical form
% h - dt - time change derivative
% e - tolerance
% N - number of itterations that defines matrix columns number
% epsilon - spacial partial derivation constant for X,Y,Z, space
%outputs:
% Y - matrix of MxN; 2D: M=4; 3D: M=6 !!! 2D: 1,2 raws - x, y vectors data; 3,4 slownesses sx sy
% 3D: 1,2,3 raws - x, y, z vectors data; 4, 5, 6 slownesses sx sy sz
% Time - propagation time vector
%% Inputs
Y = Y0(:); % Defined vector rearanged into column
time=0;
Time = [time];
iter = 1;
N=1;

%% Main loop for ray tracing
while time <  odeParam.tmax && N < 1000000   
    %% Update positions Euler-Richardson method:
    % Calculate by Euler for first position:
    % Y (:, iter) = Y(:, iter-1) + h*systemFunc(Y(:, iter-1), velocityFunc, epsilon);

    % % System function slope prediction:
    k1 = systemFunc(Y(:, iter), velocityFunc, odeParam.epsilon);
    % Calculation by Euler first order:
    % Y_1 = Y(:, iter-1) + h*k1;
    % Half-way temporal prediction of function
    Y_temp = Y(:, iter) + (odeParam.h/2) * k1;
    % Recalculation of slope at intermidiate value:
    k2 = systemFunc(Y_temp, velocityFunc, odeParam.epsilon);
    % Calculation second order:
    % Y_2 = Y(:, iter-1) + h * k2;
    %% Error evaluation:
    Err=odeParam.h*sqrt((sum(k2-k1)^2));
    alfa = 0.3;
    beta = 2;

    if Err < odeParam.tolerance
        %    Y(:, iter) = Y(:, iter-1) - h*k1 + 2*h*k2;
  
        time = time + odeParam.h;
        Time = [ Time, time]; 
        Y(:, iter+1) = Y(:, iter) - odeParam.h*k1 + 2*odeParam.h*k2; % Above 'commented' in Euler-Richardson coeff calc application of the methode  
        iter = iter + 1;
    end 
        
 h = 0.9*odeParam.h*min(max( sqrt(odeParam.tolerance/abs(2*Err)), alfa),beta); % change of step after cycle
 N=N+1; 
end
