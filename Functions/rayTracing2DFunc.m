function [result] = rayTracing2DFunc(coords_init, dir_init,  solverType, materialType, velocityFunc, odeParam)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

if solverType == "Euler"
    solverFunc = @euler ;
elseif solverType == "Euler-implicite"
    solverFunc = @euler_implicite;
elseif solverType == "Euler-Richardson"
    solverFunc = @eulerRichardson;
elseif solverType == "Second-order RK"
    solverFunc = @second_order_parametrized;
elseif solverType == "RK4"
    solverFunc = @RK4;
elseif solverType == "DormandPrince RK4"
    solverFunc = @DormandPrince;
elseif solverType == "DormandPrince adaptative"
    solverFunc = @DormandPrinceAdapt;   
end

if materialType == "IsoFluid"
    systemFunc = @iso_fluid_system_2D ;
end

x0 = coords_init(1) ;            % Initial x position
y0 = coords_init(2) ;            % Initial y position
s0 = abs(1/ velocityFunc(x0, y0));   % slowness space
sx0 = s0 * dir_init(1) / sqrt(sum(dir_init.^2)) ;
sy0 = s0 * dir_init(2) / sqrt(sum(dir_init.^2)) ;

Y0 = [x0, y0, sx0, sy0];
square_root0 = sqrt(Y0(3)^2+Y0(4)^2);
% [F] = systemFunc(Y0, velocityFunc, odeParam)
[Y, Time] = solverFunc(Y0, systemFunc, velocityFunc, odeParam);

result.x = Y(1,:);
result.y = Y(2,:);
result.sx = Y(3,:);
result.sy = Y(4,:);
result.times = Time;

end