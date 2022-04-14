function varargout = ABA_2T_GUI(varargin)
% ABA_2T_GUI M-file for ABA_2T_GUI.fig
%      ABA_2T_GUI, by itself, creates a new ABA_2T_GUI or raises the existing
%      singleton*.
%
%      H = ABA_2T_GUI returns the handle to a new ABA_2T_GUI or the handle to
%      the existing singleton*.
%
%      ABA_2T_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ABA_2T_GUI.M with the given input arguments.
%
%      ABA_2T_GUI('Property','Value',...) creates a new ABA_2T_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ABA_2T_GUI_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ABA_2T_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help ABA_2T_GUI

% Last Modified by GUIDE v2.5 12-Jan-2010 17:45:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ABA_2T_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @ABA_2T_GUI_OutputFcn, ...
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


% --- Executes just before ABA_2T_GUI is made visible.
function ABA_2T_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ABA_2T_GUI (see VARARGIN)

% Choose default command line output for ABA_2T_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

load ABAPARAMS
load Auditory_handles
wtd_val=get(PP_handles.what_to_do,'Value');
if wtd_val==7
    set(handles.text11,'String','Total Time (sec)')
    set(handles.text12,'String','Start Time (sec)')
end
eval(sprintf('set(handles.frame_dur,''String'',''%5.3f'');',ABAPARAMS.frame_dur))
set(handles.frame_dur,'Value',ABAPARAMS.frame_dur);
eval(sprintf('set(handles.total_frames_lines,''String'',''%i'');',ABAPARAMS.total_frames_lines))
set(handles.total_frames_lines,'Value',ABAPARAMS.total_frames_lines);
eval(sprintf('set(handles.stim_start,''String'',''%i'');',ABAPARAMS.stim_start))
set(handles.stim_start,'Value',ABAPARAMS.stim_start);

eval(sprintf('set(handles.toneAfr,''String'',''%i'');',ABAPARAMS.toneAfr))
set(handles.toneAfr,'Value',ABAPARAMS.toneAfr);
eval(sprintf('set(handles.Bfr_re_A_octaves,''String'',''%4.2f'');',ABAPARAMS.Bfr_re_A_octaves))
set(handles.Bfr_re_A_octaves,'Value',ABAPARAMS.Bfr_re_A_octaves);

eval(sprintf('set(handles.tone_Adur,''String'',''%5.3f'');',ABAPARAMS.tone_Adur))
set(handles.tone_Adur,'Value',ABAPARAMS.tone_Adur);
eval(sprintf('set(handles.tone_Bdur,''String'',''%5.3f'');',ABAPARAMS.tone_Bdur))
set(handles.tone_Bdur,'Value',ABAPARAMS.tone_Bdur);
eval(sprintf('set(handles.gapdur,''String'',''%5.3f'');',ABAPARAMS.gapdur))
set(handles.gapdur,'Value',ABAPARAMS.gapdur);

eval(sprintf('set(handles.num_ABA_sets,''String'',''%i'');',ABAPARAMS.num_ABA_sets))
set(handles.num_ABA_sets,'Value',ABAPARAMS.num_ABA_sets);
eval(sprintf('set(handles.atten,''String'',''%3.1f'');',ABAPARAMS.atten))
set(handles.atten,'Value',ABAPARAMS.atten);
eval(sprintf('set(handles.total_reps,''String'',''%i'');',ABAPARAMS.total_reps))
set(handles.total_reps,'Value',ABAPARAMS.total_reps);

% UIWAIT makes ABA_2T_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ABA_2T_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles;



function toneAfr_Callback(hObject, eventdata, handles)
% hObject    handle to toneAfr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of toneAfr as text
%        str2double(get(hObject,'String')) returns contents of toneAfr as a double

load ABAPARAMS
ABAPARAMS.toneAfr=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.toneAfr,'Value',ABAPARAMS.toneAfr);
save ABAPARAMS ABAPARAMS


% --- Executes during object creation, after setting all properties.
function toneAfr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to toneAfr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function num_ABA_sets_Callback(hObject, eventdata, handles)
% hObject    handle to toneAfr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of toneAfr as text
%        str2double(get(hObject,'String')) returns contents of toneAfr as a double

load ABAPARAMS
ABAPARAMS.num_ABA_sets=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.num_ABA_sets,'Value',ABAPARAMS.num_ABA_sets);
save ABAPARAMS ABAPARAMS


% --- Executes during object creation, after setting all properties.
function num_ABA_sets_CreateFcn(hObject, eventdata, handles)
% hObject    handle to toneAfr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function tone_Adur_Callback(hObject, eventdata, handles)
% hObject    handle to tone_Adur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tone_Adur as text
%        str2double(get(hObject,'String')) returns contents of tone_Adur as a double

load ABAPARAMS
ABAPARAMS.tone_Adur=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.toneA_dur,'Value',ABAPARAMS.toneA_dur);
save ABAPARAMS ABAPARAMS

% --- Executes during object creation, after setting all properties.
function tone_Adur_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tone_Adur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Bfr_re_A_octaves_Callback(hObject, eventdata, handles)
% hObject    handle to Bfr_re_A_octaves (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Bfr_re_A_octaves as text
%        str2double(get(hObject,'String')) returns contents of Bfr_re_A_octaves as a double

load ABAPARAMS
ABAPARAMS.Bfr_re_A_octaves=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.Bfr_re_A_octaves,'Value',ABAPARAMS.Bfr_re_A_octaves);
save ABAPARAMS ABAPARAMS

% --- Executes during object creation, after setting all properties.
function Bfr_re_A_octaves_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Bfr_re_A_octaves (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tone_Bdur_Callback(hObject, eventdata, handles)
% hObject    handle to tone_Bdur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tone_Bdur as text
%        str2double(get(hObject,'String')) returns contents of tone_Bdur as a double

load ABAPARAMS
ABAPARAMS.tone_Bdur=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.tone_Bdur,'Value',ABAPARAMS.tone_Bdur);
save ABAPARAMS ABAPARAMS

% --- Executes during object creation, after setting all properties.
function tone_Bdur_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tone_Bdur (see GCBO)
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

load ABAPARAMS
ABAPARAMS.atten=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.atten,'Value',ABAPARAMS.atten);
save ABAPARAMS ABAPARAMS

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



function frame_dur_Callback(hObject, eventdata, handles)
% hObject    handle to frame_dur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of frame_dur as text
%        str2double(get(hObject,'String')) returns contents of frame_dur as a double

load ABAPARAMS
ABAPARAMS.frame_dur=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.frame_dur,'Value',ABAPARAMS.frame_dur);
save ABAPARAMS ABAPARAMS

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



function total_reps_Callback(hObject, eventdata, handles)
% hObject    handle to total_reps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of total_reps as text
%        str2double(get(hObject,'String')) returns contents of total_reps as a double

load ABAPARAMS
ABAPARAMS.total_reps=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.total_reps,'Value',ABAPARAMS.total_reps);
save ABAPARAMS ABAPARAMS


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



function gapdur_Callback(hObject, eventdata, handles)
% hObject    handle to gapdur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gapdur as text
%        str2double(get(hObject,'String')) returns contents of gapdur as a double

load ABAPARAMS
ABAPARAMS.gapdur=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.gapdur,'Value',ABAPARAMS.gapdur);
save ABAPARAMS ABAPARAMS

% --- Executes during object creation, after setting all properties.
function gapdur_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gapdur (see GCBO)
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

load ABAPARAMS
ABAPARAMS.frame_dur=get(handles.frame_dur,'Value');fdur=ABAPARAMS.frame_dur;
ABAPARAMS.total_frames_lines=get(handles.total_frames_lines,'Value');tfl=ABAPARAMS.total_frames_lines;
ABAPARAMS.stim_start=get(handles.stim_start,'Value');sf=ABAPARAMS.stim_start;
ABAPARAMS.toneAfr=get(handles.toneAfr,'Value');toneAfr=ABAPARAMS.toneAfr;
ABAPARAMS.Bfr_re_A_octaves=get(handles.Bfr_re_A_octaves,'Value');Bfr_re_A_octaves=ABAPARAMS.Bfr_re_A_octaves;

ABAPARAMS.tone_Adur=get(handles.tone_Adur,'Value');tone_Adur=ABAPARAMS.tone_Adur;
ABAPARAMS.tone_Bdur=get(handles.tone_Bdur,'Value');tone_Bdur=ABAPARAMS.tone_Bdur;
ABAPARAMS.gapdur=get(handles.gapdur,'Value');gap_dur=ABAPARAMS.gapdur;
ABAPARAMS.num_ABA_sets=get(handles.num_ABA_sets,'Value');num_ABA_sets=ABAPARAMS.num_ABA_sets;
ABAPARAMS.atten=get(handles.atten,'Value');atten=ABAPARAMS.atten;
ABAPARAMS.total_reps=get(handles.total_reps,'Value');treps=ABAPARAMS.total_reps;
toneBfr=toneAfr*2^(Bfr_re_A_octaves);

save ABAPARAMS ABAPARAMS

load AudStimPARAMS
AudStimPARAMS.type='ABA';
AudStimPARAMS.stim_protocol=ABAPARAMS;
close(handles.figure1)
total_prairie_iterations=treps;
each_stim_dur=num_ABA_sets*(2*tone_Adur+tone_Bdur+gap_dur);
each_prairie_dur=tfl*fdur;
lines_per_set=1;

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
    load ABA_handles
    set(AA_handles.check_disp,'String',display_str)
    set(AA_handles.check_disp,'BackgroundColor',disp_bgcolor)
    set(AA_handles.check_disp,'FontSize',9)
    eval(sprintf('prot_str=''ABA 2-Tone Sequence: A Freq=%i kHz, B Freq=%i, %i ABA sets sequence %i dB atten, Starts at frame/line %i'';',fix(toneAfr/1000),fix(toneBfr/1000),num_ABA_sets,atten,sf))
    set(AA_handles.disp_protocol,'String',prot_str)

elseif AudStimPARAMS.MultFrame==1
    display_str='Multiple frames does not work for ABA 2-T Sequence';
    disp_bgcolor=[1 0 0];
    set(AA_handles.check_disp,'String',display_str)
    set(AA_handles.check_disp,'BackgroundColor',disp_bgcolor)
    set(AA_handles.check_disp,'FontSize',9)
    prot_str='N/A';
end
    
AudStimPARAMS.protocol_str=prot_str;
save AudStimPARAMS AudStimPARAMS



function total_frames_lines_Callback(hObject, eventdata, handles)
% hObject    handle to total_frames_lines (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of total_frames_lines as text
%        str2double(get(hObject,'String')) returns contents of total_frames_lines as a double

load ABAPARAMS
ABAPARAMS.total_frames_lines=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.total_frames_lines,'Value',ABAPARAMS.total_frames_lines);
save ABAPARAMS ABAPARAMS

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

load ABAPARAMS
ABAPARAMS.stim_start=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.stim_start,'Value',ABAPARAMS.stim_start);
save ABAPARAMS ABAPARAMS

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





function total_reps_sets_Callback(hObject, eventdata, handles)
% hObject    handle to total_reps_sets (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of total_reps_sets as text
%        str2double(get(hObject,'String')) returns contents of total_reps_sets as a double


% --- Executes during object creation, after setting all properties.
function total_reps_sets_CreateFcn(hObject, eventdata, handles)
% hObject    handle to total_reps_sets (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


