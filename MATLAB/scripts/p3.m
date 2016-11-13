close all
addpath ../
addpath ../models/

set(groot, 'defaultAxesTickLabelInterpreter','latex');
set(groot, 'defaultLegendInterpreter','latex');
set(groot, 'defaultFigureColor', [1 1 1]);

axlbl = @(h) [xlabel(h, 'Time [s]'); ylabel(h, '$\psi$,$\delta$ [deg]'); legend(h, '$\psi$', '$\delta$')];

load_system('ship_p3.mdl');

%% 3a
T = 85.6697;
K = 0.173945;

K_pd = 0.8;
T_d = T;
alpha = 0.1;
T_f = alpha*T_d;

s = tf('s');

H_ship = tf(K,[T 1 0]);
H_pd = tf([K_pd*T_d K_pd], [T_f 1]);

H = H_ship*H_pd;
fig1 = figure();
bode(H);
margin(H);
title('');
saveas(fig1,'../figures/3a-bode_and_phasemargin.fig');

%% 3b
set_param('ship_p3/Cargo ship', 'noise', 'on');
set_param('ship_p3/Cargo ship', 'current', 'off');
set_param('ship_p3/Cargo ship', 'waves', 'off');
sim('ship_p3.mdl');

fig2 = figure();
plot(rudder.time, compass.data, rudder.time, rudder.data);
axlbl(gca);
saveas(fig2,'../figures/3b-psi_and_rudder.fig');

%% 3c
set_param('ship_p3/Cargo ship', 'noise', 'on');
set_param('ship_p3/Cargo ship', 'current', 'on');
set_param('ship_p3/Cargo ship', 'waves', 'off');
sim('ship_p3.mdl');

fig3 = figure();
plot(rudder.time, compass.data, rudder.time, rudder.data);
axlbl(gca);
saveas(fig3,'../figures/3c-psi_and_rudder_w_current.fig');

%% 3d
set_param('ship_p3/Cargo ship', 'noise', 'on');
set_param('ship_p3/Cargo ship', 'current', 'off');
set_param('ship_p3/Cargo ship', 'waves', 'on');
sim('ship_p3.mdl');

fig4 = figure();
plot(rudder.time, compass.data, rudder.time, rudder.data);
axlbl(gca);
saveas(fig4,'../figures/3d-psi_and_rudder_w_waves.fig');
