function [ErrorMap, position, N_theta, N_x, N_y] = MapFunction_2D(solverFunc, velocityFunc, odeParam)


xSTART = 10; 
 xSTEP=5 ; %xLENGHT, ySTART, ySTEP, yLENGHT, angleSTART, angleSTEP, angleLENGHT
xLENGTH=40;

ySTART = 10; 
 ySTEP=5; %xLENGHT, ySTART, ySTEP, yLENGHT, angleSTART, angleSTEP, angleLENGHT
yLENGTH=40;

thetaSTART=0;
thetaSTEP=pi/4;
thetaLENGTH = pi/4;


x = xSTART:xSTEP:(xSTART + xLENGTH) ;
 y = ySTART:ySTEP:(ySTART + yLENGTH) ;
theta = thetaSTART:thetaSTEP:(thetaSTART + thetaLENGTH);
N_theta=numel(theta);
N_x=numel(x);
N_y=numel(y);
[X, Y, T] = meshgrid(x, y, theta) ;
position = [X(:) Y(:), T(:)];
nb_points = size(position, 1) ;

ErrorMap = nan(nb_points,1) ;

for i = 1:size(position, 1)
    ErrorMap(i) = ErrorFunc_2D(solverFunc, velocityFunc, [position(i,1) position(i,2) ] , [cos(position(i,3)), sin(position(i,3))], odeParam) ;

end

end




