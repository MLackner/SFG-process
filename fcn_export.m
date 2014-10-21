function fcn_export(handles)
% Saves the temporary processed data .mat file in custom directory with
% custom name.

%% Open save dialog
FilterSpec = '*.mat';
DialogTitle = 'Export Data Set';
[FileName,PathName,FilterIndex] = uiputfile(FilterSpec,DialogTitle);

%% Make filepath
filePath = [PathName, FileName];

%% Get data
h = handles.figure1;
dataSet = getappdata(h,'processedDataSet');

%% Save file
save(filePath,'dataSet');

end