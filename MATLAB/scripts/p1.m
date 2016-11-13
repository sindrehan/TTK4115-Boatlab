close all
clear all

addpath ..
addpath ../models/

set(groot, 'defaultAxesTickLabelInterpreter','latex');
set(groot, 'defaultLegendInterpreter','latex');
set(groot, 'defaultFigureColor', [1 1 1]);

load_system('ship_p1.mdl');

input = 0; %0 for sine wave, 1 for step
%

%% 1b
set_param('ship_p1/Cargo ship', 'noise', 'off');
set_param('ship_p1/Cargo ship', 'current', 'off');
set_param('ship_p1/Cargo ship', 'waves', 'off');

omega = 0.005;
sim('ship_p1.mdl');

figb1 = figure(1);
plot(compass);
xlim([0 3000]);
ylabel('Heading (deg)');
title('');
saveas(figb1,'../figures/1b-omega_lik_0005.fig');

omega = 0.05;
sim('ship_p1.mdl');

figb2 = figure(2);
plot(compass);
xlim([0 1000]);
ylabel('Heading (deg)');
title('');
saveas(figb2,'../figures/1b-omega_lik_005.fig');
%

%% 1c
set_param('ship_p1/Cargo ship', 'noise', 'on');
set_param('ship_p1/Cargo ship', 'current', 'off');
set_param('ship_p1/Cargo ship', 'waves', 'on');

omega = 0.005;
sim('ship_p1.mdl');

figc1 = figure(3);
plot(compass);
xlim([0 3000]);
ylabel('Heading (deg)');
title('');
saveas(figc1,'../figures/1c-omega_lik_0005.fig');

omega = 0.05;
sim('ship_p1.mdl');

figc2 = figure(4);
plot(compass);
xlim([0 1000]);
ylabel('Heading (deg)');
title('');
saveas(figc2,'../figures/1c-omega_lik_005.fig');
%

%% 1d
T = 85.6697;
K = 0.173945;

s = tf('s');
H = K/(T*s^2+s);

set_param('ship_p1/Cargo ship', 'noise', 'off');
set_param('ship_p1/Cargo ship', 'current', 'off');
set_param('ship_p1/Cargo ship', 'waves', 'off');
input = 1; %Set step as input to delta
sim('ship_p1.mdl');

figd = figure(5);
plot(compass, 'r');
hold on
[y, t] = step(H,500);
plot(t,y);
xlim([0 500]);
ylabel('Heading (deg)');
title('');
legend('Ship model', 'Transfer function model');
saveas(figd,'../figures/1d-riktig_amplitude.fig');
%