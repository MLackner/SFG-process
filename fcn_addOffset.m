function fcn_addOffset(handles)

% Get data set
h = handles.figure1;
dataSet = getappdata(h,'processedDataSet');

% Get selected index
index = get(handles.listbox_processedData,'Value');

% Open prompt
offset = input('Set Signal Offset: ');

for i=1:length(index)
    % Get name of selected data
    name = dataSet(index(i)).name;
    
    % Add info to signal data
    dataSet(index(i)).offset = offset;
    
    % Output dialog
    fprintf('---> Set signal offset of %s to %g\n',name,offset)
end

% Save data
setappdata(h,'processedDataSet',dataSet)

end