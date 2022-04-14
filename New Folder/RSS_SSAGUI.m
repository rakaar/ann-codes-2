function varargout = RSS_SSAGUI(varargin)
% RSS_SSAGUI MATLAB code for RSS_SSAGUI.fig
%      RSS_SSAGUI, by itself, creates a new RSS_SSAGUI or raises the existing
%      singleton*.
%
%      H = RSS_SSAGUI returns the handle to a new RSS_SSAGUI or the handle to
%      the existing singleton*.
%
%      RSS_SSAGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RSS_SSAGUI.M with the given input arguments.
%
%      RSS_SSAGUI('Property','Value',...) creates a new RSS_SSAGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before RSS_SSAGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to RSS_SSAGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help RSS_SSAGUI

% Last Modified by GUIDE v2.5 15-Feb-2019 20:08:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @RSS_SSAGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @RSS_SSAGUI_OutputFcn, ...
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


% --- Executes just before RSS_SSAGUI is made visible.
function RSS_SSAGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to RSS_SSAGUI (see VARARGIN)

% Choose default command line output for RSS_SSAGUI
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);

load RSSSSAPARAMS
load Auditory_handles
wtd_val=get(PP_handles.what_to_do,'Value');
if wtd_val==7
    set(handles.text3,'String','Stimulus Start Time(s)')
     set(handles.text4,'String','Repetitions')
end
% eval(sprintf('set(handles.frame_dur,''String'',''%5.3f'');',RSSSSAPARAMS.frame_dur))
% set(handles.frame_dur,'Value',RSSSSAPARAMS.frame_dur);
eval(sprintf('set(handles.total_frames_lines,''String'',''%i'');',RSSSSAPARAMS.total_frames_lines))
set(handles.total_frames_lines,'Value',RSSSSAPARAMS.total_frames_lines);
 eval(sprintf('set(handles.stim_start,''String'',''%i'');',RSSSSAPARAMS.stim_start))
 set(handles.stim_start,'Value',RSSSSAPARAMS.stim_start);
eval(sprintf('set(handles.atten,''String'',''%3.1f'');',RSSSSAPARAMS.atten))
set(handles.atten,'Value',RSSSSAPARAMS.atten);
eval(sprintf('set(handles.total_reps,''String'',''%i'');',RSSSSAPARAMS.total_reps))
set(handles.total_reps,'Value',RSSSSAPARAMS.total_reps);
% eval(sprintf('set(handles.choose_set,''String'',''%i'');',RSSSSAPARAMS.choose_set))
% set(handles.choose_set,'Value',RSSSSAPARAMS.choose_set);


% UIWAIT makes RSS_SSAGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = RSS_SSAGUI_OutputFcn(hObject, eventdata, handles) 
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

load RSSSSAPARAMS
RSSSSAPARAMS.frame_dur=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.frame_dur,'Value',RSSSSAPARAMS.frame_dur);


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



function stim_start_Callback(hObject, eventdata, handles)
% hObject    handle to stim_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stim_start as text
%        str2double(get(hObject,'String')) returns contents of stim_start as a double

load RSSSSAPARAMS
RSSSSAPARAMS.stim_start=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.stim_start,'Value',RSSSSAPARAMS.stim_start);

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



function total_reps_Callback(hObject, eventdata, handles)
% hObject    handle to total_reps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of total_reps as text
%        str2double(get(hObject,'String')) returns contents of total_reps as a double

load RSSSSAPARAMS
RSSSSAPARAMS.total_reps=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.total_reps,'Value',RSSSSAPARAMS.total_reps);

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



function total_frames_lines_Callback(hObject, eventdata, handles)
% hObject    handle to total_frames_lines (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of total_frames_lines as text
%        str2double(get(hObject,'String')) returns contents of total_frames_lines as a double

load RSSSSAPARAMS
RSSSSAPARAMS.total_frames_lines=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.total_frames_lines,'Value',RSSSSAPARAMS.total_frames_lines);

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

% --- Executes on selection change in choose_set.
function choose_set_Callback(hObject, eventdata, handles)
% hObject    handle to choose_set (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns choose_set contents as cell array
%        contents{get(hObject,'Value')} returns selected item from choose_set

load RSSSSAPARAMS

% if get(hObject,'Value')==1
%     RSSSSAPARAMS.choose_set=1;%%%default
% else
    %RSSSSAPARAMS.choose_set=get(hObject,'Value');
% end


if get(hObject,'Value')==1
    RSSSSAPARAMS.choose_set=2;%%%default
else
    RSSSSAPARAMS.choose_set=get(hObject,'Value');
end

% --- Executes during object creation, after setting all properties.
function choose_set_CreateFcn(hObject, eventdata, handles)
% hObject    handle to choose_set (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in done_button.
function done_button_Callback(hObject, eventdata, handles)
% hObject    handle to done_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

load RSSSSAPARAMS

% RSSSSAPARAMS.frame_dur=get(handles.frame_dur,'Value');fdur=RSSSSAPARAMS.frame_dur;
RSSSSAPARAMS.total_frames_lines=get(handles.total_frames_lines,'Value');tfl=RSSSSAPARAMS.total_frames_lines;
RSSSSAPARAMS.stim_start=get(handles.stim_start,'Value');sf=RSSSSAPARAMS.stim_start;
RSSSSAPARAMS.atten=get(handles.atten,'Value');atten=RSSSSAPARAMS.atten;
RSSSSAPARAMS.total_reps=get(handles.total_reps,'Value');treps=RSSSSAPARAMS.total_reps;
RSSSSAPARAMS.nsset=164;total_stims=RSSSSAPARAMS.nsset;%%%% HARD CODED STIMULI PER SET
RSSSSAPARAMS.choose_set=get(handles.choose_set,'Value')-1;set=RSSSSAPARAMS.choose_set;
all_stims=[26 10 26 26 26 26];
num_stims=all_stims(set);
RSSSSAPARAMS.nstims_set=num_stims;
RSSSSAPARAMS.stim_duration=3.6;%%%% HARD CODED STIMULUS DURATION
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save RSSSSAPARAMS RSSSSAPARAMS
cd (curdir)
%save RSSSSAPARAMS RSSSSAPARAMS

load AudStimPARAMS
AudStimPARAMS.type='RSS_SSA';
AudStimPARAMS.stim_protocol=RSSSSAPARAMS;
close(handles.figure1)
total_prairie_iterations=total_stims*treps;
each_stim_dur=RSSSSAPARAMS.stim_duration;%%%% HARD CODED STIMULUS DURATION
%each_prairie_dur=tfl*fdur;
%for at least 50% duty cycle

% if AudStimPARAMS.MultFrame==0
% %at least 200 ms extra at the end
%     least_dur=(sf-1)*fdur+each_stim_dur+0.2;
%     least_prairie_frames=ceil(least_dur/fdur);
%     if least_dur<each_prairie_dur
%         durcheck_str='PRAIRIE: Number of frames/lines per iter OKAY';
%         disp_bgcolor=[0 .8 1];
%     else
%         eval(sprintf('durcheck_str=''PRAIRIE: Increase frames/lines per iter to AT LEAST %i'';',least_prairie_frames))
%         disp_bgcolor=[1 0 0];
%     end
%     eval(sprintf('add_dur_check='' ...[At least %i : currently %i]'';',least_prairie_frames,tfl))
%     eval(sprintf('itercheck_str=''Set PAIRIE Number of ITERATIONS to AT LEAST %i'';',total_prairie_iterations))
%     display_str=strcat(durcheck_str,add_dur_check,'*\*/\*/*',itercheck_str);
%     load RSSSSA_handles
%     set(AA_handles.check_disp,'String',display_str)
%     set(AA_handles.check_disp,'BackgroundColor',disp_bgcolor)
%     set(AA_handles.check_disp,'FontSize',9)
%     eval(sprintf('prot_str='' RSS SSA Fixed Set:1, %i SSA stims sequence %i dB atten, Starts at frame/line %i'';',total_stims,atten,sf))
%     set(AA_handles.disp_protocol,'String',prot_str)
% 
% elseif AudStimPARAMS.MultFrame==1
%     display_str='Multiple frames does not work';
%     disp_bgcolor=[1 0 0];
%     set(AA_handles.check_disp,'String',display_str)
%     set(AA_handles.check_disp,'BackgroundColor',disp_bgcolor)
%     set(AA_handles.check_disp,'FontSize',9)
%     prot_str='N/A';
% end
%sf=0.05;
%eval(sprintf('prot_str='' RSS SSA Fixed Set:%i, %i SSA stims sequence %i dB atten, Starts at frame/line %i'';',set,total_stims,atten,sf))
set
prot_str=strcat('RSS SSA Fixed Set',' ',num2str(set),',',' ',num2str(num_stims),' SSA stims sequence,',' ',num2str(atten),' dB atten, Starts at frame/line ',num2str(sf));
prot_str
load RSSSSA_handles
%set(AA_handles.disp_protocol,'String',prot_str)
AudStimPARAMS.protocol_str=prot_str;
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save AudStimPARAMS AudStimPARAMS
cd (curdir)

function atten_Callback(hObject, eventdata, handles)
% hObject    handle to atten (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of atten as text
%        str2double(get(hObject,'String')) returns contents of atten as a double

load RSSSSAPARAMS
RSSSSAPARAMS.atten=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.atten,'Value',RSSSSAPARAMS.atten);

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


% --- Executes on selection change in choose_set.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to choose_set (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns choose_set contents as cell array
%        contents{get(hObject,'Value')} returns selected item from choose_set
load RSSSSAPARAMS

if get(hObject,'Value')==1
    RSSSSAPARAMS.stim_set=2;%%%default
else
    RSSSSAPARAMS.stim_set=get(hObject,'Value');
end


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to choose_set (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over text4.
function text4_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to text4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function text7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function text3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function text4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
