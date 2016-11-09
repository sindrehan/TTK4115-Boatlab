close all
addpath ../
addpath ../models/

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
saveas(fig1,'../figures/3a-bode_and_phasemargin.fig');

%% 3b
axlbl = @(h) [xlabel(h, 'Time [s]'); ylabel(h, '\psi,\delta [deg]'); legend(h, '\psi', '\delta')];
simb = sim('ship_p3b.mdl');
fig2 = figure();
plot(rudder.time, compass.data, rudder.time, rudder.data);
axlbl(gca);
saveas(fig2,'../figures/3b-psi_and_rudder.fig');

%% 3c
simc = sim('ship_p3c.mdl');
fig3 = figure();
plot(rudder.time, compass.data, rudder.time, rudder.data);
axlbl(gca);
saveas(fig3,'../figures/3c-psi_and_rudder_w_current.fig');

%% 3d
simd = sim('ship_p3d.mdl');
fig4 = figure();
plot(rudder.time, compass.data, rudder.time, rudder.data);
axlbl(gca);
saveas(fig3,'../figures/3d-psi_and_rudder_w_waves.fig');
