function fcn_load(handles)
% Returns path to selected file or folder

% Start timer
tic

%% Get files
% Open dialog
[fileName,pathName,~] = uigetfile('*.itx','Select files',...
    'MultiSelect','on'); % Returns fileName as cell array (if multiple)
% Convert string to array
if iscell(fileName)==false
    fileName = cellstr(fileName);
end
% Make Filepaths
filePath = cell(1,length(fileName));
for i=1:length(fileName)
    filePath{i} = [pathName,fileName{i}];
end

% Output
formatSpec = 'Importing %i files:\n';
fprintf(formatSpec,length(fileName))
for i=1:length(fileName)
    formatSpec = '\t%s\n';
    fprintf(formatSpec,fileName{i});
end

% Init waitbar progress
progress = 0;
waitBar = waitbar(progress,...
    ['Importing ',num2str(length(fileName)),' files...']);
% Call import function for every selected file
for i=1:length(filePath)
    % Call import function
    newData = itximport(filePath{i},'struct');
    
    %% Write data in structure
    % Name
    [~,name,~] = fileparts(filePath{i});
    newData.name = name;
    % Wavelength
    newData.wavelength = newData.WLOPG;
    % Signal
    newData.signal = newData.SigOsc1;
    % Parent directory
    [~, parentFolder, ~] = fileparts(fileparts(filePath{i}));
    newData.parentFolder = parentFolder;
    
    %% Store data in app
    % Get Figure handle
    h = handles.figure1;
    % Check if there is already raw data stored
    if isappdata(h,'rawDataSet') == true
        % Exists
        % Add new data to already existing data
        oldData = getappdata(h,'rawDataSet');
        newData = [oldData;newData];
    end
    % Store merged Data/ first data set in app
    setappdata(h,'rawDataSet',newData)
    
    % Update waitbar
    progress = i/length(filePath);
    waitbar(progress);
end
% Close waitbar
close(waitBar)

%% Update raw data listbox
% This part converts a comma seperated list to a cell array with the names
% of the original data files

% Get app data
h = handles.figure1;
rawDataSet = getappdata(h,'rawDataSet');
% Create Cell array with names
namesRawData = cell(1,length(rawDataSet));
for i=1:length(rawDataSet)
    namesRawData{i} = rawDataSet(i).name;
end
% Set listbox entries
set(handles.listbox_rawData,    'String',   namesRawData)
set(handles.listbox_rawData,    'Value',    1)

%Stop timer
duration = toc;
%Output
formatSpec = 'Import successful. Duration: %g seconds.\n';
fprintf(formatSpec,round(duration))

end
