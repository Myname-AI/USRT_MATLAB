clc
clear all
close all
addpath('C:\Users\OG277444\Documents\MATLAB\USRT_MATLAB\Functions')
load("h_step.txt")
% Define predefined vectors
h = []; % Example values for "h"
tmax = []; % Example values for "tmax"
epsilon = []; % Example values for "epsilon"
tolerance = []; % Example values for "tolerance"
alfa = []; % Example values for "tolerance"
% Construct odeParam structure
odeParam = struct('h', h, 'tmax', tmax, 'epsilon', epsilon, 'tolerance', tolerance, 'alfa', alfa);
%%
xSTART = 10; 
 xSTEP=2 ; %xLENGHT, ySTART, ySTEP, yLENGHT, angleSTART, angleSTEP, angleLENGHT
xLENGTH=10;

ySTART = 0; 
 ySTEP=2; %xLENGHT, ySTART, ySTEP, yLENGHT, angleSTART, angleSTEP, angleLENGHT
yLENGTH=2;

thetaSTART=-pi;
thetaSTEP=pi/4;
thetaLENGTH = pi;

x = xSTART:xSTEP:(xSTART + xLENGTH) ;
 y = ySTART:ySTEP:(ySTART + yLENGTH) ;
% theta = thetaSTART:thetaSTEP:(thetaSTART + thetaLENGTH);
theta = [0, pi/6, pi/4, pi/3, pi/2, 2*pi/3, 3*pi/4, 5*pi/6, pi];
N_theta=numel(theta);
N_x=numel(x);
N_y=numel(y);
[X, Y, T] = meshgrid(x, y, theta) ;
position = [X(:) Y(:), T(:)];
nb_points = size(position, 1) ;

for i = 1:nb_points
    [result_ref] = rayTracing2DFunc([position(i,1),position(i,2)], [cos(position(i,3)), sin(position(i,3))],  "Euler", "IsoFluid", @gradient_2D_euler_addapted, ...
    struct('h', 0.0001, 'tmax', 100., 'epsilon', 0.01));
    reference = result_ref;
    save("reference.mat","result_ref");
    reference = load ("reference.mat");

    [result] = rayTracing2DFunc([position(i,1),position(i,2)], [cos(position(i,3)), sin(position(i,3))],  "RK4", "IsoFluid", @gradient_2D_euler_addapted, ...
    struct('h', 0.01, 'tmax', 100., 'epsilon', 0.01, 'alfa', 0.5));
    xv=result.x;   xv_ref=result_ref.x;
    yv=result.y;   yv_ref=result_ref.x;
    xsv=result.sx;  xsv_ref=result_ref.y;
    ysv=result.sy;   syv_ref=result_ref.sy;
    
    ErrorMap(i,:) = ErrorFunc_2D(result, reference);

end

M = [position ErrorMap];
% Extract unique values from the second column
u_values = unique(M(:, 2));

% Initialize cell array to store submatrices
sub_M = cell(size(u_values));

% Iterate over unique values and split the matrix
for i = 1:numel(u_values)
    % Find rows where the second column matches the current unique value
    indices = (M(:, 2) == u_values(i));
    
    % Extract rows based on indices and store in the cell array
    sub_M{i} = M(indices, :);

    figure(i);
    [X, Y] = meshgrid(sub_M{i}(:,1), sub_M{i}(:,3)) ; % set the parameters that do not iter in the loop
    Z=griddata(sub_M{i}(:,1), sub_M{i}(:,3), sub_M{i}(:,5), X,Y);
    imagesc(sub_M{i}(:,1), sub_M{i}(:,3), Z);
    caxis([min(sub_M{i}(:,5)), max(sub_M{i}(:,5))]);
    xlim([10, 20]);
    ylim([0, pi]);
    colorbar;
    title('Max Abs Error as a function of angle at y0=');
    xlabel('x0');
    ylabel('theta0');

end




%% OLD
% 
% % Plot slices along the y-axis
%     figure;
%     imagesc(squeeze(error_matrix(:, N_y, :)));
%     colorbar;
%     xlabel('X');
%     ylabel('Theta');
%     title(['Slice at Y = ', num2str(y_index)]);
% 
% % Adjust the X and Y data to reflect real values
% set(h, 'XData', x);
% set(h, 'YData', theta);

% 
% M_on_theta = ceil(size(ErrorMap, 1) / N_theta); % number of angles areas
% M_on_y = ceil(size(ErrorMap, 1) / N_y);
% 
% for i = 1:N_y % or N_theta
% %     % Define the indices for the current chunks on theta position
% %     start_index = (i - 1) * M_on_theta  + 1;
% %     end_index = min(i * M_on_theta, size(ErrorMap, 1));
%     % Define the indices for the current chunks on Y position
%     start_index = (i - 1) * M_on_y  + 1;
%     end_index = min(i * M_on_y, size(ErrorMap, 1));
% 
%     % Extract the data for the current chunk
%     x = position(start_index:end_index, 1);
%     y = position(start_index:end_index, 2);
%     theta = position(start_index:end_index, 3);
%     Err = ErrorMap(start_index:end_index, 1);
%     
%     
%     figure(i);
%     [X, Y] = meshgrid(x, theta) ; % set the parameters that do not iter in the loop
%     Z=griddata(x, theta, Err, X,Y);
%     imagesc(x, theta, Z);
%     caxis([min(Err), max(Err)]);
%     xlim([10, 20]);
%     ylim([0, pi]);
%     colorbar;
%     title('Max Abs Error as a function of angle at y0=');
%     xlabel('x0');
%     ylabel('theta0');
% 
%     % Visualize the x vector
%        
%     figure (77);
%     plot(x, Err);
%     title('X Vector');
%     xlabel('Index');
%     ylabel('Value');
%     figure (78);
%     plot(y, Err);
%     title('Y Vector');
%     xlabel('Index');
%     ylabel('Value');
% 
% end
% 
