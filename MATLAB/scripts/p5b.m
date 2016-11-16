%% Initialize
addpath ../
addpath ../models/

%% Run simulation
sim('ship_p5b.mdl');

%% Get variance of compass values
variance = var(compass)