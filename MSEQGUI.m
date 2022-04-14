function varargout = MSEQGUI(varargin)
% MSEQGUI MATLAB code for MSEQGUI.fig
%      MSEQGUI, by itself, creates a new MSEQGUI or raises the existing
%      singleton*.
%
%      H = MSEQGUI returns the handle to a new MSEQGUI or the handle to
%      the existing singleton*.
%
%      MSEQGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MSEQGUI.M with the given input arguments.
%
%      MSEQGUI('Property','Value',...) creates a new MSEQGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MSEQGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MSEQGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MSEQGUI

% Last Modified by GUIDE v2.5 22-Nov-2013 17:42:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MSEQGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @MSEQGUI_OutputFcn, ...
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


% --- Executes just before MSEQGUI is made visible.
function MSEQGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MSEQGUI (see VARARGIN)

% Choose default command line output for MSEQGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

load MSEQPARAMS
load Auditory_handles

wtd_val=get(PP_handles.what_to_do,'Value');
if wtd_val==7
    set(handles.text3,'String','Total Time (sec)')
    set(handles.text4,'String','Start Time (sec)')
end
eval(sprintf('set(handles.frame_dur,''String'',''%5.3f'');',MSEQPARAMS.frame_dur))
set(handles.frame_dur,'Value',MSEQPARAMS.frame_dur);
eval(sprintf('set(handles.total_frames_lines,''String'',''%i'');',MSEQPARAMS.total_frames_lines))
set(handles.total_frames_lines,'Value',MSEQPARAMS.total_frames_lines);
eval(sprintf('set(handles.stim_start,''String'',''%i'');',MSEQPARAMS.stim_start))
set(handles.stim_start,'Value',MSEQPARAMS.stim_start);
eval(sprintf('set(handles.binwidth,''String'',''%6.4f'');',MSEQPARAMS.binwidth))
set(handles.binwidth,'Value',MSEQPARAMS.binwidth);
eval(sprintf('set(handles.carrier_freq,''String'',''%8.1f'');',MSEQPARAMS.carrier_freq))
set(handles.carrier_freq,'Value',MSEQPARAMS.carrier_freq);
eval(sprintf('set(handles.atten,''String'',''%3.1f'');',MSEQPARAMS.atten))
set(handles.atten,'Value',MSEQPARAMS.atten);
eval(sprintf('set(handles.total_reps,''String'',''%i'');',MSEQPARAMS.total_reps))
set(handles.total_reps,'Value',MSEQPARAMS.total_reps);

% UIWAIT makes MSEQGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MSEQGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function frame_dur_Callback(hObject, eventdata, handles)
% hObject    handle to frame_dur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of frame_dur as text
%        str2double(get(hObject,'String')) returns contents of frame_dur as a double

load MSEQPARAMS
MSEQPARAMS.frame_dur=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.frame_dur,'Value',MSEQPARAMS.frame_dur);

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

load MSEQPARAMS
MSEQPARAMS.total_frames_lines=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.total_frames_lines,'Value',MSEQPARAMS.total_frames_lines);

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

load MSEQPARAMS
MSEQPARAMS.stim_start=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.stim_start,'Value',MSEQPARAMS.stim_start);

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



function binwidth_Callback(hObject, eventdata, handles)
% hObject    handle to binwidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of binwidth as text
%        str2double(get(hObject,'String')) returns contents of binwidth as a double

load MSEQPARAMS
MSEQPARAMS.binwidth=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.binwidth,'Value',MSEQPARAMS.binwidth);

% --- Executes during object creation, after setting all properties.
function binwidth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to binwidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function carrier_freq_Callback(hObject, eventdata, handles)
% hObject    handle to carrier_freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of carrier_freq as text
%        str2double(get(hObject,'String')) returns contents of carrier_freq as a double

load MSEQPARAMS
MSEQPARAMS.carrier_freq=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.carrier_freq,'Value',MSEQPARAMS.carrier_freq);

% --- Executes during object creation, after setting all properties.
function carrier_freq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to carrier_freq (see GCBO)
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

load MSEQPARAMS
MSEQPARAMS.atten=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.atten,'Value',MSEQPARAMS.atten);

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



function total_reps_Callback(hObject, eventdata, handles)
% hObject    handle to total_reps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of total_reps as text
%        str2double(get(hObject,'String')) returns contents of total_reps as a double

load MSEQPARAMS
MSEQPARAMS.total_reps=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.total_reps,'Value',MSEQPARAMS.total_reps);

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


% --- Executes on button press in done_button.
function done_button_Callback(hObject, eventdata, handles)
% hObject    handle to done_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

load MSEQPARAMS

MSEQPARAMS.frame_dur=get(handles.frame_dur,'Value');fdur=MSEQPARAMS.frame_dur;
MSEQPARAMS.total_frames_lines=get(handles.total_frames_lines,'Value');tfl=MSEQPARAMS.total_frames_lines;
MSEQPARAMS.stim_start=get(handles.stim_start,'Value');sf=MSEQPARAMS.stim_start;
MSEQPARAMS.binwidth=get(handles.binwidth,'Value');bw=MSEQPARAMS.binwidth;
MSEQPARAMS.carrier_freq=get(handles.carrier_freq,'Value');cf=MSEQPARAMS.carrier_freq;
MSEQPARAMS.atten=get(handles.atten,'Value');att=MSEQPARAMS.atten;
MSEQPARAMS.total_reps=get(handles.total_reps,'Value');treps=MSEQPARAMS.total_reps;

curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save MSEQPARAMS MSEQPARAMS
cd (curdir)
%save MSEQPARAMS MSEQPARAMS
load AudStimPARAMS
AudStimPARAMS.type='MSEQ';
AudStimPARAMS.stim_protocol=MSEQPARAMS;
close(handles.figure1)
total_prairie_iterations=treps;
each_stim_dur=4096*bw;
each_prairie_dur=tfl*fdur;
lines_per_set=1;

if AudStimPARAMS.MultFrame==0
%for at least 50% duty cycle

    least_dur=2*each_stim_dur;least_prairie_frames=max([ceil(2*each_stim_dur/fdur) sf+ceil(each_stim_dur/fdur)]);
    if least_prairie_frames<tfl
        durcheck_str='PRAIRIE: Number of frames/lines per iter OKAY';
        disp_bgcolor=[0 .8 1];
    else
        eval(sprintf('durcheck_str=''PRAIRIE: Increase frames/lines per iter to AT LEAST %i'';',least_prairie_frames))
        disp_bgcolor=[1 0 0];
    end
    eval(sprintf('add_dur_check='' ...[At least %i : currently %i]'';',least_prairie_frames,tfl))
    eval(sprintf('itercheck_str=''Set PAIRIE Number of ITERATIONS to AT LEAST %i'';',total_prairie_iterations))
    display_str=strcat(durcheck_str,add_dur_check,'*\*/\*/*',itercheck_str);
    load MSEQ_handles
    set(AA_handles.check_disp,'String',display_str)
    set(AA_handles.check_disp,'BackgroundColor',disp_bgcolor)
    set(AA_handles.check_disp,'FontSize',9)
    eval(sprintf('prot_str=''MSEQ: Carrier Freq = %8.1f Hz, Atten %4.1f dB, Starts at frame/line/(s) %i'';',cf,att,sf))
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
    load TPS_handles
    set(AA_handles.check_disp,'String',display_str)
    set(AA_handles.check_disp,'BackgroundColor',disp_bgcolor)
    set(AA_handles.check_disp,'FontSize',9)
    eval(sprintf('prot_str=''MSEQ: Carrier Freq = %8.1f Hz, Atten %4.1f dB, Starts at frame/line/(s) %i'';',cf,att,sf))
    set(AA_handles.disp_protocol,'String',prot_str)
end

AudStimPARAMS.protocol_str=prot_str;
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save AudStimPARAMS AudStimPARAMS
cd (curdir)
