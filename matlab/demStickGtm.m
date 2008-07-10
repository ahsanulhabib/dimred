% DEMSTICKGTM1 Model the stick man using an GTM

% DIMRED

% Fix seeds
randn('seed', 1e5);
rand('seed', 1e5);

dataSetName = 'stick';
experimentNo = 1;

% load data
[Y, lbls] = lvmLoadData(dataSetName);

% Set up model
% Train using the full training conditional (i.e. no approximation.)
options = dnetOptions('gtm');
latentDim = 2;

d = size(Y, 2);
model = dnetCreate(latentDim, d, Y, options);

% Optimise the model.
iters = 1000;
display = 1;

model = dnetOptimise(model, display, iters);

% Save the results.
capName = dataSetName;;
capName(1) = upper(capName(1));
save(['dem' capName 'Gtm' num2str(experimentNo) '.mat'], 'model');

if exist('printDiagram') & printDiagram
  fgplvmPrintPlot(model, lbls, capName, experimentNo);
end

% load connectivity matrix
[void, connect] = mocapLoadTextData('run1');
% Load the results and display dynamically.
fgplvmResultsDynamic(dataSetName, experimentNo, 'stick', connect)

