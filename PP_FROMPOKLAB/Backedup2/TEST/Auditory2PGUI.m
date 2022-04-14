function varargout = Auditory2PGUI(varargin)
% AUDITORY2PGUI M-file for Auditory2PGUI.fig
%      AUDITORY2PGUI, by itself, creates a new AUDITORY2PGUI or raises the existing
%      singleton*.
%
%      H = AUDITORY2PGUI returns the handle to a new AUDITORY2PGUI or the handle to
%      the existing singleton*.
%
%      AUDITORY2PGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AUDITORY2PGUI.M with the given input arguments.
%
%      AUDITORY2PGUI('Property','Value',...) creates a new AUDITORY2PGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Auditory2PGUI_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Auditory2PGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help Auditory2PGUI

% Last Modified by GUIDE v2.5 02-Aug-2010 14:20:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Auditory2PGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @Auditory2PGUI_OutputFcn, ...
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


% --- Executes just before Auditory2PGUI is made visible.
function Auditory2PGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Auditory2PGUI (see VARARGIN)

% Choose default command line output for Auditory2PGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
set(handles.disp_protocol,'String','Choose Stimulus Set')
load AudStimPARAMS
AudStimPARAMS.MultFrame=0;
% AudStimPARAMS
% handles
set(handles.left_check,'Value',AudStimPARAMS.left_check);
set(handles.right_check,'Value',AudStimPARAMS.right_check);
set(handles.both_check,'Value',AudStimPARAMS.both_check);
set(handles.linescan_check,'Value',AudStimPARAMS.linescan_check);
set(handles.frame_check,'Value',AudStimPARAMS.frame_check);
set(handles.max_speed_check,'Value',AudStimPARAMS.max_speed_check);
eval(sprintf('set(handles.offset_num,''String'',''%i'');',AudStimPARAMS.offset_num))
set(handles.offset_num,'Value',AudStimPARAMS.offset_num);
set(handles.MultFrame,'Value',AudStimPARAMS.MultFrame);

load Auditory_handles
wtd_val=get(PP_handles.what_to_do,'Value');
if wtd_val==7
    set(handles.ephys_electrode,'String','CHECK (CHN)')
    set(handles.ephys_electrode,'BackgroundColor',[1 0 0])
else
    set(handles.ephys_electrode,'String','FOR EPHYS')
end
set(handles.single_channel,'Value',AudStimPARAMS.single_channel);
set(handles.mult_channel,'Value',AudStimPARAMS.mult_channel);
    

% UIWAIT makes Auditory2PGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Auditory2PGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles;


% --- Executes on selection change in stim_name.
function stim_name_Callback(hObject, eventdata, handles)
% hObject    handle to stim_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns stim_name contents as cell array
%        contents{get(hObject,'Value')} returns selected item from stim_name

stimset=get(hObject,'Value');
switch get(hObject,'Value')
    case 1
         set(handles.disp_protocol,'String','Choose Stimulus Set')
    case 2
        AA_handles=handles;
        save TPS_handles AA_handles
        TonePipSweepGUI
    case 3
        AA_handles=handles;
        save NP_handles AA_handles
        NoisePipGUI
     case 4
        AA_handles=handles;
        save SAM_handles AA_handles
        SAMGUI
     case 5
        AA_handles=handles;
        save RSS_handles AA_handles
        RSSGUI
      case 6
        AA_handles=handles;
        save ABA_handles AA_handles
        ABA_2T_GUI
     case 7
        AA_handles=handles;
        save SSA_handles AA_handles
        SSAGUI
     case 8
        AA_handles=handles;
        save HC_handles AA_handles
        HCGUI
end

% --- Executes during object creation, after setting all properties.
function stim_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stim_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in left_check.
function left_check_Callback(hObject, eventdata, handles)
% hObject    handle to left_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of left_check

load AudStimPARAMS
AudStimPARAMS.left_check=get(hObject,'Value'); %returns contents of num_pt_val as a double
set(handles.left_check,'Value',AudStimPARAMS.left_check);
set(handles.right_check,'Value',~AudStimPARAMS.left_check);
AudStimPARAMS.right_check=~get(hObject,'Value');
if get(hObject,'Value')==1
    set(handles.both_check,'Value',~AudStimPARAMS.left_check);
    AudStimPARAMS.both_check=~get(hObject,'Value');
end
if get(handles.left_check,'Value')==0&get(handles.right_check,'Value')==0&get(handles.both_check,'Value')==0
    set(handles.right_check,'Value',1);
    AudStimPARAMS.right_check=1;
end

save AudStimPARAMS AudStimPARAMS

% --- Executes on button press in right_check.
function right_check_Callback(hObject, eventdata, handles)
% hObject    handle to right_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of right_check

load AudStimPARAMS
AudStimPARAMS.right_check=get(hObject,'Value'); %returns contents of num_pt_val as a double
set(handles.right_check,'Value',AudStimPARAMS.right_check);
set(handles.left_check,'Value',~AudStimPARAMS.right_check);
AudStimPARAMS.left_check=~get(hObject,'Value');
if get(hObject,'Value')==1
    set(handles.both_check,'Value',~AudStimPARAMS.right_check);
    AudStimPARAMS.both_check=~get(hObject,'Value');
end
if get(handles.left_check,'Value')==0&get(handles.right_check,'Value')==0&get(handles.both_check,'Value')==0
    set(handles.right_check,'Value',1);
    AudStimPARAMS.right_check=1;
end
save AudStimPARAMS AudStimPARAMS

% --- Executes on button press in both_check.
function both_check_Callback(hObject, eventdata, handles)
% hObject    handle to both_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of both_check

load AudStimPARAMS
AudStimPARAMS.both_check=get(hObject,'Value'); %returns contents of num_pt_val as a double
set(handles.both_check,'Value',AudStimPARAMS.both_check);
if get(hObject,'Value')==1
    set(handles.left_check,'Value',0);
    AudStimPARAMS.left_check=0;
    set(handles.right_check,'Value',0);
    AudStimPARAMS.right_check=0;
end
if get(handles.left_check,'Value')==0&get(handles.right_check,'Value')==0&get(handles.both_check,'Value')==0
    set(handles.right_check,'Value',1);
    AudStimPARAMS.right_check=1;
end
save AudStimPARAMS AudStimPARAMS

% --- Executes on button press in frame_check.
function frame_check_Callback(hObject, eventdata, handles)
% hObject    handle to frame_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of frame_check

load AudStimPARAMS
AudStimPARAMS.frame_check=get(hObject,'Value'); %returns contents of num_pt_val as a double
set(handles.frame_check,'Value',AudStimPARAMS.frame_check);
set(handles.linescan_check,'Value',~AudStimPARAMS.frame_check);
AudStimPARAMS.linescan_check=~get(hObject,'Value');
save AudStimPARAMS AudStimPARAMS

% --- Executes on button press in linescan_check.
function linescan_check_Callback(hObject, eventdata, handles)
% hObject    handle to linescan_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of linescan_check

load AudStimPARAMS
AudStimPARAMS.linescan_check=get(hObject,'Value'); %returns contents of num_pt_val as a double
set(handles.linescan_check,'Value',AudStimPARAMS.linescan_check);
set(handles.frame_check,'Value',~AudStimPARAMS.linescan_check);
AudStimPARAMS.frame_check=~get(hObject,'Value');
save AudStimPARAMS AudStimPARAMS


function start_frame_line_num_Callback(hObject, eventdata, handles)
% hObject    handle to start_frame_line_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of start_frame_line_num as text
%        str2double(get(hObject,'String')) returns contents of start_frame_line_num as a double


% --- Executes during object creation, after setting all properties.
function start_frame_line_num_CreateFcn(hObject, eventdata, handles)
% hObject    handle to start_frame_line_num (see GCBO)
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

load AudStimPARAMS
AudStimPARAMS.linescan_check=get(handles.linescan_check,'Value');
AudStimPARAMS.frame_check=get(handles.frame_check,'Value');
AudStimPARAMS.max_speed_check=get(handles.max_speed_check,'Value');
AudStimPARAMS.left_check=get(handles.left_check,'Value');
AudStimPARAMS.right_check=get(handles.right_check,'Value');
AudStimPARAMS.both_check=get(handles.both_check,'Value');
AudStimPARAMS.offset_num=get(handles.offset_num,'Value');
AudStimPARAMS.MultFrame=get(handles.MultFrame,'Value');
save AudStimPARAMS AudStimPARAMS
close(handles.figure1)
load Auditory_handles
if AudStimPARAMS.linescan_check==1
    scantype='Lines';
elseif AudStimPARAMS.frame_check==1
    scantype='Frames';
    if AudStimPARAMS.max_speed_check==1
        scantype='Frames at Max Speed';
    end
end
disp_string=AudStimPARAMS.protocol_str;
set(PP_handles.disp_protocol,'String',disp_string)
set(PP_handles.disp_status,'String','Not Started')


% --- Executes on button press in max_speed_check.
function max_speed_check_Callback(hObject, eventdata, handles)
% hObject    handle to max_speed_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of max_speed_check

load AudStimPARAMS
AudStimPARAMS.max_speed_check=get(hObject,'Value'); %returns contents of num_pt_val as a double
set(handles.max_speed_check,'Value',AudStimPARAMS.max_speed_check);
save AudStimPARAMS AudStimPARAMS



function offset_num_Callback(hObject, eventdata, handles)
% hObject    handle to offset_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of offset_num as text
%        str2double(get(hObject,'String')) returns contents of offset_num as a double

AudStimPARAMS.offset_num=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.offset_num,'Value',AudStimPARAMS.offset_num);

% --- Executes during object creation, after setting all properties.
function offset_num_CreateFcn(hObject, eventdata, handles)
% hObject    handle to offset_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% % --- Executes on button press in MultFrame.
% function MultFrame_Callback(hObject, eventdata, handles)
% % hObject    handle to MultFrame (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hint: get(hObject,'Value') returns toggle state of MultFrame
% 
% load AudStimPARAMS
% AudStimPARAMS.MultFrame=get(hObject,'Value'); %returns contents of num_pt_val as a double
% load MFISI_PARAM
% AudStimPARAMS.MultFrameVal=MFISI_PARAM.val;
% set(handles.MultFrame,'Value',AudStimPARAMS.MultFrame);
% if AudStimPARAMS.MultFrame==1
%     InterStimIntGUI
%     load MFISI_PARAM
%     AudStimPARAMS.MultFrameVal=MFISI_PARAM.val;
% end
% 
% save AudStimPARAMS AudStimPARAMS


% --- Executes on button press in MultFrame.
function MultFrame_Callback(hObject, eventdata, handles)
% hObject    handle to MultFrame (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of MultFrame

load AudStimPARAMS
AudStimPARAMS.MultFrame=get(hObject,'Value'); %returns contents of num_pt_val as a double
load MFISI_PARAM
AudStimPARAMS.MultFrameVal=MFISI_PARAM.val;
set(handles.MultFrame,'Value',AudStimPARAMS.MultFrame);
if AudStimPARAMS.MultFrame==1
    InterStimIntGUI
    load MFISI_PARAM
    AudStimPARAMS.MultFrameVal=MFISI_PARAM.val;
end

save AudStimPARAMS AudStimPARAMS



% --- Executes on button press in single_channel.
function single_channel_Callback(hObject, eventdata, handles)
% hObject    handle to single_channel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of single_channel

load AudStimPARAMS
AudStimPARAMS.single_channel=get(hObject,'Value'); %returns contents of num_pt_val as a double
set(handles.single_channel,'Value',AudStimPARAMS.single_channel);
set(handles.mult_channel,'Value',~AudStimPARAMS.single_channel);
AudStimPARAMS.mult_channel=~get(hObject,'Value');
save AudStimPARAMS AudStimPARAMS

% --- Executes on button press in mult_channel.
function mult_channel_Callback(hObject, eventdata, handles)
% hObject    handle to mult_channel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of mult_channel

load AudStimPARAMS
AudStimPARAMS.mult_channel=get(hObject,'Value'); %returns contents of num_pt_val as a double
set(handles.mult_channel,'Value',AudStimPARAMS.mult_channel);
set(handles.single_channel,'Value',~AudStimPARAMS.mult_channel);
AudStimPARAMS.single_channel=~get(hObject,'Value');
save AudStimPARAMS AudStimPARAMS
