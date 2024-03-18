function [c] = gradient_2D(x, y, c0, coeff) % dx, dy, x0, y0)
    % Function to compute speed of sound at position (x, y)
    % c0: Speed of sound at reference position
    % coeff: Coefficient for linear variation with x
    
    % Compute speed of sound at given position
    c = c0 + coeff * x;
%     c_diff_x = (c(x0+dx) - c(x0))/dx; 
%     c_diff_y = (c(y0+dy) - c(y0))/dy; 
end

