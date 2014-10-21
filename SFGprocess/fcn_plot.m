function fcn_plot(handles)
% Plot selected data

% Get indices of selected data
idx = get(handles.listbox_processedData,'Value');

% Get name of data file
fileName = handles.options.fileNamePrData;
% Load *.mat file
matFile = load(fileName);
% Get variable names from matfile
varNames = fieldnames(matFile);

if get(handles.radio_wn,'Value') == 1
    % Get wavenumber data
    xData = eval(['matFile.',varNames{idx},'.wavenumber']);
elseif get(handles.radio_wl,'Value') == 1
    % Get wavelength data
    xData = eval(['matFile.',varNames{idx},'.wavelength']);
end
    
% Get signal data
yData = eval(['matFile.',varNames{idx},'.signal']);

% Plot
figure(1)
hold on
legend('off')
plot(xData,yData,'.-','DisplayName',regexprep(varNames{idx},'_','\\_'))
legend('show')
hold off

end