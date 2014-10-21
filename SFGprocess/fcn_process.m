function fcn_process(handles)
% Process raw data

% Get name of data file
fileName = handles.options.fileNameRawData;
% Load *.mat file
matFile = load(fileName);
% Get variable names from matfile
varNames = fieldnames(matFile);

% Loop through every raw data set
for i=1:length(varNames)
    % Get name of original file
    name = eval(['matFile.',varNames{i},'.name']);
    
    % Get wavelength data
    wavelengthData = eval(['matFile.',varNames{i},'.wavelength']);
    % Get signal data
    signalData = eval(['matFile.',varNames{i},'.signal']);
    
    %% Processing
    %% 1st step: Multiply signal data by (-1)
    signalData = signalData*(-1);
    
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
    % Write
    eval([varNames{i},'.name = name']);
    eval([varNames{i},'.wavelength = wlDataPr']);
    eval([varNames{i},'.wavenumber = wavenumber']);
    eval([varNames{i},'.signal = sigDataPr']);
    eval([varNames{i},'.stepSize = stepSize']);
    eval([varNames{i},'.shotsPerAvg = shotsPerWL']);
    
    %% Redefine structure for FID
    if handles.options.FID == true
        % Set delay field
        eval([varNames{i},'.delay = wlDataPr']);
        % Remove wavelength and wavenumber fields
        fields = {'wavelength','wavenumber'};
        eval([varNames{i}, '= rmfield(',varNames{i},',fields)']);
        
        % Call FID process function
        FID = eval(varNames{i});
        fcn_processFID(handles,FID)
    end
    
    %% Store data in file
    % Check if file exists
    if exist(handles.options.fileNamePrData,'file') == 2
        save(handles.options.fileNamePrData,varNames{i},'-append')
    else
        save(handles.options.fileNamePrData,varNames{i})
    end
    
end

%% Update processed data listbox
% Get actual file names of raw data
namesPrData = cell(1,length(varNames));
for k=1:length(varNames)
    namesPrData{k} = eval(['matFile.',varNames{k},'.name']);
end
set(handles.listbox_processedData,'String',namesPrData)


end