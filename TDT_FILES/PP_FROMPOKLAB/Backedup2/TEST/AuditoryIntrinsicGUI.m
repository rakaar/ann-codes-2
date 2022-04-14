function varargout = AuditoryIntrinsicGUI(varargin)
% AUDITORYINTRINSICGUI M-file for AuditoryIntrinsicGUI.fig
%      AUDITORYINTRINSICGUI, by itself, creates a new AUDITORYINTRINSICGUI or raises the existing
%      singleton*.
%
%      H = AUDITORYINTRINSICGUI returns the handle to a new AUDITORYINTRINSICGUI or the handle to
%      the existing singleton*.
%
%      AUDITORYINTRINSICGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AUDITORYINTRINSICGUI.M with the given input arguments.
%
%      AUDITORYINTRINSICGUI('Property','Value',...) creates a new AUDITORYINTRINSICGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AuditoryIntrinsicGUI_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AuditoryIntrinsicGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help AuditoryIntrinsicGUI

% Last Modified by GUIDE v2.5 14-Feb-2011 10:28:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AuditoryIntrinsicGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @AuditoryIntrinsicGUI_OutputFcn, ...
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


% --- Executes just before AuditoryIntrinsicGUI is made visible.
function AuditoryIntrinsicGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AuditoryIntrinsicGUI (see VARARGIN)

% Choose default command line output for AuditoryIntrinsicGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
set(handles.disp_protocol,'String','Choose Stimulus Set')
load AudStimIIPARAMS

set(handles.left_check,'Value',AudStimIIPARAMS.left_check);
set(handles.right_check,'Value',AudStimIIPARAMS.right_check);
set(handles.both_check,'Value',AudStimIIPARAMS.both_check);
set(handles.piptrainmode,'Value',AudStimIIPARAMS.piptrainmode);

% UIWAIT makes AuditoryIntrinsicGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = AuditoryIntrinsicGUI_OutputFcn(hObject, eventdata, handles) 
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
        AAII_handles=handles;
        save TPSII_handles AAII_handles
        TonePipSweepIIGUI
    case 3
        AAII_handles=handles;
        save SAMII_handles AAII_handles
        SAMIIGUI
    case 4
        AAII_handles=handles;
        save HCII_handles AAII_handles
        HCIIGUI
    
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

load AudStimIIPARAMS
AudStimIIPARAMS.left_check=get(hObject,'Value'); %returns contents of num_pt_val as a double
set(handles.left_check,'Value',AudStimIIPARAMS.left_check);
set(handles.right_check,'Value',~AudStimIIPARAMS.left_check);
AudStimIIPARAMS.right_check=~get(hObject,'Value');
if get(hObject,'Value')==1
    set(handles.both_check,'Value',~AudStimIIPARAMS.left_check);
    AudStimIIPARAMS.both_check=~get(hObject,'Value');
end
if get(handles.left_check,'Value')==0&get(handles.right_check,'Value')==0&get(handles.both_check,'Value')==0
    set(handles.right_check,'Value',1);
    AudStimIIPARAMS.right_check=1;
end

save AudStimIIPARAMS AudStimIIPARAMS

% --- Executes on button press in right_check.
function right_check_Callback(hObject, eventdata, handles)
% hObject    handle to right_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of right_check

load AudStimIIPARAMS
AudStimIIPARAMS.right_check=get(hObject,'Value'); %returns contents of num_pt_val as a double
set(handles.right_check,'Value',AudStimIIPARAMS.right_check);
set(handles.left_check,'Value',~AudStimIIPARAMS.right_check);
AudStimIIPARAMS.left_check=~get(hObject,'Value');
if get(hObject,'Value')==1
    set(handles.both_check,'Value',~AudStimIIPARAMS.right_check);
    AudStimIIPARAMS.both_check=~get(hObject,'Value');
end
if get(handles.left_check,'Value')==0&get(handles.right_check,'Value')==0&get(handles.both_check,'Value')==0
    set(handles.right_check,'Value',1);
    AudStimIIPARAMS.right_check=1;
end
save AudStimIIPARAMS AudStimIIPARAMS

% --- Executes on button press in both_check.
function both_check_Callback(hObject, eventdata, handles)
% hObject    handle to both_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of both_check

load AudStimIIPARAMS
AudStimIIPARAMS.both_check=get(hObject,'Value'); %returns contents of num_pt_val as a double
set(handles.both_check,'Value',AudStimIIPARAMS.both_check);
if get(hObject,'Value')==1
    set(handles.left_check,'Value',0);
    AudStimIIPARAMS.left_check=0;
    set(handles.right_check,'Value',0);
    AudStimIIPARAMS.right_check=0;
end
if get(handles.left_check,'Value')==0&get(handles.right_check,'Value')==0&get(handles.both_check,'Value')==0
    set(handles.right_check,'Value',1);
    AudStimIIPARAMS.right_check=1;
end
save AudStimIIPARAMS AudStimIIPARAMS

% --- Executes on button press in done_button.
function done_button_Callback(hObject, eventdata, handles)
% hObject    handle to done_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

load AudStimIIPARAMS
AudStimIIPARAMS.left_check=get(handles.left_check,'Value');
AudStimIIPARAMS.right_check=get(handles.right_check,'Value');
AudStimIIPARAMS.both_check=get(handles.both_check,'Value');
AudStimIIPARAMS.piptrainmode=get(handles.piptrainmode,'Value');
save AudStimIIPARAMS AudStimIIPARAMS
close(handles.figure1)
load AuditoryII_handles
scantype='Frames';

disp_string=AudStimIIPARAMS.protocol_str;
set(PP_handles.disp_protocol,'String',disp_string)
set(PP_handles.disp_status,'String','Not Started')



% --- Executes on button press in piptrainmode.
function piptrainmode_Callback(hObject, eventdata, handles)
% hObject    handle to piptrainmode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of piptrainmode

load AudStimIIPARAMS
AudStimIIPARAMS.piptrainmode=get(handles.piptrainmode,'Value');
set(handles.piptrainmode,'Value',AudStimIIPARAMS.piptrainmode);
save AudStimIIPARAMS AudStimIIPARAMS
