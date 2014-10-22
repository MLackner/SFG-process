function fcn_addOffset(handles)

% Get data set
h = handles.figure1;
dataSet = getappdata(h,'processedDataSet');

% Get selected index
index = get(handles.listbox_processedData,'Value');

% Get name of selected data
name = dataSet(index).name;

% Open prompt
offset = input('Set Signal Offset: ');
fprintf('---> Set signal offset of %s to %g\n',name,offset)

% Add info to signal data
dataSet(index).offset = offset;

% Save data
setappdata(h,'processedDataSet',dataSet)

end