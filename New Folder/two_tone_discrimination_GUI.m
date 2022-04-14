function varargout = two_tone_discrimination_GUI(varargin)
% TWO_TONE_DISCRIMINATION_GUI MATLAB code for two_tone_discrimination_GUI.fig
%      TWO_TONE_DISCRIMINATION_GUI, by itself, creates a new TWO_TONE_DISCRIMINATION_GUI or raises the existing
%      singleton*.
%
%      H = TWO_TONE_DISCRIMINATION_GUI returns the handle to a new TWO_TONE_DISCRIMINATION_GUI or the handle to
%      the existing singleton*.
%
%      TWO_TONE_DISCRIMINATION_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TWO_TONE_DISCRIMINATION_GUI.M with the given input arguments.
%
%      TWO_TONE_DISCRIMINATION_GUI('Property','Value',...) creates a new TWO_TONE_DISCRIMINATION_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before two_tone_discrimination_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to two_tone_discrimination_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help two_tone_discrimination_GUI

% Last Modified by GUIDE v2.5 07-Nov-2019 17:10:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @two_tone_discrimination_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @two_tone_discrimination_GUI_OutputFcn, ...
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


% --- Executes just before two_tone_discrimination_GUI is made visible.
function two_tone_discrimination_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to two_tone_discrimination_GUI (see VARARGIN)

% Choose default command line output for two_tone_discrimination_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
load two_toneParams

cd (curdir)


eval(sprintf('set(handles.frame_period,''String'',''%5.3f'');',two_toneParams.frame_period))
set(handles.frame_period,'Value',two_toneParams.frame_period);
eval(sprintf('set(handles.pip_dur,''String'',''%5.3f'');',two_toneParams.pip_dur))
set(handles.pip_dur,'Value',two_toneParams.pip_dur);
eval(sprintf('set(handles.total_frames,''String'',''%i'');',two_toneParams.total_frames))
set(handles.total_frames,'Value',two_toneParams.total_frames);
eval(sprintf('set(handles.stim_start,''String'',''%i'');',two_toneParams.stim_start))
set(handles.stim_start,'Value',two_toneParams.stim_start);
eval(sprintf('set(handles.num_pips,''String'',''%i'');',two_toneParams.num_pips))
set(handles.num_pips,'Value',two_toneParams.num_pips);
eval(sprintf('set(handles.inter_pip_int,''String'',''%i'');',two_toneParams.inter_pip_int))
set(handles.inter_pip_int,'Value',two_toneParams.inter_pip_int);
eval(sprintf('set(handles.atten,''String'',''%i'');',two_toneParams.atten))
set(handles.atten,'Value',two_toneParams.atten);
eval(sprintf('set(handles.rf,''String'',''%i'');',two_toneParams.rf))
set(handles.rf,'Value',two_toneParams.rf);
eval(sprintf('set(handles.nrf,''String'',''%i'');',two_toneParams.nrf))
set(handles.nrf,'Value',two_toneParams.nrf);
eval(sprintf('set(handles.reps,''String'',''%i'');',two_toneParams.reps))
set(handles.reps,'Value',two_toneParams.reps);


% UIWAIT makes two_tone_discrimination_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = two_tone_discrimination_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function frame_period_Callback(hObject, eventdata, handles)
% hObject    handle to frame_period (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load two_toneParams
two_toneParams.frame_period=str2double(get(hObject,'String')); 
set(handles.frame_period,'Value',two_toneParams.frame_period);


% Hints: get(hObject,'String') returns contents of frame_period as text
%        str2double(get(hObject,'String')) returns contents of frame_period as a double


% --- Executes during object creation, after setting all properties.
function frame_period_CreateFcn(hObject, eventdata, handles)
% hObject    handle to frame_period (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pip_dur_Callback(hObject, eventdata, handles)


load two_toneParams
two_toneParams.pip_dur=str2double(get(hObject,'String')); 
set(handles.pip_dur,'Value',two_toneParams.pip_dur);



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



function total_frames_Callback(hObject, eventdata, handles)
% hObject    handle to total_frames (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load two_toneParams
two_toneParams.total_frames=str2double(get(hObject,'String')); 
set(handles.total_frames,'Value',two_toneParams.total_frames);



% Hints: get(hObject,'String') returns contents of total_frames as text
%        str2double(get(hObject,'String')) returns contents of total_frames as a double


% --- Executes during object creation, after setting all properties.
function total_frames_CreateFcn(hObject, eventdata, handles)
% hObject    handle to total_frames (see GCBO)
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

load two_toneParams
two_toneParams.stim_start=str2double(get(hObject,'String')); 
set(handles.stim_start,'Value',two_toneParams.stim_start);


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



function inter_pip_int_Callback(hObject, eventdata, handles)
% hObject    handle to inter_pip_int (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

load two_toneParams
two_toneParams.inter_pip_int=str2double(get(hObject,'String')); 
set(handles.inter_pip_int,'Value',two_toneParams.inter_pip_int);


% Hints: get(hObject,'String') returns contents of inter_pip_int as text
%        str2double(get(hObject,'String')) returns contents of inter_pip_int as a double


% --- Executes during object creation, after setting all properties.
function inter_pip_int_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inter_pip_int (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rf_Callback(hObject, eventdata, handles)
% hObject    handle to rf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

load two_toneParams
two_toneParams.rf=str2double(get(hObject,'String')); 
set(handles.rf,'Value',two_toneParams.rf);

% Hints: get(hObject,'String') returns contents of rf as text
%        str2double(get(hObject,'String')) returns contents of rf as a double


% --- Executes during object creation, after setting all properties.
function rf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function nrf_Callback(hObject, eventdata, handles)
% hObject    handle to nrf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load two_toneParams
two_toneParams.nrf=str2double(get(hObject,'String')); 
set(handles.nrf,'Value',two_toneParams.nrf);
% Hints: get(hObject,'String') returns contents of nrf as text
%        str2double(get(hObject,'String')) returns contents of nrf as a double


% --- Executes during object creation, after setting all properties.
function nrf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nrf (see GCBO)
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

load two_toneParams
two_toneParams.atten=str2double(get(hObject,'String')); 
set(handles.atten,'Value',two_toneParams.atten);
% Hints: get(hObject,'String') returns contents of atten as text
%        str2double(get(hObject,'String')) returns contents of atten as a double


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



function num_pips_Callback(hObject, eventdata, handles)
% hObject    handle to num_pips (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load two_toneParams
two_toneParams.num_pips=str2double(get(hObject,'String')); 
set(handles.num_pips,'Value',two_toneParams.num_pips);


% Hints: get(hObject,'String') returns contents of num_pips as text
%        str2double(get(hObject,'String')) returns contents of num_pips as a double


% --- Executes during object creation, after setting all properties.
function num_pips_CreateFcn(hObject, eventdata, handles)
% hObject    handle to num_pips (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function reps_Callback(hObject, eventdata, handles)
% hObject    handle to reps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load two_toneParams
two_toneParams.reps=str2double(get(hObject,'String')); 
set(handles.reps,'Value',two_toneParams.reps);
% Hints: get(hObject,'String') returns contents of reps as text
%        str2double(get(hObject,'String')) returns contents of reps as a double


% --- Executes during object creation, after setting all properties.
function reps_CreateFcn(hObject, eventdata, handles)
% hObject    handle to reps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in done.
function done_Callback(hObject, eventdata, handles)
% hObject    handle to done (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load two_toneParams

two_toneParams.frame_period=get(handles.frame_period,'Value');fdur=two_toneParams.frame_period;
two_toneParams.pip_dur=get(handles.pip_dur,'Value');
two_toneParams.total_frames=get(handles.total_frames,'Value');tfl=two_toneParams.total_frames;
two_toneParams.stim_start=get(handles.stim_start,'Value');sf=two_toneParams.stim_start;
two_toneParams.inter_pip_int=get(handles.inter_pip_int,'Value');ipi=two_toneParams.inter_pip_int;


two_toneParams.rf=get(handles.rf,'Value');fl=two_toneParams.rf;
two_toneParams.nrf=get(handles.nrf,'Value');fh=two_toneParams.nrf;


two_toneParams.atten=get(handles.atten,'Value');na=1;
two_toneParams.num_pips=get(handles.num_pips,'Value');nppt=two_toneParams.num_pips;
two_toneParams.reps=get(handles.reps,'Value');treps=two_toneParams.reps;

curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save two_toneParams two_toneParams
cd (curdir)
%save TonePipSweepPARAMS TonePipSweepPARAMS
load AudStimPARAMS
AudStimPARAMS.type='Two_tone_discrimination';
AudStimPARAMS.stim_protocol=two_toneParams;
close(handles.figure1)
nf=1;
total_prairie_iterations=nf*na*treps;
each_stim_dur=ipi*nppt;
each_prairie_dur=tfl*fdur;
lines_per_set=1;

% if AudStimPARAMS.MultFrame==0
% %for at least 50% duty cycle
% 
%     least_dur=2*ipi*nppt;least_prairie_frames=max([ceil(2*ipi*nppt/fdur) sf+ceil(each_stim_dur/fdur)]);
%     if least_prairie_frames<tfl
%         durcheck_str='PRAIRIE: Number of frames/lines per iter OKAY';
%         disp_bgcolor=[0 .8 1];
%     else
%         eval(sprintf('durcheck_str=''PRAIRIE: Increase frames/lines per iter to AT LEAST %i'';',least_prairie_frames))
%         disp_bgcolor=[1 0 0];
%     end
%     eval(sprintf('add_dur_check='' ...[At least %i : currently %i]'';',least_prairie_frames,tfl))
%     eval(sprintf('itercheck_str=''Set PAIRIE Number of ITERATIONS to AT LEAST %i'';',total_prairie_iterations))
%     display_str=strcat(durcheck_str,add_dur_check,'*\*/\*/*',itercheck_str);
%     load TPS_handles
%     set(AA_handles.check_disp,'String',display_str)
%     set(AA_handles.check_disp,'BackgroundColor',disp_bgcolor)
%     set(AA_handles.check_disp,'FontSize',9)
%     eval(sprintf('prot_str=''Two tone discrimination: %i freqs from %8.1f to %8.1f Hz, %i atten steps from %4.1f to %4.1f dB, %i Tone pips per train, Starts at frame/line %i'';',nf,fl,fh,na,ll,lh,nppt,sf))
%     set(AA_handles.disp_protocol,'String',prot_str)
% 
% elseif AudStimPARAMS.MultFrame==1
%     gapdur=AudStimPARAMS.MultFrameVal;
%     nframes_per_iter=sf+(fix((each_stim_dur+gapdur)/fdur)+1)*lines_per_set;
%     if tfl==nframes_per_iter
%         durcheck_str='PRAIRIE: Number of frames/lines per iter OKAY';
%         disp_bgcolor=[0 .8 1];
%     else
%         eval(sprintf('durcheck_str=''PRAIRIE: Set frames/lines per iter to %i'';',nframes_per_iter))
%         disp_bgcolor=[1 0 0];
%     end
%     eval(sprintf('add_dur_check='' ...[Must be %i : currently %i]'';',nframes_per_iter,tfl))
%     eval(sprintf('itercheck_str=''Set PAIRIE Number of ITERATIONS to AT LEAST %i'';',treps))
%     display_str=strcat(durcheck_str,add_dur_check,'*\*/\*/*',itercheck_str);
%     load TPS_handles
%     set(AA_handles.check_disp,'String',display_str)
%     set(AA_handles.check_disp,'BackgroundColor',disp_bgcolor)
%     set(AA_handles.check_disp,'FontSize',9)
%     eval(sprintf('prot_str=''Two tone discrimination: %i freqs from %8.1f to %8.1f Hz, %i atten steps from %4.1f to %4.1f dB, %i Tone pips per train, Starts at frame/line %i'';',nf,fl,fh,na,ll,lh,nppt,sf))
%     set(AA_handles.disp_protocol,'String',prot_str)
% end

%AudStimPARAMS.protocol_str=prot_str;
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save AudStimPARAMS AudStimPARAMS
cd (curdir)
%save AudStimPARAMS AudStimPARAMS




