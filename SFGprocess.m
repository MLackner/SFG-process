function varargout = SFGprocess(varargin)
% SFGPROCESS MATLAB code for SFGprocess.fig
%      SFGPROCESS, by itself, creates a new SFGPROCESS or raises the existing
%      singleton*.
%
%      H = SFGPROCESS returns the handle to a new SFGPROCESS or the handle to
%      the existing singleton*.
%
%      SFGPROCESS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SFGPROCESS.M with the given input arguments.
%
%      SFGPROCESS('Property','Value',...) creates a new SFGPROCESS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SFGprocess_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SFGprocess_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SFGprocess

% Last Modified by GUIDE v2.5 24-Oct-2014 21:44:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SFGprocess_OpeningFcn, ...
                   'gui_OutputFcn',  @SFGprocess_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before SFGprocess is made visible.
function SFGprocess_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SFGprocess (see VARARGIN)

% Define signal amplification
handles.options.signalAmplifier = 1e10;

% Choose default command line output for SFGprocess
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SFGprocess wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SFGprocess_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on selection change in listbox_rawData.
function listbox_rawData_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_rawData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_rawData contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_rawData

% Get file name of raw data
dataName = 'rawDataSet';
% Get index
idx = get(handles.listbox_rawData,'Value');
% Return if nothing in list
if isempty(idx)
    return
end
handles.options.idx = idx;
% Define style
handles.options.style = '.';
% Call function to show raw data in preview
fcn_showData(handles,dataName);

% --- Executes during object creation, after setting all properties.
function listbox_rawData_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_rawData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in listbox_processedData.
function listbox_processedData_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_processedData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_processedData contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_processedData

% Get file name of processed data
dataName = 'processedDataSet';
% Get index
idx = get(handles.listbox_processedData,'Value');
% Return if nothing in list
if isempty(idx)
    return
end
handles.options.idx = idx;
% Define style
handles.options.style = '.:';
% Call function to show processed data in preview
fcn_showData(handles,dataName);
% Display Info
fcn_displayInfo(handles);

% --- Executes during object creation, after setting all properties.
function listbox_processedData_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_processedData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in push_saveData.
function push_saveData_Callback(hObject, eventdata, handles)
% hObject    handle to push_saveData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Call funtion
fcn_saveData(handles)


% --- Executes on button press in push_newFig.
function push_newFig_Callback(hObject, eventdata, handles)
% hObject    handle to push_newFig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

figure;
set(0,'CurrentFigure',gcf)
xlabel('Wavenumber [cm^{-1}]')
ylabel('Signal (a.u.)')

% --- Executes on button press in push_plot.
function push_plot_Callback(hObject, eventdata, handles)
% hObject    handle to push_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Call funtion
fcn_plot(handles)

% --- Executes on button press in push_saveMat.
function push_saveMat_Callback(hObject, eventdata, handles)
% hObject    handle to push_saveMat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in push_processFID.
function push_processFID_Callback(hObject, eventdata, handles)
% hObject    handle to push_processFID (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when selected object is changed in uibuttongroup1.
function uibuttongroup1_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uibuttongroup1 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get file name of processed data
dataName = 'processedDataSet';
handles.options.idx = get(handles.listbox_processedData,'Value');
handles.options.style = '.:';
fcn_showData(handles,dataName)


% --------------------------------------------------------------------
function uipush_newSession_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipush_newSession (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Delete app data
h = handles.figure1;
if isappdata(h,'rawDataSet') == true
    rmappdata(h,'rawDataSet');
end
if isappdata(h,'processedDataSet') == true
    rmappdata(h,'processedDataSet');
end

% Clear listboxes
set(handles.listbox_rawData,'String','')
set(handles.listbox_rawData,'Value',[])
set(handles.listbox_processedData,'String','')
set(handles.listbox_processedData,'Value',[])
fprintf('---New Session---\n')


% --------------------------------------------------------------------
function uipush_loadRawData_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipush_loadRawData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fcn_load(handles);


% --------------------------------------------------------------------
function uipush_saveMat_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipush_saveMat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fcn_export(handles)


% --------------------------------------------------------------------
function uipush_process_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipush_process (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.options.FID = false;
fcn_process(handles)


% --------------------------------------------------------------------
function uipush_processFID_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipush_processFID (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Set options
handles.options.FID = true;
% Call function
fcn_process(handles)


% --------------------------------------------------------------------
function uipush_remove_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipush_remove (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Call function
fcn_removeEntry(handles)


% --------------------------------------------------------------------
function uipush_addOffset_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipush_addOffset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fcn_addOffset(handles)


% --------------------------------------------------------------------
function menu_data_Callback(hObject, eventdata, handles)
% hObject    handle to menu_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function data_import_Callback(hObject, eventdata, handles)
% hObject    handle to data_import (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fcn_importMatFile(handles)
