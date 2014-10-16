function fcn_showData(handles,fileName)
% Show raw data in axes

% Get value of selected data
idx = handles.options.idx;
% Load *.mat file
matFile = load(fileName);
% Get variable names from matfile
varNames = fieldnames(matFile);
% Get wavelength data
xData = eval(['matFile.',varNames{idx},'.wavelength']);
% Get signal data
yData = eval(['matFile.',varNames{idx},'.signal']);

% Plot data
plot(handles.axes_preview,xData,yData,handles.options.style)

end