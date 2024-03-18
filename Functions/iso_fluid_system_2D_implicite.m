function [F] = iso_fluid_system_2D_implicite(Y, velocityFunc, epsilon)

c = velocityFunc(Y(1), Y(2));
c_x_pos = velocityFunc(Y(1) + 0.5 * epsilon, Y(2));
c_x_min = velocityFunc(Y(1) - 0.5 * epsilon, Y(2));
c_y_pos = velocityFunc(Y(1), Y(2) + 0.5 * epsilon);
c_y_min = velocityFunc(Y(1), Y(2) - 0.5 * epsilon);

square_root = sqrt(Y(3)^2+Y(4)^2);
F(3, 1)= - ((c_x_pos - c_x_min) / epsilon)*square_root; % slowness_1/dt
F(4, 1)= - ((c_y_pos - c_y_min) / epsilon)*square_root; % slowness_2/dt
F(1, 1)= c*Y(3)/square_root; % x/dt
F(2, 1)= c*Y(4)/square_root; % y/dt


end