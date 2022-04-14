function varargout = SSAGUI(varargin)
% SSAGUI M-file for SSAGUI.fig
%      SSAGUI, by itself, creates a new SSAGUI or raises the existing
%      singleton*.
%
%      H = SSAGUI returns the handle to a new SSAGUI or the handle to
%      the existing singleton*.
%
%      SSAGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SSAGUI.M with the given input arguments.
%
%      SSAGUI('Property','Value',...) creates a new SSAGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SSAGUI_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SSAGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help SSAGUI

% Last Modified by GUIDE v2.5 09-Aug-2018 22:32:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SSAGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @SSAGUI_OutputFcn, ...
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


% --- Executes just before SSAGUI is made visible.
function SSAGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SSAGUI (see VARARGIN)

% Choose default command line output for SSAGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

load SSAPARAMS
load Auditory_handles
wtd_val=get(PP_handles.what_to_do,'Value');
if wtd_val==7
    set(handles.total_fld_text,'String','Total Time (s)')
    set(handles.stim_start_text,'String','Start Time (sec)')
end
eval(sprintf('set(handles.frame_dur,''String'',''%5.3f'');',SSAPARAMS.frame_dur))
set(handles.frame_dur,'Value',SSAPARAMS.frame_dur);
eval(sprintf('set(handles.total_frames_lines,''String'',''%i'');',SSAPARAMS.total_frames_lines))
set(handles.total_frames_lines,'Value',SSAPARAMS.total_frames_lines);
eval(sprintf('set(handles.stim_start,''String'',''%i'');',SSAPARAMS.stim_start))
set(handles.stim_start,'Value',SSAPARAMS.stim_start);

eval(sprintf('set(handles.stim_Adur,''String'',''%5.3f'');',SSAPARAMS.stim_Adur))
set(handles.stim_Adur,'Value',SSAPARAMS.stim_Adur);
eval(sprintf('set(handles.stim_Bdur,''String'',''%5.3f'');',SSAPARAMS.stim_Bdur))
set(handles.stim_Bdur,'Value',SSAPARAMS.stim_Bdur);
eval(sprintf('set(handles.gap_dur,''String'',''%5.3f'');',SSAPARAMS.gap_dur))
set(handles.gap_dur,'Value',SSAPARAMS.gap_dur);

set(handles.choose_A,'Value',SSAPARAMS.Atype);
switch SSAPARAMS.Atype
    case 1
         set(handles.A_tone,'BackgroundColor',[1 0 0])
         set(handles.Noise_A_low,'BackgroundColor',[0.8314    0.8157    0.7843])
         set(handles.Noise_A_high,'BackgroundColor',[0.8314    0.8157    0.7843])
         set(handles.choose_A_file,'BackgroundColor',[0.8314    0.8157    0.7843])
    case 2
         set(handles.A_tone,'BackgroundColor',[0.8314    0.8157    0.7843])
         set(handles.Noise_A_low,'BackgroundColor',[1 0 0])
         set(handles.Noise_A_high,'BackgroundColor',[1 0 0])
         set(handles.choose_A_file,'BackgroundColor',[0.8314    0.8157    0.7843])
    case 3
         set(handles.A_tone,'BackgroundColor',[0.8314    0.8157    0.7843])
         set(handles.Noise_A_low,'BackgroundColor',[0.8314    0.8157    0.7843])
         set(handles.Noise_A_high,'BackgroundColor',[0.8314    0.8157    0.7843])
         set(handles.choose_A_file,'BackgroundColor',[1 0 0])
end

set(handles.choose_B,'Value',SSAPARAMS.Btype);
switch SSAPARAMS.Btype
    case 1
         set(handles.B_tone,'BackgroundColor',[1 0 0])
         set(handles.Noise_B_low,'BackgroundColor',[0.8314    0.8157    0.7843])
         set(handles.Noise_B_high,'BackgroundColor',[0.8314    0.8157    0.7843])
         set(handles.choose_B_file,'BackgroundColor',[0.8314    0.8157    0.7843])
    case 2
         set(handles.B_tone,'BackgroundColor',[0.8314    0.8157    0.7843])
         set(handles.Noise_B_low,'BackgroundColor',[1 0 0])
         set(handles.Noise_B_high,'BackgroundColor',[1 0 0])
         set(handles.choose_B_file,'BackgroundColor',[0.8314    0.8157    0.7843])
    case 3
         set(handles.B_tone,'BackgroundColor',[0.8314    0.8157    0.7843])
         set(handles.Noise_B_low,'BackgroundColor',[0.8314    0.8157    0.7843])
         set(handles.Noise_B_high,'BackgroundColor',[0.8314    0.8157    0.7843])
         set(handles.choose_B_file,'BackgroundColor',[1 0 0])
end

eval(sprintf('set(handles.freqA,''String'',''%i'');',SSAPARAMS.freqA))
set(handles.freqA,'Value',SSAPARAMS.freqA);
eval(sprintf('set(handles.freqB,''String'',''%i'');',SSAPARAMS.freqB))
set(handles.freqB,'Value',SSAPARAMS.freqB);
eval(sprintf('set(handles.NoiseAlow,''String'',''%i'');',SSAPARAMS.NoiseAlow))
set(handles.NoiseAlow,'Value',SSAPARAMS.NoiseAlow);
eval(sprintf('set(handles.NoiseAhigh,''String'',''%i'');',SSAPARAMS.NoiseAhigh))
set(handles.NoiseAhigh,'Value',SSAPARAMS.NoiseAhigh);
eval(sprintf('set(handles.NoiseBlow,''String'',''%i'');',SSAPARAMS.NoiseBlow))
set(handles.NoiseBlow,'Value',SSAPARAMS.NoiseBlow);
eval(sprintf('set(handles.NoiseBhigh,''String'',''%i'');',SSAPARAMS.NoiseBhigh))
set(handles.NoiseBhigh,'Value',SSAPARAMS.NoiseBhigh);
eval(sprintf('set(handles.file_A,''String'',''%s'');',SSAPARAMS.file_A))
set(handles.file_A,'String',SSAPARAMS.file_A);
eval(sprintf('set(handles.file_B,''String'',''%s'');',SSAPARAMS.file_B))
set(handles.file_B,'String',SSAPARAMS.file_B);

eval(sprintf('set(handles.total_stims,''String'',''%i'');',SSAPARAMS.total_stims))
set(handles.total_stims,'Value',SSAPARAMS.total_stims);
eval(sprintf('set(handles.stimB_loc,''String'',''%i'');',SSAPARAMS.stimB_loc))
set(handles.randB_check,'Value',SSAPARAMS.randB_check);
set(handles.rand_nstim_check,'Value',SSAPARAMS.rand_nstim_check);
set(handles.stimB_loc,'Value',SSAPARAMS.stimB_loc);
% eval(sprintf('set(handles.num_stimB,''String'',''%i'');',SSAPARAMS.num_stimB))
set(handles.num_stimB,'Value',1);


eval(sprintf('set(handles.atten,''String'',''%3.1f'');',SSAPARAMS.atten))
set(handles.atten,'Value',SSAPARAMS.atten);
eval(sprintf('set(handles.nreps,''String'',''%i'');',SSAPARAMS.nreps))
set(handles.nreps,'Value',SSAPARAMS.nreps);

%%% FOR SAM SSA

set(handles.use_sam,'Value',SSAPARAMS.use_sam);
if SSAPARAMS.use_sam==1
    set(handles.samblock,'BackgroundColor',[1    0   0]);
else
    set(handles.samblock,'BackgroundColor','white');
end
set(handles.do_swap,'Value',SSAPARAMS.do_swap);
if SSAPARAMS.do_swap==1
    set(handles.do_swap,'BackgroundColor',[0    1    0]);
else
    set(handles.do_swap,'BackgroundColor','white');
end
eval(sprintf('set(handles.A_mod_cyc,''String'',''%i'');',SSAPARAMS.A_mod_cyc))
set(handles.A_mod_cyc,'Value',SSAPARAMS.A_mod_cyc);
eval(sprintf('set(handles.B_mod_cyc,''String'',''%i'');',SSAPARAMS.B_mod_cyc))
set(handles.B_mod_cyc,'Value',SSAPARAMS.B_mod_cyc);
eval(sprintf('set(handles.A_period,''String'',''%8.4f'');',SSAPARAMS.A_period))
set(handles.A_period,'Value',SSAPARAMS.A_period);
eval(sprintf('set(handles.B_period,''String'',''%8.4f'');',SSAPARAMS.B_period))
set(handles.B_period,'Value',SSAPARAMS.B_period);


% UIWAIT makes SSAGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = SSAGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles;



function total_frames_lines_Callback(hObject, eventdata, handles)
% hObject    handle to total_frames_lines (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of total_frames_lines as text
%        str2double(get(hObject,'String')) returns contents of total_frames_lines as a double

load SSAPARAMS
SSAPARAMS.total_frames_lines=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.total_frames_lines,'Value',SSAPARAMS.total_frames_lines);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save SSAPARAMS SSAPARAMS
cd (curdir)
%save SSAPARAMS SSAPARAMS

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

load SSAPARAMS
SSAPARAMS.stim_start=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.stim_start,'Value',SSAPARAMS.stim_start);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save SSAPARAMS SSAPARAMS
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



function frame_dur_Callback(hObject, eventdata, handles)
% hObject    handle to frame_dur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of frame_dur as text
%        str2double(get(hObject,'String')) returns contents of frame_dur as a double

load SSAPARAMS
SSAPARAMS.frame_dur=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.frame_dur,'Value',SSAPARAMS.frame_dur);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save SSAPARAMS SSAPARAMS
cd (curdir)

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



function gap_dur_Callback(hObject, eventdata, handles)
% hObject    handle to gap_dur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gap_dur as text
%        str2double(get(hObject,'String')) returns contents of gap_dur as a double

load SSAPARAMS
SSAPARAMS.gap_dur=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.gap_dur,'Value',SSAPARAMS.gap_dur);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save SSAPARAMS SSAPARAMS
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



function stim_Adur_Callback(hObject, eventdata, handles)
% hObject    handle to stim_Adur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stim_Adur as text
%        str2double(get(hObject,'String')) returns contents of stim_Adur as a double

load SSAPARAMS
SSAPARAMS.stim_Adur=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.stim_Adur,'Value',SSAPARAMS.stim_Adur);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save SSAPARAMS SSAPARAMS
cd (curdir)

% --- Executes during object creation, after setting all properties.
function stim_Adur_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stim_Adur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function stim_Bdur_Callback(hObject, eventdata, handles)
% hObject    handle to stim_Bdur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stim_Bdur as text
%        str2double(get(hObject,'String')) returns contents of stim_Bdur as a double

load SSAPARAMS
SSAPARAMS.stim_Bdur=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.stim_Bdur,'Value',SSAPARAMS.stim_Bdur);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save SSAPARAMS SSAPARAMS
cd (curdir)

% --- Executes during object creation, after setting all properties.
function stim_Bdur_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stim_Bdur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in choose_A.
function choose_A_Callback(hObject, eventdata, handles)
% hObject    handle to choose_A (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns choose_A contents as cell array
%        contents{get(hObject,'Value')} returns selected item from choose_A

load SSAPARAMS
SSAPARAMS.Atype=get(hObject,'Value');
switch get(hObject,'Value')
    case 1
         set(handles.A_tone,'BackgroundColor',[1 0 0])
         set(handles.Noise_A_low,'BackgroundColor',[0.8314    0.8157    0.7843])
         set(handles.Noise_A_high,'BackgroundColor',[0.8314    0.8157    0.7843])
         set(handles.choose_A_file,'BackgroundColor',[0.8314    0.8157    0.7843])
    case 2
         set(handles.A_tone,'BackgroundColor',[0.8314    0.8157    0.7843])
         set(handles.Noise_A_low,'BackgroundColor',[1 0 0])
         set(handles.Noise_A_high,'BackgroundColor',[1 0 0])
         set(handles.choose_A_file,'BackgroundColor',[0.8314    0.8157    0.7843])
    case 3
         set(handles.A_tone,'BackgroundColor',[0.8314    0.8157    0.7843])
         set(handles.Noise_A_low,'BackgroundColor',[0.8314    0.8157    0.7843])
         set(handles.Noise_A_high,'BackgroundColor',[0.8314    0.8157    0.7843])
         set(handles.choose_A_file,'BackgroundColor',[1 0 0])
end
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save SSAPARAMS SSAPARAMS
cd (curdir)

% --- Executes during object creation, after setting all properties.
function choose_A_CreateFcn(hObject, eventdata, handles)
% hObject    handle to choose_A (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in choose_B.
function choose_B_Callback(hObject, eventdata, handles)
% hObject    handle to choose_B (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns choose_B contents as cell array
%        contents{get(hObject,'Value')} returns selected item from choose_B

load SSAPARAMS
SSAPARAMS.Btype=get(hObject,'Value');
switch get(hObject,'Value')
    case 1
         set(handles.B_tone,'BackgroundColor',[1 0 0])
         set(handles.Noise_B_low,'BackgroundColor',[0.8314    0.8157    0.7843])
         set(handles.Noise_B_high,'BackgroundColor',[0.8314    0.8157    0.7843])
         set(handles.choose_B_file,'BackgroundColor',[0.8314    0.8157    0.7843])
    case 2
         set(handles.B_tone,'BackgroundColor',[0.8314    0.8157    0.7843])
         set(handles.Noise_B_low,'BackgroundColor',[1 0 0])
         set(handles.Noise_B_high,'BackgroundColor',[1 0 0])
         set(handles.choose_B_file,'BackgroundColor',[0.8314    0.8157    0.7843])
    case 3
         set(handles.B_tone,'BackgroundColor',[0.8314    0.8157    0.7843])
         set(handles.Noise_B_low,'BackgroundColor',[0.8314    0.8157    0.7843])
         set(handles.Noise_B_high,'BackgroundColor',[0.8314    0.8157    0.7843])
         set(handles.choose_B_file,'BackgroundColor',[1 0 0])
end
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save SSAPARAMS SSAPARAMS
cd (curdir)

% --- Executes during object creation, after setting all properties.
function choose_B_CreateFcn(hObject, eventdata, handles)
% hObject    handle to choose_B (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function freqA_Callback(hObject, eventdata, handles)
% hObject    handle to freqA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of freqA as text
%        str2double(get(hObject,'String')) returns contents of freqA as a double

load SSAPARAMS
SSAPARAMS.freqA=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.freqA,'Value',SSAPARAMS.freqA);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save SSAPARAMS SSAPARAMS
cd (curdir)

% --- Executes during object creation, after setting all properties.
function freqA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to freqA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function freqB_Callback(hObject, eventdata, handles)
% hObject    handle to freqB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of freqB as text
%        str2double(get(hObject,'String')) returns contents of freqB as a double

load SSAPARAMS
SSAPARAMS.freqB=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.freqB,'Value',SSAPARAMS.freqB);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save SSAPARAMS SSAPARAMS
cd (curdir)

% --- Executes during object creation, after setting all properties.
function freqB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to freqB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function NoiseAlow_Callback(hObject, eventdata, handles)
% hObject    handle to NoiseAlow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NoiseAlow as text
%        str2double(get(hObject,'String')) returns contents of NoiseAlow as a double

load SSAPARAMS
SSAPARAMS.NoiseAlow=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.NoiseAlow,'Value',SSAPARAMS.NoiseAlow);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save SSAPARAMS SSAPARAMS
cd (curdir)

% --- Executes during object creation, after setting all properties.
function NoiseAlow_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NoiseAlow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function NoiseBlow_Callback(hObject, eventdata, handles)
% hObject    handle to NoiseBlow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NoiseBlow as text
%        str2double(get(hObject,'String')) returns contents of NoiseBlow as a double

load SSAPARAMS
SSAPARAMS.NoiseBlow=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.NoiseBlow,'Value',SSAPARAMS.NoiseBlow);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save SSAPARAMS SSAPARAMS
cd (curdir)

% --- Executes during object creation, after setting all properties.
function NoiseBlow_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NoiseBlow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function NoiseAhigh_Callback(hObject, eventdata, handles)
% hObject    handle to NoiseAhigh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NoiseAhigh as text
%        str2double(get(hObject,'String')) returns contents of NoiseAhigh as a double

load SSAPARAMS
SSAPARAMS.NoiseAhigh=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.NoiseAhigh,'Value',SSAPARAMS.NoiseAhigh);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save SSAPARAMS SSAPARAMS
cd (curdir)

% --- Executes during object creation, after setting all properties.
function NoiseAhigh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NoiseAhigh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function NoiseBhigh_Callback(hObject, eventdata, handles)
% hObject    handle to NoiseBhigh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NoiseBhigh as text
%        str2double(get(hObject,'String')) returns contents of NoiseBhigh as a double

load SSAPARAMS
SSAPARAMS.NoiseBhigh=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.NoiseBhigh,'Value',SSAPARAMS.NoiseBhigh);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save SSAPARAMS SSAPARAMS
cd (curdir)

% --- Executes during object creation, after setting all properties.
function NoiseBhigh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NoiseBhigh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function total_stims_Callback(hObject, eventdata, handles)
% hObject    handle to total_stims (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of total_stims as text
%        str2double(get(hObject,'String')) returns contents of total_stims as a double

load SSAPARAMS
SSAPARAMS.total_stims=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.total_stims,'Value',SSAPARAMS.total_stims);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save SSAPARAMS SSAPARAMS
cd (curdir)

% --- Executes during object creation, after setting all properties.
function total_stims_CreateFcn(hObject, eventdata, handles)
% hObject    handle to total_stims (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function stimB_loc_Callback(hObject, eventdata, handles)
% hObject    handle to stimB_loc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stimB_loc as text
%        str2double(get(hObject,'String')) returns contents of stimB_loc as a double

load SSAPARAMS
SSAPARAMS.stimB_loc=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.stimB_loc,'Value',SSAPARAMS.stimB_loc);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save SSAPARAMS SSAPARAMS
cd (curdir)

% --- Executes during object creation, after setting all properties.
function stimB_loc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stimB_loc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in randB_check.
function randB_check_Callback(hObject, eventdata, handles)
% hObject    handle to randB_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of randB_check

load SSAPARAMS
SSAPARAMS.randB_check=get(hObject,'Value');
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save SSAPARAMS SSAPARAMS
cd (curdir)

function nreps_Callback(hObject, eventdata, handles)
% hObject    handle to nreps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nreps as text
%        str2double(get(hObject,'String')) returns contents of nreps as a double

load SSAPARAMS
SSAPARAMS.nreps=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.nreps,'Value',SSAPARAMS.nreps);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save SSAPARAMS SSAPARAMS
cd (curdir)

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



function atten_Callback(hObject, eventdata, handles)
% hObject    handle to atten (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of atten as text
%        str2double(get(hObject,'String')) returns contents of atten as a double

load SSAPARAMS
SSAPARAMS.atten=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.atten,'Value',SSAPARAMS.atten);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save SSAPARAMS SSAPARAMS
cd (curdir)

% --- Executes during object creation, after setting all properties.
function atten_CreateFcn(hObject, eventdata, handles)
% hObject    handle to atten (see GCBO)
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

% Hint: get(hObject,'Value') returns toggle state of done_button

load SSAPARAMS
SSAPARAMS.frame_dur=get(handles.frame_dur,'Value');fdur=SSAPARAMS.frame_dur;
SSAPARAMS.total_frames_lines=get(handles.total_frames_lines,'Value');tfl=SSAPARAMS.total_frames_lines;
SSAPARAMS.stim_start=get(handles.stim_start,'Value');sf=SSAPARAMS.stim_start;

SSAPARAMS.stim_Adur=get(handles.stim_Adur,'Value');stim_Adur=SSAPARAMS.stim_Adur;
SSAPARAMS.stim_Bdur=get(handles.stim_Bdur,'Value');stim_Bdur=SSAPARAMS.stim_Bdur;
SSAPARAMS.gap_dur=get(handles.gap_dur,'Value');gap_dur=SSAPARAMS.gap_dur;

SSAPARAMS.Atype=get(handles.choose_A,'Value');tA=SSAPARAMS.Atype;
SSAPARAMS.Btype=get(handles.choose_B,'Value');tB=SSAPARAMS.Btype;

SSAPARAMS.freqA=get(handles.freqA,'Value');freqA=SSAPARAMS.freqA;
SSAPARAMS.freqB=get(handles.freqB,'Value');freqB=SSAPARAMS.freqB;
SSAPARAMS.NoiseAlow=get(handles.NoiseAlow,'Value');NoiseAlow=SSAPARAMS.NoiseAlow;
SSAPARAMS.NoiseAhigh=get(handles.NoiseAhigh,'Value');NoiseAhigh=SSAPARAMS.NoiseAhigh;
SSAPARAMS.NoiseBlow=get(handles.NoiseBlow,'Value');NoiseBlow=SSAPARAMS.NoiseBlow;
SSAPARAMS.NoiseBhigh=get(handles.NoiseBhigh,'Value');NoiseBhigh=SSAPARAMS.NoiseBhigh;
SSAPARAMS.file_A=get(handles.file_A,'String');file_A=SSAPARAMS.file_A;
SSAPARAMS.file_B=get(handles.file_B,'String');file_B=SSAPARAMS.file_B;

SSAPARAMS.total_stims=get(handles.total_stims,'Value');total_stims=SSAPARAMS.total_stims;
SSAPARAMS.stimB_loc=get(handles.stimB_loc,'Value');stimB_loc=SSAPARAMS.stimB_loc;
SSAPARAMS.num_stimB=get(handles.num_stimB,'Value');num_stimB=SSAPARAMS.num_stimB;

SSAPARAMS.atten=get(handles.atten,'Value');atten=SSAPARAMS.atten;
SSAPARAMS.nreps=get(handles.nreps,'Value');treps=SSAPARAMS.nreps;
SSAPARAMS.randB_check=get(handles.randB_check,'Value');
SSAPARAMS.rand_nstim_check=get(handles.rand_nstim_check,'Value');
if SSAPARAMS.randB_check==1&SSAPARAMS.rand_nstim_check==0
    SSAPARAMS.rand_stimB_loc=fix((total_stims-1)*rand(1,treps))+2;%%% SB there was error till 13/1/2015 - corrected 14/1/2015 SB
    %SSAPARAMS.rand_stimB_loc
end
if SSAPARAMS.rand_nstim_check==1
    changemax=fix(1/3*total_stims);%%% 30% variation
    nstimvar=fix((2*changemax+1)*rand(1,treps)+1)-changemax-1
    SSAPARAMS.rand_nstim_num=repmat([total_stims],1,treps)+nstimvar;%%% 30% variation
    if SSAPARAMS.randB_check==1
        SSAPARAMS.rand_stimB_loc=[];
        for lll=1:treps
            SSAPARAMS.rand_stimB_loc(lll)=fix((SSAPARAMS.rand_nstim_num(lll)-1)*rand(1,1))+2;
        end
    end
        
end
SSAPARAMS.use_sam=get(handles.use_sam,'Value');
SSAPARAMS.do_swap=get(handles.do_swap,'Value');
SSAPARAMS.A_period=get(handles.A_period,'Value');
SSAPARAMS.B_period=get(handles.B_period,'Value');
SSAPARAMS.A_mod_cyc=get(handles.A_mod_cyc,'Value');
SSAPARAMS.B_mod_cyc=get(handles.B_mod_cyc,'Value');
if SSAPARAMS.use_sam==1
    stim_Adur=SSAPARAMS.A_period*SSAPARAMS.A_mod_cyc;
    stim_Bdur=SSAPARAMS.B_period*SSAPARAMS.B_mod_cyc;
    if SSAPARAMS.do_swap==1
        stim_Adur=SSAPARAMS.B_period*SSAPARAMS.B_mod_cyc;
        stim_Bdur=SSAPARAMS.A_period*SSAPARAMS.A_mod_cyc;
    end
end

curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save SSAPARAMS SSAPARAMS
cd (curdir)

load AudStimPARAMS
AudStimPARAMS.type='SSA';
AudStimPARAMS.stim_protocol=SSAPARAMS;
close(handles.figure1)
total_prairie_iterations=treps;
each_stim_dur=(total_stims-1)*stim_Adur+stim_Bdur+total_stims*gap_dur;
each_prairie_dur=tfl*fdur;
if SSAPARAMS.randB_check==0&SSAPARAMS.rand_nstim_check==0
    lines_per_set=1;
else
    lines_per_set=treps;
    treps=1;
end

if AudStimPARAMS.MultFrame==0
%at least 200 ms extra at the end
    least_dur=(sf-1)*fdur+each_stim_dur+0.2;
    least_prairie_frames=ceil(least_dur/fdur);
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
    load SSA_handles
    set(AA_handles.check_disp,'String',display_str)
    set(AA_handles.check_disp,'BackgroundColor',disp_bgcolor)
    set(AA_handles.check_disp,'FontSize',9)
    eval(sprintf('prot_str=''SSA A-stim B-ODDBALL: A Type %i, B Type %i, %i SSA stims sequence %i dB atten, Starts at frame/line %i'';',tA,tB,total_stims,atten,sf))
    set(AA_handles.disp_protocol,'String',prot_str)

elseif AudStimPARAMS.MultFrame==1
    display_str='Multiple frames does not work for SSA A-stim B-ODDBALL Sequence';
    disp_bgcolor=[1 0 0];
    set(AA_handles.check_disp,'String',display_str)
    set(AA_handles.check_disp,'BackgroundColor',disp_bgcolor)
    set(AA_handles.check_disp,'FontSize',9)
    prot_str='N/A';
end
    
AudStimPARAMS.protocol_str=prot_str;
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save AudStimPARAMS AudStimPARAMS
cd (curdir)
%save AudStimPARAMS AudStimPARAMS


% --- Executes on button press in choose_A_file.
function choose_A_file_Callback(hObject, eventdata, handles)
% hObject    handle to choose_A_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of choose_A_file

load SSAPARAMS
[fname, pathname] = uigetfile('*.wav','Pick Stim A wav file','G:\MATLAB701\work\2p\STIMULI\');
SSAPARAMS.file_A=fname;
SSAPARAMS.path_A=pathname;
set(handles.file_A,'String',fname)
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save SSAPARAMS SSAPARAMS
cd (curdir)

% --- Executes on button press in choose_B_file.
function choose_B_file_Callback(hObject, eventdata, handles)
% hObject    handle to choose_B_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of choose_B_file

load SSAPARAMS
[fname, pathname] = uigetfile('*.wav','Pick Stim B wav file','G:\MATLAB701\work\2p\STIMULI\');
SSAPARAMS.file_B=fname;
SSAPARAMS.path_B=pathname;
set(handles.file_B,'String',fname)
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save SSAPARAMS SSAPARAMS
cd (curdir)


% --- Executes on button press in rand_nstim_check.
function rand_nstim_check_Callback(hObject, eventdata, handles)
% hObject    handle to rand_nstim_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rand_nstim_check
load SSAPARAMS
SSAPARAMS.rand_nstim_check=get(hObject,'Value');
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save SSAPARAMS SSAPARAMS
cd (curdir)


function num_stimB_Callback(hObject, eventdata, handles)
% hObject    handle to num_stimB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of num_stimB as text
%        str2double(get(hObject,'String')) returns contents of num_stimB as a double
load SSAPARAMS
SSAPARAMS.num_stimB=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.num_stimB,'Value',SSAPARAMS.num_stimB);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save SSAPARAMS SSAPARAMS
cd (curdir)


% --- Executes during object creation, after setting all properties.
function num_stimB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to num_stimB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in use_sam.
function use_sam_Callback(hObject, eventdata, handles)
% hObject    handle to use_sam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of use_sam

load SSAPARAMS
SSAPARAMS.use_sam=get(hObject,'Value');
if SSAPARAMS.use_sam==1
    set(handles.samblock,'BackgroundColor',[1    0    0]);
else
    set(handles.samblock,'BackgroundColor','white');
end
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save SSAPARAMS SSAPARAMS
cd (curdir)

% --- Executes on button press in do_swap.
function do_swap_Callback(hObject, eventdata, handles)
% hObject    handle to do_swap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of do_swap
load SSAPARAMS
SSAPARAMS.do_swap=get(hObject,'Value');
if SSAPARAMS.do_swap==1
    set(handles.do_swap,'BackgroundColor',[0    1    0]);
else
    set(handles.do_swap,'BackgroundColor','white');
end
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save SSAPARAMS SSAPARAMS
cd (curdir)


function A_period_Callback(hObject, eventdata, handles)
% hObject    handle to A_period (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of A_period as text
%        str2double(get(hObject,'String')) returns contents of A_period as a double

load SSAPARAMS
SSAPARAMS.A_period=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.A_period,'Value',SSAPARAMS.A_period);
if SSAPARAMS.use_sam==1
    if SSAPARAMS.do_swap==0
        eval(sprintf('set(handles.stim_Adur,''String'',''%8.4f'');',SSAPARAMS.A_period*SSAPARAMS.A_mod_cyc))
        set(handles.stim_Adur,'Value',SSAPARAMS.A_period*SSAPARAMS.A_mod_cyc);
        SSAPARAMS.stim_Adur=SSAPARAMS.A_period*SSAPARAMS.A_mod_cyc;
    elseif SSAPARAMS.do_swap==1
        eval(sprintf('set(handles.stim_Bdur,''String'',''%8.4f'');',SSAPARAMS.A_period*SSAPARAMS.A_mod_cyc))
        set(handles.stim_Adur,'Value',SSAPARAMS.A_period*SSAPARAMS.A_mod_cyc);
        SSAPARAMS.stim_Adur=SSAPARAMS.A_period*SSAPARAMS.A_mod_cyc;
    end
end
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save SSAPARAMS SSAPARAMS
cd (curdir)

% --- Executes during object creation, after setting all properties.
function A_period_CreateFcn(hObject, eventdata, handles)
% hObject    handle to A_period (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function B_period_Callback(hObject, eventdata, handles)
% hObject    handle to B_period (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of B_period as text
%        str2double(get(hObject,'String')) returns contents of B_period as a double

load SSAPARAMS
SSAPARAMS.B_period=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.B_period,'Value',SSAPARAMS.B_period);
if SSAPARAMS.use_sam==1
    if SSAPARAMS.do_swap==0
        eval(sprintf('set(handles.stim_Bdur,''String'',''%8.4f'');',SSAPARAMS.B_period*SSAPARAMS.B_mod_cyc))
        set(handles.stim_Bdur,'Value',SSAPARAMS.B_period*SSAPARAMS.B_mod_cyc);
        SSAPARAMS.stim_Bdur=SSAPARAMS.B_period*SSAPARAMS.B_mod_cyc;
    elseif SSAPARAMS.do_swap==1
        eval(sprintf('set(handles.stim_Adur,''String'',''%8.4f'');',SSAPARAMS.B_period*SSAPARAMS.B_mod_cyc))
        set(handles.stim_Bdur,'Value',SSAPARAMS.B_period*SSAPARAMS.B_mod_cyc);
        SSAPARAMS.stim_Bdur=SSAPARAMS.B_period*SSAPARAMS.B_mod_cyc;
    end
end
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save SSAPARAMS SSAPARAMS
cd (curdir)

% --- Executes during object creation, after setting all properties.
function B_period_CreateFcn(hObject, eventdata, handles)
% hObject    handle to B_period (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function A_mod_cyc_Callback(hObject, eventdata, handles)
% hObject    handle to A_mod_cyc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of A_mod_cyc as text
%        str2double(get(hObject,'String')) returns contents of A_mod_cyc as a double

load SSAPARAMS
SSAPARAMS.A_mod_cyc=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.A_mod_cyc,'Value',SSAPARAMS.A_mod_cyc);
if SSAPARAMS.use_sam==1
    if SSAPARAMS.do_swap==0
        eval(sprintf('set(handles.stim_Adur,''String'',''%8.4f'');',SSAPARAMS.A_period*SSAPARAMS.A_mod_cyc))
        set(handles.stim_Adur,'Value',SSAPARAMS.A_period*SSAPARAMS.A_mod_cyc);
        SSAPARAMS.stim_Adur=SSAPARAMS.A_period*SSAPARAMS.A_mod_cyc;
    elseif SSAPARAMS.do_swap==1
        eval(sprintf('set(handles.stim_Bdur,''String'',''%8.4f'');',SSAPARAMS.A_period*SSAPARAMS.A_mod_cyc))
        set(handles.stim_Adur,'Value',SSAPARAMS.A_period*SSAPARAMS.A_mod_cyc);
        SSAPARAMS.stim_Adur=SSAPARAMS.A_period*SSAPARAMS.A_mod_cyc;
    end
end
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save SSAPARAMS SSAPARAMS
cd (curdir)

% --- Executes during object creation, after setting all properties.
function A_mod_cyc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to A_mod_cyc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function B_mod_cyc_Callback(hObject, eventdata, handles)
% hObject    handle to B_mod_cyc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of B_mod_cyc as text
%        str2double(get(hObject,'String')) returns contents of B_mod_cyc as a double

load SSAPARAMS
SSAPARAMS.B_mod_cyc=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.B_mod_cyc,'Value',SSAPARAMS.B_mod_cyc);
if SSAPARAMS.use_sam==1
    if SSAPARAMS.do_swap==0
        eval(sprintf('set(handles.stim_Bdur,''String'',''%8.4f'');',SSAPARAMS.B_period*SSAPARAMS.B_mod_cyc))
        set(handles.stim_Bdur,'Value',SSAPARAMS.B_period*SSAPARAMS.B_mod_cyc);
        SSAPARAMS.stim_Bdur=SSAPARAMS.B_period*SSAPARAMS.B_mod_cyc;
    elseif SSAPARAMS.do_swap==1
        eval(sprintf('set(handles.stim_Adur,''String'',''%8.4f'');',SSAPARAMS.B_period*SSAPARAMS.B_mod_cyc))
        set(handles.stim_Bdur,'Value',SSAPARAMS.B_period*SSAPARAMS.B_mod_cyc);
        SSAPARAMS.stim_Bdur=SSAPARAMS.B_period*SSAPARAMS.B_mod_cyc;
    end
end
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save SSAPARAMS SSAPARAMS
cd (curdir)

% --- Executes during object creation, after setting all properties.
function B_mod_cyc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to B_mod_cyc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
