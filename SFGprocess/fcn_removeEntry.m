function fcn_removeEntry(handles)
% Removes an entry from the list of processed data

%% Open and read temporary *.mat file
% Get name of temporary data file
fileName = handles.options.fileNamePrData;
% Load *.mat file
matFile = load(fileName);
% Get variable names from matfile
varNames = fieldnames(matFile);
% Get selected index
idx = get(handles.listbox_processedData,'Value');
% Get variable name
varName = varNames{idx};
% Call remove function
fcn_rmvar(fileName,varName);

%% Update processed data listbox
% Load *.mat file
matFile = load(fileName);
% Get variable names from matfile
varNames = fieldnames(matFile);
% Get actual file names of raw data
namesPrData = cell(1,length(varNames));
for k=1:length(varNames)
    namesPrData{k} = eval(['matFile.',varNames{k},'.name']);
end
set(handles.listbox_processedData,'String',namesPrData,'Value',(idx-1))

end