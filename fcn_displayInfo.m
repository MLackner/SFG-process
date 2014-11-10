function fcn_displayInfo(handles)

% Get index of selected data
index = handles.options.idx;

% Get processed data
h = handles.figure1;
dataSet = getappdata(h,'processedDataSet');

if length(index) > 1
    % If multiple data is selected
    infoStr = sprintf('Multiple data sets selected');
else
    % Get Info Data
    name = dataSet(index).name;
    minWL = min(dataSet(index).wavelength);
    maxWL = max(dataSet(index).wavelength);
    minWN = min(dataSet(index).wavenumber);
    maxWN = max(dataSet(index).wavenumber);
    shotsPerAvg = dataSet(index).shotsPerAvg;
    stepSize = dataSet(index).stepSize;
    signalAmp = dataSet(index).signalAmp;
    % Offset
    if isfield(dataSet(index),'offset')
        % If field exists
        offset = dataSet(index).offset;
    else
        % If field doesn't exist
        offset = nan;
    end
    parentFolder = dataSet(index).parentFolder;
        
    % Display Info
    infoStr = sprintf('Name: %s\nminWL: %g        maxWL: %g\nminWN: %g     maxWN: %g\nSPAvg: %g\nStepSize: %g\nSigAmp: %g\nOffset: %g\nParentDir: %s',...
        name,minWL,maxWL,minWN,maxWN,shotsPerAvg,stepSize,signalAmp,offset,parentFolder);
end

% Set info string
set(handles.text_dataInfo,'String',infoStr)

end