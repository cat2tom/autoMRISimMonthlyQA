
% specifiy the SE configuration file

configFileSE='C:\autoMRISimQAResource\dirsConfigFile\examplemMO.ini';

% create monthlyQA obj

monthlyObjSE=MonthlyQA(configFileSE);

% call autoRun

monthlyObjSE.autoRun();
