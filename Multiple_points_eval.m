clc
clear all
close all
addpath('C:\RP\USRT_MATLAB\Functions\')
addpath('C:\RP\USRT_MATLAB\Data\')
load("h_step.txt")
h = []; % % Initialise predifined vectors "h"...
tmax = []; epsilon = []; tolerance = []; alfa = [];
% Construct odeParam structure
odeParam = struct('h', h, 'tmax', tmax, 'epsilon', epsilon, 'tolerance', tolerance, 'alfa', alfa);
%%
xSTART = 10;    ySTART = 0;    thetaSTART=0;
xSTEP=2 ;       ySTEP=2;       thetaSTEP=pi/180;
xLENGTH=10;     yLENGTH=2;     thetaLENGTH = pi;

% Initialization of space vectors: 
x = xSTART:xSTEP:(xSTART + xLENGTH) ;
y = ySTART:ySTEP:(ySTART + yLENGTH) ;
theta = thetaSTART:thetaSTEP:(thetaSTART + thetaLENGTH);
% theta = [0, pi/6, pi/4, pi/3, pi/2, 2*pi/3, 3*pi/4, 5*pi/6, pi];

% Number of elements at each parameter: 
N_theta=numel(theta); N_x=numel(x); N_y=numel(y);

% Define position matrix
[X, Y, T] = meshgrid(x, y, theta) ;
position = [X(:) Y(:), T(:)];
nb_points = size(position, 1) ;

for i = 1:nb_points
    [result_ref] = rayTracing2DFunc([position(i,1),position(i,2)], [cos(position(i,3)), sin(position(i,3))],  "Euler", "IsoFluid", @gauss_2D, ...
    struct('h', 0.1, 'tmax', 100., 'epsilon', 0.01));
    reference = result_ref; % Rebundant yet allow to stock ref result values out-of script
    save("reference.mat","result_ref");
    reference = load ("reference.mat");

    [result] = rayTracing2DFunc([position(i,1),position(i,2)], [cos(position(i,3)), sin(position(i,3))],  "RK4", "IsoFluid", @gauss_2D, ...
    struct('h', 0.1, 'tmax', 100., 'epsilon', 0.01, 'alfa', 0.5));
 
    ErrorMap(i,:) = ErrorFunc_2D(result, reference); 

end

M = [position ErrorMap]; % Append two 2D arrays
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
    [X, Y] = meshgrid(sub_M{i}(:,1), sub_M{i}(:,3)) ; % define the grid
    Z=griddata(sub_M{i}(:,1), sub_M{i}(:,3), sub_M{i}(:,5), X,Y); % grid error data point to associated cordinate
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
