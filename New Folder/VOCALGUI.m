function varargout = VOCALGUI(varargin)
% VOCALGUI MATLAB code for VOCALGUI.fig
%      VOCALGUI, by itself, creates a new VOCALGUI or raises the existing
%      singleton*.
%
%      H = VOCALGUI returns the handle to a new VOCALGUI or the handle to
%      the existing singleton*.
%
%      VOCALGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VOCALGUI.M with the given input arguments.
%
%      VOCALGUI('Property','Value',...) creates a new VOCALGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before VOCALGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to VOCALGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help VOCALGUI

% Last Modified by GUIDE v2.5 02-Aug-2018 09:15:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @VOCALGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @VOCALGUI_OutputFcn, ...
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


% --- Executes just before VOCALGUI is made visible.
function VOCALGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to VOCALGUI (see VARARGIN)

% Choose default command line output for VOCALGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

load VOCALPARAMS
load Auditory_handles
wtd_val=get(PP_handles.what_to_do,'Value');
%eval(sprintf('set(handles.frame_dur,''String'',''%5.3f'');',VOCALPARAMS.frame_dur))
%set(handles.frame_dur,'Value',VOCALPARAMS.frame_dur);
%eval(sprintf('set(handles.pip_dur,''String'',''%5.3f'');',VOCALPARAMS.pip_dur))
%set(handles.pip_dur,'Value',VOCALPARAMS.pip_dur);
eval(sprintf('set(handles.total_time,''String'',''%i'');',VOCALPARAMS.total_frames_lines))
set(handles.total_time,'Value',VOCALPARAMS.total_frames_lines);
eval(sprintf('set(handles.stim_start,''String'',''%i'');',VOCALPARAMS.stim_start))
set(handles.stim_start,'Value',VOCALPARAMS.stim_start);
%eval(sprintf('set(handles.ipi_val,''String'',''%8.3f'');',VOCALPARAMS.ipi_val))
%set(handles.ipi_val,'Value',VOCALPARAMS.ipi_val);
eval(sprintf('set(handles.no_times_rand_stim_set,''String'',''%3.1f'');',VOCALPARAMS.no_times_rand_stim_set))
set(handles.no_times_rand_stim_set,'Value',VOCALPARAMS.no_times_rand_stim_set);
eval(sprintf('set(handles.dbatten,''String'',''%3.1f'');',VOCALPARAMS.level))
set(handles.dbatten,'Value',VOCALPARAMS.level);
% eval(sprintf('set(handles.choose_set,''String'',''%i'');',VOCALPARAMS.choose_set))
% set(handles.choose_set,'Value',VOCALPARAMS.choose_set);

%eval(sprintf('set(handles.level_hi,''String'',''%3.1f'');',VOCALPARAMS.level_hi))
%set(handles.level_hi,'Value',VOCALPARAMS.level_hi);
%eval(sprintf('set(handles.num_att_steps,''String'',''%i'');',VOCALPARAMS.num_att_steps))
%set(handles.num_att_steps,'Value',VOCALPARAMS.num_att_steps);
%eval(sprintf('set(handles.npips_per_train,''String'',''%i'');',VOCALPARAMS.npips_per_train))
%set(handles.npips_per_train,'Value',VOCALPARAMS.npips_per_train);
eval(sprintf('set(handles.nreps,''String'',''%i'');',VOCALPARAMS.total_reps))
set(handles.nreps,'Value',VOCALPARAMS.total_reps);
%eval(sprintf('set(handles.nstims_set,''String'',''%i'');',VOCALPARAMS.nstims_set))
%set(handles.nstims_set,'Value',VOCALPARAMS.nstims_set);

% UIWAIT makes VOCALGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = VOCALGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles;



function stim_start_Callback(hObject, eventdata, handles)
% hObject    handle to stim_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stim_start as text
%        str2double(get(hObject,'String')) returns contents of stim_start as a double

load VOCALPARAMS
VOCALPARAMS.stim_start=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.stim_start,'Value',VOCALPARAMS.stim_start);

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



function total_time_Callback(hObject, eventdata, handles)
% hObject    handle to total_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of total_time as text
%        str2double(get(hObject,'String')) returns contents of total_time as a double

load VOCALPARAMS
VOCALPARAMS.total_frames_lines=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.total_time,'Value',VOCALPARAMS.total_frames_lines);


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



function nreps_Callback(hObject, eventdata, handles)
% hObject    handle to nreps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nreps as text
%        str2double(get(hObject,'String')) returns contents of nreps as a double

load VOCALPARAMS
VOCALPARAMS.total_reps=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.nreps,'Value',VOCALPARAMS.total_reps);

% --- Executes during object creation, after setting all properties.
function nreps_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nreps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dbatten_Callback(hObject, eventdata, handles)
% hObject    handle to dbatten (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dbatten as text
%        str2double(get(hObject,'String')) returns contents of dbatten as a double

load VOCALPARAMS
VOCALPARAMS.level=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.dbatten,'Value',VOCALPARAMS.level);


% --- Executes during object creation, after setting all properties.
function dbatten_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dbatten (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in choose_set.
function choose_set_Callback(hObject, eventdata, handles)
% hObject    handle to choose_set (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns choose_set contents as cell array
%        contents{get(hObject,'Value')} returns selected item from choose_set

load VOCALPARAMS

if get(hObject,'Value')==1
    VOCALPARAMS.choose_set=1;%%%default
else
    VOCALPARAMS.choose_set=get(hObject,'Value');
end

% --- Executes during object creation, after setting all properties.
function choose_set_CreateFcn(hObject, eventdata, handles)
% hObject    handle to choose_set (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function no_times_rand_stim_set_Callback(hObject, eventdata, handles)
% hObject    handle to no_times_rand_stim_set (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of no_times_rand_stim_set as text
%   str2double(get(hObject,'String')) returns contents of no_times_rand_stim_set as a double
load VOCALPARAMS
VOCALPARAMS.no_times_rand_stim_set=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.no_times_rand_stim_set,'Value',VOCALPARAMS.no_times_rand_stim_set);

% if get(hObject,'Value')==1
% VOCALPARAMS.no_times_rand_stim_set=5;%%%default
% else
%     VOCALPARAMS.no_times_rand_stim_set=get(hObject,'Value');
% end

% --- Executes during object creation, after setting all properties.
function no_times_rand_stim_set_CreateFcn(hObject, eventdata, handles)
% hObject    handle to no_times_rand_stim_set (see GCBO)
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

load VOCALPARAMS

%VOCALPARAMS.frame_dur=get(handles.frame_dur,'Value');fdur=VOCALPARAMS.frame_dur;
%VOCALPARAMS.pip_dur=get(handles.pip_dur,'Value');
VOCALPARAMS.total_frames_lines=get(handles.total_time,'Value');
tfl=VOCALPARAMS.total_frames_lines;
VOCALPARAMS.stim_start=get(handles.stim_start,'Value');sf=VOCALPARAMS.stim_start;
%VOCALPARAMS.ipi_val=get(handles.ipi_val,'Value');ipi=VOCALPARAMS.ipi_val;
VOCALPARAMS.level=get(handles.dbatten,'Value');ll=VOCALPARAMS.level;
VOCALPARAMS.no_times_rand_stim_set=get(handles.no_times_rand_stim_set,'Value');
%VOCALPARAMS.level_hi=get(handles.level_hi,'Value');
lh=VOCALPARAMS.level;
%VOCALPARAMS.num_att_steps=get(handles.num_att_steps,'Value');na=VOCALPARAMS.num_att_steps;
%VOCALPARAMS.npips_per_train=get(handles.npips_per_train,'Value');nppt=VOCALPARAMS.npips_per_train;
%VOCALPARAMS.nstims_set=get(handles.nstims_set,'Value');nsset=VOCALPARAMS.nstims_set;
VOCALPARAMS.total_reps=get(handles.nreps,'Value');treps=VOCALPARAMS.total_reps;
setnums=[1 2 3 4 5];
VOCALPARAMS.choose_set=get(handles.choose_set,'Value');stimset=setnums(VOCALPARAMS.choose_set);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
VOCALPARAMS
save VOCALPARAMS VOCALPARAMS
cd (curdir)
%save VOCALPARAMS VOCALPARAMS

load AudStimPARAMS
AudStimPARAMS.type='VOCAL';
na=1;nsset=20;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% HARDCODED NOW FOR ONLY 1 VOCALIZATIONS SET
AudStimPARAMS.stim_protocol=VOCALPARAMS;
close(handles.figure1)
total_prairie_iterations=nsset*na*treps;
each_stim_dur=1.64;%ipi*nppt;
each_prairie_dur=2;%tfl*fdur;
%for at least 50% duty cycle
% 
% least_dur=2*ipi*nppt;least_prairie_frames=max([ceil(2*ipi*nppt/fdur) sf+ceil(each_stim_dur/fdur)]);
% if least_prairie_frames<tfl
%     durcheck_str='PRAIRIE: Number of frames/lines per iter OKAY';
     disp_bgcolor=[0 .8 1];
% else
%     eval(sprintf('durcheck_str=''PRAIRIE: Increase frames/lines per iter to AT LEAST %i'';',least_prairie_frames))
%     disp_bgcolor=[1 0 0];
% end
% eval(sprintf('add_dur_check='' ...[At least %i : currently %i]'';',least_prairie_frames,tfl))
% eval(sprintf('itercheck_str=''Set PAIRIE Number of ITERATIONS to AT LEAST %i'';',total_prairie_iterations))
display_str='VOCAL SET 1';
load VOCAL_handles
set(AA_handles.check_disp,'String',display_str)
set(AA_handles.check_disp,'BackgroundColor',disp_bgcolor)
set(AA_handles.check_disp,'FontSize',9)
eval(sprintf('prot_str=''VOCAL: %i SET, %i Stimuli, 1 atten %4.1f dB, Starts at %4.2f'';',stimset,nsset,ll,sf))
set(AA_handles.disp_protocol,'String',prot_str)
AudStimPARAMS.protocol_str=prot_str;
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save AudStimPARAMS AudStimPARAMS
cd (curdir)
%save AudStimPARAMS AudStimPARAMS



% % --- Executes during object creation, after setting all properties.
% function xf_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to no_times_rand_stim_set (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: edit controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end
% 
