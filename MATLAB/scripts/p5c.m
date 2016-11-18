

% Start Matrices/Constants
Q = [30 0; 0 10e-6]; %Process noise covaariance
P0_apriori = diag([1 0.13 pi^2 1 2.5e-4]); %initial a priori estimate error covariance
x0_apriori = zeros(5, 1);

fr = 10;
T_sam = 1/fr;

%%Update to discrete values
% A = [0     1             0 0      0; ...
%     -w_0^2 -2*lambda*w_0 0 0      0; ...
%     0      0             0 1      0; ...
%     0      0             0 -(1/T) -(K/T); ...
%     0      0             0 0      0];
% 
% B = [ 0; 0; 0; K/T; 0];
% E = [0   0; ...
%      K_w 0; ...
%      0   0; ...
%      0   0; ...
%      0   1];
% 
% C = [ 0 1 1 0 0];

R_v = variance/T_sam; %discrete time variance of measurement noise