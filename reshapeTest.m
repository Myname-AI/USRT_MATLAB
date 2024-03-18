A = reshape (position(:,1),[M_on_y, N_y])
B = reshape (position(:,3), [M_on_y, N_y])
C = reshape (ErrorMap(:,1),[M_on_y, N_y])
% [X, Y] = meshgrid(x, theta) ; % set the parameters that do not iter in the loop
%     Z=griddata(x, theta, Err, X,Y);
% reshape(X,M,N,P,...) or reshape(X,[M,N,P,...]) returns an 
%     N-D array with the same elements as X but reshaped to have 
%     the size M-by-N-by-P-by-.
imagesc(A, B, C)
positionD = [A(:) B(:), C(:)];
for i = size(A(:,:,1))
    imagesc(A(:,:,i), B(:,:,i), C(:,:,i));
end
    caxis([min(Err), max(Err)]);
    xlim([10, 20]);
    ylim([0, pi]);
    colorbar;
    title('Max Abs Error as a function of angle at y0=');
    xlabel('x0');
    ylabel('theta0');