function [Error_max, Y_interp] = ErrorFunc_2D(result, reference)

%% BY INTERPOLATING THE VECTORS TO BIGGER ONES ---> THE ERRORS HERE ARE ABSOLUTE IN-BETWEEN NEIGHBORING h VALUES 
 %% CORRECTED FROM PREVIOS CASE; NOW REFERING TO ERROR @ REFERENCE VALUE WITH h calculated for reference case ans stored in the matalb space. 
        Y_interp.x = interp1(result.times, result.x, reference.result_ref.times, 'linear', 'extrap');
        Error.x=abs(reference.result_ref.x-Y_interp.x); 
        Error_max.x=max(Error.x);
        Y_interp.y = interp1(result.times, result.y, reference.result_ref.times, 'linear', 'extrap');
        Error.y=abs(reference.result_ref.y-Y_interp.y); 
        Error_max.y=max(Error.y);
        Y_interp.sx = interp1(result.times, result.sx, reference.result_ref.times, 'linear', 'extrap');
        Error.sx=abs(reference.result_ref.sx-Y_interp.sx); 
        Error_max.sx=max(Error.sx);
        Y_interp.sy = interp1(result.times, result.sy, reference.result_ref.times, 'linear', 'extrap');
        Error.sy=abs(reference.result_ref.sy-Y_interp.sy); 
        Error_max.sy=max(Error.sy);

        Error_max = [Error_max.x, Error_max.y,Error_max.sx, Error_max.sy];

end




% rayTracing2DFunc, velocityFunc, reference, coords_init, dir_init, result, result, odeParam
%% Initial conditions
%             x0 = coords_init(1) ;            % Initial x position
%             y0 = coords_init(2) ;            % Initial y position
%             
%             s0 = abs(1/ velocityFunc(x0, y0));
%             sx0 = s0 * dir_init(1) / sqrt(sum(dir_init.^2)) ;
%             sy0 = s0 * dir_init(2) / sqrt(sum(dir_init.^2)) ;
%             Y0 = [x0, y0, sx0, sy0];
% 
%             square_root0 = sqrt(Y0(3)^2+Y0(4)^2);

        %% Call given solver for asked params.
%         [result] = rayTracing2DFunc(coords_init, dir_init,  solverType, materialType, velocityFunc, odeParam);
%         [Y, Time] = solverFunc(Y0, @iso_fluid_system_2D, velocityFunc, odeParam);
%         Y_method = Y;
%         T_method = Time;

        %% Call Euler solver for ref params.

%         reference = load("reference.mat");

  


%         refParam = struct('h', 1e-4, 'tmax', 100., 'epsilon', 0.01) ;
%         [Y, Time] = euler(Y0, @iso_fluid_system_2D, velocityFunc, refParam);
%         Y_ref = Y;
%         T_ref = Time;
