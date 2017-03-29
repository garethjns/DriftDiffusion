classdef Experiments
   
    properties
    end
    methods
    end
    methods (Static)
        [y, yErr] = basicExperiment(rates, n, modalities)
        [y, yErr] = basicUnbalancedExperiment(rates, n, modalities)
        [y, yErr] = BBUnbalancedExperiment(rates, n, modalities)
    end
end
