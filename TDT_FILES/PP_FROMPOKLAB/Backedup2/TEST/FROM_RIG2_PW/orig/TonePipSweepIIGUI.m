function varargout = TonePipSweepIIGUI(varargin)
% TONEPIPSWEEPIIGUI M-file for TonePipSweepIIGUI.fig
%      TONEPIPSWEEPIIGUI, by itself, creates a new TONEPIPSWEEPIIGUI or raises the existing
%      singleton*.
%
%      H = TONEPIPSWEEPIIGUI returns the handle to a new TONEPIPSWEEPIIGUI or the handle to
%      the existing singleton*.
%
%      TONEPIPSWEEPIIGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TONEPIPSWEEPIIGUI.M with the given input arguments.
%
%      TONEPIPSWEEPIIGUI('Property','Value',...) creates a new TONEPIPSWEEPIIGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TonePipSweepIIGUI_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to TonePipSweepIIGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help TonePipSweepIIGUI

% Last Modified by GUIDE v2.5 28-May-2009 16:22:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TonePipSweepIIGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @TonePipSweepIIGUI_OutputFcn, ...
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


% --- Executes just before TonePipSweepIIGUI is made visible.
function TonePipSweepIIGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to TonePipSweepIIGUI (see VARARGIN)

% Choose default command line output for TonePipSweepIIGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

load TonePipSweepIIPARAMS
load AuditoryII_handles

eval(sprintf('set(handles.frame_,''String'',''%5.3f'');',TonePipSweepIIPARAMS.frame_dur))
set(handles.frame_,'Value',TonePipSweepIIPARAMS.frame_dur);
eval(sprintf('set(handles.exp_dur,''String'',''%5.3f'');',TonePipSweepIIPARAMS.exp_dur))
set(handles.exp_dur,'Value',TonePipSweepIIPARAMS.exp_dur);
eval(sprintf('set(handles.gap_dur,''String'',''%5.3f'');',TonePipSweepIIPARAMS.gap_dur))
set(handles.gap_dur,'Value',TonePipSweepIIPARAMS.gap_dur);
eval(sprintf('set(handles.pip_dur,''String'',''%5.3f'');',TonePipSweepIIPARAMS.pip_dur))
set(handles.pip_dur,'Value',TonePipSweepIIPARAMS.pip_dur);
eval(sprintf('set(handles.total_frames_lines,''String'',''%i'');',TonePipSweepIIPARAMS.total_frames_lines))
set(handles.total_frames_lines,'Value',TonePipSweepIIPARAMS.total_frames_lines);
eval(sprintf('set(handles.stim_start,''String'',''%i'');',TonePipSweepIIPARAMS.stim_start))
set(handles.stim_start,'Value',TonePipSweepIIPARAMS.stim_start);
eval(sprintf('set(handles.ipi_val,''String'',''%8.3f'');',TonePipSweepIIPARAMS.ipi_val))
set(handles.ipi_val,'Value',TonePipSweepIIPARAMS.ipi_val);
eval(sprintf('set(handles.freq_lo,''String'',''%8.1f'');',TonePipSweepIIPARAMS.freq_lo))
set(handles.freq_lo,'Value',TonePipSweepIIPARAMS.freq_lo);
eval(sprintf('set(handles.freq_hi,''String'',''%8.1f'');',TonePipSweepIIPARAMS.freq_hi))
set(handles.freq_hi,'Value',TonePipSweepIIPARAMS.freq_hi);
eval(sprintf('set(handles.num_freq_steps,''String'',''%i'');',TonePipSweepIIPARAMS.num_freq_steps))
set(handles.num_freq_steps,'Value',TonePipSweepIIPARAMS.num_freq_steps);
eval(sprintf('set(handles.level_lo,''String'',''%3.1f'');',TonePipSweepIIPARAMS.level_lo))
set(handles.level_lo,'Value',TonePipSweepIIPARAMS.level_lo);
eval(sprintf('set(handles.level_hi,''String'',''%3.1f'');',TonePipSweepIIPARAMS.level_hi))
set(handles.level_hi,'Value',TonePipSweepIIPARAMS.level_hi);
eval(sprintf('set(handles.num_att_steps,''String'',''%i'');',TonePipSweepIIPARAMS.num_att_steps))
set(handles.num_att_steps,'Value',TonePipSweepIIPARAMS.num_att_steps);
eval(sprintf('set(handles.npips_per_train,''String'',''%i'');',TonePipSweepIIPARAMS.npips_per_train))
set(handles.npips_per_train,'Value',TonePipSweepIIPARAMS.npips_per_train);
eval(sprintf('set(handles.total_reps,''String'',''%i'');',TonePipSweepIIPARAMS.total_reps))
set(handles.total_reps,'Value',TonePipSweepIIPARAMS.total_reps);

% UIWAIT makes TonePipSweepIIGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = TonePipSweepIIGUI_OutputFcn(hObject, eventdata, handles) 
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

load TonePipSweepIIPARAMS
TonePipSweepIIPARAMS.frame_dur=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.frame_,'Value',TonePipSweepIIPARAMS.frame_dur);

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

load TonePipSweepIIPARAMS
TonePipSweepIIPARAMS.pip_dur=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.pip_dur,'Value',TonePipSweepIIPARAMS.pip_dur);

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

load TonePipSweepIIPARAMS
TonePipSweepIIPARAMS.total_frames_lines=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.total_frames_lines,'Value',TonePipSweepIIPARAMS.total_frames_lines);

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

load TonePipSweepIIPARAMS
TonePipSweepIIPARAMS.stim_start=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.stim_start,'Value',TonePipSweepIIPARAMS.stim_start);

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

load TonePipSweepIIPARAMS
TonePipSweepIIPARAMS.ipi_val=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.ipi_val,'Value',TonePipSweepIIPARAMS.ipi_val);

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

load TonePipSweepIIPARAMS
TonePipSweepIIPARAMS.freq_lo=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.freq_lo,'Value',TonePipSweepIIPARAMS.freq_lo);

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

load TonePipSweepIIPARAMS
TonePipSweepIIPARAMS.freq_hi=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.freq_hi,'Value',TonePipSweepIIPARAMS.freq_hi);

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

load TonePipSweepIIPARAMS
TonePipSweepIIPARAMS.num_freq_steps=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.num_freq_steps,'Value',TonePipSweepIIPARAMS.num_freq_steps);

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

load TonePipSweepIIPARAMS
TonePipSweepIIPARAMS.level_lo=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.level_lo,'Value',TonePipSweepIIPARAMS.level_lo);

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

load TonePipSweepIIPARAMS
TonePipSweepIIPARAMS.level_hi=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.level_hi,'Value',TonePipSweepIIPARAMS.level_hi);

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

load TonePipSweepIIPARAMS
TonePipSweepIIPARAMS.num_att_steps=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.num_att_steps,'Value',TonePipSweepIIPARAMS.num_att_steps);

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

load TonePipSweepIIPARAMS
TonePipSweepIIPARAMS.npips_per_train=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.npips_per_train,'Value',TonePipSweepIIPARAMS.npips_per_train);

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

load TonePipSweepIIPARAMS
TonePipSweepIIPARAMS.total_reps=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.total_reps,'Value',TonePipSweepIIPARAMS.total_reps);

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

load TonePipSweepIIPARAMS

TonePipSweepIIPARAMS.frame_dur=get(handles.frame_,'Value');fdur=TonePipSweepIIPARAMS.frame_dur;
TonePipSweepIIPARAMS.exp_dur=get(handles.exp_dur,'Value');edur=TonePipSweepIIPARAMS.exp_dur;
TonePipSweepIIPARAMS.gap_dur=get(handles.gap_dur,'Value');gapdur=TonePipSweepIIPARAMS.gap_dur;
TonePipSweepIIPARAMS.pip_dur=get(handles.pip_dur,'Value');
TonePipSweepIIPARAMS.total_frames_lines=get(handles.total_frames_lines,'Value');tfl=TonePipSweepIIPARAMS.total_frames_lines;
TonePipSweepIIPARAMS.stim_start=get(handles.stim_start,'Value');sf=TonePipSweepIIPARAMS.stim_start;
TonePipSweepIIPARAMS.ipi_val=get(handles.ipi_val,'Value');ipi=TonePipSweepIIPARAMS.ipi_val;
TonePipSweepIIPARAMS.freq_lo=get(handles.freq_lo,'Value');fl=TonePipSweepIIPARAMS.freq_lo;
TonePipSweepIIPARAMS.freq_hi=get(handles.freq_hi,'Value');fh=TonePipSweepIIPARAMS.freq_hi;
TonePipSweepIIPARAMS.num_freq_steps=get(handles.num_freq_steps,'Value');nf=TonePipSweepIIPARAMS.num_freq_steps;
TonePipSweepIIPARAMS.level_lo=get(handles.level_lo,'Value');ll=TonePipSweepIIPARAMS.level_lo;
TonePipSweepIIPARAMS.level_hi=get(handles.level_hi,'Value');lh=TonePipSweepIIPARAMS.level_hi;
TonePipSweepIIPARAMS.num_att_steps=get(handles.num_att_steps,'Value');na=TonePipSweepIIPARAMS.num_att_steps;
TonePipSweepIIPARAMS.npips_per_train=get(handles.npips_per_train,'Value');nppt=TonePipSweepIIPARAMS.npips_per_train;
TonePipSweepIIPARAMS.total_reps=get(handles.total_reps,'Value');treps=TonePipSweepIIPARAMS.total_reps;

save TonePipSweepIIPARAMS TonePipSweepIIPARAMS
load AudStimIIPARAMS
AudStimIIPARAMS.type='TonePipSweep';
AudStimIIPARAMS.stim_protocol=TonePipSweepIIPARAMS;
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
load TPSII_handles
set(AAII_handles.check_disp,'String',display_str)
set(AAII_handles.check_disp,'BackgroundColor',disp_bgcolor)
set(AAII_handles.check_disp,'FontSize',9)
eval(sprintf('prot_str=''TonePipSweep: %i freqs from %8.1f to %8.1f Hz, %i atten steps from %4.1f to %4.1f dB, %i Tone pips per train, Starts at frame %i'';',nf,fl,fh,na,ll,lh,nppt,sf))
set(AAII_handles.disp_protocol,'String',prot_str)

AudStimIIPARAMS.protocol_str=prot_str;
save AudStimIIPARAMS AudStimIIPARAMS

function exp_dur_Callback(hObject, eventdata, handles)
% hObject    handle to exp_dur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of exp_dur as text
%        str2double(get(hObject,'String')) returns contents of exp_dur as a double

load TonePipSweepIIPARAMS
TonePipSweepIIPARAMS.exp_dur=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.exp_dur,'Value',TonePipSweepIIPARAMS.exp_dur);

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

load TonePipSweepIIPARAMS
TonePipSweepIIPARAMS.gap_dur=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.gap_dur,'Value',TonePipSweepIIPARAMS.gap_dur);

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


