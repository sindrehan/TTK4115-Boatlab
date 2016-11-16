%% Initialize
clear all
close all

addpath ../
addpath ../models/

set(groot, 'defaultAxesTickLabelInterpreter','latex');
set(groot, 'defaultLegendInterpreter','latex');
set(groot, 'defaultFigureColor', [1 1 1]);

T = 85.6697;
K = 0.173945;

K_pd = 0.8;
T_d = T;
alpha = 0.1;
T_f = alpha*T_d;

%% Part A
omega_zero = 0.7823;
lambda = 0.0827;
sigma = sqrt(0.0015);
K_omega = 2*lambda*omega_zero*sigma;
T = 85.6697;
K = 0.173945;

F_s = 10;
T_s = 1/F_s;

A = [0 1 0 0 0 ; 
    -omega_zero^2 -2*lambda*omega_zero 0 0 0 ; 
    0 0 0 1 0 ; 
    0 0 0 -1/T -K/T; 
    0 0 0 0 0];

B = [ 0 ; 0 ; 0 ; K/T ; 0 ];
C = [ 0 1 1 0 0];
E = [ 0 0 ; K_omega 0 ; 0 0 ; 0 0 ; 0 1];
% 
Q_w = [30 0 ; 0 10^-6];
% 
% M = exp([A E*Q_w*transpose(E) ; zeros(size(A))  -transpose(A)]*T_s);
% N = exp([A B ; zeros(size(transpose(B))) zeros(min(size(B)))]*T_s);

[A_d B_d] = c2d(A, B, T_s);
[A_d E_d] = c2d(A, E, T_s);
Q_wd = E_d*Q_w*transpose(E_d);


%% Part B
% Run simulation
sim('ship_p5b.mdl');

% Get variance of compass values
variance = var(compass);

%% Part C
task = 0; %0 For C, 1 for D
load_system('ship_p5.slx');

% Start Matrices/Constants
Q = [30 0; 0 10e-6]; %Process noise covaariance
P0_apriori = diag([1 0.13 pi^2 1 2.5e-4]); %initial a priori estimate error covariance
x0_apriori = zeros(5, 1);

R_v = variance/T_s; %discrete time variance of measurement noise
set_param('ship_p5/Cargo ship', 'noise', 'on');
set_param('ship_p5/Cargo ship', 'current', 'off');
set_param('ship_p5/Cargo ship', 'waves', 'off');

sim('ship_p5.slx');

figure()
plot(x_k.time, x_k.signals.values(:,3))
hold on
plot(compass);
legend('Kalman Estimate', 'Measured')
title('')
ylabel('Compass Angle (deg)')

figure()
plot(x_k.time, x_k.signals.values(:,5))
hold on
plot(rudder);
legend('Kalman Estimate', 'Measured')
title('')
ylabel('Rudder Angle (deg)')

%% Part D
task = 1;
set_param('ship_p5/Cargo ship', 'noise', 'on');
set_param('ship_p5/Cargo ship', 'current', 'on');
set_param('ship_p5/Cargo ship', 'waves', 'off');

sim('ship_p5.slx');

figure()
plot(x_k.time, x_k.signals.values(:,3))
hold on
plot(compass);
legend('Kalman Estimate', 'Measured')
title('')
ylabel('Compass Angle (deg)')
grid on;

figure()
plot(x_k.time, x_k.signals.values(:,5))
hold on
plot(rudder);
legend('Kalman Estimate', 'Measured')
title('')
ylabel('Rudder Angle (deg)')

%% Part D
set_param('ship_p5e/Cargo ship', 'noise', 'on');
set_param('ship_p5e/Cargo ship', 'current', 'on');
set_param('ship_p5e/Cargo ship', 'waves', 'on');

sim('ship_p5e.slx');

figure()
plot(x_k.time, x_k.signals.values(:,3))
hold on
plot(compass);
legend('Kalman Estimate', 'Measured')
title('')
ylabel('Compass Angle (deg)')

figure()
plot(x_k.time, x_k.signals.values(:,5))
hold on
plot(rudder);
legend('Kalman Estimate', 'Measured')
title('')
ylabel('Rudder Angle (deg)')