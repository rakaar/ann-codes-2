function varargout = Search_GUIx(varargin)
% SEARCH_GUIX M-file for Search_GUIx.fig
%      SEARCH_GUIX, by itself, creates a new SEARCH_GUIX or raises the existing
%      singleton*.
%
%      H = SEARCH_GUIX returns the handle to a new SEARCH_GUIX or the handle to
%      the existing singleton*.
%
%      SEARCH_GUIX('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SEARCH_GUIX.M with the given input arguments.
%
%      SEARCH_GUIX('Property','Value',...) creates a new SEARCH_GUIX or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Search_GUIx_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Search_GUIx_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Search_GUIx

% Last Modified by GUIDE v2.5 25-Oct-2007 17:40:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Search_GUIx_OpeningFcn, ...
                   'gui_OutputFcn',  @Search_GUIx_OutputFcn, ...
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


% --- Executes just before Search_GUIx is made visible.
function Search_GUIx_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Search_GUIx (see VARARGIN)

% Choose default command line output for Search_GUIx
handles.output = hObject;

% Update handles structure
handles.Quit_search=0;
guidata(hObject, handles)
%movegui(hObject,'northwest');
load search_start
if search_start==1
    set(handles.Frequency,'String','16 kHz');
    freqv=freqloc(16);
    set(handles.Tone_Freq,'Value',freqv);
    set(handles.Attenuation_Disp,'String','80 dB');
    attv=attloc(80);
    set(handles.Attenuation,'Value',attv);
    set(handles.Spike_Threshold,'Value',thloc(1));
    set(handles.Timeout,'Value',tmoloc(0.8));
    set(handles.SpkTh_Disp,'String','1 V');
    set(handles.TimeOut_Disp,'String','0.8 ms');
end
    
% UIWAIT makes Search_GUIx wait for user response (see UIRESUME)
%uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Search_GUIx_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure

varargout{1} = handles;
varargout{2} = handles.Quit_search;



% --- Executes on slider movement.
function Tone_Freq_Callback(hObject, eventdata, handles)
% hObject    handle to Tone_Freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fr=Svaltofreq(get(hObject,'Value'));
eval(sprintf('set(handles.Frequency,''String'',''%5.2f kHz'');',fr))



% --- Executes during object creation, after setting all properties.
function Tone_Freq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Tone_Freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function Attenuation_Callback(hObject, eventdata, handles)
% hObject    handle to Attenuation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
att=Svaltoatt(get(hObject,'Value'));
eval(sprintf('set(handles.Attenuation_Disp,''String'',''%4.1f dB'');',att))

% --- Executes during object creation, after setting all properties.
function Attenuation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Attenuation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in Start_button.
function Start_button_Callback(hObject, eventdata, handles)
% hObject    handle to Start_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

start_stop=get(hObject,'Value');

% --- Executes on button press in Stop_button.
function Stop_button_Callback(hObject, eventdata, handles)
% hObject    handle to Stop_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Tone_Noise.
function Tone_Noise_Callback(hObject, eventdata, handles)
% hObject    handle to Tone_Noise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Tone_Noise


% --- Executes on button press in TONE_NOISE.
function TONE_NOISE_Callback(hObject, eventdata, handles)
% hObject    handle to TONE_NOISE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TONE_NOISE



function Frequency_Callback(hObject, eventdata, handles)
% hObject    handle to Frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Frequency as text
%        str2double(get(hObject,'String')) returns contents of Frequency as a double


% --- Executes during object creation, after setting all properties.
function Frequency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Attenuation_Disp_Callback(hObject, eventdata, handles)
% hObject    handle to Attenuation_Disp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Attenuation_Disp as text
%        str2double(get(hObject,'String')) returns contents of Attenuation_Disp as a double


% --- Executes during object creation, after setting all properties.
function Attenuation_Disp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Attenuation_Disp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function v=freqloc(fr)

v=log2(fr/2)/log2(40);
return

function va=attloc(dba)

va=(100-dba)/100;
return

function va=thloc(thvol)

va=(10+thvol)/20;
return

function va=tmoloc(tm)

va=(tm-.1)/(5-.1); % allowed range .1 ms to 5 ms
return

function fr=Svaltofreq(val)

fr=2^(1+val*log2(40));
return

function att=Svaltoatt(vala)

att=100*(1-vala);
return

function spk_th=Svaltovolt(val)

spk_th=20*val-10;
return

function tmo=Svaltotime(val)

tmo=4.9*val+.1;
return



% --- Executes on button press in Exit_Search.
function Exit_Search_Callback(hObject, eventdata, handles)
% hObject    handle to Exit_Search (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.Quit_search=1;
guidata(handles.figure1, handles);
uiresume;


% --- Executes on slider movement.
function Spike_Threshold_Callback(hObject, eventdata, handles)
% hObject    handle to Spike_Threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
spkt=Svaltovolt(get(hObject,'Value'));
eval(sprintf('set(handles.SpkTh_Disp,''String'',''%4.2f V'');',spkt))


% --- Executes during object creation, after setting all properties.
function Spike_Threshold_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Spike_Threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function Timeout_Callback(hObject, eventdata, handles)
% hObject    handle to Timeout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
tmo=Svaltotime(get(hObject,'Value'));
eval(sprintf('set(handles.TimeOut_Disp,''String'',''%4.2f ms'');',tmo))


% --- Executes during object creation, after setting all properties.
function Timeout_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Timeout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function SpkTh_Disp_Callback(hObject, eventdata, handles)
% hObject    handle to SpkTh_Disp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SpkTh_Disp as text
%        str2double(get(hObject,'String')) returns contents of SpkTh_Disp as a double


% --- Executes during object creation, after setting all properties.
function SpkTh_Disp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SpkTh_Disp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TimeOut_Disp_Callback(hObject, eventdata, handles)
% hObject    handle to TimeOut_Disp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TimeOut_Disp as text
%        str2double(get(hObject,'String')) returns contents of TimeOut_Disp as a double


% --- Executes during object creation, after setting all properties.
function TimeOut_Disp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TimeOut_Disp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


