close all

omega = 0.005;
sim0005 = sim('ship.mdl');
figure()
plot(compass)
xlim([0 3000])
ylabel('Heading (deg)')
title(strcat('Heading over time. Omega = ', num2str(omega)))

omega = 0.05;
sim005 = sim('ship.mdl');
figure()
plot(compass)
xlim([0 1000])
ylabel('Heading (deg)')
title(strcat('Heading over time. Omega = ', num2str(omega)))