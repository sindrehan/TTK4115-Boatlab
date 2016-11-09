close all

T = 85.6697;
K = 0.173945;

s = tf('s');
H = K/(T*s^2+s);

addpath ..
addpath ../models/
sim1d = sim('ship_p1d.mdl');
fig1 = figure()
plot(compass, 'r')
hold on
[y, t] = step(H,500);
plot(t,y);
xlim([0 500])
ylabel('Heading (deg)')
title('Heading over time.')
legend('ship model', 'transfer function model')
saveas(fig1,'../figures/1d-riktig_amplitude.fig')