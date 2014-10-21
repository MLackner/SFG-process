function fcn_load(handles)
% Returns path to selected file or folder

%% Get files
% Open dialog
[fileName,pathName,filterIndex] = uigetfile('*.itx','Select files',...
    'MultiSelect','on') % Returns fileName as cell array (if multiple)
% Convert string to array
if iscell(fileName)==false
    fileName = cellstr(fileName)
end
% Make Filepaths
filePath = cell(1,length(fileName));
for i=1:length(fileName)
    filePath{i} = [pathName,fileName{i}]
end

% Init waitbar progress
progress = 0;
waitBar = waitbar(progress,...
    ['Importing ',num2str(length(fileName)),' files...']);
% Call import function for every selected file
for i=1:length(filePath)
    % Call import function
    fcn_itxImport(handles,filePath{i});
    % Update waitbar
    progress = i/length(filePath);
    waitbar(progress);
end
% Close waitbar
close(waitBar)

%% Update raw data listbox
% Load *.mat file
matFile = load(handles.options.fileNameRawData);
% Get variable names from matfile
varNames = fieldnames(matFile);
% Get actual file names of raw data
namesRawData = cell(1,length(varNames));
for i=1:length(varNames)
    namesRawData{i} = eval(['matFile.',varNames{i},'.name']);
end
set(handles.listbox_rawData,'String',namesRawData)
set(handles.listbox_rawData,'Value',1)

end
