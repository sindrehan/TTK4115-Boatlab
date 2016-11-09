close all
addpath ..
addpath ../models/

omega = 0.005;
sim1 = sim('ship_p1b.mdl');
fig1 = figure(1);
plot(compass)
xlim([0 3000])
ylabel('Heading (deg)')
title(strcat('Heading over time. Omega = ', num2str(omega)))
saveas(fig1,'../figures/1b-omega_lik_0005.fig')

omega = 0.05;
sim2 = sim('ship_p1b.mdl');
fig2 = figure(2);
plot(compass)
xlim([0 1000])
ylabel('Heading (deg)')
title(strcat('Heading over time. Omega = ', num2str(omega)))
saveas(fig1,'../figures/1b-omega_lik_005.fig')