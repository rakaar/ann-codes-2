function varargout = HCIIGUI(varargin)
% HCIIGUI M-file for HCIIGUI.fig
%      HCIIGUI, by itself, creates a new HCIIGUI or raises the existing
%      singleton*.
%
%      H = HCIIGUI returns the handle to a new HCIIGUI or the handle to
%      the existing singleton*.
%
%      HCIIGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HCIIGUI.M with the given input arguments.
%
%      HCIIGUI('Property','Value',...) creates a new HCIIGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before HCIIGUI_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to HCIIGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help HCIIGUI

% Last Modified by GUIDE v2.5 02-Feb-2011 13:20:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @HCIIGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @HCIIGUI_OutputFcn, ...
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


% --- Executes just before HCIIGUI is made visible.
function HCIIGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to HCIIGUI (see VARARGIN)

% Choose default command line output for HCIIGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

load HCIIPARAMS
load AuditoryII_handles

eval(sprintf('set(handles.frame_,''String'',''%5.3f'');',HCIIPARAMS.frame_dur))
set(handles.frame_,'Value',HCIIPARAMS.frame_dur);
eval(sprintf('set(handles.exp_dur,''String'',''%5.3f'');',HCIIPARAMS.exp_dur))
set(handles.exp_dur,'Value',HCIIPARAMS.exp_dur);
eval(sprintf('set(handles.gap_dur,''String'',''%5.3f'');',HCIIPARAMS.gap_dur))
set(handles.gap_dur,'Value',HCIIPARAMS.gap_dur);
eval(sprintf('set(handles.pip_dur,''String'',''%5.3f'');',HCIIPARAMS.pip_dur))
set(handles.pip_dur,'Value',HCIIPARAMS.pip_dur);
eval(sprintf('set(handles.total_frames_lines,''String'',''%i'');',HCIIPARAMS.total_frames_lines))
set(handles.total_frames_lines,'Value',HCIIPARAMS.total_frames_lines);
eval(sprintf('set(handles.stim_start,''String'',''%i'');',HCIIPARAMS.stim_start))
set(handles.stim_start,'Value',HCIIPARAMS.stim_start);
eval(sprintf('set(handles.ipi_val,''String'',''%8.3f'');',HCIIPARAMS.ipi_val))
set(handles.ipi_val,'Value',HCIIPARAMS.ipi_val);
eval(sprintf('set(handles.freq_lo,''String'',''%8.1f'');',HCIIPARAMS.freq_lo))
set(handles.freq_lo,'Value',HCIIPARAMS.freq_lo);
eval(sprintf('set(handles.freq_hi,''String'',''%8.1f'');',HCIIPARAMS.freq_hi))
set(handles.freq_hi,'Value',HCIIPARAMS.freq_hi);
eval(sprintf('set(handles.num_freq_steps,''String'',''%i'');',HCIIPARAMS.num_freq_steps))
set(handles.num_freq_steps,'Value',HCIIPARAMS.num_freq_steps);
eval(sprintf('set(handles.level_lo,''String'',''%3.1f'');',HCIIPARAMS.level_lo))
set(handles.level_lo,'Value',HCIIPARAMS.level_lo);
eval(sprintf('set(handles.level_hi,''String'',''%3.1f'');',HCIIPARAMS.level_hi))
set(handles.level_hi,'Value',HCIIPARAMS.level_hi);
eval(sprintf('set(handles.num_att_steps,''String'',''%i'');',HCIIPARAMS.num_att_steps))
set(handles.num_att_steps,'Value',HCIIPARAMS.num_att_steps);
eval(sprintf('set(handles.npips_per_train,''String'',''%i'');',HCIIPARAMS.npips_per_train))
set(handles.npips_per_train,'Value',HCIIPARAMS.npips_per_train);
eval(sprintf('set(handles.total_reps,''String'',''%i'');',HCIIPARAMS.total_reps))
set(handles.total_reps,'Value',HCIIPARAMS.total_reps);
eval(sprintf('set(handles.numhc,''String'',''%i'');',HCIIPARAMS.numhc))
set(handles.numhc,'Value',HCIIPARAMS.numhc);

% UIWAIT makes HCIIGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = HCIIGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles;



function frame__Callback(hObject, eventdata, handles)
% hObject    handle to frame_ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of frame_ as text
%        str2double(get(hObject,'String')) returns contents of frame_ as a double

load HCIIPARAMS
HCIIPARAMS.frame_dur=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.frame_,'Value',HCIIPARAMS.frame_dur);

% --- Executes during object creation, after setting all properties.
function frame__CreateFcn(hObject, eventdata, handles)
% hObject    handle to frame_ (see GCBO)
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

load HCIIPARAMS
HCIIPARAMS.pip_dur=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.pip_dur,'Value',HCIIPARAMS.pip_dur);

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



function total_frames_lines_Callback(hObject, eventdata, handles)
% hObject    handle to total_frames_lines (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of total_frames_lines as text
%        str2double(get(hObject,'String')) returns contents of total_frames_lines as a double

load HCIIPARAMS
HCIIPARAMS.total_frames_lines=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.total_frames_lines,'Value',HCIIPARAMS.total_frames_lines);

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



function stim_start_Callback(hObject, eventdata, handles)
% hObject    handle to stim_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stim_start as text
%        str2double(get(hObject,'String')) returns contents of stim_start as a double

load HCIIPARAMS
HCIIPARAMS.stim_start=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.stim_start,'Value',HCIIPARAMS.stim_start);

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



function ipi_val_Callback(hObject, eventdata, handles)
% hObject    handle to ipi_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ipi_val as text
%        str2double(get(hObject,'String')) returns contents of ipi_val as a double

load HCIIPARAMS
HCIIPARAMS.ipi_val=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.ipi_val,'Value',HCIIPARAMS.ipi_val);

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



function freq_lo_Callback(hObject, eventdata, handles)
% hObject    handle to freq_lo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of freq_lo as text
%        str2double(get(hObject,'String')) returns contents of freq_lo as a double

load HCIIPARAMS
HCIIPARAMS.freq_lo=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.freq_lo,'Value',HCIIPARAMS.freq_lo);

% --- Executes during object creation, after setting all properties.
function freq_lo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to freq_lo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function freq_hi_Callback(hObject, eventdata, handles)
% hObject    handle to freq_hi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of freq_hi as text
%        str2double(get(hObject,'String')) returns contents of freq_hi as a double

load HCIIPARAMS
HCIIPARAMS.freq_hi=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.freq_hi,'Value',HCIIPARAMS.freq_hi);

% --- Executes during object creation, after setting all properties.
function freq_hi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to freq_hi (see GCBO)
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

load HCIIPARAMS
HCIIPARAMS.num_freq_steps=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.num_freq_steps,'Value',HCIIPARAMS.num_freq_steps);

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



function level_lo_Callback(hObject, eventdata, handles)
% hObject    handle to level_lo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of level_lo as text
%        str2double(get(hObject,'String')) returns contents of level_lo as a double

load HCIIPARAMS
HCIIPARAMS.level_lo=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.level_lo,'Value',HCIIPARAMS.level_lo);

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

load HCIIPARAMS
HCIIPARAMS.level_hi=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.level_hi,'Value',HCIIPARAMS.level_hi);

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

load HCIIPARAMS
HCIIPARAMS.num_att_steps=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.num_att_steps,'Value',HCIIPARAMS.num_att_steps);

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



function npips_per_train_Callback(hObject, eventdata, handles)
% hObject    handle to npips_per_train (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of npips_per_train as text
%        str2double(get(hObject,'String')) returns contents of npips_per_train as a double

load HCIIPARAMS
HCIIPARAMS.npips_per_train=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.npips_per_train,'Value',HCIIPARAMS.npips_per_train);

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



function total_reps_Callback(hObject, eventdata, handles)
% hObject    handle to total_reps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of total_reps as text
%        str2double(get(hObject,'String')) returns contents of total_reps as a double

load HCIIPARAMS
HCIIPARAMS.total_reps=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.total_reps,'Value',HCIIPARAMS.total_reps);

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

load HCIIPARAMS

HCIIPARAMS.frame_dur=get(handles.frame_,'Value');fdur=HCIIPARAMS.frame_dur;
HCIIPARAMS.exp_dur=get(handles.exp_dur,'Value');edur=HCIIPARAMS.exp_dur;
HCIIPARAMS.gap_dur=get(handles.gap_dur,'Value');gapdur=HCIIPARAMS.gap_dur;
HCIIPARAMS.pip_dur=get(handles.pip_dur,'Value');
HCIIPARAMS.total_frames_lines=get(handles.total_frames_lines,'Value');tfl=HCIIPARAMS.total_frames_lines;
HCIIPARAMS.stim_start=get(handles.stim_start,'Value');sf=HCIIPARAMS.stim_start;
HCIIPARAMS.ipi_val=get(handles.ipi_val,'Value');ipi=HCIIPARAMS.ipi_val;
HCIIPARAMS.freq_lo=get(handles.freq_lo,'Value');fl=HCIIPARAMS.freq_lo;
HCIIPARAMS.freq_hi=get(handles.freq_hi,'Value');fh=HCIIPARAMS.freq_hi;
HCIIPARAMS.num_freq_steps=get(handles.num_freq_steps,'Value');nf=HCIIPARAMS.num_freq_steps;
HCIIPARAMS.level_lo=get(handles.level_lo,'Value');ll=HCIIPARAMS.level_lo;
HCIIPARAMS.level_hi=get(handles.level_hi,'Value');lh=HCIIPARAMS.level_hi;
HCIIPARAMS.num_att_steps=get(handles.num_att_steps,'Value');na=HCIIPARAMS.num_att_steps;
HCIIPARAMS.npips_per_train=get(handles.npips_per_train,'Value');nppt=HCIIPARAMS.npips_per_train;
HCIIPARAMS.total_reps=get(handles.total_reps,'Value');treps=HCIIPARAMS.total_reps;
HCIIPARAMS.numhc=get(handles.numhc,'Value');numhc=HCIIPARAMS.numhc;

save HCIIPARAMS HCIIPARAMS
load AudStimIIPARAMS
AudStimIIPARAMS.type='HC';
AudStimIIPARAMS.stim_protocol=HCIIPARAMS;
close(handles.figure1)
total_prairie_iterations=nf*na*treps;
each_stim_dur=ipi*nppt;
each_prairie_dur=tfl*fdur;
lines_per_set=nf*na;

nframes_per_iter=sf+(fix((each_stim_dur+gapdur)/fdur)+1)*total_prairie_iterations;
if tfl==nframes_per_iter
    durcheck_str='MicroManager: Number of frames OKAY';
    disp_bgcolor=[0 .8 1];
else
    eval(sprintf('durcheck_str=''MicroManager: Set frames to %i'';',nframes_per_iter))
    disp_bgcolor=[1 0 0];
end
eval(sprintf('add_dur_check='' ...[Must be %i : currently %i]'';',nframes_per_iter,tfl))
eval(sprintf('itercheck_str=''No Iteration check for MicroManager'';'))
display_str=strcat(durcheck_str,add_dur_check,'*\*/\*/*',itercheck_str);
load HCII_handles
set(AAII_handles.check_disp,'String',display_str)
set(AAII_handles.check_disp,'BackgroundColor',disp_bgcolor)
set(AAII_handles.check_disp,'FontSize',9)
eval(sprintf('prot_str=''HC: %i freqs from %8.1f to %8.1f Hz, %i atten steps from %4.1f to %4.1f dB, %i Tone pips per train, Starts at frame %i'';',nf,fl,fh,na,ll,lh,nppt,sf))
set(AAII_handles.disp_protocol,'String',prot_str)

AudStimIIPARAMS.protocol_str=prot_str;
save AudStimIIPARAMS AudStimIIPARAMS

function exp_dur_Callback(hObject, eventdata, handles)
% hObject    handle to exp_dur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of exp_dur as text
%        str2double(get(hObject,'String')) returns contents of exp_dur as a double

load HCIIPARAMS
HCIIPARAMS.exp_dur=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.exp_dur,'Value',HCIIPARAMS.exp_dur);

% --- Executes during object creation, after setting all properties.
function exp_dur_CreateFcn(hObject, eventdata, handles)
% hObject    handle to exp_dur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function gap_dur_Callback(hObject, eventdata, handles)
% hObject    handle to gap_dur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gap_dur as text
%        str2double(get(hObject,'String')) returns contents of gap_dur as a double

load HCIIPARAMS
HCIIPARAMS.gap_dur=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.gap_dur,'Value',HCIIPARAMS.gap_dur);

% --- Executes during object creation, after setting all properties.
function gap_dur_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gap_dur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function numhc_Callback(hObject, eventdata, handles)
% hObject    handle to numhc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of numhc as text
%        str2double(get(hObject,'String')) returns contents of numhc as a double

load HCIIPARAMS
HCIIPARAMS.numhc=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.numhc,'Value',HCIIPARAMS.numhc);


% --- Executes during object creation, after setting all properties.
function numhc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numhc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


