function fcn_displayInfo(handles)

% Get index of selected data
index = handles.options.idx;

% Get processed data
h = handles.figure1;
dataSet = getappdata(h,'processedDataSet');

% Get Info Data
name = dataSet(index).name;
minWL = min(dataSet(index).wavelength);
maxWL = max(dataSet(index).wavelength);
minWN = min(dataSet(index).wavenumber);
maxWN = max(dataSet(index).wavenumber);
shotsPerAvg = dataSet(index).shotsPerAvg;
stepSize = dataSet(index).stepSize;
signalAmp = dataSet(index).signalAmp;
parentFolder = dataSet(index).parentFolder;

% Display Info
infoStr = sprintf('Name: %s\nminWL: %g  maxWL: %g\nminWN: %g  maxWN: %g\nSPAvg: %g\nStepSize: %g\nSigAmp: %g\nParentDir: %s',...
    name,minWL,maxWL,minWN,maxWN,shotsPerAvg,stepSize,signalAmp,parentFolder);
set(handles.text_dataInfo,'String',infoStr)

end