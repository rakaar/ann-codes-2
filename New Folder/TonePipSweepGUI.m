function varargout = TonePipSweepGUI(varargin)
% TONEPIPSWEEPGUI M-file for TonePipSweepGUI.fig
%      TONEPIPSWEEPGUI, by itself, creates a new TONEPIPSWEEPGUI or raises the existing
%      singleton*.
%
%      H = TONEPIPSWEEPGUI returns the handle to a new TONEPIPSWEEPGUI or the handle to
%      the existing singleton*.
%
%      TONEPIPSWEEPGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TONEPIPSWEEPGUI.M with the given input arguments.
%
%      TONEPIPSWEEPGUI('Property','Value',...) creates a new TONEPIPSWEEPGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TonePipSweepGUI_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to TonePipSweepGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help TonePipSweepGUI

% Last Modified by GUIDE v2.5 08-Jul-2008 00:59:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TonePipSweepGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @TonePipSweepGUI_OutputFcn, ...
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


% --- Executes just before TonePipSweepGUI is made visible.
function TonePipSweepGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to TonePipSweepGUI (see VARARGIN)

% Choose default command line output for TonePipSweepGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

load TonePipSweepPARAMS
load Auditory_handles

wtd_val=get(PP_handles.what_to_do,'Value');
if wtd_val==7
    set(handles.text3,'String','Total Time (sec)')
    set(handles.text4,'String','Start Time (sec)')
end
eval(sprintf('set(handles.frame_dur,''String'',''%5.3f'');',TonePipSweepPARAMS.frame_dur))
set(handles.frame_dur,'Value',TonePipSweepPARAMS.frame_dur);


eval(sprintf('set(handles.pip_dur,''String'',''%5.3f'');',TonePipSweepPARAMS.pip_dur))
set(handles.pip_dur,'Value',TonePipSweepPARAMS.pip_dur);
eval(sprintf('set(handles.total_frames_lines,''String'',''%i'');',TonePipSweepPARAMS.total_frames_lines))
set(handles.total_frames_lines,'Value',TonePipSweepPARAMS.total_frames_lines);
eval(sprintf('set(handles.stim_start,''String'',''%i'');',TonePipSweepPARAMS.stim_start))
set(handles.stim_start,'Value',TonePipSweepPARAMS.stim_start);
eval(sprintf('set(handles.ipi_val,''String'',''%8.3f'');',TonePipSweepPARAMS.ipi_val))
set(handles.ipi_val,'Value',TonePipSweepPARAMS.ipi_val);
eval(sprintf('set(handles.freq_lo,''String'',''%8.1f'');',TonePipSweepPARAMS.freq_lo))
set(handles.freq_lo,'Value',TonePipSweepPARAMS.freq_lo);
eval(sprintf('set(handles.freq_hi,''String'',''%8.1f'');',TonePipSweepPARAMS.freq_hi))
set(handles.freq_hi,'Value',TonePipSweepPARAMS.freq_hi);
eval(sprintf('set(handles.num_freq_steps,''String'',''%i'');',TonePipSweepPARAMS.num_freq_steps))
set(handles.num_freq_steps,'Value',TonePipSweepPARAMS.num_freq_steps);
eval(sprintf('set(handles.level_lo,''String'',''%3.1f'');',TonePipSweepPARAMS.level_lo))
set(handles.level_lo,'Value',TonePipSweepPARAMS.level_lo);
eval(sprintf('set(handles.level_hi,''String'',''%3.1f'');',TonePipSweepPARAMS.level_hi))
set(handles.level_hi,'Value',TonePipSweepPARAMS.level_hi);
eval(sprintf('set(handles.num_att_steps,''String'',''%i'');',TonePipSweepPARAMS.num_att_steps))
set(handles.num_att_steps,'Value',TonePipSweepPARAMS.num_att_steps);
eval(sprintf('set(handles.npips_per_train,''String'',''%i'');',TonePipSweepPARAMS.npips_per_train))
set(handles.npips_per_train,'Value',TonePipSweepPARAMS.npips_per_train);
eval(sprintf('set(handles.total_reps,''String'',''%i'');',TonePipSweepPARAMS.total_reps))
set(handles.total_reps,'Value',TonePipSweepPARAMS.total_reps);

% UIWAIT makes TonePipSweepGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = TonePipSweepGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles;



function frame_dur_Callback(hObject, eventdata, handles)
% hObject    handle to frame_dur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of frame_dur as text
%        str2double(get(hObject,'String')) returns contents of frame_dur as a double

load TonePipSweepPARAMS
TonePipSweepPARAMS.frame_dur=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.frame_dur,'Value',TonePipSweepPARAMS.frame_dur);

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



function pip_dur_Callback(hObject, eventdata, handles)
% hObject    handle to pip_dur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pip_dur as text
%        str2double(get(hObject,'String')) returns contents of pip_dur as a double

load TonePipSweepPARAMS
TonePipSweepPARAMS.pip_dur=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.pip_dur,'Value',TonePipSweepPARAMS.pip_dur);

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

load TonePipSweepPARAMS
TonePipSweepPARAMS.total_frames_lines=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.total_frames_lines,'Value',TonePipSweepPARAMS.total_frames_lines);

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

load TonePipSweepPARAMS
TonePipSweepPARAMS.stim_start=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.stim_start,'Value',TonePipSweepPARAMS.stim_start);

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

load TonePipSweepPARAMS
TonePipSweepPARAMS.ipi_val=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.ipi_val,'Value',TonePipSweepPARAMS.ipi_val);

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

load TonePipSweepPARAMS
TonePipSweepPARAMS.freq_lo=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.freq_lo,'Value',TonePipSweepPARAMS.freq_lo);

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

load TonePipSweepPARAMS
TonePipSweepPARAMS.freq_hi=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.freq_hi,'Value',TonePipSweepPARAMS.freq_hi);

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

load TonePipSweepPARAMS
TonePipSweepPARAMS.num_freq_steps=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.num_freq_steps,'Value',TonePipSweepPARAMS.num_freq_steps);

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

load TonePipSweepPARAMS
TonePipSweepPARAMS.level_lo=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.level_lo,'Value',TonePipSweepPARAMS.level_lo);

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

load TonePipSweepPARAMS
TonePipSweepPARAMS.level_hi=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.level_hi,'Value',TonePipSweepPARAMS.level_hi);

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

load TonePipSweepPARAMS
TonePipSweepPARAMS.num_att_steps=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.num_att_steps,'Value',TonePipSweepPARAMS.num_att_steps);

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

load TonePipSweepPARAMS
TonePipSweepPARAMS.npips_per_train=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.npips_per_train,'Value',TonePipSweepPARAMS.npips_per_train);

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

load TonePipSweepPARAMS
TonePipSweepPARAMS.total_reps=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.total_reps,'Value',TonePipSweepPARAMS.total_reps);

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


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

load TonePipSweepPARAMS

TonePipSweepPARAMS.frame_dur=get(handles.frame_dur,'Value');fdur=TonePipSweepPARAMS.frame_dur;
TonePipSweepPARAMS.pip_dur=get(handles.pip_dur,'Value');
TonePipSweepPARAMS.total_frames_lines=get(handles.total_frames_lines,'Value');tfl=TonePipSweepPARAMS.total_frames_lines;
TonePipSweepPARAMS.stim_start=get(handles.stim_start,'Value');sf=TonePipSweepPARAMS.stim_start;
TonePipSweepPARAMS.ipi_val=get(handles.ipi_val,'Value');ipi=TonePipSweepPARAMS.ipi_val;
TonePipSweepPARAMS.freq_lo=get(handles.freq_lo,'Value');fl=TonePipSweepPARAMS.freq_lo;
TonePipSweepPARAMS.freq_hi=get(handles.freq_hi,'Value');fh=TonePipSweepPARAMS.freq_hi;
TonePipSweepPARAMS.num_freq_steps=get(handles.num_freq_steps,'Value');nf=TonePipSweepPARAMS.num_freq_steps;
TonePipSweepPARAMS.level_lo=get(handles.level_lo,'Value');ll=TonePipSweepPARAMS.level_lo;
TonePipSweepPARAMS.level_hi=get(handles.level_hi,'Value');lh=TonePipSweepPARAMS.level_hi;
TonePipSweepPARAMS.num_att_steps=get(handles.num_att_steps,'Value');na=TonePipSweepPARAMS.num_att_steps;
TonePipSweepPARAMS.npips_per_train=get(handles.npips_per_train,'Value');nppt=TonePipSweepPARAMS.npips_per_train;
TonePipSweepPARAMS.total_reps=get(handles.total_reps,'Value');treps=TonePipSweepPARAMS.total_reps;

curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save TonePipSweepPARAMS TonePipSweepPARAMS
cd (curdir)
%save TonePipSweepPARAMS TonePipSweepPARAMS
load AudStimPARAMS
AudStimPARAMS.type='TonePipSweep';
AudStimPARAMS.stim_protocol=TonePipSweepPARAMS;
close(handles.figure1)
total_prairie_iterations=nf*na*treps;
each_stim_dur=ipi*nppt;
each_prairie_dur=tfl*fdur;
lines_per_set=nf*na;

if AudStimPARAMS.MultFrame==0
%for at least 50% duty cycle

    least_dur=2*ipi*nppt;least_prairie_frames=max([ceil(2*ipi*nppt/fdur) sf+ceil(each_stim_dur/fdur)]);
    if least_prairie_frames<tfl
        durcheck_str='PRAIRIE: Number of frames/lines per iter OKAY';
        disp_bgcolor=[0 .8 1];
    else
        eval(sprintf('durcheck_str=''PRAIRIE: Increase frames/lines per iter to AT LEAST %i'';',least_prairie_frames))
        disp_bgcolor=[1 0 0];
    end
    eval(sprintf('add_dur_check='' ...[At least %i : currently %i]'';',least_prairie_frames,tfl))
    eval(sprintf('itercheck_str=''Set PAIRIE Number of ITERATIONS to AT LEAST %i'';',total_prairie_iterations))
    display_str=strcat(durcheck_str,add_dur_check,'*\*/\*/*',itercheck_str);
    load TPS_handles
    set(AA_handles.check_disp,'String',display_str)
    set(AA_handles.check_disp,'BackgroundColor',disp_bgcolor)
    set(AA_handles.check_disp,'FontSize',9)
    eval(sprintf('prot_str=''TonePipSweep: %i freqs from %8.1f to %8.1f Hz, %i atten steps from %4.1f to %4.1f dB, %i Tone pips per train, Starts at frame/line %i'';',nf,fl,fh,na,ll,lh,nppt,sf))
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
    load TPS_handles
    set(AA_handles.check_disp,'String',display_str)
    set(AA_handles.check_disp,'BackgroundColor',disp_bgcolor)
    set(AA_handles.check_disp,'FontSize',9)
    eval(sprintf('prot_str=''TonePipSweep: %i freqs from %8.1f to %8.1f Hz, %i atten steps from %4.1f to %4.1f dB, %i Tone pips per train, Starts at frame/line %i'';',nf,fl,fh,na,ll,lh,nppt,sf))
    set(AA_handles.disp_protocol,'String',prot_str)
end

AudStimPARAMS.protocol_str=prot_str;
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save AudStimPARAMS AudStimPARAMS
cd (curdir)
%save AudStimPARAMS AudStimPARAMS