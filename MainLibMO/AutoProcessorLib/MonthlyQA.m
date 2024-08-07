classdef MonthlyQA
    
    %{ Class for defining monthly QA object for different Sequences.The manin 
    % main main fucntion is to define objects for different sequences.
    %}
  

    properties(Access=private)
        
       configFile
    end
    
    methods
        
        % constructor
        function  self=MonthlyQA(configFile)
        
        
             self.configFile=configFile;
    
        end 
        
        % autoRun the main function for Sequence objects.
        
        
        function autoRun(self)
            
            
            tmpConfigFile=self.configFile;
            
            autoMonthlyQAProcessorSingleConfigFileMO(tmpConfigFile)

            
        end 
    end
    
end

