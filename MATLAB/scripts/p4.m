clear all

%% Constants
w_0 = .7823;
lambda = .0827;
T = 85.6697;
K = 0.173945;
sigma = sqrt(0.0015);
K_w = 2*lambda*w_0*sigma;

%% Part B - No Disturbances
A = [0 1; 0 -1/T];
C = [1 0];
B = [0; K/T];

O = obsv(A, C);
rankO = rank(O)

if(min(size(O)) == rank(O))
    fprintf('Observable\n');
else
    fprintf('Not Observable\n');
end

%% Part C - With Current Disturbances
A = [0 1     0; ...
    0 -(1/T) -(K/T); ...
    0 0      0];
B = [0; K/T; 0];
C = [1 0 0];

O = obsv(A, C);
rankO = rank(O)

if(min(size(O)) == rank(O))
    fprintf('Observable\n');
else
    fprintf('Not Observable\n');
end


%% Part D - With Wave Disturbances
A = [0      1             0 0;
     -w_0^2 -2*lambda*w_0 0 0;
     0      0             0 1;
     0      0             0 -(1/T)];
B = [ 0; 0; 0; K/T];
C = [ 0 1 1 0];

O = obsv(A, C);
rankO = rank(O)

if(min(size(O)) == rank(O))
    fprintf('Observable\n');
else
    fprintf('Not Observable\n');
end

%% Part E - With Current and Wave Disturbances
A = [0     1             0 0      0; ...
    -w_0^2 -2*lambda*w_0 0 0      0; ...
    0      0             0 1      0; ...
    0      0             0 -(1/T) -(K/T); ...
    0      0             0 0      0];

B = [ 0; 0; 0; K/T; 0];
E = [0   0; ...
     K_w 0; ...
     0   0; ...
     0   0; ...
     0   1];

C = [ 0 1 1 0 0];

O = obsv(A, C);
rankO = rank(O)

if(min(size(O)) == rank(O))
    fprintf('Observable\n');
else
    fprintf('Not Observable\n');
end