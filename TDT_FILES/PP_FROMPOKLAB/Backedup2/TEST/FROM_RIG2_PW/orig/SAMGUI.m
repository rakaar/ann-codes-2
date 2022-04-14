function varargout = SAMGUI(varargin)
% SAMGUI M-file for SAMGUI.fig
%      SAMGUI, by itself, creates a new SAMGUI or raises the existing
%      singleton*.
%
%      H = SAMGUI returns the handle to a new SAMGUI or the handle to
%      the existing singleton*.
%
%      SAMGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SAMGUI.M with the given input arguments.
%
%      SAMGUI('Property','Value',...) creates a new SAMGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SAMGUI_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SAMGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SAMGUI

% Last Modified by GUIDE v2.5 17-Jul-2008 13:54:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SAMGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @SAMGUI_OutputFcn, ...
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


% --- Executes just before SAMGUI is made visible.
function SAMGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SAMGUI (see VARARGIN)

% Choose default command line output for SAMGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

load SAMPARAMS
load Auditory_handles
wtd_val=get(PP_handles.what_to_do,'Value');
if wtd_val==7
    set(handles.text13,'String','Total Time (sec)')
    set(handles.text11,'String','Start Time (sec)')
end
eval(sprintf('set(handles.frame_dur,''String'',''%5.3f'');',SAMPARAMS.frame_dur))
set(handles.frame_dur,'Value',SAMPARAMS.frame_dur);
eval(sprintf('set(handles.total_frames_lines,''String'',''%i'');',SAMPARAMS.total_frames_lines))
set(handles.total_frames_lines,'Value',SAMPARAMS.total_frames_lines);
eval(sprintf('set(handles.stim_start,''String'',''%i'');',SAMPARAMS.stim_start))
set(handles.stim_start,'Value',SAMPARAMS.stim_start);
set(handles.tone_check,'Value',SAMPARAMS.tone_check);
set(handles.noise_check,'Value',SAMPARAMS.noise_check);
if SAMPARAMS.tone_check == 1
    set(handles.tone_bgbox,'BackgroundColor',[0.678 0.922 1])
    set(handles.noise_bgbox,'BackgroundColor',[0.702 0.702 0.702])
    set(handles.noise_check,'Value',~SAMPARAMS.tone_check);
else
    set(handles.noise_bgbox,'BackgroundColor',[0.678 0.922 1])
    set(handles.tone_bgbox,'BackgroundColor',[0.702 0.702 0.702])
    set(handles.tone_check,'Value',~SAMPARAMS.noise_check);
end
eval(sprintf('set(handles.To_flo,''String'',''%i'');',SAMPARAMS.To_flo))
set(handles.To_flo,'Value',SAMPARAMS.To_flo);
eval(sprintf('set(handles.To_fhi,''String'',''%i'');',SAMPARAMS.To_fhi))
set(handles.To_fhi,'Value',SAMPARAMS.To_fhi);
eval(sprintf('set(handles.num_freq_steps,''String'',''%i'');',SAMPARAMS.num_freq_steps))
set(handles.num_freq_steps,'Value',SAMPARAMS.num_freq_steps);
eval(sprintf('set(handles.No_flo,''String'',''%i'');',SAMPARAMS.No_flo))
set(handles.No_flo,'Value',SAMPARAMS.No_flo);
eval(sprintf('set(handles.No_fhi,''String'',''%i'');',SAMPARAMS.No_fhi))
set(handles.No_fhi,'Value',SAMPARAMS.No_fhi);
eval(sprintf('set(handles.mod_freq,''String'',''%6.2f'');',SAMPARAMS.mod_freq))
set(handles.mod_freq,'Value',SAMPARAMS.mod_freq);
eval(sprintf('set(handles.mod_depth,''String'',''%5.3f'');',SAMPARAMS.mod_depth))
set(handles.mod_depth,'Value',SAMPARAMS.mod_depth);
eval(sprintf('set(handles.dur,''String'',''%6.4f'');',SAMPARAMS.dur))
set(handles.dur,'Value',SAMPARAMS.dur);
eval(sprintf('set(handles.level_lo,''String'',''%3.1f'');',SAMPARAMS.level_lo))
set(handles.level_lo,'Value',SAMPARAMS.level_lo);
eval(sprintf('set(handles.level_hi,''String'',''%3.1f'');',SAMPARAMS.level_hi))
set(handles.level_hi,'Value',SAMPARAMS.level_hi);
eval(sprintf('set(handles.num_att_steps,''String'',''%i'');',SAMPARAMS.num_att_steps))
set(handles.num_att_steps,'Value',SAMPARAMS.num_att_steps);
eval(sprintf('set(handles.total_reps,''String'',''%i'');',SAMPARAMS.total_reps))
set(handles.total_reps,'Value',SAMPARAMS.total_reps);

% UIWAIT makes SAMGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SAMGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles;


% --- Executes on button press in tone_check.
function tone_check_Callback(hObject, eventdata, handles)
% hObject    handle to tone_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tone_check

load SAMPARAMS
SAMPARAMS.tone_check=get(hObject,'Value'); %returns contents of num_pt_val as a double
set(handles.tone_check,'Value',SAMPARAMS.tone_check);
set(handles.noise_check,'Value',~SAMPARAMS.tone_check);
SAMPARAMS.noise_check=~SAMPARAMS.tone_check;
if SAMPARAMS.tone_check == 1
    set(handles.tone_bgbox,'BackgroundColor',[0.678 0.922 1])
    set(handles.noise_bgbox,'BackgroundColor',[0.702 0.702 0.702])
else
    set(handles.noise_bgbox,'BackgroundColor',[0.678 0.922 1])
    set(handles.tone_bgbox,'BackgroundColor',[0.702 0.702 0.702])
end
save SAMPARAMS SAMPARAMS

% --- Executes on button press in noise_check.
function noise_check_Callback(hObject, eventdata, handles)
% hObject    handle to noise_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of noise_check

load SAMPARAMS
SAMPARAMS.noise_check=get(hObject,'Value'); %returns contents of num_pt_val as a double
set(handles.noise_check,'Value',SAMPARAMS.noise_check);
set(handles.tone_check,'Value',~SAMPARAMS.noise_check);
SAMPARAMS.tone_check=~SAMPARAMS.noise_check;
if SAMPARAMS.tone_check == 1
    set(handles.tone_bgbox,'BackgroundColor',[0.678 0.922 1])
    set(handles.noise_bgbox,'BackgroundColor',[0.702 0.702 0.702])
else
    set(handles.noise_bgbox,'BackgroundColor',[0.678 0.922 1])
    set(handles.tone_bgbox,'BackgroundColor',[0.702 0.702 0.702])
end
save SAMPARAMS SAMPARAMS

function No_flo_Callback(hObject, eventdata, handles)
% hObject    handle to No_flo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of No_flo as text
%        str2double(get(hObject,'String')) returns contents of No_flo as a double

load SAMPARAMS
SAMPARAMS.No_flo=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.No_flo,'Value',SAMPARAMS.No_flo);
save SAMPARAMS SAMPARAMS

% --- Executes during object creation, after setting all properties.
function No_flo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to No_flo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function No_fhi_Callback(hObject, eventdata, handles)
% hObject    handle to No_fhi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of No_fhi as text
%        str2double(get(hObject,'String')) returns contents of No_fhi as a double

load SAMPARAMS
SAMPARAMS.No_fhi=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.No_fhi,'Value',SAMPARAMS.No_fhi);
save SAMPARAMS SAMPARAMS

% --- Executes during object creation, after setting all properties.
function No_fhi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to No_fhi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function To_flo_Callback(hObject, eventdata, handles)
% hObject    handle to To_flo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of To_flo as text
%        str2double(get(hObject,'String')) returns contents of To_flo as a double

load SAMPARAMS
SAMPARAMS.To_flo=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.To_flo,'Value',SAMPARAMS.To_flo);
save SAMPARAMS SAMPARAMS

% --- Executes during object creation, after setting all properties.
function To_flo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to To_flo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function To_fhi_Callback(hObject, eventdata, handles)
% hObject    handle to To_fhi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of To_fhi as text
%        str2double(get(hObject,'String')) returns contents of To_fhi as a double

load SAMPARAMS
SAMPARAMS.To_fhi=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.To_fhi,'Value',SAMPARAMS.To_fhi);
save SAMPARAMS SAMPARAMS

% --- Executes during object creation, after setting all properties.
function To_fhi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to To_fhi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function num_freq_steps_Callback(hObject, eventdata, handles)
% hObject    handle to num_freq_steps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of num_freq_steps as text
%        str2double(get(hObject,'String')) returns contents of num_freq_steps as a double

load SAMPARAMS
SAMPARAMS.num_freq_steps=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.num_freq_steps,'Value',SAMPARAMS.num_freq_steps);
save SAMPARAMS SAMPARAMS


% --- Executes during object creation, after setting all properties.
function num_freq_steps_CreateFcn(hObject, eventdata, handles)
% hObject    handle to num_freq_steps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function total_frames_lines_Callback(hObject, eventdata, handles)
% hObject    handle to total_frames_lines (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of total_frames_lines as text
%        str2double(get(hObject,'String')) returns contents of total_frames_lines as a double

load SAMPARAMS
SAMPARAMS.total_frames_lines=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.total_frames_lines,'Value',SAMPARAMS.total_frames_lines);
save SAMPARAMS SAMPARAMS

% --- Executes during object creation, after setting all properties.
function total_frames_lines_CreateFcn(hObject, eventdata, handles)
% hObject    handle to total_frames_lines (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function frame_dur_Callback(hObject, eventdata, handles)
% hObject    handle to frame_dur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of frame_dur as text
%        str2double(get(hObject,'String')) returns contents of frame_dur as a double

load SAMPARAMS
SAMPARAMS.frame_dur=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.frame_dur,'Value',SAMPARAMS.frame_dur);
save SAMPARAMS SAMPARAMS

% --- Executes during object creation, after setting all properties.
function frame_dur_CreateFcn(hObject, eventdata, handles)
% hObject    handle to frame_dur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function stim_start_Callback(hObject, eventdata, handles)
% hObject    handle to stim_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stim_start as text
%        str2double(get(hObject,'String')) returns contents of stim_start as a double

load SAMPARAMS
SAMPARAMS.stim_start=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.stim_start,'Value',SAMPARAMS.stim_start);
save SAMPARAMS SAMPARAMS

% --- Executes during object creation, after setting all properties.
function stim_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stim_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pip_dur_Callback(hObject, eventdata, handles)
% hObject    handle to pip_dur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pip_dur as text
%        str2double(get(hObject,'String')) returns contents of pip_dur as a double


% --- Executes during object creation, after setting all properties.
function pip_dur_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pip_dur (see GCBO)
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



function npips_per_train_Callback(hObject, eventdata, handles)
% hObject    handle to npips_per_train (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of npips_per_train as text
%        str2double(get(hObject,'String')) returns contents of npips_per_train as a double


% --- Executes during object creation, after setting all properties.
function npips_per_train_CreateFcn(hObject, eventdata, handles)
% hObject    handle to npips_per_train (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function level_lo_Callback(hObject, eventdata, handles)
% hObject    handle to level_lo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of level_lo as text
%        str2double(get(hObject,'String')) returns contents of level_lo as a double

load SAMPARAMS
SAMPARAMS.level_lo=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.level_lo,'Value',SAMPARAMS.level_lo);
save SAMPARAMS SAMPARAMS

% --- Executes during object creation, after setting all properties.
function level_lo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to level_lo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function level_hi_Callback(hObject, eventdata, handles)
% hObject    handle to level_hi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of level_hi as text
%        str2double(get(hObject,'String')) returns contents of level_hi as a double

load SAMPARAMS
SAMPARAMS.level_hi=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.level_hi,'Value',SAMPARAMS.level_hi);
save SAMPARAMS SAMPARAMS

% --- Executes during object creation, after setting all properties.
function level_hi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to level_hi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function num_att_steps_Callback(hObject, eventdata, handles)
% hObject    handle to num_att_steps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of num_att_steps as text
%        str2double(get(hObject,'String')) returns contents of num_att_steps as a double

load SAMPARAMS
SAMPARAMS.num_att_steps=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.num_att_steps,'Value',SAMPARAMS.num_att_steps);
save SAMPARAMS SAMPARAMS

% --- Executes during object creation, after setting all properties.
function num_att_steps_CreateFcn(hObject, eventdata, handles)
% hObject    handle to num_att_steps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function total_reps_Callback(hObject, eventdata, handles)
% hObject    handle to total_reps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of total_reps as text
%        str2double(get(hObject,'String')) returns contents of total_reps as a double

load SAMPARAMS
SAMPARAMS.total_reps=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.total_reps,'Value',SAMPARAMS.total_reps);
save SAMPARAMS SAMPARAMS

% --- Executes during object creation, after setting all properties.
function total_reps_CreateFcn(hObject, eventdata, handles)
% hObject    handle to total_reps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in done_button.
function done_button_Callback(hObject, eventdata, handles)
% hObject    handle to done_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

load SAMPARAMS
SAMPARAMS.frame_dur=get(handles.frame_dur,'Value');fdur=SAMPARAMS.frame_dur;
SAMPARAMS.total_frames_lines=get(handles.total_frames_lines,'Value');tfl=SAMPARAMS.total_frames_lines;
SAMPARAMS.stim_start=get(handles.stim_start,'Value');sf=SAMPARAMS.stim_start;
SAMPARAMS.tone_check=get(handles.tone_check,'Value');
SAMPARAMS.noise_check=get(handles.noise_check,'Value');
SAMPARAMS.To_flo=get(handles.To_flo,'Value');To_flo=SAMPARAMS.To_flo;
SAMPARAMS.To_fhi=get(handles.To_fhi,'Value');To_fhi=SAMPARAMS.To_fhi;
SAMPARAMS.num_freq_steps=get(handles.num_freq_steps,'Value');
SAMPARAMS.No_flo=get(handles.No_flo,'Value');No_flo=SAMPARAMS.No_flo;
SAMPARAMS.No_fhi=get(handles.No_fhi,'Value');No_fhi=SAMPARAMS.No_fhi;
SAMPARAMS.mod_freq=get(handles.mod_freq,'Value');fm=SAMPARAMS.mod_freq;
SAMPARAMS.mod_depth=get(handles.mod_depth,'Value');md=SAMPARAMS.mod_depth;
SAMPARAMS.dur=get(handles.dur,'Value');dur=SAMPARAMS.dur;
SAMPARAMS.level_lo=get(handles.level_lo,'Value');ll=SAMPARAMS.level_lo;
SAMPARAMS.level_hi=get(handles.level_hi,'Value');lh=SAMPARAMS.level_hi;
SAMPARAMS.num_att_steps=get(handles.num_att_steps,'Value');na=SAMPARAMS.num_att_steps;
SAMPARAMS.total_reps=get(handles.total_reps,'Value');treps=SAMPARAMS.total_reps;
if SAMPARAMS.tone_check == 1
    set(handles.tone_bgbox,'BackgroundColor',[0.678 0.922 1])
    set(handles.noise_bgbox,'BackgroundColor',[0.702 0.702 0.702])
    set(handles.noise_check,'Value',~SAMPARAMS.tone_check);
    nfs=SAMPARAMS.num_freq_steps;
else
    set(handles.noise_bgbox,'BackgroundColor',[0.678 0.922 1])
    set(handles.tone_bgbox,'BackgroundColor',[0.702 0.702 0.702])
    set(handles.tone_check,'Value',~SAMPARAMS.noise_check);
    nfs=1;
end

save SAMPARAMS SAMPARAMS

load AudStimPARAMS
AudStimPARAMS.type='SAM';
AudStimPARAMS.stim_protocol=SAMPARAMS;
close(handles.figure1)
total_prairie_iterations=na*nfs*treps;
each_stim_dur=dur;
each_prairie_dur=tfl*fdur;
lines_per_set=nfs*na;

if AudStimPARAMS.MultFrame==0
%for at least 50% duty cycle

    least_dur=2*each_stim_dur;least_prairie_frames=max([ceil(2*each_stim_dur/fdur) sf+ceil(each_stim_dur/fdur)]);
    if least_dur<each_prairie_dur
        durcheck_str='PRAIRIE: Number of frames/lines per iter OKAY';
        disp_bgcolor=[0 .8 1];
    else
        eval(sprintf('durcheck_str=''PRAIRIE: Increase frames/lines per iter to AT LEAST %i'';',least_prairie_frames))
        disp_bgcolor=[1 0 0];
    end
    eval(sprintf('add_dur_check='' ...[At least %i : currently %i]'';',least_prairie_frames,tfl))
    eval(sprintf('itercheck_str=''Set PAIRIE Number of ITERATIONS to AT LEAST %i'';',total_prairie_iterations))
    display_str=strcat(durcheck_str,add_dur_check,'*\*/\*/*',itercheck_str);
    load SAM_handles
    set(AA_handles.check_disp,'String',display_str)
    set(AA_handles.check_disp,'BackgroundColor',disp_bgcolor)
    set(AA_handles.check_disp,'FontSize',9)
    if SAMPARAMS.tone_check == 1
        eval(sprintf('prot_str=''SAM Tone: Freq=%i-%i kHz, %i f-steps, %i atten steps from %4.1f to %4.1f dB, %6.3f sec long, Starts at frame/line %i'';',fix(To_flo/1000),fix(To_fhi/1000),nfs,na,ll,lh,dur,sf))
    else
        eval(sprintf('prot_str=''SAM Noise: Bandwidth %i-%i kHz, %i atten steps from %4.1f to %4.1f dB, %6.3f sec long, Starts at frame/line %i'';',fix(No_flo/1000),fix(No_fhi/1000),na,ll,lh,dur,sf))
    end
    set(AA_handles.disp_protocol,'String',prot_str)

elseif AudStimPARAMS.MultFrame==1
    gapdur=AudStimPARAMS.MultFrameVal;
    nframes_per_iter=sf+(fix((each_stim_dur+gapdur)/fdur)+1)*lines_per_set;
    if tfl==nframes_per_iter
        durcheck_str='PRAIRIE: Number of frames/lines per iter OKAY';
        disp_bgcolor=[0 .8 1];
    else
        eval(sprintf('durcheck_str=''PRAIRIE: Set frames/lines per iter to %i'';',nframes_per_iter))
        disp_bgcolor=[1 0 0];
    end
    eval(sprintf('add_dur_check='' ...[Must be %i : currently %i]'';',nframes_per_iter,tfl))
    eval(sprintf('itercheck_str=''Set PAIRIE Number of ITERATIONS to AT LEAST %i'';',treps))
    display_str=strcat(durcheck_str,add_dur_check,'*\*/\*/*',itercheck_str);
    load SAM_handles
    set(AA_handles.check_disp,'String',display_str)
    set(AA_handles.check_disp,'BackgroundColor',disp_bgcolor)
    set(AA_handles.check_disp,'FontSize',9)
    if SAMPARAMS.tone_check == 1
        eval(sprintf('prot_str=''SAM Tone: Freq=%i-%i kHz, %i f-steps, %i atten steps from %4.1f to %4.1f dB, %6.3f sec long, Starts at frame/line %i'';',fix(To_flo/1000),fix(To_fhi/1000),nfs,na,ll,lh,dur,sf))
    else
        eval(sprintf('prot_str=''SAM Noise: Bandwidth %i-%i kHz, %i atten steps from %4.1f to %4.1f dB, %6.3f sec long, Starts at frame/line %i'';',fix(No_flo/1000),fix(No_fhi/1000),na,ll,lh,dur,sf))
    end
    set(AA_handles.disp_protocol,'String',prot_str)
end
    
AudStimPARAMS.protocol_str=prot_str;
save AudStimPARAMS AudStimPARAMS


function mod_freq_Callback(hObject, eventdata, handles)
% hObject    handle to mod_freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mod_freq as text
%        str2double(get(hObject,'String')) returns contents of mod_freq as a double

load SAMPARAMS
SAMPARAMS.mod_freq=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.mod_freq,'Value',SAMPARAMS.mod_freq);
save SAMPARAMS SAMPARAMS

% --- Executes during object creation, after setting all properties.
function mod_freq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mod_freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mod_depth_Callback(hObject, eventdata, handles)
% hObject    handle to mod_depth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mod_depth as text
%        str2double(get(hObject,'String')) returns contents of mod_depth as a double

load SAMPARAMS
SAMPARAMS.mod_depth=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.mod_depth,'Value',SAMPARAMS.mod_depth);
save SAMPARAMS SAMPARAMS

% --- Executes during object creation, after setting all properties.
function mod_depth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mod_depth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dur_Callback(hObject, eventdata, handles)
% hObject    handle to dur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dur as text
%        str2double(get(hObject,'String')) returns contents of dur as a double

load SAMPARAMS
SAMPARAMS.dur=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.dur,'Value',SAMPARAMS.dur);
save SAMPARAMS SAMPARAMS

% --- Executes during object creation, after setting all properties.
function dur_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


