close all 
clear

% Set max number of iterations
its = 300;

% f1 = figure;
% f2 = figure;

%% Run accumulator 1
% Sensory information in two directions
% Accumulator noise (no sensory noise)
% Linearly decaying decision bounds

% Params
params1.model = 'Delta2D'; % Accumulator model
params1.plotSpeed = 5; % Plot every x iterations
params1.its = its;
params1.aSig = 0.25; % Accumulator noise magnitude
params1.aMu = 0;  % Accumulator noise bias
params1.aLam = 1; % Autoregressive parameter (0<1, accumulator becomes leaky)
params1.fig = figure;
% params1.decBoundMode = 'SE';
% params1.decBoundSEMulti = 2000;
% params1.decBoundMode = 'Static';
params1.decBound = 50; % Initial decision bound magnitude
% The decision bounds in this example decay linearlly, which can be
% specified with .decBoundMode = 'Linear'. However, below is an example of
% doing the same thing by specifying a custom function.
params1.decBoundMode = 'Custom';
params1.decFunc = @(dbs,dbe,its,it) ...
    dbs - it*((dbs-dbe)/(its-1));
params1.decFuncParams = [params1.decBound, 0, its];

% Stims
% Generate random stimuli
stim1.delta1 = rand(1,its)>0.88; 
stim1.delta2 = 0 - (rand(1,its)>0.99);

% Create object
DD1 = DD(params1, stim1);
% Run object
DD1 = DD1.run();


%% Run accumulator 2
% Sensory information in two directions
% Accumulator noise (no sensory noise)
% Decision bounds vary depending on accumulator noise

% Params
params2.model = 'Delta2D';
params2.plotSpeed = 5;
params2.its = its;
params2.aSig = 0.1;
params2.aMu = 0;
params2.aLam = 1;
params2.fig = figure;
params2.decBoundMode = 'SE';
params2.decBoundSEMulti = 1000;

% Stims
stim2.delta1 = rand(1,its)>0.87;
stim2.delta2 = 0-(rand(1,its)>0.99);

% Create object
DD2 = DD(params2, stim2);
% Run objec
DD2 = DD2.run(its);

%% Plot together
% Two DD objects can be plotted together

DD1.plotDD2(DD2)


%% Run accumulator 3
% Sensory information in two directions
% Accumulator noise (no sensory noise)
% No decision bounds

clear params3
% Params
params3.model = 'Delta2D';
params3.plotSpeed = 5;
params3.its = its;
params3.aSig = 0.1;
params3.aMu = 0;
params3.aLam = 1;
params3.fig = figure;

% Stims
stim3.delta1 = rand(1,its)>0.87;
stim3.delta2 = 0-(rand(1,its)>0.99);

% Create object
DD3 = DD(params3, stim3);
% Run objec
DD3 = DD3.run(its);

%% Run accumulator 4
% Sensory information in two directions
% Accumulator noise (no sensory noise)
% No decision bounds

clear params4

% Params
params4.model = 'Delta2D';
params4.plotSpeed = 5;
params4.its = its;
params4.aSig = 0.1;
params4.aMu = 0;
params4.aLam = 1;
params4.fig = figure;
% params4.decBoundMode = 'SE';
% params4.decBoundSEMulti = 1000;
% params2.decBoundMode = 'Static';
% params2.decBound = 20;
% params2.decBoundMode = 'LinearDecay';
% params2.decBound = 200;

% Stims
stim4.delta1 = rand(1,its)>0.87;
stim4.delta2 = 0-(rand(1,its)>0.99);

% Create object
DD4 = DD(params4, stim4);
% Run objec
DD4 = DD4.run(its);

%% Plot together

DD3.plotDD2(DD4)


%% Run accumulator 5 - Robust
% Stimulus in one direction
% Brunton 2013 model, without adaptaion
% No decision bounds
% Adds robustness to accumulator

% Params
params5.model = 'BB1D';
params5.plotSpeed = 5;
params5.its = its;
params5.aSig = 0.01;
params5.sMu = 1;
params5.sSig = 1;
params5.aMu = 0;
params5.aLam = 1;
params5.fig = figure;

params5.decBoundMode = 'Off';

% params5.robust = 'Off'
params5.robust = 'Threshold';
params5.robustOpts.thresh = 0.6;

% Stims
stim5.delta1 = rand(1,its)>0.88; 

% Create object
DD5 = DD(params5, stim5);
% Run object
DD5 = DD5.run();
