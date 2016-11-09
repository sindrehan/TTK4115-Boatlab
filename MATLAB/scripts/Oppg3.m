T = 85.6697;
K = 0.173945;

K_pd = 0.8;
T_d = T;
alpha = 0.1;
T_f = alpha*T_d;

s = tf('s');

H_ship = tf(K,[T 1 0]);
H_pd = tf([K_pd*T_d K_pd], [T_f 1]);

H = H_ship*H_pd;
bode(H);
margin(H);