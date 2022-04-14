function varargout = EStimGUI(varargin)
% ESTIMGUI M-file for EStimGUI.fig
%      ESTIMGUI, by itself, creates a new ESTIMGUI or raises the existing
%      singleton*.
%
%      H = ESTIMGUI returns the handle to a new ESTIMGUI or the handle to
%      the existing singleton*.
%
%      ESTIMGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ESTIMGUI.M with the given input arguments.
%
%      ESTIMGUI('Property','Value',...) creates a new ESTIMGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before EStimGUI_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to EStimGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help EStimGUI

% Last Modified by GUIDE v2.5 02-Aug-2010 14:45:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @EStimGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @EStimGUI_OutputFcn, ...
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


% --- Executes just before EStimGUI is made visible.
function EStimGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to EStimGUI (see VARARGIN)

% Choose default command line output for EStimGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
load EstimPARAMS
EstimPARAMS.EPISODIC.pulsewv=[];
%save EstimPARAMS EstimPARAMS
load Estim_handles

wtd_val=get(PP_handles.what_to_do,'Value');
if wtd_val==10
    set(handles.text3,'String','NOT REQUIRED')
    set(handles.text5,'String','TOTAL Acquisition DURATION (sec)')
    set(handles.text9,'String','ESTIM START time (sec)')
    set(handles.ephys_electrode,'String','CHECK (CHN)')
    set(handles.ephys_electrode,'BackgroundColor',[1 0 0])
else
    set(handles.ephys_electrode,'String','FOR EPHYS')
end
set(handles.single_channel,'Value',EstimPARAMS.single_channel);
set(handles.mult_channel,'Value',EstimPARAMS.mult_channel);

eval(sprintf('set(handles.current_amp,''String'',''%5.3f'');',EstimPARAMS.current_amp))
set(handles.current_amp,'Value',EstimPARAMS.current_amp);
eval(sprintf('set(handles.pulse_dur,''String'',''%5.3f'');',EstimPARAMS.pulse_dur))
set(handles.pulse_dur,'Value',EstimPARAMS.pulse_dur);
eval(sprintf('set(handles.ipi,''String'',''%7.2f'');',EstimPARAMS.ipi))
set(handles.ipi,'Value',EstimPARAMS.ipi);
eval(sprintf('set(handles.num_ppt,''String'',''%i'');',EstimPARAMS.num_ppt))
set(handles.num_ppt,'Value',EstimPARAMS.num_ppt);
eval(sprintf('set(handles.total_fcount,''String'',''%i'');',EstimPARAMS.total_fcount))
set(handles.total_fcount,'Value',EstimPARAMS.total_fcount);
eval(sprintf('set(handles.num_reps,''String'',''%i'');',EstimPARAMS.num_reps))
set(handles.num_reps,'Value',EstimPARAMS.num_reps);
set(handles.linescan_check,'Value',EstimPARAMS.linescan_check);
set(handles.frame_check,'Value',EstimPARAMS.frame_check);
eval(sprintf('set(handles.frame_duration,''String'',''%5.3f'');',EstimPARAMS.frame_duration))
set(handles.frame_duration,'Value',EstimPARAMS.frame_duration);
set(handles.max_speed_check,'Value',EstimPARAMS.max_speed_check);
EstimPARAMS.EPISODIC.do=0;

save EstimPARAMS EstimPARAMS

% UIWAIT makes EStimGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = EStimGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles;


% --- Executes on button press in frame_check.
function frame_check_Callback(hObject, eventdata, handles)
% hObject    handle to frame_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of frame_check

load EstimPARAMS
EstimPARAMS.frame_check=get(hObject,'Value'); %returns contents of num_pt_val as a double
set(handles.frame_check,'Value',EstimPARAMS.frame_check);
set(handles.linescan_check,'Value',~EstimPARAMS.frame_check);
EstimPARAMS.linescan_check=~get(hObject,'Value');

% --- Executes on button press in linescan_check.
function linescan_check_Callback(hObject, eventdata, handles)
% hObject    handle to linescan_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of linescan_check

load EstimPARAMS
EstimPARAMS.linescan_check=get(hObject,'Value'); %returns contents of num_pt_val as a double
set(handles.linescan_check,'Value',EstimPARAMS.linescan_check);
set(handles.frame_check,'Value',~EstimPARAMS.linescan_check);
EstimPARAMS.frame_check=~get(hObject,'Value');


function num_reps_Callback(hObject, eventdata, handles)
% hObject    handle to num_reps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of num_reps as text
%        str2double(get(hObject,'String')) returns contents of num_reps as a double

load EstimPARAMS
EstimPARAMS.num_reps=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.num_reps,'Value',EstimPARAMS.num_reps);

% --- Executes during object creation, after setting all properties.
function num_reps_CreateFcn(hObject, eventdata, handles)
% hObject    handle to num_reps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function total_fcount_Callback(hObject, eventdata, handles)
% hObject    handle to total_fcount (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of total_fcount as text
%        str2double(get(hObject,'String')) returns contents of total_fcount as a double

load EstimPARAMS
EstimPARAMS.total_fcount=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.total_fcount,'Value',EstimPARAMS.total_fcount);

% --- Executes during object creation, after setting all properties.
function total_fcount_CreateFcn(hObject, eventdata, handles)
% hObject    handle to total_fcount (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function num_ppt_Callback(hObject, eventdata, handles)
% hObject    handle to num_ppt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of num_ppt as text
%        str2double(get(hObject,'String')) returns contents of num_ppt as a double

load EstimPARAMS
EstimPARAMS.num_ppt=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.num_ppt,'Value',EstimPARAMS.num_ppt);

% --- Executes during object creation, after setting all properties.
function num_ppt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to num_ppt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ipi_Callback(hObject, eventdata, handles)
% hObject    handle to ipi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ipi as text
%        str2double(get(hObject,'String')) returns contents of ipi as a double

load EstimPARAMS
EstimPARAMS.ipi=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.ipi,'Value',EstimPARAMS.ipi);
save EstimPARAMS EstimPARAMS

% --- Executes during object creation, after setting all properties.
function ipi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ipi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pulse_dur_Callback(hObject, eventdata, handles)
% hObject    handle to pulse_dur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pulse_dur as text
%        str2double(get(hObject,'String')) returns contents of pulse_dur as a double

load EstimPARAMS
EstimPARAMS.pulse_dur=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.pulse_dur,'Value',EstimPARAMS.pulse_dur);
save EstimPARAMS EstimPARAMS

% --- Executes during object creation, after setting all properties.
function pulse_dur_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pulse_dur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function current_amp_Callback(hObject, eventdata, handles)
% hObject    handle to current_amp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of current_amp as text
%        str2double(get(hObject,'String')) returns contents of current_amp as a double

load EstimPARAMS
EstimPARAMS.current_amp=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.current_amp,'Value',EstimPARAMS.current_amp);
save EstimPARAMS EstimPARAMS


% --- Executes during object creation, after setting all properties.
function current_amp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to current_amp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in input_frames.
function input_frames_Callback(hObject, eventdata, handles)
% hObject    handle to input_frames (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

hh=choose_frame_line_numbers;


% --- Executes on button press in done_button.
function done_button_Callback(hObject, eventdata, handles)
% hObject    handle to done_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

load EstimPARAMS

EstimPARAMS.current_amp=get(handles.current_amp,'Value');
EstimPARAMS.pulse_dur=get(handles.pulse_dur,'Value');
EstimPARAMS.ipi=get(handles.ipi,'Value');
EstimPARAMS.num_ppt=get(handles.num_ppt,'Value');
EstimPARAMS.total_fcount=get(handles.total_fcount,'Value');
EstimPARAMS.num_reps=get(handles.num_reps,'Value');
EstimPARAMS.linescan_check=get(handles.linescan_check,'Value');
EstimPARAMS.frame_check=get(handles.frame_check,'Value');
EstimPARAMS.max_speed_check=get(handles.max_speed_check,'Value');
EstimPARAMS.frame_duration=get(handles.frame_duration,'Value');
EstimPARAMS.EPISODIC.do=0;
EstimPARAMS.EPISODIC.pulsewv=[];
save EstimPARAMS EstimPARAMS
close(handles.figure1)
load Estim_handles
if EstimPARAMS.linescan_check==1
    scantype='Line(s)';
elseif EstimPARAMS.frame_check==1
    scantype='Frame(s)';
    if EstimPARAMS.max_speed_check==1
        scantype='Frame(s) at Max Speed';
    end
end
eval(sprintf('disp_string=''%s: %i Pulse(s) per Train, %i Train(s), at %s %s, Pulse Dur %5.2f ms, %5.2f ms IPI'';',scantype,EstimPARAMS.num_ppt,length(EstimPARAMS.stim_at_fnums),scantype,EstimPARAMS.frame_str,EstimPARAMS.pulse_dur,EstimPARAMS.ipi))
set(PP_handles.disp_protocol,'String',disp_string)
set(PP_handles.disp_status,'String','Not Started')


% --- Executes on button press in max_speed_check.
function max_speed_check_Callback(hObject, eventdata, handles)
% hObject    handle to max_speed_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of max_speed_check

load EstimPARAMS
EstimPARAMS.max_speed_check=get(hObject,'Value'); %returns contents of num_pt_val as a double
set(handles.max_speed_check,'Value',EstimPARAMS.max_speed_check);

function frame_duration_Callback(hObject, eventdata, handles)
% hObject    handle to frame_duration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of frame_duration as text
%        str2double(get(hObject,'String')) returns contents of frame_duration as a double

load EstimPARAMS
EstimPARAMS.frame_duration=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.frame_duration,'Value',EstimPARAMS.frame_duration);

% --- Executes during object creation, after setting all properties.
function frame_duration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to frame_duration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in single_channel.
function single_channel_Callback(hObject, eventdata, handles)
% hObject    handle to single_channel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of single_channel

load EstimPARAMS
EstimPARAMS.single_channel=get(hObject,'Value'); %returns contents of num_pt_val as a double
set(handles.single_channel,'Value',EstimPARAMS.single_channel);
set(handles.mult_channel,'Value',~EstimPARAMS.single_channel);
EstimPARAMS.mult_channel=~get(hObject,'Value');
save EstimPARAMS EstimPARAMS

% --- Executes on button press in mult_channel.
function mult_channel_Callback(hObject, eventdata, handles)
% hObject    handle to mult_channel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of mult_channel

load EstimPARAMS
EstimPARAMS.mult_channel=get(hObject,'Value'); %returns contents of num_pt_val as a double
set(handles.mult_channel,'Value',EstimPARAMS.mult_channel);
set(handles.single_channel,'Value',~EstimPARAMS.mult_channel);
EstimPARAMS.single_channel=~get(hObject,'Value');
save EstimPARAMS EstimPARAMS
