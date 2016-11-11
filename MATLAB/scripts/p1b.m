close all
addpath ..
addpath ../models/

set(groot, 'defaultAxesTickLabelInterpreter','latex');
set(groot, 'defaultLegendInterpreter','latex');
set(groot, 'defaultFigureColor', [1 1 1]);

omega = 0.005;
sim1 = sim('ship_p1b.mdl');
fig1 = figure();
plot(compass)
xlim([0 3000])
ylabel('Heading (deg)');
title('');
saveas(fig1,'../figures/1b-omega_lik_0005.fig')

omega = 0.05;
sim2 = sim('ship_p1b.mdl');
fig2 = figure();
plot(compass)
xlim([0 1000])
ylabel('Heading (deg)')
title('');
saveas(fig1,'../figures/1b-omega_lik_005.fig')