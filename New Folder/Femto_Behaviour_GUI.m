function varargout = Femto_Behaviour_GUI(varargin)
% FEMTO_BEHAVIOUR_GUI MATLAB code for Femto_Behaviour_GUI.fig
%      FEMTO_BEHAVIOUR_GUI, by itself, creates a new FEMTO_BEHAVIOUR_GUI or raises the existing
%      singleton*.
%
%      H = FEMTO_BEHAVIOUR_GUI returns the handle to a new FEMTO_BEHAVIOUR_GUI or the handle to
%      the existing singleton*.
%
%      FEMTO_BEHAVIOUR_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FEMTO_BEHAVIOUR_GUI.M with the given input arguments.
%
%      FEMTO_BEHAVIOUR_GUI('Property','Value',...) creates a new FEMTO_BEHAVIOUR_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Femto_Behaviour_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Femto_Behaviour_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Femto_Behaviour_GUI

% Last Modified by GUIDE v2.5 07-Nov-2019 17:49:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Femto_Behaviour_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @Femto_Behaviour_GUI_OutputFcn, ...
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


% --- Executes just before Femto_Behaviour_GUI is made visible.
function Femto_Behaviour_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Femto_Behaviour_GUI (see VARARGIN)

% Choose default command line output for Femto_Behaviour_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Femto_Behaviour_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);

curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
load Femto_Behaviour_params
cd (curdir)

% set(handles.auditory_only,'Value',Femto_Behaviour_params.auditory_only);
% set(handles.visual_only,'Value',Femto_Behaviour_params.visual_only);
% set(handles.multisensory,'Value',Femto_Behaviour_params.multisensory);
% set(handles.reward_only,'Value',Femto_Behaviour_params.reward_only);
% set(handles.total_time,'Value',Femto_Behaviour_params.total_time);
% set(handles.reward_onset,'Value',Femto_Behaviour_params.reward_onset);
% set(handles.ttl_amp,'Value',Femto_Behaviour_params.ttl_amp);
% set(handles.ttl_pulse_dur,'Value',Femto_Behaviour_params.ttl_pulse_dur);
% set(handles.reps,'Value',Femto_Behaviour_params.reps);
 set(handles.gap_check,'Value',Femto_Behaviour_params.gap_check);
% set(handles.gap_value,'Value',Femto_Behaviour_params.gap_value);


eval(sprintf('set(handles.total_time,''String'',''%i'');',Femto_Behaviour_params.total_time))
set(handles.total_time,'Value',Femto_Behaviour_params.total_time);

eval(sprintf('set(handles.reward_onset,''String'',''%i'');',Femto_Behaviour_params.reward_onset))
set(handles.reward_onset,'Value',Femto_Behaviour_params.reward_onset);

eval(sprintf('set(handles.ttl_amp,''String'',''%i'');',Femto_Behaviour_params.ttl_amp))
set(handles.ttl_amp,'Value',Femto_Behaviour_params.ttl_amp);

eval(sprintf('set(handles.ttl_pulse_dur,''String'',''%i'');',Femto_Behaviour_params.ttl_pulse_dur))
set(handles.ttl_pulse_dur,'Value',Femto_Behaviour_params.ttl_pulse_dur);

eval(sprintf('set(handles.reps,''String'',''%i'');',Femto_Behaviour_params.reps))
set(handles.reps,'Value',Femto_Behaviour_params.reps);

eval(sprintf('set(handles.gap_value,''String'',''%i'');',Femto_Behaviour_params.gap_value))
set(handles.gap_value,'Value',Femto_Behaviour_params.gap_value);



% --- Outputs from this function are returned to the command line.
function varargout = Femto_Behaviour_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in auditory_only.
function auditory_only_Callback(hObject, eventdata, handles)
% hObject    handle to auditory_only (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

load Femto_Behaviour_params
Femto_Behaviour_params.auditory_only=get(hObject,'Value');
set(handles.auditory_only,'Value',Femto_Behaviour_params.auditory_only);

if Femto_Behaviour_params.auditory_only==1
    Femto_Behaviour_params.visual_only=0;
    set(handles.visual_only,'Value',0);
    Femto_Behaviour_params.multisensory=0;
    set(handles.multisensory,'Value',0);
    Femto_Behaviour_params.reward_only=0;
    set(handles.reward_only,'Value',0);
    
    
end

curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save Femto_Behaviour_params Femto_Behaviour_params
cd (curdir)


% Hint: get(hObject,'Value') returns toggle state of auditory_only


% --- Executes on button press in visual_only.
function visual_only_Callback(hObject, eventdata, handles)
% hObject    handle to visual_only (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

load Femto_Behaviour_params
Femto_Behaviour_params.visual_only=get(hObject,'Value');
set(handles.visual_only,'Value',Femto_Behaviour_params.visual_only);

if Femto_Behaviour_params.visual_only==1
    Femto_Behaviour_params.auditory_only=0;
    set(handles.auditory_only,'Value',0);
    Femto_Behaviour_params.multisensory=0;
    set(handles.multisensory,'Value',0);
    Femto_Behaviour_params.reward_only=0;
    set(handles.reward_only,'Value',0);
    
    
end

curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save Femto_Behaviour_params Femto_Behaviour_params
cd (curdir)


% Hint: get(hObject,'Value') returns toggle state of visual_only


% --- Executes on button press in multisensory.
function multisensory_Callback(hObject, eventdata, handles)
% hObject    handle to multisensory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load Femto_Behaviour_params
Femto_Behaviour_params.multisensory=get(hObject,'Value');
set(handles.multisensory,'Value',Femto_Behaviour_params.multisensory);

if Femto_Behaviour_params.multisensory==1
    Femto_Behaviour_params.visual_only=0;
    set(handles.visual_only,'Value',0);
    Femto_Behaviour_params.visual_only=0;
    set(handles.visual_only,'Value',0);
    Femto_Behaviour_params.reward_only=0;
    set(handles.reward_only,'Value',0);
    
    
end

curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save Femto_Behaviour_params Femto_Behaviour_params
cd (curdir)




% Hint: get(hObject,'Value') returns toggle state of multisensory


% --- Executes on button press in set_auditory.
function set_auditory_Callback(hObject, eventdata, handles)
% hObject    handle to set_auditory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Auditory2PGUI

% --- Executes on button press in set_visual.
function set_visual_Callback(hObject, eventdata, handles)
% hObject    handle to set_visual (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
VisualLEDStimGUI

% --- Executes on button press in reward_only.
function reward_only_Callback(hObject, eventdata, handles)
% hObject    handle to reward_only (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load Femto_Behaviour_params
Femto_Behaviour_params.reward_only=str2double(get(hObject,'String'));
set(handles.reward_only,'Value',Femto_Behaviour_params.reward_only);

if Femto_Behaviour_params.reward_only==1
    Femto_Behaviour_params.auditory_only=0;
    set(handles.auditory_only,'Value',0);
    Femto_Behaviour_params.multisensory=0;
    set(handles.multisensory,'Value',0);
    Femto_Behaviour_params.visual_only=0;
    set(handles.visual_only,'Value',0);
  
end

curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save Femto_Behaviour_params Femto_Behaviour_params
cd (curdir)



% Hint: get(hObject,'Value') returns toggle state of reward_only



function total_time_Callback(hObject, eventdata, handles)
% hObject    handle to total_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load Femto_Behaviour_params
Femto_Behaviour_params.total_time=str2double(get(hObject,'String'));
set(handles.total_time,'Value',Femto_Behaviour_params.total_time);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save Femto_Behaviour_params Femto_Behaviour_params
cd (curdir)
% Hints: get(hObject,'String') returns contents of total_time as text
%        str2double(get(hObject,'String')) returns contents of total_time as a double


% --- Executes during object creation, after setting all properties.
function total_time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to total_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function reward_onset_Callback(hObject, eventdata, handles)
% hObject    handle to reward_onset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load Femto_Behaviour_params

Femto_Behaviour_params.reward_onset=str2double(get(hObject,'String'));
set(handles.reward_onset,'Value',Femto_Behaviour_params.reward_onset);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save Femto_Behaviour_params Femto_Behaviour_params
cd (curdir)
% Hints: get(hObject,'String') returns contents of reward_onset as text
%        str2double(get(hObject,'String')) returns contents of reward_onset as a double


% --- Executes during object creation, after setting all properties.
function reward_onset_CreateFcn(hObject, eventdata, handles)
% hObject    handle to reward_onset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ttl_amp_Callback(hObject, eventdata, handles)
% hObject    handle to ttl_amp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load Femto_Behaviour_params
Femto_Behaviour_params.ttl_amp=str2double(get(hObject,'String'));
set(handles.ttl_amp,'Value',Femto_Behaviour_params.ttl_amp);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save Femto_Behaviour_params Femto_Behaviour_params
cd (curdir)
% Hints: get(hObject,'String') returns contents of ttl_amp as text
%        str2double(get(hObject,'String')) returns contents of ttl_amp as a double


% --- Executes during object creation, after setting all properties.
function ttl_amp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ttl_amp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ttl_pulse_dur_Callback(hObject, eventdata, handles)
% hObject    handle to ttl_pulse_dur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load Femto_Behaviour_params
Femto_Behaviour_params.ttl_pulse_dur=str2double(get(hObject,'String'));
set(handles.ttl_pulse_dur,'Value',Femto_Behaviour_params.ttl_pulse_dur);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save Femto_Behaviour_params Femto_Behaviour_params
cd (curdir)
% Hints: get(hObject,'String') returns contents of ttl_pulse_dur as text
%        str2double(get(hObject,'String')) returns contents of ttl_pulse_dur as a double


% --- Executes during object creation, after setting all properties.
function ttl_pulse_dur_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ttl_pulse_dur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function reps_Callback(hObject, eventdata, handles)
% hObject    handle to reps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load Femto_Behaviour_params
Femto_Behaviour_params.reps=str2double(get(hObject,'String'));
set(handles.reps,'Value',Femto_Behaviour_params.reps);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save Femto_Behaviour_params Femto_Behaviour_params
cd (curdir)
% Hints: get(hObject,'String') returns contents of reps as text
%        str2double(get(hObject,'String')) returns contents of reps as a double


% --- Executes during object creation, after setting all properties.
function reps_CreateFcn(hObject, eventdata, handles)
% hObject    handle to reps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in done.
function done_Callback(hObject, eventdata, handles)
% hObject    handle to done (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% load Femto_Behaviour_params
Femto_Behaviour_params.auditory_only=get(handles.auditory_only,'Value');
Femto_Behaviour_params.visual_only=get(handles.visual_only,'Value');
Femto_Behaviour_params.multisensory=get(handles.multisensory,'Value');
Femto_Behaviour_params.reward_only=get(handles.reward_only,'Value');

Femto_Behaviour_params.total_time=get(handles.total_time,'Value');
Femto_Behaviour_params.reward_onset=get(handles.reward_onset,'Value');
Femto_Behaviour_params.reward_onset
Femto_Behaviour_params.ttl_amp=get(handles.ttl_amp,'Value');
Femto_Behaviour_params.ttl_pulse_dur=get(handles.ttl_pulse_dur,'Value');

Femto_Behaviour_params.reps=get(handles.reps,'Value');
Femto_Behaviour_params.gap_check=get(handles.gap_check,'Value');
Femto_Behaviour_params.gap_value=get(handles.gap_value,'Value');

if Femto_Behaviour_params.auditory_only==1
    load AudStimPARAMS
    Femto_Behaviour_params.AUD=AudStimPARAMS;
    Femto_Behaviour_params.VIS=[];
elseif Femto_Behaviour_params.visual_only==1
    load VisLEDStimPARAMS
    Femto_Behaviour_params.VIS=VisLEDStimPARAMS;
    Femto_Behaviour_params.AUD=[];
elseif Femto_Behaviour_params.multisensory==1    
    load AudStimPARAMS
    load VisLEDStimPARAMS
    Femto_Behaviour_params.AUD=AudStimPARAMS;
    Femto_Behaviour_params.VIS=VisLEDStimPARAMS;
elseif Femto_Behaviour_params.reward_only==1    
    Femto_Behaviour_params.AUD=[];
    Femto_Behaviour_params.VIS=[];
end
Femto_Behaviour_params.protocol_str='Ready - Not started';    
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save Femto_Behaviour_params Femto_Behaviour_params
cd (curdir)

close(handles.figure1)







% --- Executes on button press in gap_check.
function gap_check_Callback(hObject, eventdata, handles)
% hObject    handle to gap_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

load Femto_Behaviour_params
Femto_Behaviour_params.gap_check=get(hObject,'Value');
set(handles.gap_check,'Value',Femto_Behaviour_params.gap_check);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save Femto_Behaviour_params Femto_Behaviour_params
cd (curdir)




% Hint: get(hObject,'Value') returns toggle state of gap_check



function gap_value_Callback(hObject, eventdata, handles)
% hObject    handle to gap_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

load Femto_Behaviour_params
Femto_Behaviour_params.gap_value=str2double(get(hObject,'String'));
set(handles.gap_value,'Value',Femto_Behaviour_params.gap_value);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save Femto_Behaviour_params Femto_Behaviour_params
cd (curdir)


% Hints: get(hObject,'String') returns contents of gap_value as text
%        str2double(get(hObject,'String')) returns contents of gap_value as a double


% --- Executes during object creation, after setting all properties.
function gap_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gap_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
