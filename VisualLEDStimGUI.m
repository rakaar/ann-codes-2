function varargout = VisualLEDStimGUI(varargin)
% VISUALLEDSTIMGUI M-file for VisualLEDStimGUI.fig
%      VISUALLEDSTIMGUI, by itself, creates a new VISUALLEDSTIMGUI or raises the existing
%      singleton*.
%
%      H = VISUALLEDSTIMGUI returns the handle to a new VISUALLEDSTIMGUI or the handle to
%      the existing singleton*.
%
%      VISUALLEDSTIMGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VISUALLEDSTIMGUI.M with the given input arguments.
%
%      VISUALLEDSTIMGUI('Property','Value',...) creates a new VISUALLEDSTIMGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before VisualLEDStimGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to VisualLEDStimGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help VisualLEDStimGUI

% Last Modified by GUIDE v2.5 17-May-2018 10:57:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @VisualLEDStimGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @VisualLEDStimGUI_OutputFcn, ...
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


% --- Executes just before VisualLEDStimGUI is made visible.
function VisualLEDStimGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to VisualLEDStimGUI (see VARARGIN)

% Choose default command line output for VisualLEDStimGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
load VisLEDStimPARAMS
cd (curdir)


% VisLEDStimPARAMS
% handles
set(handles.check_led1,'Value',VisLEDStimPARAMS.check_led1);
set(handles.check_led2,'Value',VisLEDStimPARAMS.check_led2);
set(handles.check_vssa,'Value',VisLEDStimPARAMS.check_vssa);
set(handles.check_vssa,'Value',VisLEDStimPARAMS.check_vssa);
set(handles.check_vis_only,'Value',VisLEDStimPARAMS.check_vis_only);
set(handles.check_ep,'Value',VisLEDStimPARAMS.check_ep);
set(handles.check_avp,'Value',VisLEDStimPARAMS.check_avp);
set(handles.check_LED1_stimB,'Value',VisLEDStimPARAMS.check_LED1_stimB);
set(handles.check_LED2_stimB,'Value',VisLEDStimPARAMS.check_LED2_stimB);
set(handles.randB_check,'Value',VisLEDStimPARAMS.randB_check);
set(handles.check_horver_led,'Value',VisLEDStimPARAMS.check_horver_led);
set(handles.check_single_ch,'Value',VisLEDStimPARAMS.check_single_ch);
set(handles.check_multiple_ch,'Value',VisLEDStimPARAMS.check_multiple_ch);
set(handles.check_gap,'Value',VisLEDStimPARAMS.check_gap);

eval(sprintf('set(handles.total_time,''String'',''%i'');',VisLEDStimPARAMS.total_time))
set(handles.total_time,'Value',VisLEDStimPARAMS.total_time);
eval(sprintf('set(handles.stim_start,''String'',''%i'');',VisLEDStimPARAMS.stim_start))
set(handles.stim_start,'Value',VisLEDStimPARAMS.stim_start);
eval(sprintf('set(handles.stim_stop,''String'',''%i'');',VisLEDStimPARAMS.stim_stop))
set(handles.stim_stop,'Value',VisLEDStimPARAMS.stim_stop);
eval(sprintf('set(handles.t_steps,''String'',''%i'');',VisLEDStimPARAMS.t_steps))
set(handles.t_steps,'Value',VisLEDStimPARAMS.t_steps);
eval(sprintf('set(handles.start_int,''String'',''%i'');',VisLEDStimPARAMS.start_int))
set(handles.start_int,'Value',VisLEDStimPARAMS.start_int);
eval(sprintf('set(handles.stop_int,''String'',''%i'');',VisLEDStimPARAMS.stop_int))
set(handles.stop_int,'Value',VisLEDStimPARAMS.stop_int);
eval(sprintf('set(handles.num_int_steps,''String'',''%i'');',VisLEDStimPARAMS.num_int_steps))
set(handles.num_int_steps,'Value',VisLEDStimPARAMS.num_int_steps);
eval(sprintf('set(handles.blink_dur,''String'',''%i'');',VisLEDStimPARAMS.blink_dur))
set(handles.blink_dur,'Value',VisLEDStimPARAMS.blink_dur);
eval(sprintf('set(handles.inter_blink_int,''String'',''%i'');',VisLEDStimPARAMS.inter_blink_int))
set(handles.inter_blink_int,'Value',VisLEDStimPARAMS.inter_blink_int);
eval(sprintf('set(handles.n_blinks,''String'',''%i'');',VisLEDStimPARAMS.n_blinks))
set(handles.n_blinks,'Value',VisLEDStimPARAMS.n_blinks);
eval(sprintf('set(handles.ssa_intensity,''String'',''%i'');',VisLEDStimPARAMS.ssa_intensity))
set(handles.ssa_intensity,'Value',VisLEDStimPARAMS.ssa_intensity);
eval(sprintf('set(handles.stimB_pos,''String'',''%i'');',VisLEDStimPARAMS.stimB_pos))
set(handles.stimB_pos,'Value',VisLEDStimPARAMS.stimB_pos);
eval(sprintf('set(handles.num_stimB,''String'',''%i'');',VisLEDStimPARAMS.num_stimB))
set(handles.num_stimB,'Value',VisLEDStimPARAMS.num_stimB);
eval(sprintf('set(handles.gap_dur,''String'',''%i'');',VisLEDStimPARAMS.gap_dur))
set(handles.gap_dur,'Value',VisLEDStimPARAMS.gap_dur);
eval(sprintf('set(handles.num_reps_set,''String'',''%i'');',VisLEDStimPARAMS.num_reps_set))
set(handles.num_reps_set,'Value',VisLEDStimPARAMS.num_reps_set);

    
% UIWAIT makes VisualLEDStimGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = VisualLEDStimGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles;


% --- Executes on button press in check_led1.
function check_led1_Callback(hObject, eventdata, handles)
% hObject    handle to check_led1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_led1

load VisLEDStimPARAMS
VisLEDStimPARAMS.check_led1=get(hObject,'Value');
set(handles.check_led1,'Value',VisLEDStimPARAMS.check_led1);
if VisLEDStimPARAMS.check_led1==1
    VisLEDStimPARAMS.check_led2=0;
    set(handles.check_led2,'Value',0);
    VisLEDStimPARAMS.check_vssa=0;
    set(handles.check_vssa,'Value',0);
else
    VisLEDStimPARAMS.check_led2=1;
    set(handles.check_led2,'Value',1);
    VisLEDStimPARAMS.check_vssa=0;
    set(handles.check_vssa,'Value',0);
end

curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save VisLEDStimPARAMS VisLEDStimPARAMS
cd (curdir)

% --- Executes on button press in check_led2.
function check_led2_Callback(hObject, eventdata, handles)
% hObject    handle to check_led2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_led2

load VisLEDStimPARAMS
VisLEDStimPARAMS.check_led2=get(hObject,'Value');
set(handles.check_led2,'Value',VisLEDStimPARAMS.check_led2);
if VisLEDStimPARAMS.check_led2==1
    VisLEDStimPARAMS.check_led1=0;
    set(handles.check_led1,'Value',0);
    VisLEDStimPARAMS.check_vssa=0;
    set(handles.check_vssa,'Value',0);
else
    VisLEDStimPARAMS.check_led1=1;
    set(handles.check_led1,'Value',1);
    VisLEDStimPARAMS.check_vssa=0;
    set(handles.check_vssa,'Value',0);
end

curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save VisLEDStimPARAMS VisLEDStimPARAMS
cd (curdir)

% --- Executes on button press in check_vssa.
function check_vssa_Callback(hObject, eventdata, handles)
% hObject    handle to check_vssa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_vssa

load VisLEDStimPARAMS
VisLEDStimPARAMS.check_vssa=get(hObject,'Value');
set(handles.check_vssa,'Value',VisLEDStimPARAMS.check_vssa);
if VisLEDStimPARAMS.check_vssa==1
    VisLEDStimPARAMS.check_led1=0;
    set(handles.check_led1,'Value',0);
    VisLEDStimPARAMS.check_led2=0;
    set(handles.check_led2,'Value',0);
else
    VisLEDStimPARAMS.check_led1=1;
    set(handles.check_led1,'Value',1);
    VisLEDStimPARAMS.check_led2=0;
    set(handles.check_led2,'Value',0);
end

curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save VisLEDStimPARAMS VisLEDStimPARAMS
cd (curdir)

function total_time_Callback(hObject, eventdata, handles)
% hObject    handle to total_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of total_time as text
%        str2double(get(hObject,'String')) returns contents of total_time as a double

load VisLEDStimPARAMS
VisLEDStimPARAMS.total_time=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.total_time,'Value',VisLEDStimPARAMS.total_time);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save VisLEDStimPARAMS VisLEDStimPARAMS
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

load VisLEDStimPARAMS
VisLEDStimPARAMS.stim_start=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.stim_start,'Value',VisLEDStimPARAMS.stim_start);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save VisLEDStimPARAMS VisLEDStimPARAMS
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



function start_int_Callback(hObject, eventdata, handles)
% hObject    handle to start_int (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of start_int as text
%        str2double(get(hObject,'String')) returns contents of start_int as a double

load VisLEDStimPARAMS
VisLEDStimPARAMS.start_int=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.start_int,'Value',VisLEDStimPARAMS.start_int);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save VisLEDStimPARAMS VisLEDStimPARAMS
cd (curdir)

% --- Executes during object creation, after setting all properties.
function start_int_CreateFcn(hObject, eventdata, handles)
% hObject    handle to start_int (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function stop_int_Callback(hObject, eventdata, handles)
% hObject    handle to stop_int (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stop_int as text
%        str2double(get(hObject,'String')) returns contents of stop_int as a double

load VisLEDStimPARAMS
VisLEDStimPARAMS.stop_int=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.stop_int,'Value',VisLEDStimPARAMS.stop_int);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save VisLEDStimPARAMS VisLEDStimPARAMS
cd (curdir)

% --- Executes during object creation, after setting all properties.
function stop_int_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stop_int (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function blink_dur_Callback(hObject, eventdata, handles)
% hObject    handle to blink_dur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of blink_dur as text
%        str2double(get(hObject,'String')) returns contents of blink_dur as a double

load VisLEDStimPARAMS
VisLEDStimPARAMS.blink_dur=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.blink_dur,'Value',VisLEDStimPARAMS.blink_dur);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save VisLEDStimPARAMS VisLEDStimPARAMS
cd (curdir)

% --- Executes during object creation, after setting all properties.
function blink_dur_CreateFcn(hObject, eventdata, handles)
% hObject    handle to blink_dur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function inter_blink_int_Callback(hObject, eventdata, handles)
% hObject    handle to inter_blink_int (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of inter_blink_int as text
%        str2double(get(hObject,'String')) returns contents of inter_blink_int as a double

load VisLEDStimPARAMS
VisLEDStimPARAMS.inter_blink_int=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.inter_blink_int,'Value',VisLEDStimPARAMS.inter_blink_int);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save VisLEDStimPARAMS VisLEDStimPARAMS
cd (curdir)

% --- Executes during object creation, after setting all properties.
function inter_blink_int_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inter_blink_int (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function n_blinks_Callback(hObject, eventdata, handles)
% hObject    handle to n_blinks (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of n_blinks as text
%        str2double(get(hObject,'String')) returns contents of n_blinks as a double

load VisLEDStimPARAMS
VisLEDStimPARAMS.n_blinks=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.n_blinks,'Value',VisLEDStimPARAMS.n_blinks);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save VisLEDStimPARAMS VisLEDStimPARAMS
cd (curdir)

% --- Executes during object creation, after setting all properties.
function n_blinks_CreateFcn(hObject, eventdata, handles)
% hObject    handle to n_blinks (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in check_ep.
function check_ep_Callback(hObject, eventdata, handles)
% hObject    handle to check_ep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_ep

load VisLEDStimPARAMS
VisLEDStimPARAMS.check_ep=get(hObject,'Value');
set(handles.check_ep,'Value',VisLEDStimPARAMS.check_ep);
if VisLEDStimPARAMS.check_ep==1
    VisLEDStimPARAMS.check_avp=0;
    set(handles.check_avp,'Value',0);
    VisLEDStimPARAMS.check_vis_only=0;
    set(handles.check_vis_only,'Value',0);
else
    VisLEDStimPARAMS.check_avp=0;
    set(handles.check_avp,'Value',0);
    VisLEDStimPARAMS.check_vis_only=1;
    set(handles.check_vis_only,'Value',1);
end

curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save VisLEDStimPARAMS VisLEDStimPARAMS
cd (curdir)

% --- Executes on button press in check_avp.
function check_avp_Callback(hObject, eventdata, handles)
% hObject    handle to check_avp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_avp

load VisLEDStimPARAMS
VisLEDStimPARAMS.check_avp=get(hObject,'Value');
set(handles.check_avp,'Value',VisLEDStimPARAMS.check_avp);
if VisLEDStimPARAMS.check_avp==1
    VisLEDStimPARAMS.check_ep=0;
    set(handles.check_ep,'Value',0);
    VisLEDStimPARAMS.check_vis_only=0;
    set(handles.check_vis_only,'Value',0);
else
    VisLEDStimPARAMS.check_ep=0;
    set(handles.check_ep,'Value',0);
    VisLEDStimPARAMS.check_vis_only=1;
    set(handles.check_vis_only,'Value',1);
end

curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save VisLEDStimPARAMS VisLEDStimPARAMS
cd (curdir)

function ssa_intensity_Callback(hObject, eventdata, handles)
% hObject    handle to ssa_intensity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ssa_intensity as text
%        str2double(get(hObject,'String')) returns contents of ssa_intensity as a double

load VisLEDStimPARAMS
VisLEDStimPARAMS.ssa_intensity=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.ssa_intensity,'Value',VisLEDStimPARAMS.ssa_intensity);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save VisLEDStimPARAMS VisLEDStimPARAMS
cd (curdir)

% --- Executes during object creation, after setting all properties.
function ssa_intensity_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ssa_intensity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in check_LED1_stimB.
function check_LED1_stimB_Callback(hObject, eventdata, handles)
% hObject    handle to check_LED1_stimB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_LED1_stimB

load VisLEDStimPARAMS
VisLEDStimPARAMS.check_LED1_stimB=get(hObject,'Value');
set(handles.check_LED1_stimB,'Value',VisLEDStimPARAMS.check_LED1_stimB);
set(handles.check_LED2_stimB,'Value',~VisLEDStimPARAMS.check_LED1_stimB);
VisLEDStimPARAMS.check_LED2_stimB=~VisLEDStimPARAMS.check_LED1_stimB;
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save VisLEDStimPARAMS VisLEDStimPARAMS
cd (curdir)

% --- Executes on button press in start_button.
function start_button_Callback(hObject, eventdata, handles)
% hObject    handle to start_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

load VisLEDStimPARAMS
VisLEDStimPARAMS.check_led1=get(handles.check_led1,'Value');
VisLEDStimPARAMS.check_led2=get(handles.check_led2,'Value');
VisLEDStimPARAMS.check_vssa=get(handles.check_vssa,'Value');
VisLEDStimPARAMS.check_vssa=get(handles.check_vssa,'Value');
VisLEDStimPARAMS.check_vis_only=get(handles.check_vis_only,'Value');
VisLEDStimPARAMS.check_ep=get(handles.check_ep,'Value');
VisLEDStimPARAMS.check_avp=get(handles.check_avp,'Value');
VisLEDStimPARAMS.check_LED1_stimB=get(handles.check_LED1_stimB,'Value');
VisLEDStimPARAMS.check_LED2_stimB=get(handles.check_LED2_stimB,'Value');
VisLEDStimPARAMS.randB_check=get(handles.randB_check,'Value');
VisLEDStimPARAMS.check_horver_led=get(handles.check_horver_led,'Value');
VisLEDStimPARAMS.check_single_ch=get(handles.check_single_ch,'Value');
VisLEDStimPARAMS.check_multiple_ch=get(handles.check_multiple_ch,'Value');
VisLEDStimPARAMS.check_gap=get(handles.check_gap,'Value');
VisLEDStimPARAMS.total_time=get(handles.total_time,'Value');
VisLEDStimPARAMS.stim_start=get(handles.stim_start,'Value');
VisLEDStimPARAMS.stim_stop=get(handles.stim_stop,'Value');
VisLEDStimPARAMS.t_steps=get(handles.t_steps,'Value');
VisLEDStimPARAMS.start_int=get(handles.start_int,'Value');
VisLEDStimPARAMS.stop_int=get(handles.stop_int,'Value');
VisLEDStimPARAMS.num_int_steps=get(handles.num_int_steps,'Value');
VisLEDStimPARAMS.blink_dur=get(handles.blink_dur,'Value');
VisLEDStimPARAMS.inter_blink_int=get(handles.inter_blink_int,'Value');
VisLEDStimPARAMS.n_blinks=get(handles.n_blinks,'Value');
VisLEDStimPARAMS.ssa_intensity=get(handles.ssa_intensity,'Value');
VisLEDStimPARAMS.stimB_pos=get(handles.stimB_pos,'Value');
VisLEDStimPARAMS.num_stimB=get(handles.num_stimB,'Value');
VisLEDStimPARAMS.gap_dur=get(handles.gap_dur,'Value');
VisLEDStimPARAMS.num_reps_set=get(handles.num_reps_set,'Value');
if VisLEDStimPARAMS.check_ep==1
    load EStimPARAMS
    VisLEDStimPARAMS.ELEC=EStimPARAMS;
elseif VisLEDStimPARAMS.check_avp==1
    33
    load AudStimPARAMS
    VisLEDStimPARAMS.AUD=AudStimPARAMS;
end
VisLEDStimPARAMS.protocol_str='Ready - Not started';    
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save VisLEDStimPARAMS VisLEDStimPARAMS
cd (curdir)

close(handles.figure1)

function stimB_pos_Callback(hObject, eventdata, handles)
% hObject    handle to stimB_pos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stimB_pos as text
%        str2double(get(hObject,'String')) returns contents of stimB_pos as a double

load VisLEDStimPARAMS
VisLEDStimPARAMS.stimB_pos=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.stimB_pos,'Value',VisLEDStimPARAMS.stimB_pos);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save VisLEDStimPARAMS VisLEDStimPARAMS
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


% --- Executes on button press in check_vis_only.
function check_vis_only_Callback(hObject, eventdata, handles)
% hObject    handle to check_vis_only (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_vis_only

load VisLEDStimPARAMS
VisLEDStimPARAMS.check_vis_only=get(hObject,'Value');
set(handles.check_vis_only,'Value',VisLEDStimPARAMS.check_vis_only);
if VisLEDStimPARAMS.check_vis_only==1
    VisLEDStimPARAMS.check_ep=0;
    set(handles.check_ep,'Value',0);
    VisLEDStimPARAMS.check_avp=0;
    set(handles.check_avp,'Value',0);
else
    VisLEDStimPARAMS.check_ep=0;
    set(handles.check_ep,'Value',0);
    VisLEDStimPARAMS.check_avp=1;
    set(handles.check_avp,'Value',1);
end

curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save VisLEDStimPARAMS VisLEDStimPARAMS
cd (curdir)

% --- Executes on button press in check_gap.
function check_gap_Callback(hObject, eventdata, handles)
% hObject    handle to check_gap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_gap

load VisLEDStimPARAMS
VisLEDStimPARAMS.check_gap=get(hObject,'Value');
set(handles.check_gap,'Value',VisLEDStimPARAMS.check_gap);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save VisLEDStimPARAMS VisLEDStimPARAMS
cd (curdir)

function gap_dur_Callback(hObject, eventdata, handles)
% hObject    handle to gap_dur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gap_dur as text
%        str2double(get(hObject,'String')) returns contents of gap_dur as a double

load VisLEDStimPARAMS
VisLEDStimPARAMS.gap_dur=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.gap_dur,'Value',VisLEDStimPARAMS.gap_dur);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save VisLEDStimPARAMS VisLEDStimPARAMS
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


% --- Executes on button press in randB_check.
function randB_check_Callback(hObject, eventdata, handles)
% hObject    handle to randB_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of randB_check

load VisLEDStimPARAMS
VisLEDStimPARAMS.randB_check=get(hObject,'Value');
set(handles.randB_check,'Value',VisLEDStimPARAMS.randB_check);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save VisLEDStimPARAMS VisLEDStimPARAMS
cd (curdir)

% --- Executes on button press in audstim_set.
function audstim_set_Callback(hObject, eventdata, handles)
% hObject    handle to audstim_set (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Auditory2PGUI

% --- Executes on button press in elecstim_set.
function elecstim_set_Callback(hObject, eventdata, handles)
% hObject    handle to elecstim_set (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

EStimGUI

% --- Executes on button press in check_LED2_stimB.
function check_LED2_stimB_Callback(hObject, eventdata, handles)
% hObject    handle to check_LED2_stimB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_LED2_stimB

load VisLEDStimPARAMS
VisLEDStimPARAMS.check_LED2_stimB=get(hObject,'Value');
set(handles.check_LED2_stimB,'Value',VisLEDStimPARAMS.check_LED2_stimB);
set(handles.check_LED1_stimB,'Value',~VisLEDStimPARAMS.check_LED2_stimB);
VisLEDStimPARAMS.check_LED1_stimB=~VisLEDStimPARAMS.check_LED2_stimB;
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save VisLEDStimPARAMS VisLEDStimPARAMS
cd (curdir)

% --- Executes on button press in check_horver_led.
function check_horver_led_Callback(hObject, eventdata, handles)
% hObject    handle to check_horver_led (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_horver_led

load VisLEDStimPARAMS
VisLEDStimPARAMS.check_horver_led=get(hObject,'Value');
set(handles.check_horver_led,'Value',VisLEDStimPARAMS.check_horver_led);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save VisLEDStimPARAMS VisLEDStimPARAMS
cd (curdir)

% --- Executes on button press in check_single_ch.
function check_single_ch_Callback(hObject, eventdata, handles)
% hObject    handle to check_single_ch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_single_ch

load VisLEDStimPARAMS
VisLEDStimPARAMS.check_single_ch=get(hObject,'Value');
set(handles.check_single_ch,'Value',VisLEDStimPARAMS.check_single_ch);
set(handles.check_multiple_ch,'Value',~VisLEDStimPARAMS.check_single_ch);
VisLEDStimPARAMS.check_multiple_ch=~VisLEDStimPARAMS.check_single_ch;
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save VisLEDStimPARAMS VisLEDStimPARAMS
cd (curdir)

% --- Executes on button press in check_multiple_ch.
function check_multiple_ch_Callback(hObject, eventdata, handles)
% hObject    handle to check_multiple_ch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_multiple_ch

load VisLEDStimPARAMS
VisLEDStimPARAMS.check_multiple_ch=get(hObject,'Value');
set(handles.check_multiple_ch,'Value',VisLEDStimPARAMS.check_multiple_ch);
set(handles.check_single_ch,'Value',~VisLEDStimPARAMS.check_multiple_ch);
VisLEDStimPARAMS.check_single_ch=~VisLEDStimPARAMS.check_multiple_ch;
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save VisLEDStimPARAMS VisLEDStimPARAMS
cd (curdir)

function num_int_steps_Callback(hObject, eventdata, handles)
% hObject    handle to num_int_steps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of num_int_steps as text
%        str2double(get(hObject,'String')) returns contents of num_int_steps as a double

load VisLEDStimPARAMS
VisLEDStimPARAMS.num_int_steps=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.num_int_steps,'Value',VisLEDStimPARAMS.num_int_steps);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save VisLEDStimPARAMS VisLEDStimPARAMS
cd (curdir)

% --- Executes during object creation, after setting all properties.
function num_int_steps_CreateFcn(hObject, eventdata, handles)
% hObject    handle to num_int_steps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function num_reps_set_Callback(hObject, eventdata, handles)
% hObject    handle to num_reps_set (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of num_reps_set as text
%        str2double(get(hObject,'String')) returns contents of num_reps_set as a double

load VisLEDStimPARAMS
VisLEDStimPARAMS.num_reps_set=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.num_reps_set,'Value',VisLEDStimPARAMS.num_reps_set);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save VisLEDStimPARAMS VisLEDStimPARAMS
cd (curdir)

% --- Executes during object creation, after setting all properties.
function num_reps_set_CreateFcn(hObject, eventdata, handles)
% hObject    handle to num_reps_set (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function num_stimB_Callback(hObject, eventdata, handles)
% hObject    handle to num_stimB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of num_stimB as text
%        str2double(get(hObject,'String')) returns contents of num_stimB as a double
load VisLEDStimPARAMS
VisLEDStimPARAMS.num_stimB=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.num_stimB,'Value',VisLEDStimPARAMS.num_stimB);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save VisLEDStimPARAMS VisLEDStimPARAMS
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



function stim_stop_Callback(hObject, eventdata, handles)
% hObject    handle to Stimulus_stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Stimulus_stop as text
%        str2double(get(hObject,'String')) returns contents of Stimulus_stop as a double
load VisLEDStimPARAMS
VisLEDStimPARAMS.stim_stop=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.stim_stop,'Value',VisLEDStimPARAMS.stim_stop);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save VisLEDStimPARAMS VisLEDStimPARAMS
cd (curdir)

% --- Executes during object creation, after setting all properties.
function stim_stop_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Stimulus_stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function t_steps_Callback(hObject, eventdata, handles)
% hObject    handle to t_steps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of t_steps as text
%        str2double(get(hObject,'String')) returns contents of t_steps as a double
load VisLEDStimPARAMS
VisLEDStimPARAMS.t_steps=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.t_steps,'Value',VisLEDStimPARAMS.t_steps);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save VisLEDStimPARAMS VisLEDStimPARAMS
cd (curdir)

% --- Executes during object creation, after setting all properties.
function t_steps_CreateFcn(hObject, eventdata, handles)
% hObject    handle to t_steps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
