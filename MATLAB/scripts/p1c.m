close all
addpath ..
addpath ../models/

set(groot, 'defaultAxesTickLabelInterpreter','latex');
set(groot, 'defaultLegendInterpreter','latex');

omega = 0.005;
sim1 = sim('ship_p1c.mdl');
fig1 = figure(1);
plot(compass)
xlim([0 3000])
ylabel('Heading (deg)')
title('');
saveas(fig1,'../figures/1c-omega_lik_0005.fig')

omega = 0.05;
sim2 = sim('ship_p1c.mdl');
fig2 = figure(2);
plot(compass)
xlim([0 1000])
ylabel('Heading (deg)')
title('');
saveas(fig1,'../figures/1c-omega_lik_005.fig')