omega_zero = 0.7823;
lambda = 0.0827;
sigma = sqrt(0.0015);
K_omega = 2*lambda*omega_zero*sigma;
T = 85.6697;
K = 0.173945;

F_s = 10;
T_s = 1/F_s;

A = [0 1 0 0 0 ; -omega_zero^2 -2*lambda*omega_zero 0 0 0 ; 0 0 0 1 0 ; 0 0 0 -1/T -K/T; 0 0 0 0 0];
B = [ 0 ; 0 ; 0 ; K/T ; 0 ];
E = [ 0 0 ; K_omega 0 ; 0 0 ; 0 0 ; 0 1];

Q_w = [30 0 ; 0 10^-6];

M = exp([A E*Q_w*transpose(E) ; zeros(size(A))  -transpose(A)]*T_s);
N = exp([A B ; zeros(size(transpose(B))) zeros(min(size(B)))]*T_s);

[A_d B_d] = c2d(A, B, T_s);