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

% Last Modified by GUIDE v2.5 12-Oct-2014 17:08:44

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


% --- Executes on button press in push_loadSingle.
function push_loadSingle_Callback(hObject, eventdata, handles)
% hObject    handle to push_loadSingle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in push_loadMulti.
function push_loadMulti_Callback(hObject, eventdata, handles)
% hObject    handle to push_loadMulti (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in listbox_rawData.
function listbox_rawData_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_rawData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_rawData contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_rawData


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


% --- Executes on button press in push_process.
function push_process_Callback(hObject, eventdata, handles)
% hObject    handle to push_process (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in listbox_processedData.
function listbox_processedData_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_processedData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_processedData contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_processedData


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


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
