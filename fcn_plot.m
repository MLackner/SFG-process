function fcn_plot(handles)
% Plot selected data

% Get indices of selected data
index = get(handles.listbox_processedData,'Value');
% Get processed data
h = handles.figure1;
dataSet = getappdata(h,'processedDataSet');

for i=1:length(index)
    if get(handles.radio_wn,'Value') == 1
        % Get wavenumber data
        xData = dataSet(index(i)).wavenumber;
        xlabel('Wavenumber [cm^{-1}]')
    elseif get(handles.radio_wl,'Value') == 1
        % Get wavelength data
        xData = dataSet(index(i)).wavelength;
        xlabel('Wavelength [nm]')
    end
    
    % Get signal data
    yData = dataSet(index(i)).signal + dataSet(index(i)).offset;
    ylabel('Signal (a.u.)')
    
    % Plot
    figure(1)
    hold on
    legend('off')
    
    p = plot(xData,yData);
    p.DisplayName = regexprep(dataSet(index(i)).name,'_','\\_');
    p.LineWidth = 1;
    p.Marker = '.';
    p.MarkerSize = 2;
    
    legend('show')
    
    % Plot fit data if available
    if isfield(dataSet(index(i)),'fit') && get(handles.radio_wn,'Value') == 1
        plot(dataSet(index(i)).fit,'-')
    end
    
end
hold off
box on
end