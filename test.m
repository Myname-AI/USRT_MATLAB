clc
clear all
close all
addpath('C:\Users\OG277444\Documents\MATLAB\USRT_MATLAB\Functions')
% [Error_max] = ErrorFunc_2D(@euler, @gradient_2D_euler_addapted, [0,0], [0.5,0.5], struct('h', 0.01, 'tmax', 100., 'epsilon', 0.01));
[ErrorMap,position,N_theta, N_x, N_y] = MapFunction_2D(@euler, @gradient_2D_euler_addapted, struct('h', 0.01, 'tmax', 100., 'epsilon', 0.01));


M_on_theta = ceil(size(ErrorMap, 1) / N_theta); % number of angles areas


for i = 1:N_theta
    % Define the indices for the current chunk
    start_index = (i - 1) * M_on_theta  + 1;
    end_index = min(i * M_on_theta, size(ErrorMap, 1));

    % Extract the data for the current chunk
    x = position(start_index:end_index, 1);
    y = position(start_index:end_index, 2);
    Err = ErrorMap(start_index:end_index, 1);

    [X, Y] = meshgrid(x, y) ;



    figure(i);
    imagesc(x, y, Err);
    caxis([min(Err), max(Err)]);
    % xlim([10, 70]);
    % ylim([10, 70]);
    colorbar;
    % Visualize the x vector
   
    
    figure (77);
    plot(x, Err);
    title('X Vector');
    xlabel('Index');
    ylabel('Value');
    figure (78);
    plot(y, Err);
    title('Y Vector');
    xlabel('Index');
    ylabel('Value');




       

end

