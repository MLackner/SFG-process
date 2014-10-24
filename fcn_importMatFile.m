function fcn_importMatFile(handles)

[file,fileName] = fcn_loadFile('*.mat','Select Data Set');
% Store Data
h = handles.figure1;
fileFldName = fieldnames(file);
dataSet = file.(fileFldName{1});
setappdata(h,'processedDataSet',dataSet)
% Write Data Names in listbox
dataNames = cell(1,length(dataSet));
for i=1:length(dataSet)
    dataNames{i} = dataSet(i).name;
end
set(handles.listbox_processedData,'String',dataNames)

end

function [file,FileName] = fcn_loadFile(fileType,dlgName)
% Loads a file with an open file dialog

%% Open load file Dialog
% Open Dialog
[FileName,PathName,FilterIndex] = uigetfile(fileType,dlgName);

% Return if no file was selected
if FileName == 0
    file = 'None';
    return
end

%% Load Selected File if it isn't a *.txt file
if strcmp(fileType,'*.txt') == 0
    file = load([PathName FileName]);
else
    file = [PathName FileName];
end

end