function fcn_showData(handles,dataName)
% Show raw data in axes

% Get value of selected data
index = handles.options.idx;
% Get app data
h = handles.figure1;
dataSet = getappdata(h,dataName);

for i=1:length(index)
    % Get wavelength data
    if isfield(dataSet,'wavelength')
        % For SFS
        if get(handles.radio_wn,'Value') == 1
            % Get wavenumber data
            xData = dataSet(index(i)).wavenumber;
        elseif get(handles.radio_wl,'Value') == 1
            % Get wavelength data
            xData = dataSet(index(i)).wavelength;
        end
    elseif isfield(dataSet,'delay')
        % For FIDs
        xData = dataSet(index(i)).delay;
    else
        % Error dialog
        errordlg('No x-data found.')
    end
    % Get signal data
    if exist('dataSet(index(i)).offset','var') ~= 0
        dataSet(index(i)).offset = 0;
    end
        
    yData = dataSet(index(i)).signal + dataSet(index(i)).offset;
    ylabel('Signal (a.u.)')
    
    % Plot data
    plot(handles.axes_preview,xData,yData,handles.options.style,...
        'DisplayName',regexprep(dataSet(index(i)).name,'_','\\_'))
    hold on
    box on
    legend('off')
    legend('show')
end

hold off
end