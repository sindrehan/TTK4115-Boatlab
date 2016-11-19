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
Q_w = (pi/180)^2 * [30 0 ; 0 10^-6];

[A_d B_d] = c2d(A, B, T_s);
[A_d E_d] = c2d(A, E, T_s);
Q_wd = E_d*Q_w*transpose(E_d);


%% Part B
% Run simulation
sim('ship_p5b.mdl');

% Get variance of compass values
variance = var(compass*pi/180);

%% Part C
task = 0; %0 For C, 1 for D
task2 = 0; %0 for C/D, 1 for E
load_system('ship_p5.mdl');

% Start Matrices/Constants
Q = (pi/180)^2 * [30 0; 0 10e-6]; %Process noise covaariance
P0_apriori = (pi/180)^2 * diag([1 0.013 pi^2 1 2.5e-4]); %initial a priori estimate error covariance
x0_apriori = zeros(5, 1);

R_v = variance/T_s; %discrete time variance of measurement noise

%% Part D
task = 1;
task2 = 0;
set_param('ship_p5/Cargo ship', 'noise', 'on');
set_param('ship_p5/Cargo ship', 'current', 'on');
set_param('ship_p5/Cargo ship', 'waves', 'off');

sim('ship_p5.mdl');

fig1 = figure();
%plot(x_k.time, x_k.signals.values(:,3))
hold on
plot(compass);
plot(rudder);
legend('Measured $\psi$', '$\delta$');
title('');
ylabel('Angle (deg)');
saveas(fig1,'../figures/5d-psi_and_rudder.fig');

fig2 = figure();
plot(x_k.time, x_k.signals.values(:,5));
legend('Esimated rudder bias');
title('');
ylabel('Angle (deg)');
saveas(fig2,'../figures/5d-estimated_rudder_bias.fig');

%% Part E
task1 = 1;
task2 = 1;
set_param('ship_p5/Cargo ship', 'noise', 'on');
set_param('ship_p5/Cargo ship', 'current', 'on');
set_param('ship_p5/Cargo ship', 'waves', 'on');

sim('ship_p5.mdl');

fig3 = figure();
hold on
plot(compass);
plot(x_k.time, x_k.signals.values(:,3))
plot(rudder);
legend('Measured $\psi$', 'Estimated $\psi$', '$\delta$');
title('');
ylabel('Angle (deg)');
saveas(fig3,'../figures/5e-psi_and_rudder.fig');

fig4 = figure();
plot(x_k.time, x_k.signals.values(:,5));
legend('Esimated rudder bias');
title('');
ylabel('Angle (deg)');
saveas(fig4,'../figures/5e-estimated_rudder_bias.fig');

fig5 = figure();
load('../wave.mat');
hold on
plot(psi_w(1,:), psi_w(2,:));
plot(x_k.time, x_k.signals.values(:,2));
legend('Actual wave influence', 'Estimated wave influence');
title('');
ylabel('Angle (deg)');
xlim([0 500]);
saveas(fig5,'../figures/5e-wave_influence.fig');
