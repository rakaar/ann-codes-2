function varargout = ABA_EpisodicEStim_GUI(varargin)
% ABA_EPISODICESTIM_GUI M-file for ABA_EpisodicEStim_GUI.fig
%      ABA_EPISODICESTIM_GUI, by itself, creates a new ABA_EPISODICESTIM_GUI or raises the existing
%      singleton*.
%
%      H = ABA_EPISODICESTIM_GUI returns the handle to a new ABA_EPISODICESTIM_GUI or the handle to
%      the existing singleton*.
%
%      ABA_EPISODICESTIM_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ABA_EPISODICESTIM_GUI.M with the given input arguments.
%
%      ABA_EPISODICESTIM_GUI('Property','Value',...) creates a new ABA_EPISODICESTIM_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ABA_EpisodicEStim_GUI_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ABA_EpisodicEStim_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help ABA_EpisodicEStim_GUI

% Last Modified by GUIDE v2.5 10-Aug-2010 14:21:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ABA_EpisodicEStim_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @ABA_EpisodicEStim_GUI_OutputFcn, ...
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


% --- Executes just before ABA_EpisodicEStim_GUI is made visible.
function ABA_EpisodicEStim_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ABA_EpisodicEStim_GUI (see VARARGIN)

% Choose default command line output for ABA_EpisodicEStim_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

load EstimPARAMS
load ABAPARAMS
EstimPARAMS.EPISODIC.pulsewv=[];
EstimPARAMS.EPISODIC.ABA.totalsets=ABAPARAMS.num_ABA_sets;
save EstimPARAMS EstimPARAMS

eval(sprintf('EstimPARAMS.EPISODIC.AUD_display=''%i ABAS tokens, A1-%s,B-%s,A2-%s,S-%s (s)'';',ABAPARAMS.num_ABA_sets,num2str(ABAPARAMS.tone_Adur),num2str(ABAPARAMS.tone_Bdur),num2str(ABAPARAMS.tone_Adur),num2str(ABAPARAMS.gapdur)))
clear ABAPARAMS
eval(sprintf('set(handles.AUD_display,''String'',''%s'');',EstimPARAMS.EPISODIC.AUD_display))
eval(sprintf('set(handles.current_amp,''String'',''%5.3f'');',EstimPARAMS.current_amp))
set(handles.current_amp,'Value',EstimPARAMS.current_amp);
eval(sprintf('set(handles.pulse_dur,''String'',''%5.3f'');',EstimPARAMS.pulse_dur))
set(handles.pulse_dur,'Value',EstimPARAMS.pulse_dur);
eval(sprintf('set(handles.ipi,''String'',''%7.2f'');',EstimPARAMS.ipi))
set(handles.ipi,'Value',EstimPARAMS.ipi);

set(handles.A1_stim_check,'Value',EstimPARAMS.EPISODIC.ABA.A1_stim_check);
set(handles.A2_stim_check,'Value',EstimPARAMS.EPISODIC.ABA.A2_stim_check);
set(handles.B_stim_check,'Value',EstimPARAMS.EPISODIC.ABA.B_stim_check);
set(handles.S_stim_check,'Value',EstimPARAMS.EPISODIC.ABA.S_stim_check);
set(handles.A1_epi_check,'Value',EstimPARAMS.EPISODIC.ABA.A1_epi_check);
set(handles.A2_epi_check,'Value',EstimPARAMS.EPISODIC.ABA.A2_epi_check);
set(handles.B_epi_check,'Value',EstimPARAMS.EPISODIC.ABA.B_epi_check);
set(handles.S_epi_check,'Value',EstimPARAMS.EPISODIC.ABA.S_epi_check);
set(handles.A1_range_check,'Value',EstimPARAMS.EPISODIC.ABA.A1_range_check);
set(handles.A2_range_check,'Value',EstimPARAMS.EPISODIC.ABA.A2_range_check);
set(handles.B_range_check,'Value',EstimPARAMS.EPISODIC.ABA.B_range_check);
set(handles.S_range_check,'Value',EstimPARAMS.EPISODIC.ABA.S_range_check);

eval(sprintf('set(handles.A1_from,''String'',''%i'');',EstimPARAMS.EPISODIC.ABA.A1_from))
set(handles.A1_from,'Value',EstimPARAMS.EPISODIC.ABA.A1_from);
eval(sprintf('set(handles.A1_to,''String'',''%i'');',EstimPARAMS.EPISODIC.ABA.A1_to))
set(handles.A1_to,'Value',EstimPARAMS.EPISODIC.ABA.A1_to);
eval(sprintf('set(handles.A2_from,''String'',''%i'');',EstimPARAMS.EPISODIC.ABA.A2_from))
set(handles.A2_from,'Value',EstimPARAMS.EPISODIC.ABA.A2_from);
eval(sprintf('set(handles.A2_to,''String'',''%i'');',EstimPARAMS.EPISODIC.ABA.A2_to))
set(handles.A2_to,'Value',EstimPARAMS.EPISODIC.ABA.A2_to);
eval(sprintf('set(handles.B_from,''String'',''%i'');',EstimPARAMS.EPISODIC.ABA.B_from))
set(handles.B_from,'Value',EstimPARAMS.EPISODIC.ABA.B_from);
eval(sprintf('set(handles.B_to,''String'',''%i'');',EstimPARAMS.EPISODIC.ABA.B_to))
set(handles.B_to,'Value',EstimPARAMS.EPISODIC.ABA.B_to);
eval(sprintf('set(handles.S_from,''String'',''%i'');',EstimPARAMS.EPISODIC.ABA.S_from))
set(handles.S_from,'Value',EstimPARAMS.EPISODIC.ABA.S_from);
eval(sprintf('set(handles.S_to,''String'',''%i'');',EstimPARAMS.EPISODIC.ABA.S_to))
set(handles.S_to,'Value',EstimPARAMS.EPISODIC.ABA.S_to);

set(handles.A1_episodes,'String',EstimPARAMS.EPISODIC.ABA.A1_episodes);
set(handles.A2_episodes,'String',EstimPARAMS.EPISODIC.ABA.A2_episodes);
set(handles.B_episodes,'String',EstimPARAMS.EPISODIC.ABA.B_episodes);
set(handles.S_episodes,'String',EstimPARAMS.EPISODIC.ABA.S_episodes);

% UIWAIT makes ABA_EpisodicEStim_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ABA_EpisodicEStim_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles;


% --- Executes on button press in A1_stim_check.
function A1_stim_check_Callback(hObject, eventdata, handles)
% hObject    handle to A1_stim_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of A1_stim_check

load EstimPARAMS
EstimPARAMS.EPISODIC.ABA.A1_stim_check=get(hObject,'Value'); %returns contents of num_pt_val as a double
set(handles.A1_stim_check,'Value',EstimPARAMS.EPISODIC.ABA.A1_stim_check);
save EstimPARAMS EstimPARAMS

% --- Executes on button press in B_stim_check.
function B_stim_check_Callback(hObject, eventdata, handles)
% hObject    handle to B_stim_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of B_stim_check

load EstimPARAMS
EstimPARAMS.EPISODIC.ABA.B_stim_check=get(hObject,'Value'); %returns contents of num_pt_val as a double
set(handles.B_stim_check,'Value',EstimPARAMS.EPISODIC.ABA.B_stim_check);
save EstimPARAMS EstimPARAMS

% --- Executes on button press in A2_stim_check.
function A2_stim_check_Callback(hObject, eventdata, handles)
% hObject    handle to A2_stim_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of A2_stim_check

load EstimPARAMS
EstimPARAMS.EPISODIC.ABA.A2_stim_check=get(hObject,'Value'); %returns contents of num_pt_val as a double
set(handles.A2_stim_check,'Value',EstimPARAMS.EPISODIC.ABA.A2_stim_check);
save EstimPARAMS EstimPARAMS

% --- Executes on button press in S_stim_check.
function S_stim_check_Callback(hObject, eventdata, handles)
% hObject    handle to S_stim_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of S_stim_check

load EstimPARAMS
EstimPARAMS.EPISODIC.ABA.S_stim_check=get(hObject,'Value'); %returns contents of num_pt_val as a double
set(handles.S_stim_check,'Value',EstimPARAMS.EPISODIC.ABA.S_stim_check);
save EstimPARAMS EstimPARAMS

% --- Executes on button press in A1_range_check.
function A1_range_check_Callback(hObject, eventdata, handles)
% hObject    handle to A1_range_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of A1_range_check

load EstimPARAMS
EstimPARAMS.EPISODIC.ABA.A1_range_check=get(hObject,'Value'); %returns contents of num_pt_val as a double
set(handles.A1_range_check,'Value',EstimPARAMS.EPISODIC.ABA.A1_range_check);
set(handles.A1_epi_check,'Value',~EstimPARAMS.EPISODIC.ABA.A1_range_check);
EstimPARAMS.EPISODIC.ABA.A1_epi_check=~EstimPARAMS.EPISODIC.ABA.A1_range_check;
save EstimPARAMS EstimPARAMS

function A1_from_Callback(hObject, eventdata, handles)
% hObject    handle to A1_from (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of A1_from as text
%        str2double(get(hObject,'String')) returns contents of A1_from as a double

load EstimPARAMS
EstimPARAMS.EPISODIC.ABA.A1_from=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.A1_from,'Value',EstimPARAMS.EPISODIC.ABA.A1_from);
save EstimPARAMS EstimPARAMS

% --- Executes during object creation, after setting all properties.
function A1_from_CreateFcn(hObject, eventdata, handles)
% hObject    handle to A1_from (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function A1_to_Callback(hObject, eventdata, handles)
% hObject    handle to A1_to (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of A1_to as text
%        str2double(get(hObject,'String')) returns contents of A1_to as a double

load EstimPARAMS
EstimPARAMS.EPISODIC.ABA.A1_to=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.A1_to,'Value',EstimPARAMS.EPISODIC.ABA.A1_to);
save EstimPARAMS EstimPARAMS

% --- Executes during object creation, after setting all properties.
function A1_to_CreateFcn(hObject, eventdata, handles)
% hObject    handle to A1_to (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in B_range_check.
function B_range_check_Callback(hObject, eventdata, handles)
% hObject    handle to B_range_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of B_range_check

load EstimPARAMS
EstimPARAMS.EPISODIC.ABA.B_range_check=get(hObject,'Value'); %returns contents of num_pt_val as a double
set(handles.B_range_check,'Value',EstimPARAMS.EPISODIC.ABA.B_range_check);
set(handles.B_epi_check,'Value',~EstimPARAMS.EPISODIC.ABA.B_range_check);
EstimPARAMS.EPISODIC.ABA.B_epi_check=~EstimPARAMS.EPISODIC.ABA.B_range_check;
save EstimPARAMS EstimPARAMS

function B_from_Callback(hObject, eventdata, handles)
% hObject    handle to B_from (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of B_from as text
%        str2double(get(hObject,'String')) returns contents of B_from as a double

load EstimPARAMS
EstimPARAMS.EPISODIC.ABA.B_from=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.B_from,'Value',EstimPARAMS.EPISODIC.ABA.B_from);
save EstimPARAMS EstimPARAMS

% --- Executes during object creation, after setting all properties.
function B_from_CreateFcn(hObject, eventdata, handles)
% hObject    handle to B_from (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function B_to_Callback(hObject, eventdata, handles)
% hObject    handle to B_to (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of B_to as text
%        str2double(get(hObject,'String')) returns contents of B_to as a double

load EstimPARAMS
EstimPARAMS.EPISODIC.ABA.B_to=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.B_to,'Value',EstimPARAMS.EPISODIC.ABA.B_to);
save EstimPARAMS EstimPARAMS

% --- Executes during object creation, after setting all properties.
function B_to_CreateFcn(hObject, eventdata, handles)
% hObject    handle to B_to (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in A2_range_check.
function A2_range_check_Callback(hObject, eventdata, handles)
% hObject    handle to A2_range_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of A2_range_check

load EstimPARAMS
EstimPARAMS.EPISODIC.ABA.A2_range_check=get(hObject,'Value'); %returns contents of num_pt_val as a double
set(handles.A2_range_check,'Value',EstimPARAMS.EPISODIC.ABA.A2_range_check);
set(handles.A2_epi_check,'Value',~EstimPARAMS.EPISODIC.ABA.A2_range_check);
EstimPARAMS.EPISODIC.ABA.A2_epi_check=~EstimPARAMS.EPISODIC.ABA.A2_range_check;
save EstimPARAMS EstimPARAMS


function A2_from_Callback(hObject, eventdata, handles)
% hObject    handle to A2_from (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of A2_from as text
%        str2double(get(hObject,'String')) returns contents of A2_from as a double

load EstimPARAMS
EstimPARAMS.EPISODIC.ABA.A2_from=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.A2_from,'Value',EstimPARAMS.EPISODIC.ABA.A2_from);
save EstimPARAMS EstimPARAMS

% --- Executes during object creation, after setting all properties.
function A2_from_CreateFcn(hObject, eventdata, handles)
% hObject    handle to A2_from (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function A2_to_Callback(hObject, eventdata, handles)
% hObject    handle to A2_to (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of A2_to as text
%        str2double(get(hObject,'String')) returns contents of A2_to as a double

load EstimPARAMS
EstimPARAMS.EPISODIC.ABA.A2_to=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.A2_to,'Value',EstimPARAMS.EPISODIC.ABA.A2_to);
save EstimPARAMS EstimPARAMS

% --- Executes during object creation, after setting all properties.
function A2_to_CreateFcn(hObject, eventdata, handles)
% hObject    handle to A2_to (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in S_range_check.
function S_range_check_Callback(hObject, eventdata, handles)
% hObject    handle to S_range_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of S_range_check

load EstimPARAMS
EstimPARAMS.EPISODIC.ABA.S_range_check=get(hObject,'Value'); %returns contents of num_pt_val as a double
set(handles.S_range_check,'Value',EstimPARAMS.EPISODIC.ABA.S_range_check);
set(handles.S_epi_check,'Value',~EstimPARAMS.EPISODIC.ABA.S_range_check);
EstimPARAMS.EPISODIC.ABA.S_epi_check=~EstimPARAMS.EPISODIC.ABA.S_range_check;
save EstimPARAMS EstimPARAMS

function S_from_Callback(hObject, eventdata, handles)
% hObject    handle to S_from (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of S_from as text
%        str2double(get(hObject,'String')) returns contents of S_from as a double

load EstimPARAMS
EstimPARAMS.EPISODIC.ABA.S_from=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.S_from,'Value',EstimPARAMS.EPISODIC.ABA.S_from);
save EstimPARAMS EstimPARAMS

% --- Executes during object creation, after setting all properties.
function S_from_CreateFcn(hObject, eventdata, handles)
% hObject    handle to S_from (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function S_to_Callback(hObject, eventdata, handles)
% hObject    handle to S_to (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of S_to as text
%        str2double(get(hObject,'String')) returns contents of S_to as a double

load EstimPARAMS
EstimPARAMS.EPISODIC.ABA.S_to=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.S_to,'Value',EstimPARAMS.EPISODIC.ABA.S_to);
save EstimPARAMS EstimPARAMS

% --- Executes during object creation, after setting all properties.
function S_to_CreateFcn(hObject, eventdata, handles)
% hObject    handle to S_to (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in A1_epi_check.
function A1_epi_check_Callback(hObject, eventdata, handles)
% hObject    handle to A1_epi_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of A1_epi_check

load EstimPARAMS
EstimPARAMS.EPISODIC.ABA.A1_epi_check=get(hObject,'Value'); %returns contents of num_pt_val as a double
set(handles.A1_epi_check,'Value',EstimPARAMS.EPISODIC.ABA.A1_epi_check);
set(handles.A1_range_check,'Value',~EstimPARAMS.EPISODIC.ABA.A1_epi_check);
EstimPARAMS.EPISODIC.ABA.A1_range_check=~EstimPARAMS.EPISODIC.ABA.A1_epi_check;
save EstimPARAMS EstimPARAMS

function A1_episodes_Callback(hObject, eventdata, handles)
% hObject    handle to A1_episodes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of A1_episodes as text
%        str2double(get(hObject,'String')) returns contents of A1_episodes as a double

load EstimPARAMS
ppr=get(hObject,'String');
set(handles.A1_episodes,'String',ppr);
EstimPARAMS.EPISODIC.ABA.A1_episodes=ppr;
save EstimPARAMS EstimPARAMS

% --- Executes during object creation, after setting all properties.
function A1_episodes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to A1_episodes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in B_epi_check.
function B_epi_check_Callback(hObject, eventdata, handles)
% hObject    handle to B_epi_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of B_epi_check

load EstimPARAMS
EstimPARAMS.EPISODIC.ABA.B_epi_check=get(hObject,'Value'); %returns contents of num_pt_val as a double
set(handles.B_epi_check,'Value',EstimPARAMS.EPISODIC.ABA.B_epi_check);
set(handles.B_range_check,'Value',~EstimPARAMS.EPISODIC.ABA.B_epi_check);
EstimPARAMS.EPISODIC.ABA.B_range_check=~EstimPARAMS.EPISODIC.ABA.B_epi_check;
save EstimPARAMS EstimPARAMS

function B_episodes_Callback(hObject, eventdata, handles)
% hObject    handle to B_episodes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of B_episodes as text
%        str2double(get(hObject,'String')) returns contents of B_episodes as a double

load EstimPARAMS
ppr=get(hObject,'String');
set(handles.B_episodes,'String',ppr);
EstimPARAMS.EPISODIC.ABA.B_episodes=ppr;
save EstimPARAMS EstimPARAMS

% --- Executes during object creation, after setting all properties.
function B_episodes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to B_episodes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in A2_epi_check.
function A2_epi_check_Callback(hObject, eventdata, handles)
% hObject    handle to A2_epi_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of A2_epi_check

load EstimPARAMS
EstimPARAMS.EPISODIC.ABA.A2_epi_check=get(hObject,'Value'); %returns contents of num_pt_val as a double
set(handles.A2_epi_check,'Value',EstimPARAMS.EPISODIC.ABA.A2_epi_check);
set(handles.A2_range_check,'Value',~EstimPARAMS.EPISODIC.ABA.A2_epi_check);
EstimPARAMS.EPISODIC.ABA.A2_range_check=~EstimPARAMS.EPISODIC.ABA.A2_epi_check;
save EstimPARAMS EstimPARAMS

function A2_episodes_Callback(hObject, eventdata, handles)
% hObject    handle to A2_episodes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of A2_episodes as text
%        str2double(get(hObject,'String')) returns contents of A2_episodes as a double

load EstimPARAMS
ppr=get(hObject,'String');
set(handles.A2_episodes,'String',ppr);
EstimPARAMS.EPISODIC.ABA.A2_episodes=ppr;
save EstimPARAMS EstimPARAMS

% --- Executes during object creation, after setting all properties.
function A2_episodes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to A2_episodes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in S_epi_check.
function S_epi_check_Callback(hObject, eventdata, handles)
% hObject    handle to S_epi_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of S_epi_check

load EstimPARAMS
EstimPARAMS.EPISODIC.ABA.S_epi_check=get(hObject,'Value'); %returns contents of num_pt_val as a double
set(handles.S_epi_check,'Value',EstimPARAMS.EPISODIC.ABA.S_epi_check);
set(handles.S_range_check,'Value',~EstimPARAMS.EPISODIC.ABA.S_epi_check);
EstimPARAMS.EPISODIC.ABA.S_range_check=~EstimPARAMS.EPISODIC.ABA.S_epi_check;
save EstimPARAMS EstimPARAMS

function S_episodes_Callback(hObject, eventdata, handles)
% hObject    handle to S_episodes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of S_episodes as text
%        str2double(get(hObject,'String')) returns contents of S_episodes as a double

load EstimPARAMS
ppr=get(hObject,'String');
set(handles.S_episodes,'String',ppr);
EstimPARAMS.EPISODIC.ABA.S_episodes=ppr;
save EstimPARAMS EstimPARAMS

% --- Executes during object creation, after setting all properties.
function S_episodes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to S_episodes (see GCBO)
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


% --- Executes on button press in done_button.
function done_button_Callback(hObject, eventdata, handles)
% hObject    handle to done_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

load EstimPARAMS
EstimPARAMS.EPISODIC.do=1;
EstimPARAMS.current_amp=get(handles.current_amp,'Value');
EstimPARAMS.pulse_dur=get(handles.pulse_dur,'Value');
EstimPARAMS.ipi=get(handles.ipi,'Value');
EstimPARAMS.EPISODIC.ABA.A1_stim_check=get(handles.A1_stim_check,'Value');
EstimPARAMS.EPISODIC.ABA.B_stim_check=get(handles.B_stim_check,'Value');
EstimPARAMS.EPISODIC.ABA.A2_stim_check=get(handles.A2_stim_check,'Value');
EstimPARAMS.EPISODIC.ABA.S_stim_check=get(handles.S_stim_check,'Value');
EstimPARAMS.EPISODIC.ABA.A1_range_check=get(handles.A1_range_check,'Value');
EstimPARAMS.EPISODIC.ABA.B_range_check=get(handles.B_range_check,'Value');
EstimPARAMS.EPISODIC.ABA.A2_range_check=get(handles.A2_range_check,'Value');
EstimPARAMS.EPISODIC.ABA.S_range_check=get(handles.S_range_check,'Value');
EstimPARAMS.EPISODIC.ABA.A1_epi_check=get(handles.A1_epi_check,'Value');
EstimPARAMS.EPISODIC.ABA.B_epi_check=get(handles.B_epi_check,'Value');
EstimPARAMS.EPISODIC.ABA.A2_epi_check=get(handles.A2_epi_check,'Value');
EstimPARAMS.EPISODIC.ABA.S_epi_check=get(handles.S_epi_check,'Value');
EstimPARAMS.EPISODIC.ABA.A1_from=get(handles.A1_from,'Value');
EstimPARAMS.EPISODIC.ABA.A1_to=get(handles.A1_to,'Value');
EstimPARAMS.EPISODIC.ABA.A2_from=get(handles.A2_from,'Value');
EstimPARAMS.EPISODIC.ABA.A2_to=get(handles.A2_to,'Value');
EstimPARAMS.EPISODIC.ABA.B_from=get(handles.B_from,'Value');
EstimPARAMS.EPISODIC.ABA.B_to=get(handles.B_to,'Value');
EstimPARAMS.EPISODIC.ABA.S_from=get(handles.S_from,'Value');
EstimPARAMS.EPISODIC.ABA.S_to=get(handles.S_to,'Value');
EstimPARAMS.EPISODIC.ABA.A1_episodes=get(handles.A1_episodes,'String');
EstimPARAMS.EPISODIC.ABA.A2_episodes=get(handles.A2_episodes,'String');
EstimPARAMS.EPISODIC.ABA.B_episodes=get(handles.B_episodes,'String');
EstimPARAMS.EPISODIC.ABA.S_episodes=get(handles.S_episodes,'String');

EstimPARAMS.EPISODIC.pulsewv=episodic_estim_wvgen('ABA',EstimPARAMS);

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
%eval(sprintf('disp_string=''%s: %i Pulse(s) per Train, %i Train(s), at %s %s, Pulse Dur %5.2f ms, %5.2f ms IPI'';',scantype,EstimPARAMS.num_ppt,length(EstimPARAMS.stim_at_fnums),scantype,EstimPARAMS.frame_str,EstimPARAMS.pulse_dur,EstimPARAMS.ipi))
%set(PP_handles.disp_protocol,'String',disp_string)
set(PP_handles.disp_status,'String','Not Started')
