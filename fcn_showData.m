function fcn_showData(handles,dataName)
% Show raw data in axes

% Get value of selected data
idx = handles.options.idx;
% Get app data
h = handles.figure1;
dataSet = getappdata(h,dataName);

% Get wavelength data
if isfield(dataSet,'wavelength')
    % For SFS
    if get(handles.radio_wn,'Value') == 1
        % Get wavenumber data
        xData = dataSet(idx).wavenumber;
    elseif get(handles.radio_wl,'Value') == 1
        % Get wavelength data
        xData = dataSet(idx).wavelength;
    end
elseif isfield(dataSet,'delay')
    % For FIDs
    xData = dataSet(idx).delay;
else
    % Error dialog
    errordlg('No x-data found.')
end
% Get signal data
yData = dataSet(idx).signal;

% Plot data
plot(handles.axes_preview,xData,yData,handles.options.style)

end