function [Y, Time] = euler(Y0, systemFunc, velocityFunc, odeParam)
%% Euler explicite solver function
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


% %% Update positions Explicite Euler method:
    Y (:, iter+1) = Y(:, iter) + odeParam.h*systemFunc(Y(:, iter), velocityFunc, odeParam.epsilon);
    time = time + odeParam.h;
    Time = [ Time, time]; 
    iter = iter + 1 ;
   
end
end


