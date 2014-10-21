function fcn_showData(handles,fileName)
% Show raw data in axes

% Get value of selected data
idx = handles.options.idx;
% Load *.mat file
matFile = load(fileName);
% Get variable names from matfile
varNames = fieldnames(matFile);
% Get wavelength data
if isfield(eval(['matFile.',varNames{idx}]),'wavelength')
    % For SFS
    if get(handles.radio_wn,'Value') == 1
        % Get wavenumber data
        xData = eval(['matFile.',varNames{idx},'.wavenumber']);
    elseif get(handles.radio_wl,'Value') == 1
        % Get wavelength data
        xData = eval(['matFile.',varNames{idx},'.wavelength']);
    end
elseif isfield(eval(['matFile.',varNames{idx}]),'delay')
    % For FIDs
    xData = eval(['matFile.',varNames{idx},'.delay']);
else
    % Error dialog
    errordlg('No x-data found.')
end
% Get signal data
yData = eval(['matFile.',varNames{idx},'.signal']);

% Plot data
plot(handles.axes_preview,xData,yData,handles.options.style)

end