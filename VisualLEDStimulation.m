function varargout = VisualLEDStimulation(varargin)
% VISUALLEDSTIMULATION M-file for VisualLEDStimulation.fig
%      VISUALLEDSTIMULATION, by itself, creates a new VISUALLEDSTIMULATION or raises the existing
%      singleton*.
%
%      H = VISUALLEDSTIMULATION returns the handle to a new VISUALLEDSTIMULATION or the handle to
%      the existing singleton*.
%
%      VISUALLEDSTIMULATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VISUALLEDSTIMULATION.M with the given input arguments.
%
%      VISUALLEDSTIMULATION('Property','Value',...) creates a new VISUALLEDSTIMULATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before VisualLEDStimulation_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to VisualLEDStimulation_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help VisualLEDStimulation

% Last Modified by GUIDE v2.5 20-Mar-2016 18:36:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @VisualLEDStimulation_OpeningFcn, ...
                   'gui_OutputFcn',  @VisualLEDStimulation_OutputFcn, ...
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


% --- Executes just before VisualLEDStimulation is made visible.
function VisualLEDStimulation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to VisualLEDStimulation (see VARARGIN)

% Choose default command line output for VisualLEDStimulation
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes VisualLEDStimulation wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = VisualLEDStimulation_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in check_led1.
function check_led1_Callback(hObject, eventdata, handles)
% hObject    handle to check_led1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_led1


% --- Executes on button press in check_led2.
function check_led2_Callback(hObject, eventdata, handles)
% hObject    handle to check_led2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_led2


% --- Executes on button press in check_vssa.
function check_vssa_Callback(hObject, eventdata, handles)
% hObject    handle to check_vssa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_vssa



function total_time_Callback(hObject, eventdata, handles)
% hObject    handle to total_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of total_time as text
%        str2double(get(hObject,'String')) returns contents of total_time as a double


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


% --- Executes on button press in check_avp.
function check_avp_Callback(hObject, eventdata, handles)
% hObject    handle to check_avp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_avp



function ssa_intensity_Callback(hObject, eventdata, handles)
% hObject    handle to ssa_intensity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ssa_intensity as text
%        str2double(get(hObject,'String')) returns contents of ssa_intensity as a double


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


% --- Executes on button press in start_button.
function start_button_Callback(hObject, eventdata, handles)
% hObject    handle to start_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function stimB_pos_Callback(hObject, eventdata, handles)
% hObject    handle to stimB_pos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stimB_pos as text
%        str2double(get(hObject,'String')) returns contents of stimB_pos as a double


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


% --- Executes on button press in check_gap.
function check_gap_Callback(hObject, eventdata, handles)
% hObject    handle to check_gap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_gap



function gap_dur_Callback(hObject, eventdata, handles)
% hObject    handle to gap_dur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gap_dur as text
%        str2double(get(hObject,'String')) returns contents of gap_dur as a double


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


% --- Executes on button press in audstim_set.
function audstim_set_Callback(hObject, eventdata, handles)
% hObject    handle to audstim_set (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in elecstim_set.
function elecstim_set_Callback(hObject, eventdata, handles)
% hObject    handle to elecstim_set (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in check_LED2_stimB.
function check_LED2_stimB_Callback(hObject, eventdata, handles)
% hObject    handle to check_LED2_stimB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_LED2_stimB


% --- Executes on button press in check_horver_led.
function check_horver_led_Callback(hObject, eventdata, handles)
% hObject    handle to check_horver_led (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_horver_led


% --- Executes on button press in check_single_ch.
function check_single_ch_Callback(hObject, eventdata, handles)
% hObject    handle to check_single_ch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_single_ch


% --- Executes on button press in check_multiple_ch.
function check_multiple_ch_Callback(hObject, eventdata, handles)
% hObject    handle to check_multiple_ch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_multiple_ch
