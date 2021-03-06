function varargout = LoadingGUI(varargin)
% LOADINGGUI M-file for LoadingGUI.fig
%      LOADINGGUI, by itself, creates a new LOADINGGUI or raises the existing
%      singleton*.
%
%      H = LOADINGGUI returns the handle to a new LOADINGGUI or the handle to
%      the existing singleton*.
%
%      LOADINGGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LOADINGGUI.M with the given input arguments.
%
%      LOADINGGUI('Property','Value',...) creates a new LOADINGGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before LoadingGUI_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to LoadingGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help LoadingGUI

% Last Modified by GUIDE v2.5 05-Jul-2008 10:08:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @LoadingGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @LoadingGUI_OutputFcn, ...
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


% --- Executes just before LoadingGUI is made visible.
function LoadingGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to LoadingGUI (see VARARGIN)

% Choose default command line output for LoadingGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
load LoadingPARAMS

eval(sprintf('set(handles.puff_dur,''String'',''%5.3f'');',LoadingPARAMS.puff_dur))
set(handles.puff_dur,'Value',LoadingPARAMS.puff_dur);
eval(sprintf('set(handles.ipi_val,''String'',''%5.3f'');',LoadingPARAMS.ipi_val))
set(handles.ipi_val,'Value',LoadingPARAMS.ipi_val);
eval(sprintf('set(handles.ipti_val,''String'',''%6.2f'');',LoadingPARAMS.ipti_val))
set(handles.ipti_val,'Value',LoadingPARAMS.ipti_val);
eval(sprintf('set(handles.num_ppt_val,''String'',''%i'');',LoadingPARAMS.num_ppt_val))
set(handles.num_ppt_val,'Value',LoadingPARAMS.num_ppt_val);
eval(sprintf('set(handles.num_pt_val,''String'',''%i'');',LoadingPARAMS.num_pt_val))
set(handles.num_pt_val,'Value',LoadingPARAMS.num_pt_val);



% UIWAIT makes LoadingGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = LoadingGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles;


% --- Executes on button press in done_button.
function done_button_Callback(hObject, eventdata, handles)
% hObject    handle to done_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

LoadingPARAMS.puff_dur=get(handles.puff_dur,'Value');
LoadingPARAMS.ipi_val=get(handles.ipi_val,'Value');
LoadingPARAMS.ipti_val=get(handles.ipti_val,'Value');
LoadingPARAMS.num_ppt_val=get(handles.num_ppt_val,'Value');
LoadingPARAMS.num_pt_val=get(handles.num_pt_val,'Value');
save LoadingPARAMS LoadingPARAMS 

close(handles.figure1)
load Loading_handles
eval(sprintf('disp_string=''%i Puffs per Train, %i Trains every %5.2f secs, Puff Dur %5.2f sec, %5.2f sec IPI'';',LoadingPARAMS.num_ppt_val,LoadingPARAMS.num_pt_val,LoadingPARAMS.ipti_val,LoadingPARAMS.puff_dur,LoadingPARAMS.ipi_val))
set(PP_handles.disp_protocol,'String',disp_string)
set(PP_handles.disp_status,'String','Not Started')

function num_pt_val_Callback(hObject, eventdata, handles)
% hObject    handle to num_pt_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of num_pt_val as text
load LoadingPARAMS
LoadingPARAMS.num_pt_val=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
%save LoadingPARAMS LoadingPARAMS 
set(handles.num_pt_val,'Value',LoadingPARAMS.num_pt_val);


% --- Executes during object creation, after setting all properties.
function num_pt_val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to num_pt_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function num_ppt_val_Callback(hObject, eventdata, handles)
% hObject    handle to num_ppt_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of num_ppt_val as text
%        str2double(get(hObject,'String')) returns contents of num_ppt_val as a double
load LoadingPARAMS
LoadingPARAMS.num_ppt_val=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
%save LoadingPARAMS LoadingPARAMS
set(handles.num_ppt_val,'Value',LoadingPARAMS.num_ppt_val);


% --- Executes during object creation, after setting all properties.
function num_ppt_val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to num_ppt_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ipti_val_Callback(hObject, eventdata, handles)
% hObject    handle to ipti_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ipti_val as text
%        str2double(get(hObject,'String')) returns contents of ipti_val as a double

load LoadingPARAMS
LoadingPARAMS.ipti_val=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
%save LoadingPARAMS LoadingPARAMS
set(handles.ipti_val,'Value',LoadingPARAMS.ipti_val);

% --- Executes during object creation, after setting all properties.
function ipti_val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ipti_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ipi_val_Callback(hObject, eventdata, handles)
% hObject    handle to ipi_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ipi_val as text
%        str2double(get(hObject,'String')) returns contents of ipi_val as a double

load LoadingPARAMS
LoadingPARAMS.ipi_val=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
%save LoadingPARAMS LoadingPARAMS
set(handles.ipi_val,'Value',LoadingPARAMS.ipi_val);


% --- Executes during object creation, after setting all properties.
function ipi_val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ipi_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function puff_dur_Callback(hObject, eventdata, handles)
% hObject    handle to puff_dur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of puff_dur as text
%        str2double(get(hObject,'String')) returns contents of puff_dur as a double

load LoadingPARAMS
LoadingPARAMS.puff_dur=str2double(get(hObject,'String')) %returns contents of num_pt_val as a double
%save LoadingPARAMS LoadingPARAMS
set(handles.puff_dur,'Value',LoadingPARAMS.puff_dur);

% --- Executes during object creation, after setting all properties.
function puff_dur_CreateFcn(hObject, eventdata, handles)
% hObject    handle to puff_dur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


