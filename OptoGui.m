function varargout = OptoGui(varargin)
% OPTOGUI MATLAB code for OptoGui.fig
%      OPTOGUI, by itself, creates a new OPTOGUI or raises the existing
%      singleton*.
%
%      H = OPTOGUI returns the handle to a new OPTOGUI or the handle to
%      the existing singleton*.
%
%      OPTOGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OPTOGUI.M with the given input arguments.
%
%      OPTOGUI('Property','Value',...) creates a new OPTOGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before OptoGui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to OptoGui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help OptoGui

% Last Modified by GUIDE v2.5 04-Nov-2020 13:58:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @OptoGui_OpeningFcn, ...
                   'gui_OutputFcn',  @OptoGui_OutputFcn, ...
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


% --- Executes just before OptoGui is made visible.
function OptoGui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to OptoGui (see VARARGIN)

% Choose default command line output for OptoGui
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
load OptoParams
cd (curdir)

set(handles.check_auditory,'Value',OptoParams.check_auditory);
set(handles.check_visual,'Value',OptoParams.check_visual);
set(handles.check_all,'Value',OptoParams.check_all);
set(handles.check_none,'Value',OptoParams.check_none);
set(handles.check_optoSSA,'Value',OptoParams.check_optoSSA);
set(handles.check_standard,'Value',OptoParams.check_standard);
set(handles.check_deviant,'Value',OptoParams.check_deviant);
set(handles.gapcheck,'Value',OptoParams.gapcheck);
%%%%for wavelength
set(handles.check473nm,'Value',OptoParams.check473nm);
set(handles.check589nm,'Value',OptoParams.check589nm);

eval(sprintf('set(handles.total_time,''String'',''%i'');',OptoParams.total_time))
set(handles.total_time,'Value',OptoParams.total_time);
eval(sprintf('set(handles.stim_start,''String'',''%i'');',OptoParams.stim_start))
set(handles.stim_start,'Value',OptoParams.stim_start);
eval(sprintf('set(handles.stimB_pos,''String'',''%i'');',OptoParams.stimB_pos))
set(handles.stimB_pos,'Value',OptoParams.stimB_pos);
eval(sprintf('set(handles.stimA_dur,''String'',''%i'');',OptoParams.stimA_dur))
set(handles.stimA_dur,'Value',OptoParams.stimA_dur);
eval(sprintf('set(handles.stimB_dur,''String'',''%i'');',OptoParams.stimB_dur))
set(handles.stimB_dur,'Value',OptoParams.stimB_dur);
eval(sprintf('set(handles.curr_amp,''String'',''%i'');',OptoParams.curr_amp))
set(handles.curr_amp,'Value',OptoParams.curr_amp);
eval(sprintf('set(handles.stim_dur,''String'',''%i'');',OptoParams.stim_dur))
set(handles.stim_dur,'Value',OptoParams.stim_dur);
eval(sprintf('set(handles.isi_dur,''String'',''%i'');',OptoParams.isi_dur))
set(handles.isi_dur,'Value',OptoParams.isi_dur);
eval(sprintf('set(handles.n_stims,''String'',''%i'');',OptoParams.n_stims))
set(handles.n_stims,'Value',OptoParams.n_stims);
eval(sprintf('set(handles.n_reps,''String'',''%i'');',OptoParams.n_reps))
set(handles.n_reps,'Value',OptoParams.n_reps);
eval(sprintf('set(handles.gap_dur,''String'',''%i'');',OptoParams.gap_dur))
set(handles.gap_dur,'Value',OptoParams.gap_dur);


% UIWAIT makes OptoGui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = OptoGui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in check_auditory.
function check_auditory_Callback(hObject, eventdata, handles)
% hObject    handle to check_auditory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_auditory

load OptoParams
OptoParams.check_auditory=get(hObject,'Value');
set(handles.check_auditory,'Value',OptoParams.check_auditory);

if OptoParams.check_auditory==1
    OptoParams.check_visual=0;
    set(handles.check_visual,'Value',0);
    OptoParams.check_all=0;
    set(handles.check_all,'Value',0);
    OptoParams.check_none=0;
    set(handles.check_none,'Value',0);
    OptoParams.check_optoSSA=0;
    set(handles.check_optoSSA,'Value',0);
end

curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save OptoParams OptoParams
cd (curdir)

% --- Executes on button press in check_visual.
function check_visual_Callback(hObject, eventdata, handles)
% hObject    handle to check_visual (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_visual
load OptoParams
OptoParams.check_visual=get(hObject,'Value');
set(handles.check_visual,'Value',OptoParams.check_visual);

if OptoParams.check_visual==1
    OptoParams.check_auditory=0;
    set(handles.check_auditory,'Value',0);
    OptoParams.check_all=0;
    set(handles.check_all,'Value',0);
    OptoParams.check_none=0;
    set(handles.check_none,'Value',0);
    OptoParams.check_optoSSA=0;
    set(handles.check_optoSSA,'Value',0);
end

curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save OptoParams OptoParams
cd (curdir)

% --- Executes on button press in check_all.
function check_all_Callback(hObject, eventdata, handles)
% hObject    handle to check_all (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_all
load OptoParams
OptoParams.check_all=get(hObject,'Value');
set(handles.check_all,'Value',OptoParams.check_all);

if OptoParams.check_all==1
    OptoParams.check_auditory=0;
    set(handles.check_auditory,'Value',0);
    OptoParams.check_visual=0;
    set(handles.check_visual,'Value',0);
    OptoParams.check_none=0;
    set(handles.check_none,'Value',0);
    OptoParams.check_optoSSA=0;
    set(handles.check_optoSSA,'Value',0);
end

curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save OptoParams OptoParams
cd (curdir)

% --- Executes on button press in SetAuditory.
function SetAuditory_Callback(hObject, eventdata, handles)
% hObject    handle to SetAuditory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Auditory2PGUI

% --- Executes on button press in SetVisual.
function SetVisual_Callback(hObject, eventdata, handles)
% hObject    handle to SetVisual (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
VisualLEDStimGUI

% --- Executes on button press in check_none.
function check_none_Callback(hObject, eventdata, handles)
% hObject    handle to check_none (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_none
load OptoParams
OptoParams.check_none=get(hObject,'Value');
set(handles.check_none,'Value',OptoParams.check_none);

if OptoParams.check_none==1
    OptoParams.check_auditory=0;
    set(handles.check_auditory,'Value',0);
    OptoParams.check_all=0;
    set(handles.check_all,'Value',0);
    OptoParams.check_visual=0;
    set(handles.check_visual,'Value',0);
    OptoParams.check_optoSSA=0;
    set(handles.check_optoSSA,'Value',0);
end

curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save OptoParams OptoParams
cd (curdir)

% --- Executes on button press in done.
function done_Callback(hObject, eventdata, handles)
% hObject    handle to done (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

load OptoParams
OptoParams.check_auditory=get(handles.check_auditory,'Value');
OptoParams.check_visual=get(handles.check_visual,'Value');
OptoParams.check_all=get(handles.check_all,'Value');
OptoParams.check_none=get(handles.check_none,'Value');
OptoParams.check_optoSSA=get(handles.check_optoSSA,'Value');
OptoParams.check_standard=get(handles.check_standard,'Value');
OptoParams.check_deviant=get(handles.check_deviant,'Value');
OptoParams.stimB_pos=get(handles.stimB_pos,'Value');
OptoParams.stimA_dur=get(handles.stimA_dur,'Value');
OptoParams.stimB_dur=get(handles.stimB_dur,'Value');
OptoParams.total_time=get(handles.total_time,'Value');
OptoParams.stim_start=get(handles.stim_start,'Value');
OptoParams.curr_amp=get(handles.curr_amp,'Value');
OptoParams.stim_dur=get(handles.stim_dur,'Value');
OptoParams.isi_dur=get(handles.isi_dur,'Value');
OptoParams.n_stims=get(handles.n_stims,'Value');
OptoParams.n_reps=get(handles.n_reps,'Value');
OptoParams.gapcheck=get(handles.gapcheck,'Value');
OptoParams.gap_dur=get(handles.gap_dur,'Value');

if OptoParams.check_auditory==1
    load AudStimPARAMS
    OptoParams.AUD=AudStimPARAMS;
    OptoParams.VIS=[];
elseif OptoParams.check_visual==1
    load VisLEDStimPARAMS
    OptoParams.VIS=VisLEDStimPARAMS;
    OptoParams.AUD=[];
elseif OptoParams.check_all==1    
    load AudStimPARAMS
    load VisLEDStimPARAMS
    OptoParams.AUD=AudStimPARAMS;
    OptoParams.VIS=VisLEDStimPARAMS;
elseif OptoParams.check_none==1    
    OptoParams.AUD=[];
    OptoParams.VIS=[];
end
OptoParams.protocol_str='Ready - Not started';    
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save OptoParams OptoParams
cd (curdir)

close(handles.figure1)




% --- Executes on button press in gapcheck.
function gapcheck_Callback(hObject, eventdata, handles)
% hObject    handle to gapcheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of gapcheck
load OptoParams
OptoParams.gapcheck=get(hObject,'Value');
set(handles.gapcheck,'Value',OptoParams.gapcheck);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save OptoParams OptoParams
cd (curdir)


function total_time_Callback(hObject, eventdata, handles)
% hObject    handle to total_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of total_time as text
%        str2double(get(hObject,'String')) returns contents of total_time as a double
load OptoParams
OptoParams.total_time=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.total_time,'Value',OptoParams.total_time);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save OptoParams OptoParams
cd (curdir)

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



function stim_start_Callback(hObject, eventdata, handles)
% hObject    handle to stim_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stim_start as text
%        str2double(get(hObject,'String')) returns contents of stim_start as a double
load OptoParams
OptoParams.stim_start=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.stim_start,'Value',OptoParams.stim_start);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save OptoParams OptoParams
cd (curdir)

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



function curr_amp_Callback(hObject, eventdata, handles)
% hObject    handle to curr_amp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of curr_amp as text
%        str2double(get(hObject,'String')) returns contents of curr_amp as a double
load OptoParams
OptoParams.curr_amp=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.curr_amp,'Value',OptoParams.curr_amp);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save OptoParams OptoParams
cd (curdir)

% --- Executes during object creation, after setting all properties.
function curr_amp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to curr_amp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function stim_dur_Callback(hObject, eventdata, handles)
% hObject    handle to stim_dur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stim_dur as text
%        str2double(get(hObject,'String')) returns contents of stim_dur as a double
load OptoParams
OptoParams.stim_dur=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.stim_dur,'Value',OptoParams.stim_dur);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save OptoParams OptoParams
cd (curdir)

% --- Executes during object creation, after setting all properties.
function stim_dur_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stim_dur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function isi_dur_Callback(hObject, eventdata, handles)
% hObject    handle to isi_dur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of isi_dur as text
%        str2double(get(hObject,'String')) returns contents of isi_dur as a double
load OptoParams
OptoParams.isi_dur=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.isi_dur,'Value',OptoParams.isi_dur);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save OptoParams OptoParams
cd (curdir)

% --- Executes during object creation, after setting all properties.
function isi_dur_CreateFcn(hObject, eventdata, handles)
% hObject    handle to isi_dur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function n_stims_Callback(hObject, eventdata, handles)
% hObject    handle to n_stims (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of n_stims as text
%        str2double(get(hObject,'String')) returns contents of n_stims as a double
load OptoParams
OptoParams.n_stims=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.n_stims,'Value',OptoParams.n_stims);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save OptoParams OptoParams
cd (curdir)

% --- Executes during object creation, after setting all properties.
function n_stims_CreateFcn(hObject, eventdata, handles)
% hObject    handle to n_stims (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function n_reps_Callback(hObject, eventdata, handles)
% hObject    handle to n_reps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of n_reps as text
%        str2double(get(hObject,'String')) returns contents of n_reps as a double
load OptoParams
OptoParams.n_reps=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.n_reps,'Value',OptoParams.n_reps);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save OptoParams OptoParams
cd (curdir)

% --- Executes during object creation, after setting all properties.
function n_reps_CreateFcn(hObject, eventdata, handles)
% hObject    handle to n_reps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in check_optoSSA.
function check_optoSSA_Callback(hObject, eventdata, handles)
% hObject    handle to check_optoSSA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_optoSSA
load OptoParams
OptoParams.check_optoSSA=get(hObject,'Value');
set(handles.check_optoSSA,'Value',OptoParams.check_optoSSA);

if OptoParams.check_optoSSA==1
    OptoParams.check_auditory=0;
    set(handles.check_auditory,'Value',0);
    OptoParams.check_all=0;
    set(handles.check_all,'Value',0);
    OptoParams.check_visual=0;
    set(handles.check_visual,'Value',0);
    OptoParams.check_none=0;
    set(handles.check_none,'Value',0);
end

curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save OptoParams OptoParams
cd (curdir)

% --- Executes on button press in check_standard.
function check_standard_Callback(hObject, eventdata, handles)
% hObject    handle to check_standard (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_standard
load OptoParams
OptoParams.check_standard=get(hObject,'Value');
set(handles.check_standard,'Value',OptoParams.check_standard);
set(handles.check_deviant,'Value',~OptoParams.check_standard);
VisLEDStimPARAMS.check_deviant=~OptoParams.check_standard;
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save OptoParams OptoParams
cd (curdir)


function stimB_pos_Callback(hObject, eventdata, handles)
% hObject    handle to stimB_pos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stimB_pos as text
%        str2double(get(hObject,'String')) returns contents of stimB_pos as a double
load OptoParams
OptoParams.stimB_pos=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.stimB_pos,'Value',OptoParams.stimB_pos);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save OptoParams OptoParams
cd (curdir)

% --- Executes during object creation, after setting all properties.
function stimB_pos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stimB_pos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in check_deviant.
function check_deviant_Callback(hObject, eventdata, handles)
% hObject    handle to check_deviant (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_deviant
load OptoParams
OptoParams.check_deviant=get(hObject,'Value');
set(handles.check_deviant,'Value',OptoParams.check_deviant);
set(handles.check_standard,'Value',~OptoParams.check_deviant);
VisLEDStimPARAMS.check_standard=~OptoParams.check_deviant;
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save OptoParams OptoParams
cd (curdir)


function stimA_dur_Callback(hObject, eventdata, handles)
% hObject    handle to stimA_dur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stimA_dur as text
%        str2double(get(hObject,'String')) returns contents of stimA_dur as a double
load OptoParams
OptoParams.stimA_dur=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.stimA_dur,'Value',OptoParams.stimA_dur);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save OptoParams OptoParams
cd (curdir)

% --- Executes during object creation, after setting all properties.
function stimA_dur_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stimA_dur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function stimB_dur_Callback(hObject, eventdata, handles)
% hObject    handle to stimB_dur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stimB_dur as text
%        str2double(get(hObject,'String')) returns contents of stimB_dur as a double
load OptoParams
OptoParams.stimB_dur=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.stimB_dur,'Value',OptoParams.stimB_dur);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save OptoParams OptoParams
cd (curdir)

% --- Executes during object creation, after setting all properties.
function stimB_dur_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stimB_dur (see GCBO)
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
load OptoParams
OptoParams.gap_dur=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.gap_dur,'Value',OptoParams.gap_dur);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save OptoParams OptoParams
cd (curdir)

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


% --- Executes on button press in check473nm.
function check473nm_Callback(hObject, eventdata, handles)
% hObject    handle to check473nm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%%%%%%%%%%%%%%%%%%%%%
load OptoParams
OptoParams.check473nm=get(hObject,'Value');
set(handles.check473nm,'Value',OptoParams.check473nm);
set(handles.check589nm,'Value',~OptoParams.check473nm);
if OptoParams.check473nm==1
    OptoParams.check589nm=0;
    set(handles.check589nm,'Value',0);
end
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save OptoParams OptoParams
cd (curdir)


% Hint: get(hObject,'Value') returns toggle state of check473nm


% --- Executes on button press in check589nm.
function check589nm_Callback(hObject, eventdata, handles)
% hObject    handle to check589nm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

load OptoParams
OptoParams.check589nm=get(hObject,'Value');
set(handles.check589nm,'Value',OptoParams.check589nm);
set(handles.check473nm,'Value',~OptoParams.check589nm);
if OptoParams.check589nm==1
    OptoParams.check473nm=0;
    set(handles.check473nm,'Value',0);
end
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save OptoParams OptoParams


% Hint: get(hObject,'Value') returns toggle state of check589nm
