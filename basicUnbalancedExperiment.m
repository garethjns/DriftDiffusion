function [y, yErr] = basicUnbalancedExperiment(rates, n, modalities)


nRates = numel(rates);
nMods = numel(modalities);

stimLength = 1000;

% General DD params
paramsDD.contPlot = 1;
paramsDD.plotSpeed = 20;
paramsDD.aMu = 0;
paramsDD.aLam = 1;
paramsDD.fig = [];
paramsDD.model = 'Delta1D';
paramsDD.its = stimLength;

% "Fast" response, n x rate
data = NaN(n, nRates, nMods);
for m = 1:nMods
    for r = 1:nRates
        for rep = 1:n
            
            if modalities(m) == 1 || modalities(m) == 3
                % Create DD model for "auditory"
                % Generate delta
                stim1.delta1 = zeros(1, stimLength);
                % Add events
                stim1.delta1(randi(stimLength,1,rates(r))) = 1;
                % Create
                params1 = paramsDD;
                params1.aSig = 0.1;
                DD1 = DD(params1, stim1);
            else
                DD1 = [];
            end
            
            if modalities(m) == 2 || modalities(m) == 3
                % Create DD model for "visual"
                stim2.delta1 = zeros(1, stimLength);
                % Add events
                stim2.delta1(randi(stimLength,1,rates(r))) = 1;
                % Create
                params2 = paramsDD;
                params2.aSig = 0.2;
                DD2 = DD(params2, stim2);
            else
                DD2 = [];
            end
            
            % Create multisensory decision
            % (Or unisensory if one modality is empty)
            paramsM.independentVar = rates;
            DDMulti = multiDD(DD1, DD2, paramsM);
            
            % Save binary decision
            data(rep, r, m) = DDMulti.finalDecBin;
        end
    end
end

% Proportion of "fast" responses vs rate
y = sum(data)/n;
yErr = std(data)/sqrt(n);


%% Plot
figure
hold on
hPlot = gobjects(1, nMods);
for m = 1:nMods
    
    SPs = [0.35, 0.35, inf, inf;
        0.01, 0.01, 7.5, 1;
        0, 0, 0, 0];
    [ffit, curve] = fitPsycheCurveWH(rates, y(:,:,m), SPs);
    hPlot(m) = plot(curve(:,1), curve(:,2));
    hSc = scatter(rates, y(:,:,m));
    hSc.MarkerEdgeColor = hPlot(m).Color;
    errorbar(rates, y(:,:,m), yErr(:,:,m), ...
        'LineStyle', 'none', 'color', hPlot(m).Color)
end

legText = {'Auditory', 'Visual', 'Multisensory'};
legText = legText(modalities);

axis([min(rates)-1, max(rates)+1, 0, 1])
legend(hPlot, legText)
xlabel('Stimulus rate')
ylabel('Proportion of "fast" responses')
