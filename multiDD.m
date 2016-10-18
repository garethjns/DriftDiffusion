classdef multiDD
   
    properties
        params
        mods
        nMods
    end
    
    methods
        function obj = multiDD(varargin)
            % Inputs should be (DDMod, DDMod, ..., params)
            obj.params = varargin{end};
            nIn = numel(varargin)-1;
            % Collect models
            for n = 1:nIn
               obj.mods.(['mod' , num2str(n)]) = varargin{n};
            end
            obj.nMods = nIn;
            
            obj = runAll(obj);
        end
        
        function obj = runAll(obj)
            % For each modality
            for n = 1:obj.nMods
                mStr = ['mod', num2str(n)];
                % Get mod
                m = obj.(mStr);
                % Check finished
                if ~m.finished
                    % If not, run to completion
                    m.plotOn = 0;
                    m = m.run();
                end
                obj.(mStr) = m;
            end
            
        end
        
        function dec = lateDec(mod)
            % Combine modality final decisions
            
        end
        
    end
    
end