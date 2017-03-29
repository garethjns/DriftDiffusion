classdef multiDD
    
    properties
        params
        mods = cell(1);
        nMods
        decType = 'Mean'
        mags % Individual (modality) decision mags
        RTs % Individual (modality) decision RT (in pts)
        bins % Individual (modality) binary decision 
        conf % Individual decision confidence of modality
        decConfMode = 'Var' % For indv dec, varience or distance
        independentVar = [] %
        threshold = [] % Binary decision threshold
        multiDecType = 'Mean'
        finalDecMag
        finalDecBin
    end
    
    methods
        function obj = multiDD(varargin)
            % Inputs should be (DDMod, DDMod, ..., params)
            % Or (DDModStruct, params)
            params = varargin{end};
            obj.params = params;
            nIn = numel(varargin)-1;
            mods = varargin(1:nIn);
            
            % Set models using set.mods
            obj.mods = mods;
            obj.nMods = numel(obj.mods);
            
            % Set experiment information
            % If independentVar information is supplied, populate and guess
            % binary decision threshold
            if isfield(params, 'independentVar')
                obj.independentVar = params.independentVar;
                obj.threshold = mean(obj.independentVar);
            elseif isfield(params, 'threshold')
                % If a threshold is specified, use that (instead)
                obj.threshold = params.threshold;
            else
                % Assume 0 threshold - or throw error?
                obj.threshold = 0;
            end
            
            % Set remaining params if specified
            fns = {'decType'};
            for f = 1:numel(fns)
                if isfield(params, fns{f})
                    obj.(fns{f}) = params.(fns{f});
                end
            end
            
            % Check all DDs finished
            obj = runAll(obj);
            % Get their results
            obj = makeIndividualDecisions(obj);
            % Make decision
            [obj.finalDecMag, obj.finalDecBin] = makeOverallDecision(obj);
            
        end
        
        function obj = runAll(obj)
            % For each modality
            for n = 1:obj.nMods
                % Get mod
                m = obj.mods{n};
                % Check finished
                if ~m.finished
                    % If not, run to completion
                    m.contPlot = 0;
                    m = m.run();
                end
                obj.mods{n} = m;
            end
        end
        
        function obj = set.mods(obj, mods)
            if isa(mods, 'struct')
                mods = struct2cell(mods);
            end
            nM = numel(mods);
            
            % Check for and remove empty models
            keep = false(1, nM);
            for m = 1:numel(mod)
                keep(m) = ~isempty(mods{m})
            end
            
            obj.mods = mods;
            
        end
        
        function obj = makeIndividualDecisions(obj)
            % Collect and assess individual decisions
            decs = NaN(1, obj.nMods);
            RT = decs;
            bin = decs;
            con = decs;
            for n = 1:obj.nMods
                decs(n) = obj.mods{n}.output(end);
                RT(n) = obj.mods{n}.decMadeAt;
                bin(n) = decs(n) > obj.threshold;
                
                % Decision confidence
                switch obj.decConfMode
                    case {'Var', 'Variance'} % SD
                        % Overall varibaility of accumulator value
                        % NB: More events will have more variability
                        con(n) = 1/std(obj.mods{n}.output);
                    case {'Dist', 'Distance'}
                        % Distance from binary decision threshold
                        con(n) = decs(n) - obj.threshold;
                end
            end
            obj.mags = decs;
            obj.RTs = RT;
            % The uni-modality decision
            obj.bins = bin;
            % Normalise modality confidence
            obj.conf = con;
        end
        
        function [finalDecMag, finalDecBin] = makeOverallDecision(obj)
            % Using the information from the available modalities, make a
            % overall, multisensory, decision
            switch obj.multiDecType
                case {'Max', 'max'} 
                    % Go with max (abs) mag
                case {'weightedMean'}
                    % Mean of mags, weighted by confidence
                case {'Mode', 'mode'}
                    % Mode of unimodal binary decisions - perhaps best for
                    % nMods>2?
                otherwise % Use mean (default)
                    % Mean of mags, greater than threshold?
                    mm = mean(obj.mags);
                    finalDecMag = mm;
                    finalDecBin = mm>obj.threshold;
            end
        end
    end
    
    methods (Static)
        
    end
end