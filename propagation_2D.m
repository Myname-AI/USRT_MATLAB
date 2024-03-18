clc
clear all
close all
addpath('C:\Users\OG277444\Documents\MATLAB\USRT_MATLAB\Functions')
% load("h_step.txt")
solverType = ["Euler", "Euler-implicite", "Second-order RK",...
    "RK4", "DormandPrince RK4", "DormandPrince adaptative"]; 
% Define predefined vectors
h = []; % Example values for "h"
tmax = []; % Example values for "tmax"
epsilon = []; % Example values for "epsilon"
tolerance = []; % Example values for "tolerance"
alfa = []; % Example values for "tolerance"
% Construct odeParam structure
odeParam = struct('h', h, 'tmax', tmax, 'epsilon', epsilon, 'tolerance', tolerance, 'alfa', alfa);
h_step = [0.01];

coords_init= [12, 0];
dir_init = [0.5,0.5];

%% Calculation of the reference case and error calculation
[result_ref] = rayTracing2DFunc([12,0], [0.5,0.5],  "Euler", "IsoFluid", @gauss_2D, ...
    struct('h', 0.0001, 'tmax', 100., 'epsilon', 0.01));
save("reference.mat","result_ref");
reference = load ("reference.mat");
% [result] = rayTracing2DFunc([12,0], [0.5,0.5],  "Euler", "IsoFluid", @gauss_2D, ...
%     struct('h', 0.1, 'tmax', 100., 'epsilon', 0.01));
% [Error_max, Y_interp] = ErrorFunc_2D(result, reference);
%% Tracing of the VECTORS at given range in time: 
figure(3)
plot(result_ref.times, result_ref.x, 'LineWidth', 1.5, 'Color','m')  %'LineWidth',8, 'DisplayName'
legend("Euler reference")
hold on

figure(3);
hold on;
for j = 1:numel(solverType)

     time_points = [];
     vector_points = [];
    
    for i = 1:numel(h_step)
        
        result = rayTracing2DFunc([12,0], [0.5,0.5], solverType(j), "IsoFluid", @gauss_2D, ...
            struct('h', h_step(i), 'tmax', 100., 'epsilon', 0.01, 'tolerance', 0.001, 'alfa', 0.5));
time_points = [time_points, result.times];
vector_points = [vector_points, result.x];
    end 
    plot(time_points, vector_points, '-', 'DisplayName', solverType(j))
end
xlabel('Time'); ylabel('X-vector');
xlim([0, 110]); ylim([-10, 80]); legend('show');

xSTART = 10; 
 xSTEP=5 ; %xLENGHT, ySTART, ySTEP, yLENGHT, angleSTART, angleSTEP, angleLENGHT
xLENGTH=40;

ySTART = 10; 
 ySTEP=5; 
yLENGTH=40;

thetaSTART=0;
thetaSTEP=pi/4;
thetaLENGTH = pi/4;
%% ERROR TRACING under x0,y0: VAR: [h & solverType]
% % Initialize arrays to store data points
% h_points = [];
% Error_points = [];
% figure(1);
% hold on;
% for j = 1:numel(solverType)
%     % Reset h_points and Error_points for each solver
%     h_points = [];
%     Error_points = [];
% 
%     for i = 1:numel(h_step)
%         result = rayTracing2DFunc([12,0], [0.5,0.5], solverType(j), "IsoFluid", @gauss_2D, ...
%             struct('h', h_step(i), 'tmax', 100., 'epsilon', 0.01, 'tolerance', 0.001, 'alfa', 0.5));
%         [Error_max] = ErrorFunc_2D(result, reference);
%         % Collect data points
%         h_points = [h_points, h_step(i)];
%         Error_points = [Error_points, Error_max(1,4)];
%     end
%     loglog(h_points, Error_points, '*', 'DisplayName', solverType(j));
% end
% title('Absolute error; gradient function distribution')
% xlabel('h'); ylabel('Error SY-vector');
% xlim([10^-5, 2*10^1]); ylim([1*10^-7, 10^1]); legend('show');
% set(gca, 'XScale', 'log'); set(gca, 'YScale', 'log'); % Explicitly force scale to be logarithmic










%% BELOW UNRELEVANT 
%% Initial conditions
% coords_init = [12,0];
% x0 = coords_init(1) ;            % Initial x position
% y0 = coords_init(2) ;            % Initial y position
% 
% s0 = abs(1/ gauss_2D(x0, y0));   % slowness space
% 
% dir_init = [0.5,0.5];            % slowness vectors directions
% sx0 = s0 * dir_init(1) / sqrt(sum(dir_init.^2)) ;
% sy0 = s0 * dir_init(2) / sqrt(sum(dir_init.^2)) ;
% Y0 = [x0, y0, sx0, sy0];
% 
% square_root0 = sqrt(Y0(3)^2+Y0(4)^2);

%             %% Call Euler solver
%             for k = 1:numel(h_step)
%          
%             [Y, Time] = euler(Y0, @iso_fluid_system_2D, @gauss_2D, struct('h', h_step(k), 'tmax', 100., 'epsilon', 0.01));
%           % Construct the dynamic variable names with one digit incremented
%     var_name_Y = ['Y', num2str(k)];
%     var_name_T = ['T', num2str(k)];
%     
%     % Assign data to dynamically named variables
%     eval([var_name_Y, ' = Y;']);
%     eval([var_name_T, ' = Time;']);
%     Y_{k} = eval(var_name_Y);
%     T_{k} = eval(var_name_T);
% 
%             %% Plot graphs with variable step h to check visually an acceptable case.
%             figure (23)
%             hold on
%             plot(T_{k},Y_{k}(1,:), "-" )
%             legend('1s', '0.5s','0.1s','0.01s', '0.001s', '0.0001s','0.00001s')
%             xlabel('Time')
%             ylabel('X-vector')
%             end

            %% BY INTERPOLATING THE VECTORS TO BIGGER ONES >> THE ERRORS HERE ARE ABSOLUTE IN-BETWEEN NEIGHBORING h VALUES
            %         Y1_interp = interp1(T1, Y1(4,:), T2, 'linear', 'extrap');
            %         Error1=abs(Y2(4,:)-Y1_interp); Error_sum1=sum(Error1(:,:))*1*0.5;
            %         Error_max1=max(Error1(:,:));
            %
            %         Y2_interp = interp1(T2, Y2(4,:), T3, 'linear', 'extrap');
            %         Error2=abs(Y3(4,:)-Y2_interp); Error_sum2=sum(Error2(:,:))*1*10^-1;
            %         Error_max2=max(Error2(:,:));
            %
            %         Y3_interp = interp1(T3, Y3(4,:), T4, 'linear', 'extrap');
            %         Error3=abs(Y4(4,:)-Y3_interp); Error_sum3=sum(Error3(:,:))*1*10^-2;
            %         Error_max3=max(Error3(:,:));
            %
            %         Y4_interp = interp1(T4, Y4(4,:), T5, 'linear', 'extrap');
            %         Error4=abs(Y5(4,:)-Y4_interp); Error_sum4=sum(Error4(:,:))*1*10^-3;
            %         Error_max34=max(Error4(:,:));
            %
            %         Y5_interp = interp1(T5, Y5(4,:), T6, 'linear', 'extrap');
            %         Error5=abs(Y6(4,:)-Y5_interp); Error_sum5=sum(Error5(:,:))*1*10^-4;
            %         Error_max5=max(Error5(:,:));
            %
            %         Y6_interp = interp1(T6, Y6(4,:), T7, 'linear', 'extrap');
            %         Error6=abs(Y7(4,:)-Y6_interp); Error_sum6=sum(Error6(:,:))*1*10^-5;
            %         Error_max6=max(Error6(:,:));
            %
            %         Y7_interp = interp1(T7, Y7(4,:), T8, 'linear', 'extrap');
            %         Error7=abs(Y8(4,:)-Y7_interp); Error_sum7=sum(Error7(:,:))*1*10^-6;
            %         Error_max7=max(Error7(:,:));
            %
            %         figure (98)
            %         loglog (0.5, Error_max1,  "r.",'MarkerSize',12);
            %         hold on
            %         loglog (0.1, Error_max2,  "r.",'MarkerSize',12);
            %         hold on
            %         loglog (0.01, Error_max3,  "r.",'MarkerSize',12);
            %         hold on
            %         loglog (0.001, Error_max4,  "r.",'MarkerSize',12);
            %         hold on
            %         loglog (0.0001, Error_max5,  "r.",'MarkerSize',12);
            %         hold on
            %         loglog (0.00001, Error_max6,  "r.",'MarkerSize',12);
            %         hold on
            % %         loglog (0.000001, Error_sum7,  "r.",'MarkerSize',12);
            % %         hold on
            %         xlabel('Time step h, [s]')
            %         ylabel('Absolute error X-vector')


            %% CORRECTED FROM PREVIOS CASE; NOW REFERING TO ERROR @ REFERENCE VALUE WITH h=0.0001
            %  Y1_interp = interp1(T1, Y1(1,:), T7, 'linear', 'extrap');
            %         Error1=abs(Y7(1,:)-Y1_interp);
            %         Error_max1=max(Error1(:,:));
            %
            %         Y2_interp = interp1(T2, Y2(1,:), T7, 'linear', 'extrap');
            %         Error2=abs(Y7(1,:)-Y2_interp);
            %         Error_max2=max(Error2(:,:));
            %
            %         Y3_interp = interp1(T3, Y3(1,:), T7, 'linear', 'extrap');
            %         Error3=abs(Y7(1,:)-Y3_interp);
            %         Error_max3=max(Error3(:,:));
            %
            %         Y4_interp = interp1(T4, Y4(1,:), T7, 'linear', 'extrap');
            %         Error4=abs(Y7(1,:)-Y4_interp);
            %         Error_max4=max(Error4(:,:));
            %
            %         Y5_interp = interp1(T5, Y5(1,:), T7, 'linear', 'extrap');
            %         Error5=abs(Y7(1,:)-Y5_interp);
            %         Error_max5=max(Error5(:,:));
            %
            %         Y6_interp = interp1(T6, Y6(1,:), T7, 'linear', 'extrap');
            %         Error6=abs(Y7(1,:)-Y6_interp);
            %         Error_max6=max(Error6(:,:));
            
            %         figure (94)
            %         loglog (1, Error_max1,  "r.",'MarkerSize',15);
            %         hold on
            %         loglog (0.5, Error_max2,  "r.",'MarkerSize',15);
            %         hold on
            %         loglog (0.1, Error_max3,  "r.",'MarkerSize',15);
            %         hold on
            %         loglog (0.01, Error_max4,  "r.",'MarkerSize',15);
            %         hold on
            %         loglog (0.001, Error_max5,  "r.",'MarkerSize',15);
            %         hold on
            %         loglog (0.0001, Error_max6,  "r.",'MarkerSize',15);
            %         hold on
            %         loglog (0.000001, Error_sum7,  "r.",'MarkerSize',12);
            %         hold on
            %         xlabel('Time step h, [s]')
            %         ylabel('Absolute error SX-vector')
            % set(gca, 'XScale', 'log') % Explicitly force scale to be logarithmic
%% CALCULATION OF MAX ERROR FOR EACH CASE AND PLOT ON THE TIME SCALE



% % Initialize tables to store Time and Y data
% time_table = table();
% y_table = table();
% 
% % Initialize vector to store Error scalar values
% error_vector = zeros(8, 1);
% 
% for i = 1:8
%     h_step_i=h_step(i);
%     % Call your function to get results
%     [Error_max_i, odeParam_i, Time_i, Y_i] = ErrorFunc_2D(@RK4, @gauss_2D, [12,0], [0.5,0.5], struct('h', h_step_i, 'tmax', 100., 'epsilon', 0.01));
%     
%     % Store Error scalar value in the vector
%     error_vector(i) = Error_max_i;
%     
%     % Create tables for Time and Y data for the current iteration
%     time_table_i = table(Time_i', 'VariableNames', {'Time'});
%     y_table_i = table(Y_i', 'VariableNames', {'Y'});
%     
%     % Append tables for Time and Y data to the main tables
%     time_table = [time_table time_table_i];
%     y_table = [y_table  y_table_i];
% end





% 
% % Initialize cell arrays to store variable-size data
% Error_max_cell = cell(8, 1);
% Time_cell = cell(8, 1);
% Y_cell = cell(8, 1);
% 
% % Initialize a table to store results
% results_table = table(Error_max_cell, Time_cell, Y_cell);
% 
% for i = 1:8
%     % Call your function to get results
%     [Error_max_i, odeParam_i, Time_i, Y_i] = ErrorFunc_2D(@DormandPrinceAdapt, @gauss_2D, [12,0], [0.5,0.5], struct('h', h_step(1,i), 'tmax', 100., 'epsilon', 0.01));
%     
%     % Store the results of the current iteration in cell arrays
%     Error_max_cell{i} = Error_max_i;
%     Time_cell{i} = Time_i;
%     Y_cell{i} = Y_i;
% end

% Loop through each row of the table
% for i = 1:height(results_table)
%     % Access Time and Y values from the current row
%     Time_i = results_table.Time_cell{i};
%     Y_i = results_table.Y_cell{i}(1);
%     
%     % Plot Time vs. Y for the current iteration
%     figure (66);
%     plot(Time_i, Y_i);
%     xlabel('Time');
%     ylabel('Y');
% %     title(['Time vs. Y - Iteration ', num2str(i)]);
% hold on
% end


% Convert cell arrays to table
% results_table = table(Error_max_cell, Time_cell, Y_cell);


% figure(50)
% loglog(odeParam.h, Error_max, "c*");
% xlim([10^-5, 10^2]);
% ylim([10^-6, 10^3]);
% hold on

% set(gca, 'XScale', 'log') % Explicitly force scale to be logarithmic
            %% Continue
            %  [Y, Time] = euler_implicite(Y0, @iso_fluid_system_2D, @gauss_2D, 0.01, 100., 0.01);
            % figure(1)
            % % plot(Y(1, :), Y(2, :),  "k."); % In 2D space
            % plot (Time, (Y(1, :)),  "k."); % On Time vector
            % xlabel('Time')
            % ylabel('X-vector')
            % hold on
            % [Y, Time] = eulerRichardson(Y0, @iso_fluid_system_2D, @gauss_2D, 0.1, 0.01, 100., 0.01);
            % figure(1)
            % % plot(Y(1, :), Y(2, :), "b." ); % In 2D space
            % plot (Time, (Y(1, :)),  "b."); % On Time vector
            % xlabel('Time')
            % ylabel('X-vector')
            % hold on
            % [Y, Time] = second_order_parametrized(Y0, 0.5, @iso_fluid_system_2D, @gauss_2D, ...
            %    0.01, 100., 0.01);
            % figure(1)
            % % plot(Y(1, :), Y(2, :), "g." );% In 2D space
            % plot (Time, (Y(1, :)),  "g."); % On Time vector
            % xlabel('Time')
            % ylabel('X-vector')
            % hold on
            %  [Y, Time] = RK4(Y0, @iso_fluid_system_2D, @gauss_2D, 0.01, 100, 0.01);
            % figure(1)
            % % plot(Y(1, :), Y(2, :), "c." ); % In 2D space
            % plot (Time, (Y(1, :)),  "c."); % On Time vector
            % xlabel('Time')
            % ylabel('X-vector')
            % hold on
            % [Y, Time] = DormandPrince(Y0, @iso_fluid_system_2D, @gauss_2D, 0.01, 100, 0.01);
            % figure(1)
            % % plot(Y(1, :), Y(2, :), "m*"); % In 2D space
            % plot (Time, (Y(1, :)),  "m*"); % On Time vector
            % xlabel('Time')
            % ylabel('X-vector')
            % hold on
            %  [Y, Time] = DormandPrinceAdapt(Y0, @iso_fluid_system_2D, @gauss_2D, 0.01, 0.01, 100, 0.01);
            % figure(1)
            % % plot(Y(1, :), Y(2, :), "r*"); % In 2D space
            % plot (Time, (Y(1, :)),  "r*"); % On Time vector
            % xlabel('Time')
            % ylabel('X-vector')
            % legend('Euler','RK4','Dormand Prince','Dormand Prince h adapt' )
            % hold on
           


%         %% Visualization
%         figure(10+i)
% 
%         x = linspace(0, 100, 100);
%         y = linspace(0, 100, 100);
%         [X1, X2] = meshgrid(x, y);
%         C = gauss_2D(X1, X2);
% 
%         imagesc((x),(y), (C));
%         xlim = [0 100];
%         ylim = [0 100];
%         colorbar ()
%         hold on
%         figure(10+i)
%         plot(Y2(1, :),  Y2(2, :),  '.' , 'Color','r');



