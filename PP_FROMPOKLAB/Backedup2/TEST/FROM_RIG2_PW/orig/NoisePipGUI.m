function varargout = NoisePipGUI(varargin)
% NOISEPIPGUI M-file for NoisePipGUI.fig
%      NOISEPIPGUI, by itself, creates a new NOISEPIPGUI or raises the existing
%      singleton*.
%
%      H = NOISEPIPGUI returns the handle to a new NOISEPIPGUI or the handle to
%      the existing singleton*.
%
%      NOISEPIPGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NOISEPIPGUI.M with the given input arguments.
%
%      NOISEPIPGUI('Property','Value',...) creates a new NOISEPIPGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before NoisePipGUI_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to NoisePipGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help NoisePipGUI

% Last Modified by GUIDE v2.5 08-Jul-2008 00:59:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NoisePipGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @NoisePipGUI_OutputFcn, ...
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


% --- Executes just before NoisePipGUI is made visible.
function NoisePipGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to NoisePipGUI (see VARARGIN)

% Choose default command line output for NoisePipGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

load NoisePipPARAMS
load Auditory_handles
wtd_val=get(PP_handles.what_to_do,'Value');
if wtd_val==7
    set(handles.text3,'String','Total Time (sec)')
    set(handles.text4,'String','Start Time (sec)')
end
eval(sprintf('set(handles.frame_dur,''String'',''%5.3f'');',NoisePipPARAMS.frame_dur))
set(handles.frame_dur,'Value',NoisePipPARAMS.frame_dur);
eval(sprintf('set(handles.pip_dur,''String'',''%5.3f'');',NoisePipPARAMS.pip_dur))
set(handles.pip_dur,'Value',NoisePipPARAMS.pip_dur);
eval(sprintf('set(handles.total_frames_lines,''String'',''%i'');',NoisePipPARAMS.total_frames_lines))
set(handles.total_frames_lines,'Value',NoisePipPARAMS.total_frames_lines);
eval(sprintf('set(handles.stim_start,''String'',''%i'');',NoisePipPARAMS.stim_start))
set(handles.stim_start,'Value',NoisePipPARAMS.stim_start);
eval(sprintf('set(handles.ipi_val,''String'',''%8.3f'');',NoisePipPARAMS.ipi_val))
set(handles.ipi_val,'Value',NoisePipPARAMS.ipi_val);
eval(sprintf('set(handles.flo_val,''String'',''%i'');',NoisePipPARAMS.flo_val))
set(handles.flo_val,'Value',NoisePipPARAMS.flo_val);
eval(sprintf('set(handles.fhi_val,''String'',''%i'');',NoisePipPARAMS.fhi_val))
set(handles.fhi_val,'Value',NoisePipPARAMS.fhi_val);
% eval(sprintf('set(handles.num_freq_steps,''String'',''%i'');',NoisePipPARAMS.num_freq_steps))
% set(handles.num_freq_steps,'Value',NoisePipPARAMS.num_freq_steps);
eval(sprintf('set(handles.level_lo,''String'',''%3.1f'');',NoisePipPARAMS.level_lo))
set(handles.level_lo,'Value',NoisePipPARAMS.level_lo);
eval(sprintf('set(handles.level_hi,''String'',''%3.1f'');',NoisePipPARAMS.level_hi))
set(handles.level_hi,'Value',NoisePipPARAMS.level_hi);
eval(sprintf('set(handles.num_att_steps,''String'',''%i'');',NoisePipPARAMS.num_att_steps))
set(handles.num_att_steps,'Value',NoisePipPARAMS.num_att_steps);
eval(sprintf('set(handles.npips_per_train,''String'',''%i'');',NoisePipPARAMS.npips_per_train))
set(handles.npips_per_train,'Value',NoisePipPARAMS.npips_per_train);
eval(sprintf('set(handles.total_reps,''String'',''%i'');',NoisePipPARAMS.total_reps))
set(handles.total_reps,'Value',NoisePipPARAMS.total_reps);

% UIWAIT makes NoisePipGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = NoisePipGUI_OutputFcn(hObject, eventdata, handles) 
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

load NoisePipPARAMS
NoisePipPARAMS.frame_dur=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.frame_dur,'Value',NoisePipPARAMS.frame_dur);

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

load NoisePipPARAMS
NoisePipPARAMS.pip_dur=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.pip_dur,'Value',NoisePipPARAMS.pip_dur);

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

load NoisePipPARAMS
NoisePipPARAMS.total_frames_lines=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.total_frames_lines,'Value',NoisePipPARAMS.total_frames_lines);

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

load NoisePipPARAMS
NoisePipPARAMS.stim_start=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.stim_start,'Value',NoisePipPARAMS.stim_start);

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

load NoisePipPARAMS
NoisePipPARAMS.ipi_val=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.ipi_val,'Value',NoisePipPARAMS.ipi_val);

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

load NoisePipPARAMS
NoisePipPARAMS.freq_lo=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.freq_lo,'Value',NoisePipPARAMS.freq_lo);

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

load NoisePipPARAMS
NoisePipPARAMS.freq_hi=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.freq_hi,'Value',NoisePipPARAMS.freq_hi);

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

load NoisePipPARAMS
NoisePipPARAMS.num_freq_steps=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.num_freq_steps,'Value',NoisePipPARAMS.num_freq_steps);

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

load NoisePipPARAMS
NoisePipPARAMS.level_lo=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.level_lo,'Value',NoisePipPARAMS.level_lo);

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

load NoisePipPARAMS
NoisePipPARAMS.level_hi=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.level_hi,'Value',NoisePipPARAMS.level_hi);

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

load NoisePipPARAMS
NoisePipPARAMS.num_att_steps=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.num_att_steps,'Value',NoisePipPARAMS.num_att_steps);

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

load NoisePipPARAMS
NoisePipPARAMS.npips_per_train=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.npips_per_train,'Value',NoisePipPARAMS.npips_per_train);

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

load NoisePipPARAMS
NoisePipPARAMS.total_reps=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.total_reps,'Value',NoisePipPARAMS.total_reps);

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

function flo_val_Callback(hObject, eventdata, handles)
% hObject    handle to total_reps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of total_reps as text
%        str2double(get(hObject,'String')) returns contents of total_reps as a double

load NoisePipPARAMS
NoisePipPARAMS.flo_val=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.flo_val,'Value',NoisePipPARAMS.flo_val);

% --- Executes during object creation, after setting all properties.
function flo_val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to total_reps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function fhi_val_Callback(hObject, eventdata, handles)
% hObject    handle to total_reps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of total_reps as text
%        str2double(get(hObject,'String')) returns contents of total_reps as a double

load NoisePipPARAMS
NoisePipPARAMS.fhi_val=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.fhi_val,'Value',NoisePipPARAMS.fhi_val);

% --- Executes during object creation, after setting all properties.
function fhi_val_CreateFcn(hObject, eventdata, handles)
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

load NoisePipPARAMS

NoisePipPARAMS.frame_dur=get(handles.frame_dur,'Value');fdur=NoisePipPARAMS.frame_dur;
NoisePipPARAMS.pip_dur=get(handles.pip_dur,'Value');
NoisePipPARAMS.total_frames_lines=get(handles.total_frames_lines,'Value');tfl=NoisePipPARAMS.total_frames_lines;
NoisePipPARAMS.stim_start=get(handles.stim_start,'Value');sf=NoisePipPARAMS.stim_start;
NoisePipPARAMS.ipi_val=get(handles.ipi_val,'Value');ipi=NoisePipPARAMS.ipi_val;
NoisePipPARAMS.flo_val=get(handles.flo_val,'Value');fl=NoisePipPARAMS.flo_val;
NoisePipPARAMS.fhi_val=get(handles.fhi_val,'Value');fh=NoisePipPARAMS.fhi_val;
% NoisePipPARAMS.num_freq_steps=get(handles.num_freq_steps,'Value');nf=NoisePipPARAMS.num_freq_steps;
NoisePipPARAMS.level_lo=get(handles.level_lo,'Value');ll=NoisePipPARAMS.level_lo;
NoisePipPARAMS.level_hi=get(handles.level_hi,'Value');lh=NoisePipPARAMS.level_hi;
NoisePipPARAMS.num_att_steps=get(handles.num_att_steps,'Value');na=NoisePipPARAMS.num_att_steps;
NoisePipPARAMS.npips_per_train=get(handles.npips_per_train,'Value');nppt=NoisePipPARAMS.npips_per_train;
NoisePipPARAMS.total_reps=get(handles.total_reps,'Value');treps=NoisePipPARAMS.total_reps;

save NoisePipPARAMS NoisePipPARAMS
load AudStimPARAMS
AudStimPARAMS.type='NoisePip';
AudStimPARAMS.stim_protocol=NoisePipPARAMS;
close(handles.figure1)
total_prairie_iterations=na*treps;
each_stim_dur=ipi*nppt;
each_prairie_dur=tfl*fdur;
lines_per_set=na;

if AudStimPARAMS.MultFrame==0
%for at least 50% duty cycle

    least_dur=2*ipi*nppt;least_prairie_frames=max([ceil(2*ipi*nppt/fdur) sf+ceil(each_stim_dur/fdur)]);
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
    load NP_handles
    set(AA_handles.check_disp,'String',display_str)
    set(AA_handles.check_disp,'BackgroundColor',disp_bgcolor)
    set(AA_handles.check_disp,'FontSize',9)
    eval(sprintf('prot_str=''NoisePip: Bandwidth %i-%i kHz, %i atten steps from %4.1f to %4.1f dB, %i Noise pips per train, Starts at frame/line %i'';',fix(fl/1000),fix(fh/1000),na,ll,lh,nppt,sf))
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
    load NP_handles
    set(AA_handles.check_disp,'String',display_str)
    set(AA_handles.check_disp,'BackgroundColor',disp_bgcolor)
    set(AA_handles.check_disp,'FontSize',9)
    eval(sprintf('prot_str=''NoisePip: Bandwidth %i-%i kHz, %i atten steps from %4.1f to %4.1f dB, %i Noise pips per train, Starts at frame/line %i'';',fix(fl/1000),fix(fh/1000),na,ll,lh,nppt,sf))
    set(AA_handles.disp_protocol,'String',prot_str)
end

AudStimPARAMS.protocol_str=prot_str;
save AudStimPARAMS AudStimPARAMS