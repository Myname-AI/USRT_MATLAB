function [Y, Time] = euler_implicite(Y0, systemFunc, velocityFunc, odeParam)
%% Euler implicite solver function
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

    %% Update positions using Implicit Euler method:
    Y(:, iter+1) = Y(:, iter); % Initialize with the previous position as a starting guess

    % Define the implicit equation: Y(:, iter+1) - Y(:, iter) + h * systemFunc(Y(:, iter+1), velocityFunc, epsilon) = 0
    % We need to solve this equation to find Y(:, iter+1)

    % Using Newton's method to iteratively solve the implicit equation
    max_iter = 100; % Maximum number of iterations
    tol = 1e-6; % Tolerance for convergence

    for j = 1:max_iter
        % Compute the increment using the system function
        increment = odeParam.h * systemFunc(Y(:, iter+1), velocityFunc, odeParam.epsilon);

        % Define the residual function
        residual = Y(:, iter+1) - Y(:, iter) - increment;

        % Compute the Jacobian of the residual function if needed

        % Update Y(:, iter+1) using Newton's method
        Y(:, iter+1) = Y(:, iter+1) - residual; % Direct update since we're not using a Jacobian

        % Check for convergence
        if norm(residual) < tol
            break; % Convergence achieved
        end
    end

    % Update time
    time = time + odeParam.h;
    Time = [ Time, time];
    iter = iter + 1;

end
end


