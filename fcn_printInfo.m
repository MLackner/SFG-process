function fcn_printInfo(handles)
% Prints data information

% Load processed data
h = handles.figure1;
dataSet = getappdata(h,'processedDataSet');
% Get index
idx = get(handles.listbox_processedData,'Value');
% Return if nothing in list
if isempty(dataSet)
    formatSpec = 'No processed data selected\n';
    fprintf(formatSpec);
else
    % Load processed data
    h = handles.figure1;
    dataSet = getappdata(h,'processedDataSet');
    % Row names
    rowNames = cell(1,length(idx));
    % Column names
    columnNames = {'min WL','max WL','min WN','max WN','Shots Per Avg',...
        'Step Size'};
    % Define data
    data = cell(length(idx),length(columnNames));
    for i=1:length(idx)
        rowNames{i} = dataSet(idx(i)).name;
        data{i,1} = min(dataSet(idx(i)).wavelength);
        data{i,2} = max(dataSet(idx(i)).wavelength);
        data{i,3} = min(dataSet(idx(i)).wavenumber);
        data{i,4} = max(dataSet(idx(i)).wavenumber);
        data{i,5} = dataSet(idx(i)).shotsPerAvg;
        data{i,6} = dataSet(idx(i)).stepSize;
    end
    % Print
    f = figure('Position',[440 500 700 146]);
    t = uitable(f,  'Data',         data,...
        'ColumnName',   columnNames,...
        'RowName',      rowNames)
    % Set width and height
    t.Position(3) = t.Extent(3);
    t.Position(4) = t.Extent(4);
end

end