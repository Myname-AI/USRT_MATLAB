function [c] = gauss_2D(x, y) % dx, dy, x0, y0)
% Function to compute speed of sound at position (x, y)
% c0: Speed of sound at reference position
% coeff: Coefficient for linear variation with x

% Compute speed of sound at given position
c0 = 1.500;
coeff = -1.000;
a = 50;
b = 50;
sigma_a = 10;
sigma_b = 10; 
A = (((x-a).^2)/(sigma_a.^2)); 
B = (((y-b).^2)/(sigma_b.^2)); 
c = c0 + coeff .*exp(-A-B);
end