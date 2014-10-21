function fcn_export(handles)
% Saves the temporary processed data .mat file in custom directory with
% custom name.

%% Open save dialog
FilterSpec = '*.mat';
DialogTitle = 'Export Data Set';
[FileName,PathName,FilterIndex] = uiputfile(FilterSpec,DialogTitle);

%% Make filepath
filePath = [PathName, FileName];

%% Load file
% Original file
fileNameOriginal = handles.options.fileNamePrData;
% Load *.mat file
dataSet = load(fileNameOriginal);

%% Save file
save(filePath,'dataSet');

end