function varargout = RSSGUI(varargin)
% RSSGUI M-file for RSSGUI.fig
%      RSSGUI, by itself, creates a new RSSGUI or raises the existing
%      singleton*.
%
%      H = RSSGUI returns the handle to a new RSSGUI or the handle to
%      the existing singleton*.
%
%      RSSGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RSSGUI.M with the given input arguments.
%
%      RSSGUI('Property','Value',...) creates a new RSSGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before RSSGUI_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to RSSGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help RSSGUI

% Last Modified by GUIDE v2.5 16-Sep-2008 10:53:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @RSSGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @RSSGUI_OutputFcn, ...
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


% --- Executes just before RSSGUI is made visible.
function RSSGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to RSSGUI (see VARARGIN)

% Choose default command line output for RSSGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

load RSSPipPARAMS
load Auditory_handles
wtd_val=get(PP_handles.what_to_do,'Value');
if wtd_val==7
    set(handles.text3,'String','Total Time (sec)')
    set(handles.text4,'String','Start Time (sec)')
end
handles
eval(sprintf('set(handles.frame_dur,''String'',''%5.3f'');',RSSPipPARAMS.frame_dur))
set(handles.frame_dur,'Value',RSSPipPARAMS.frame_dur);
eval(sprintf('set(handles.pip_dur,''String'',''%5.3f'');',RSSPipPARAMS.pip_dur))
set(handles.pip_dur,'Value',RSSPipPARAMS.pip_dur);
eval(sprintf('set(handles.total_frames_lines,''String'',''%i'');',RSSPipPARAMS.total_frames_lines))
set(handles.total_frames_lines,'Value',RSSPipPARAMS.total_frames_lines);
eval(sprintf('set(handles.stim_start,''String'',''%i'');',RSSPipPARAMS.stim_start))
set(handles.stim_start,'Value',RSSPipPARAMS.stim_start);
eval(sprintf('set(handles.ipi_val,''String'',''%8.3f'');',RSSPipPARAMS.ipi_val))
set(handles.ipi_val,'Value',RSSPipPARAMS.ipi_val);

eval(sprintf('set(handles.level_lo,''String'',''%3.1f'');',RSSPipPARAMS.level_lo))
set(handles.level_lo,'Value',RSSPipPARAMS.level_lo);
eval(sprintf('set(handles.level_hi,''String'',''%3.1f'');',RSSPipPARAMS.level_hi))
set(handles.level_hi,'Value',RSSPipPARAMS.level_hi);
eval(sprintf('set(handles.num_att_steps,''String'',''%i'');',RSSPipPARAMS.num_att_steps))
set(handles.num_att_steps,'Value',RSSPipPARAMS.num_att_steps);
eval(sprintf('set(handles.npips_per_train,''String'',''%i'');',RSSPipPARAMS.npips_per_train))
set(handles.npips_per_train,'Value',RSSPipPARAMS.npips_per_train);
eval(sprintf('set(handles.total_reps,''String'',''%i'');',RSSPipPARAMS.total_reps))
set(handles.total_reps,'Value',RSSPipPARAMS.total_reps);
eval(sprintf('set(handles.nstims_set,''String'',''%i'');',RSSPipPARAMS.nstims_set))
set(handles.nstims_set,'Value',RSSPipPARAMS.nstims_set);

% UIWAIT makes RSSGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = RSSGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles;


% --- Executes on selection change in contrast_val.
function contrast_val_Callback(hObject, eventdata, handles)
% hObject    handle to contrast_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns contrast_val contents as cell array
%        contents{get(hObject,'Value')} returns selected item from contrast_val

load RSSPipPARAMS

if get(hObject,'Value')==1
    RSSPipPARAMS.contrast_val=2;%%%default
else
    RSSPipPARAMS.contrast_val=get(hObject,'Value');
end

% --- Executes during object creation, after setting all properties.
function contrast_val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to contrast_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
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

load RSSPipPARAMS
RSSPipPARAMS.frame_dur=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.frame_dur,'Value',RSSPipPARAMS.frame_dur);

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



function total_frames_lines_Callback(hObject, eventdata, handles)
% hObject    handle to total_frames_lines (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of total_frames_lines as text
%        str2double(get(hObject,'String')) returns contents of total_frames_lines as a double

load RSSPipPARAMS
RSSPipPARAMS.total_frames_lines=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.total_frames_lines,'Value',RSSPipPARAMS.total_frames_lines);

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

load RSSPipPARAMS
RSSPipPARAMS.stim_start=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.stim_start,'Value',RSSPipPARAMS.stim_start);

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

load RSSPipPARAMS
RSSPipPARAMS.pip_dur=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.pip_dur,'Value',RSSPipPARAMS.pip_dur);

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

load RSSPipPARAMS
RSSPipPARAMS.ipi_val=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.ipi_val,'Value',RSSPipPARAMS.ipi_val);

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


function level_lo_Callback(hObject, eventdata, handles)
% hObject    handle to level_lo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of level_lo as text
%        str2double(get(hObject,'String')) returns contents of level_lo as a double

load RSSPipPARAMS
RSSPipPARAMS.level_lo=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.level_lo,'Value',RSSPipPARAMS.level_lo);

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

load RSSPipPARAMS
RSSPipPARAMS.level_hi=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.level_hi,'Value',RSSPipPARAMS.level_hi);

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

load RSSPipPARAMS
RSSPipPARAMS.num_att_steps=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.num_att_steps,'Value',RSSPipPARAMS.num_att_steps);

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

load RSSPipPARAMS
RSSPipPARAMS.npips_per_train=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.npips_per_train,'Value',RSSPipPARAMS.npips_per_train);

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

load RSSPipPARAMS
RSSPipPARAMS.total_reps=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.total_reps,'Value',RSSPipPARAMS.total_reps);

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

load RSSPipPARAMS

RSSPipPARAMS.frame_dur=get(handles.frame_dur,'Value');fdur=RSSPipPARAMS.frame_dur;
RSSPipPARAMS.pip_dur=get(handles.pip_dur,'Value');
RSSPipPARAMS.total_frames_lines=get(handles.total_frames_lines,'Value');tfl=RSSPipPARAMS.total_frames_lines;
RSSPipPARAMS.stim_start=get(handles.stim_start,'Value');sf=RSSPipPARAMS.stim_start;
RSSPipPARAMS.ipi_val=get(handles.ipi_val,'Value');ipi=RSSPipPARAMS.ipi_val;
RSSPipPARAMS.level_lo=get(handles.level_lo,'Value');ll=RSSPipPARAMS.level_lo;
RSSPipPARAMS.level_hi=get(handles.level_hi,'Value');lh=RSSPipPARAMS.level_hi;
RSSPipPARAMS.num_att_steps=get(handles.num_att_steps,'Value');na=RSSPipPARAMS.num_att_steps;
RSSPipPARAMS.npips_per_train=get(handles.npips_per_train,'Value');nppt=RSSPipPARAMS.npips_per_train;
RSSPipPARAMS.nstims_set=get(handles.nstims_set,'Value');nsset=RSSPipPARAMS.nstims_set;
RSSPipPARAMS.total_reps=get(handles.total_reps,'Value');treps=RSSPipPARAMS.total_reps;
contrasts=[12 12 24 6 3];
RSSPipPARAMS.contrast_val=get(handles.contrast_val,'Value');contrast=contrasts(RSSPipPARAMS.contrast_val);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save RSSPipPARAMS RSSPipPARAMS
cd (curdir)
%save RSSPipPARAMS RSSPipPARAMS

load AudStimPARAMS
AudStimPARAMS.type='RSSPip';
AudStimPARAMS.stim_protocol=RSSPipPARAMS;
close(handles.figure1)
total_prairie_iterations=nsset*na*treps;
each_stim_dur=ipi*nppt;
each_prairie_dur=tfl*fdur;
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
load RSS_handles
set(AA_handles.check_disp,'String',display_str)
set(AA_handles.check_disp,'BackgroundColor',disp_bgcolor)
set(AA_handles.check_disp,'FontSize',9)
eval(sprintf('prot_str=''RSSPip: %i dB contrast, %i Stimuli, %i atten steps from %4.1f to %4.1f dB, %i RSS pips per train, Starts at frame/line %i'';',contrast,nsset,na,ll,lh,nppt,sf))
set(AA_handles.disp_protocol,'String',prot_str)
AudStimPARAMS.protocol_str=prot_str;
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save AudStimPARAMS AudStimPARAMS
cd (curdir)
%save AudStimPARAMS AudStimPARAMS



function nstims_set_Callback(hObject, eventdata, handles)
% hObject    handle to nstims_set (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nstims_set as text
%        str2double(get(hObject,'String')) returns contents of nstims_set as a double

load RSSPipPARAMS
RSSPipPARAMS.nstims_set=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.nstims_set,'Value',RSSPipPARAMS.nstims_set);

% --- Executes during object creation, after setting all properties.
function nstims_set_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nstims_set (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


