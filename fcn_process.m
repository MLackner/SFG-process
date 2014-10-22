function fcn_process(handles)
% Process raw data

fprintf('___________________________\n')
fprintf('Start Processing...\n\n')
% Get raw data
h = handles.figure1;
rawDataSet = getappdata(h,'rawDataSet');

% Loop through every raw data set
for i=1:length(rawDataSet)
    % Get name of original file
    name = rawDataSet(i).name;
    fprintf('(%g/%g)Processing %s\n', i, length(rawDataSet), name)
    % Get wavelength data
    wavelengthData = rawDataSet(i).wavelength;
    % Get signal data
    signalData = rawDataSet(i).signal;
    
    %% Processing
    %% 1st step: Multiply signal data by (-1)
    signalData = signalData*(-1)*handles.options.signalAmplifier;
    
    %% 2nd step: Take all signal data points for one wavelength and average them
    % Count shots per wavelength
    shotsPerWL = 1;
    for k=1:length(wavelengthData)
        if wavelengthData(k+1) == wavelengthData(k)
            shotsPerWL = shotsPerWL + 1;
        else
            break
        end
    end
    
    % Get length of raw data
    lengthRD = length(wavelengthData);
    % Determine length of processed data
    lengthPD = lengthRD/shotsPerWL;
    
    % Get step size
    % Get minimum WL
    minWL = min(wavelengthData);
    % Get maximum WL
    maxWL = max(wavelengthData);
    % Total wavelength range
    rangeWL = maxWL - minWL;
    % Step size
    stepSize = rangeWL/(lengthPD - 1);
    
    % Make array for processed Wavelength data
    wlDataPr = minWL:stepSize:maxWL;
    % Make empty array for processed signal data
    sigDataPr = zeros(1,length(wlDataPr));
    
    % Loop through every wavelength
    for j=1:length(wlDataPr)
        % Get range of signal data
        signalDataRangeLower = ((j-1)*shotsPerWL) + 1;
        signalDataRangeUpper = signalDataRangeLower + shotsPerWL - 1;
        % Get average of signalData
        sigDataPr(j) =...
            mean(signalData(signalDataRangeLower:signalDataRangeUpper));
    end
    
    %% Calculate wavenumbers
    wavenumber = 1e7./wlDataPr;
    
    %% Define structure of processed data
    % Write new data
    newData = struct(...
        'name',name,...
        'wavelength',wlDataPr,...
        'wavenumber',wavenumber,...
        'signal',sigDataPr,...
        'stepSize',stepSize,...
        'shotsPerAvg',shotsPerWL,...
        'signalAmp',handles.options.signalAmplifier,...
        'parentFolder',rawDataSet(i).parentFolder);
    
    %% Redefine structure for FID
    if handles.options.FID == true
        % Set delay field
        newData.delay = wlDataPr;
        % Remove wavelength and wavenumber fields
        fields = {'wavelength','wavenumber'};
        newData = rmfield(newData,fields);
        
        % Call FID process function
        FID = newData;
        fcn_processFID(handles,FID)
    end
    
    %% Store data in app
    % Get Figure handle
    h = handles.figure1;
    % Check if there is already raw data stored
    if isappdata(h,'processedDataSet') == true
        % Exists
        % Add new data to already existing data
        oldData = getappdata(h,'processedDataSet');
        % Check if there is already a data set with the same name as the
        % current data set (newData)
        for k=1:length(oldData)
            strOne = oldData(k).name;
            strTwo = newData.name;
            if strcmp(strOne,strTwo)
                % Overwrite that one
                oldData(k) = newData;
                % Make new data empty
                newData = [];
                fprintf('!!!Overwrote %s!!!\n',oldData(k).name)
                % Escape out of for loop
                break
            end
        end
        saveData = [oldData;newData];
    else
        saveData = newData;
    end
    % Store merged Data/ first data set in app
    setappdata(h,'processedDataSet',saveData)
    
end



%% Update processed data listbox
% This part converts a comma seperated list to a cell array with the names
% of the original data files

% Get app data
h = handles.figure1;
processedDataSet = getappdata(h,'processedDataSet');
% Create Cell array with names
namesProcessedData = cell(1,length(processedDataSet));
for i=1:length(processedDataSet)
    namesProcessedData{i} = processedDataSet(i).name;
end
% Set listbox entries
set(handles.listbox_processedData,'String',namesProcessedData)
set(handles.listbox_processedData,'Value',1)

fprintf('\nDone.\n')
fprintf('___________________________\n\n')

end