function P = PSD_psi_omega(w, lambda, sigma_squared, omega_zero)

P = @(w) 4.*lambda^2.*omega_zero^2.*sigma_squared.*w.^2./(w.^4 +(4.*lambda^2-2).*omega_zero^2*w.^2+omega_zero^4);
end

