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
    yData = dataSet(index(i)).signal;
    
    % Plot
    figure(1)
    hold on
    legend('off')
    plot(xData,yData,'.-',...
        'DisplayName',regexprep(dataSet(index(i)).name,'_','\\_'))
    legend('show')
end
hold off

end