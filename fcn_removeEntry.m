function fcn_removeEntry(handles)
% Removes an entry from the list of processed data

%% Remove selected
% Get selected index
idx = get(handles.listbox_processedData,'Value');
% Get processed data
h = handles.figure1;
dataSet = getappdata(h,'processedDataSet');
% Get name of data
name = dataSet(idx).name;
% Remove indexed data
dataSet(idx) = [];
fprintf('Removed data: %s\n',name)
% Save data Set
setappdata(h,'processedDataSet',dataSet)

%% Update processed data listbox
% Create Cell array with names
namesProcessedData = cell(1,length(dataSet));
for i=1:length(dataSet)
    namesProcessedData{i} = dataSet(i).name;
end
if idx > 1
    % Go down one index
    set(handles.listbox_processedData,...
        'String',namesProcessedData,...
        'Value',(idx-1))
else
    % If index is at first entry stay there
    set(handles.listbox_processedData,...
        'String',namesProcessedData,...
        'Value',1)
end

end