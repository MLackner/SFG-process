function fcn_showData(handles,dataName)
% Show data in axes

% Get value of selected data
index = handles.options.idx;
% Get app data
h = handles.figure1;
dataSet = getappdata(h,dataName);
% Get axes handle
ax = handles.axes_preview;

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
    
    %% Get signal data
    
    % Check if offset field exists and is not empty
    if isfield(dataSet(index(i)),'offset') &&...
            ~isempty(dataSet(index(i)).offset)
        offset = dataSet(index(i)).offset;
    else
        offset = 0;
    end
        
    
    % Get signal data and add offset
    yData = dataSet(index(i)).signal + offset;
    
    % Plot data
    p = plot(ax,xData,yData);
    p.DisplayName = regexprep(dataSet(index(i)).name,'_','\\_');
    p.Marker = handles.options.marker;
    p.MarkerSize = handles.options.markerSize;
    p.LineStyle = handles.options.line;
    p.LineWidth = handles.options.lineWidth;
    
    hold on
    
    % Plot fit data if available
    if isfield(dataSet(index(i)),'fit') && get(handles.radio_wn,'Value') == 1
        f = plot(dataSet(index(i)).fit,'-');
        f.DisplayName = regexprep(dataSet(index(i)).name,'_','\\_');
        f.Color = p.Color;
        f.LineWidth = 2;
        p.LineStyle = 'none';
        p.DisplayName = '';
    end
    
    % Make axis labels
    ylabel('Signal')
    if get(handles.radio_wn,'Value') == 1
        xlabel('Wavenumber')
    elseif get(handles.radio_wl,'Value') == 1
        xlabel('Wavelength')
    end
    % Other plot options
    box on
    legend('off')
    legend('show','Location','best')
end

hold off
end