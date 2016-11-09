load('wave.mat');
window = 4096;
fs = 10;
[pxx,f] = pwelch(psi_w(2,:).*pi./180,window, [], [],fs);
fig1 = figure();
plot(2.*pi.*f, pxx./2./pi);
title('Welch PSD estimate');
ylabel('power s/rad');
xlabel('rad/s');
xlim([0 2]);
saveas(fig1,'../figures/2a-welchPSDestimate.fig')

sigma_squared = max(pxx)/2/pi;
omega_zero = 1;
for i = 1:length(pxx)
    if(pxx(i) == sigma_squared*2*pi);
        omega_zero = f(i)*2*pi;
    end
end
lambda = 1;
P_psi_omega = @(lambda,w_in) 4.*lambda^2.*omega_zero^2.*sigma_squared.*w_in.^2./(w_in.^4 +(4.*lambda^2-2).*omega_zero^2*w_in.^2+omega_zero^4);
w = f.*2.*pi;

lambda = lsqcurvefit(P_psi_omega, lambda, w, pxx./2./pi);

fig2 = figure();
hold on;
plot(w, P_psi_omega(lambda, w));
plot(w, pxx./2./pi);
legend('Theoretical PDS', 'Estimated PDS');
title('Fitted theoretical PSD vs estimated PSD');
ylabel('power s/rad');
xlabel('rad/s');
xlim([0 2])
saveas(fig1,'../figures/2d-fitted_theoretical_PSD_vs_estimated_PSD')