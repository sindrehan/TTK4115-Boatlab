close all

T = 85.6697;
K = 0.173945;


s = tf('s')
H = K/(T*s^2+s)

sim1d = sim('ship.mdl');
figure()
plot(compass, 'r')
hold on
[y, t] = step(H,500);
plot(t,y);
xlim([0 500])
ylabel('Heading (deg)')
title('Heading over time.')
legend('ship model', 'transfer function model')