%% MultiDD
% Create a multisensory decision based on unisensory accumulators
% Uses

its = 300;

params.treshold = 10;

clear mods
close all force

% Create individual models using template
stim1.delta1 = rand(1,its)>0.88; 
stim1.delta2 = 0 - (rand(1,its)>0.99);
stim2.delta1 = rand(1,its)>0.75; 
stim2.delta2 = 0 - (rand(1,its)>0.80);
params.template = 'Delta2D_CustomLin';

mods.DD1 = DD(params, stim1);
mods.DD2 = DD(params, stim2);
% Or
% mods = {DD(params, stim1), DD(params, stim2)};

% Create multiseosnry model
% (and run to deicsion)
mulMod = MultiDD(mods, params);

% Print available methods
methodsview(mulMod);
% No plot methods yet. Print decision.
display(mulMod)


%% Run basic multisensory experiment
% 1 stimulus per modality
% 2 Modalities

n = 25;
rates = [6, 7, 8, 9, 10, 11, 12, 13];
modalities  = 3; % 3 = AV
[y, yErr] = Experiments.basicExperiment(rates, n, modalities);


%% Run basic uni and multi-sensory experiment
% Run experiment as above but also with uni sensory modalities

n = 500;
rates = [6, 7, 8, 9, 10, 11, 12, 13];
modalities  = [1, 2, 3]; % 1 = "Auditory", 2 = "visual", 3 = AV
[y, yErr] = Experiments.basicExperiment(rates, n, modalities);


%% Run unbalanced, basic uni and multi-sensory experiment 
% Run experiment as above but with More noise on "visual" modality (than
% "auditory" modality)

n = 500;
rates = [6, 7, 8, 9, 10, 11, 12, 13];
modalities  = [1, 2, 3]; % 1 = "Auditory", 2 = "visual", 3 = AV
[y, yErr] = Experiments.basicUnbalancedExperiment(rates, n, modalities);


%% Run BB uni and multi-sensory experiment - not working yet
% More noise on "visual" modality

n = 500;
rates = [6, 7, 8, 9, 10, 11, 12, 13];
modalities  = [1, 2, 3]; % 1 = "Auditory", 2 = "visual", 3 = AV
[y, yErr] = Experiments.BBExperiment(rates, n, modalities);


%% Run unbalanced, BB uni and multi-sensory experiment - not working yet
% More noise on "visual" modality

n = 100;
rates = [6, 7, 8, 9, 10, 11, 12, 13];
modalities  = [1, 2, 3]; % 1 = "Auditory", 2 = "visual", 3 = AV
[y, yErr] = Experiments.BBExperiment(rates, n, modalities);