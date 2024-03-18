function [c] = gradient_2D_euler_addapted(x, y) % dx, dy, x0, y0)
% Function to compute speed of sound at position (x, y)
% c0: Speed of sound at reference position
% coeff: Coefficient for linear variation with x

% Compute speed of sound at given position

coeff = -0.01;
c0 = 1.5;
c = c0 + coeff * x;

end

