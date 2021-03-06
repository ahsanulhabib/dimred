% DEMSTICKDNET1 Model the stick man using an GTM 10x10 grid.

% DIMRED

% Fix seeds
randn('seed', 1e5);
rand('seed', 1e5);

dataSetName = 'stick';
experimentNo = 1;

% load data
[Y, lbls] = lvmLoadData(dataSetName);

% Set up model
options = dnetOptions('rbf', [10, 10]);

latentDim = 2;
d = size(Y, 2);
model = dnetCreate(latentDim, d, Y, options);

% Optimise the model.
iters = 1000;
display = 3;

model = dnetOptimise(model, display, iters);

% Save the results.
modelWriteResult(model, dataSetName, experimentNo);

if exist('printDiagram') & printDiagram
  lvmPrintPlot(model, lbls, dataSetName, experimentNo);
end

% load connectivity matrix
[void, connect] = mocapLoadTextData('run1');
% Load the results and display dynamically.
lvmResultsDynamic(model.type, dataSetName, experimentNo, 'stick', connect)

