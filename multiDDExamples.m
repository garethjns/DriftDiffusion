%% MultiDD
% Create a multisensory decision based on unisensory accumulators


params.treshold = 10;

mods.DD1 = DD1;
mods.DD2 = DD2;

multiDD(mods, params)

%% Run basic multisensory experiment
% 1 stimulus per modality
% 2 Modalities

n = 25;
rates = [6, 7, 8, 9, 10, 11, 12, 13];
modalities  = 3; % 1 = "Auditory", 2 = "visual", 3 = AV
[y, yErr] = basicExperiment(rates, n, modalities);


%% Run basic uni and multi-sensory experiment

n = 500;
rates = [6, 7, 8, 9, 10, 11, 12, 13];
modalities  = [1, 2, 3]; % 1 = "Auditory", 2 = "visual", 3 = AV
[y, yErr] = basicExperiment(rates, n, modalities);
