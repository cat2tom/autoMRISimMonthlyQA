
%{
This is the main program for autoMonthlyMRIQA using OOP technique. For
each sequence, there is a configuration file.So an object was defined. 
This is modular design which can be added to the main program by adding new
module and new functionality.
%}

%% read main configure files and get configue file for each sequense.

mainConfigMonthlyQA='C:\autoMRISimQAResource\dirsConfigFile\monthlyQAConfigMain.ini';

mainConfigs=readMainConfigFileMO(mainConfigMonthlyQA);

% configFileSE=mainConfigs{1}; % specify the SE configration file



%% SE section
configFileSE=mainConfigs{1}; % specify the SE configration file
monthlyObjSE=MonthlyQA(configFileSE);% create SE object

monthlyObjSE.autoRun(); % call autoRun to start autoQA process.

%% GE section.

configFileGE=mainConfigs{2};

monthlyObjGE=MonthlyQA(configFileGE);% create SE object

monthlyObjGE.autoRun(); % call autoRun to start autoQAProcess.

%% Dixon section


configFileDIXON=mainConfigs{3};
monthlyObjDIXON=MonthlyQA(configFileDIXON);
monthlyObjDIXON.autoRun();

%% UTE section

configFileUTE=mainConfigs{4};

monthlyObjUTE=MonthlyQA(configFileUTE);

monthlyObjUTE.autoRun();



    
  