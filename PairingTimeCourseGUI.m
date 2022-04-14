function varargout = PairingTimeCourseGUI(varargin)
% PAIRINGTIMECOURSEGUI M-file for PairingTimeCourseGUI.fig
%      PAIRINGTIMECOURSEGUI, by itself, creates a new PAIRINGTIMECOURSEGUI or raises the existing
%      singleton*.
%
%      H = PAIRINGTIMECOURSEGUI returns the handle to a new PAIRINGTIMECOURSEGUI or the handle to
%      the existing singleton*.
%
%      PAIRINGTIMECOURSEGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PAIRINGTIMECOURSEGUI.M with the given input arguments.
%
%      PAIRINGTIMECOURSEGUI('Property','Value',...) creates a new PAIRINGTIMECOURSEGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PairingTimeCourseGUI_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PairingTimeCourseGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PairingTimeCourseGUI

% Last Modified by GUIDE v2.5 19-Oct-2010 14:05:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PairingTimeCourseGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @PairingTimeCourseGUI_OutputFcn, ...
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


% --- Executes just before PairingTimeCourseGUI is made visible.
function PairingTimeCourseGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PairingTimeCourseGUI (see VARARGIN)

% Choose default command line output for PairingTimeCourseGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

load Pairing_TC_PARAMS
% load Auditory_handles
% wtd_val=get(PP_handles.what_to_do,'Value');
% if wtd_val==7
%     set(handles.text11,'String','Total Time (sec)')
%     set(handles.text12,'String','Start Time (sec)')
% end
eval(sprintf('set(handles.frame_dur,''String'',''%5.3f'');',Pairing_TC_PARAMS.frame_dur))
set(handles.frame_dur,'Value',Pairing_TC_PARAMS.frame_dur);
eval(sprintf('set(handles.total_frames_lines,''String'',''%i'');',Pairing_TC_PARAMS.total_frames_lines))
set(handles.total_frames_lines,'Value',Pairing_TC_PARAMS.total_frames_lines);
eval(sprintf('set(handles.stim_start,''String'',''%i'');',Pairing_TC_PARAMS.stim_start))
set(handles.stim_start,'Value',Pairing_TC_PARAMS.stim_start);
eval(sprintf('set(handles.current_amplitude,''String'',''%5.3f'');',Pairing_TC_PARAMS.current_amplitude))
set(handles.current_amplitude,'Value',Pairing_TC_PARAMS.current_amplitude);

eval(sprintf('set(handles.toneB,''String'',''%i'');',Pairing_TC_PARAMS.toneB))
set(handles.toneB,'Value',Pairing_TC_PARAMS.toneB);
eval(sprintf('set(handles.toneA_octaves_from_B,''String'',''%4.2f'');',Pairing_TC_PARAMS.toneA_octaves_from_B))
set(handles.toneA_octaves_from_B,'Value',Pairing_TC_PARAMS.toneA_octaves_from_B);

eval(sprintf('set(handles.tone_duration,''String'',''%5.3f'');',Pairing_TC_PARAMS.tone_duration))
set(handles.tone_duration,'Value',Pairing_TC_PARAMS.tone_duration);
eval(sprintf('set(handles.mod_freq,''String'',''%i'');',Pairing_TC_PARAMS.mod_freq))
set(handles.mod_freq,'Value',Pairing_TC_PARAMS.mod_freq);
eval(sprintf('set(handles.mod_depth,''String'',''%5.3f'');',Pairing_TC_PARAMS.mod_depth))
set(handles.mod_depth,'Value',Pairing_TC_PARAMS.mod_depth);

eval(sprintf('set(handles.tone_reps,''String'',''%i'');',Pairing_TC_PARAMS.tone_reps))
set(handles.tone_reps,'Value',Pairing_TC_PARAMS.tone_reps);
eval(sprintf('set(handles.attens,''String'',''%3.1f'');',Pairing_TC_PARAMS.attens))
set(handles.attens,'Value',Pairing_TC_PARAMS.attens);
eval(sprintf('set(handles.measure_batches,''String'',''%i'');',Pairing_TC_PARAMS.measure_batches))
set(handles.measure_batches,'Value',Pairing_TC_PARAMS.measure_batches);


eval(sprintf('set(handles.pairing_reps,''String'',''%i'');',Pairing_TC_PARAMS.pairing_reps))
set(handles.pairing_reps,'Value',Pairing_TC_PARAMS.pairing_reps);
eval(sprintf('set(handles.ipi_val,''String'',''%6.2f'');',Pairing_TC_PARAMS.ipi_val))
set(handles.ipi_val,'Value',Pairing_TC_PARAMS.ipi_val);
eval(sprintf('set(handles.pulse_width,''String'',''%6.2f'');',Pairing_TC_PARAMS.pulse_width))
set(handles.pulse_width,'Value',Pairing_TC_PARAMS.pulse_width);

% UIWAIT makes PairingTimeCourseGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = PairingTimeCourseGUI_OutputFcn(hObject, eventdata, handles) 
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

load Pairing_TC_PARAMS
Pairing_TC_PARAMS.frame_dur=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.frame_dur,'Value',Pairing_TC_PARAMS.frame_dur);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save Pairing_TC_PARAMS Pairing_TC_PARAMS
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



function total_frames_lines_Callback(hObject, eventdata, handles)
% hObject    handle to total_frames_lines (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of total_frames_lines as text
%        str2double(get(hObject,'String')) returns contents of total_frames_lines as a double

load Pairing_TC_PARAMS
Pairing_TC_PARAMS.total_frames_lines=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.total_frames_lines,'Value',Pairing_TC_PARAMS.total_frames_lines);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save Pairing_TC_PARAMS Pairing_TC_PARAMS
cd (curdir)

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

load Pairing_TC_PARAMS
Pairing_TC_PARAMS.stim_start=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.stim_start,'Value',Pairing_TC_PARAMS.stim_start);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save Pairing_TC_PARAMS Pairing_TC_PARAMS
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



function current_amplitude_Callback(hObject, eventdata, handles)
% hObject    handle to current_amplitude (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of current_amplitude as text
%        str2double(get(hObject,'String')) returns contents of current_amplitude as a double

load Pairing_TC_PARAMS
Pairing_TC_PARAMS.current_amplitude=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.current_amplitude,'Value',Pairing_TC_PARAMS.current_amplitude);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save Pairing_TC_PARAMS Pairing_TC_PARAMS
cd (curdir)

% --- Executes during object creation, after setting all properties.
function current_amplitude_CreateFcn(hObject, eventdata, handles)
% hObject    handle to current_amplitude (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function toneB_Callback(hObject, eventdata, handles)
% hObject    handle to toneB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of toneB as text
%        str2double(get(hObject,'String')) returns contents of toneB as a double

load Pairing_TC_PARAMS
Pairing_TC_PARAMS.toneB=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.toneB,'Value',Pairing_TC_PARAMS.toneB);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save Pairing_TC_PARAMS Pairing_TC_PARAMS
cd (curdir)

% --- Executes during object creation, after setting all properties.
function toneB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to toneB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function toneA_octaves_from_B_Callback(hObject, eventdata, handles)
% hObject    handle to toneA_octaves_from_B (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of toneA_octaves_from_B as text
%        str2double(get(hObject,'String')) returns contents of toneA_octaves_from_B as a double

load Pairing_TC_PARAMS
Pairing_TC_PARAMS.toneA_octaves_from_B=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.toneA_octaves_from_B,'Value',Pairing_TC_PARAMS.toneA_octaves_from_B);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save Pairing_TC_PARAMS Pairing_TC_PARAMS
cd (curdir)

% --- Executes during object creation, after setting all properties.
function toneA_octaves_from_B_CreateFcn(hObject, eventdata, handles)
% hObject    handle to toneA_octaves_from_B (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tone_reps_Callback(hObject, eventdata, handles)
% hObject    handle to tone_reps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tone_reps as text
%        str2double(get(hObject,'String')) returns contents of tone_reps as a double

load Pairing_TC_PARAMS
Pairing_TC_PARAMS.tone_reps=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.tone_reps,'Value',Pairing_TC_PARAMS.tone_reps);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save Pairing_TC_PARAMS Pairing_TC_PARAMS
cd (curdir)

% --- Executes during object creation, after setting all properties.
function tone_reps_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tone_reps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function measure_batches_Callback(hObject, eventdata, handles)
% hObject    handle to measure_batches (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of measure_batches as text
%        str2double(get(hObject,'String')) returns contents of measure_batches as a double

load Pairing_TC_PARAMS
Pairing_TC_PARAMS.measure_batches=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.measure_batches,'Value',Pairing_TC_PARAMS.measure_batches);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save Pairing_TC_PARAMS Pairing_TC_PARAMS
cd (curdir)

% --- Executes during object creation, after setting all properties.
function measure_batches_CreateFcn(hObject, eventdata, handles)
% hObject    handle to measure_batches (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tone_duration_Callback(hObject, eventdata, handles)
% hObject    handle to tone_duration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tone_duration as text
%        str2double(get(hObject,'String')) returns contents of tone_duration as a double

load Pairing_TC_PARAMS
Pairing_TC_PARAMS.tone_duration=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.tone_duration,'Value',Pairing_TC_PARAMS.tone_duration);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save Pairing_TC_PARAMS Pairing_TC_PARAMS
cd (curdir)

% --- Executes during object creation, after setting all properties.
function tone_duration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tone_duration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mod_freq_Callback(hObject, eventdata, handles)
% hObject    handle to mod_freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mod_freq as text
%        str2double(get(hObject,'String')) returns contents of mod_freq as a double

load Pairing_TC_PARAMS
Pairing_TC_PARAMS.mod_freq=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.mod_freq,'Value',Pairing_TC_PARAMS.mod_freq);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save Pairing_TC_PARAMS Pairing_TC_PARAMS
cd (curdir)

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

load Pairing_TC_PARAMS
Pairing_TC_PARAMS.mod_depth=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.mod_depth,'Value',Pairing_TC_PARAMS.mod_depth);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save Pairing_TC_PARAMS Pairing_TC_PARAMS
cd (curdir)

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



function pulse_width_Callback(hObject, eventdata, handles)
% hObject    handle to pulse_width (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pulse_width as text
%        str2double(get(hObject,'String')) returns contents of pulse_width as a double


load Pairing_TC_PARAMS
Pairing_TC_PARAMS.pulse_width=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.pulse_width,'Value',Pairing_TC_PARAMS.pulse_width);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save Pairing_TC_PARAMS Pairing_TC_PARAMS
cd (curdir)

% --- Executes during object creation, after setting all properties.
function pulse_width_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pulse_width (see GCBO)
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

load Pairing_TC_PARAMS
Pairing_TC_PARAMS.ipi_val=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.ipi_val,'Value',Pairing_TC_PARAMS.ipi_val);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save Pairing_TC_PARAMS Pairing_TC_PARAMS
cd (curdir)

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



function pairing_reps_Callback(hObject, eventdata, handles)
% hObject    handle to pairing_reps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pairing_reps as text
%        str2double(get(hObject,'String')) returns contents of pairing_reps as a double

load Pairing_TC_PARAMS
Pairing_TC_PARAMS.pairing_reps=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.pairing_reps,'Value',Pairing_TC_PARAMS.pairing_reps);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save Pairing_TC_PARAMS Pairing_TC_PARAMS
cd (curdir)

% --- Executes during object creation, after setting all properties.
function pairing_reps_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pairing_reps (see GCBO)
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

load Pairing_TC_PARAMS
Pairing_TC_PARAMS.frame_dur=get(handles.frame_dur,'Value');fdur=Pairing_TC_PARAMS.frame_dur;
Pairing_TC_PARAMS.total_frames_lines=get(handles.total_frames_lines,'Value');tfl=Pairing_TC_PARAMS.total_frames_lines;
Pairing_TC_PARAMS.stim_start=get(handles.stim_start,'Value');sf=Pairing_TC_PARAMS.stim_start;
Pairing_TC_PARAMS.toneB=get(handles.toneB,'Value');toneB=Pairing_TC_PARAMS.toneB;
Pairing_TC_PARAMS.toneA_octaves_from_B=get(handles.toneA_octaves_from_B,'Value');toneA_octaves_from_B=Pairing_TC_PARAMS.toneA_octaves_from_B;

Pairing_TC_PARAMS.tone_duration=get(handles.tone_duration,'Value');tone_duration=Pairing_TC_PARAMS.tone_duration;
Pairing_TC_PARAMS.mod_freq=get(handles.mod_freq,'Value');mod_freq=Pairing_TC_PARAMS.mod_freq;
Pairing_TC_PARAMS.mod_depth=get(handles.mod_depth,'Value');mod_depth=Pairing_TC_PARAMS.mod_depth;
Pairing_TC_PARAMS.tone_reps=get(handles.tone_reps,'Value');tone_reps=Pairing_TC_PARAMS.tone_reps;
Pairing_TC_PARAMS.attens=get(handles.attens,'Value');attens=Pairing_TC_PARAMS.attens;
Pairing_TC_PARAMS.measure_batches=get(handles.measure_batches,'Value');measure_batches=Pairing_TC_PARAMS.measure_batches;
toneA=toneB*2^(toneA_octaves_from_B);

Pairing_TC_PARAMS.pulse_width=get(handles.pulse_width,'Value');pulse_width=Pairing_TC_PARAMS.pulse_width;
Pairing_TC_PARAMS.ipi_val=get(handles.ipi_val,'Value');ipi_val=Pairing_TC_PARAMS.ipi_val;
Pairing_TC_PARAMS.pairing_reps=get(handles.pairing_reps,'Value');pairing_reps=Pairing_TC_PARAMS.pairing_reps;

Pairing_TC_PARAMS.type='PTC';
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save Pairing_TC_PARAMS Pairing_TC_PARAMS
cd (curdir)

%close(handles.figure1)
total_prairie_iterations=2*tone_reps*measure_batches+(measure_batches-1)*pairing_reps;
each_stim_dur=tone_duration;
each_prairie_dur=tfl*fdur;
lines_per_set=1;

%if AudStimPARAMS.MultFrame==0
%at least 200 ms extra at the end
    least_dur=(sf-1)*fdur+each_stim_dur+0.2;
    least_prairie_frames=ceil(least_dur/fdur);
    if least_dur<each_prairie_dur
        durcheck_str='PRAIRIE: Number of frames/lines per iter OKAY';
        disp_bgcolor=[0 .8 1];
        eval(sprintf('add_dur_check='' ...[At least %i : currently %i]'';',least_prairie_frames,tfl))
        eval(sprintf('itercheck_str=''Set PAIRIE Number of ITERATIONS to AT LEAST %i'';',total_prairie_iterations))
        display_str=strcat(durcheck_str,add_dur_check,'*\*/\*/*',itercheck_str);
        set(handles.display_image_check,'String',display_str)
        set(handles.display_image_check,'BackgroundColor',disp_bgcolor)
        set(handles.display_image_check,'FontSize',12)
        pause(2)
        close(handles.figure1)
    else
        eval(sprintf('durcheck_str=''PRAIRIE: Increase frames/lines per iter to AT LEAST %i'';',least_prairie_frames))
        disp_bgcolor=[1 0 0];
        eval(sprintf('add_dur_check='' ...[At least %i : currently %i]'';',least_prairie_frames,tfl))
        eval(sprintf('itercheck_str=''Set PAIRIE Number of ITERATIONS to AT LEAST %i'';',total_prairie_iterations))
        display_str=strcat(durcheck_str,add_dur_check,'*\*/\*/*',itercheck_str);
        set(handles.display_image_check,'String',display_str)
        set(handles.display_image_check,'BackgroundColor',disp_bgcolor)
        set(handles.display_image_check,'FontSize',12)
    end
    eval(sprintf('prot_str=''2-Tones, A Freq=%i kHz, B Freq=%i, %i measure sets, %i dB atten, Starts at frame %i, %i pairings in sets of %i'';',fix(toneA/1000),fix(toneB/1000),measure_batches,attens,sf, measure_batches-1,pairing_reps))
    %set(AA_handles.disp_protocol,'String',prot_str)

% elseif AudStimPARAMS.MultFrame==1
%     display_str='Multiple frames does not work for Pairing Time Course';
%     disp_bgcolor=[1 0 0];
%     set(AA_handles.check_disp,'String',display_str)
%     set(AA_handles.check_disp,'BackgroundColor',disp_bgcolor)
%     set(AA_handles.check_disp,'FontSize',9)
%     prot_str='N/A';
% end
    
Pairing_TC_PARAMS.protocol_str=prot_str;
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save Pairing_TC_PARAMS Pairing_TC_PARAMS
cd (curdir)

function attens_Callback(hObject, eventdata, handles)
% hObject    handle to attens (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of attens as text
%        str2double(get(hObject,'String')) returns contents of attens as a double

load Pairing_TC_PARAMS
Pairing_TC_PARAMS.attens=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.attens,'Value',Pairing_TC_PARAMS.attens);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save Pairing_TC_PARAMS Pairing_TC_PARAMS
cd (curdir)

% --- Executes during object creation, after setting all properties.
function attens_CreateFcn(hObject, eventdata, handles)
% hObject    handle to attens (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


