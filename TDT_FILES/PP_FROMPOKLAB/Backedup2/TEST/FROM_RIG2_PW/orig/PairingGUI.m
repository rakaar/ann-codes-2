function varargout = PairingGUI(varargin)
% PAIRINGGUI M-file for PairingGUI.fig
%      PAIRINGGUI, by itself, creates a new PAIRINGGUI or raises the existing
%      singleton*.
%
%      H = PAIRINGGUI returns the handle to a new PAIRINGGUI or the handle to
%      the existing singleton*.
%
%      PAIRINGGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PAIRINGGUI.M with the given input arguments.
%
%      PAIRINGGUI('Property','Value',...) creates a new PAIRINGGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PairingGUI_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PairingGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help PairingGUI

% Last Modified by GUIDE v2.5 03-Aug-2009 10:15:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PairingGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @PairingGUI_OutputFcn, ...
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


% --- Executes just before PairingGUI is made visible.
function PairingGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PairingGUI (see VARARGIN)

% Choose default command line output for PairingGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

load PairingPARAMS
load Pairing_handles

eval(sprintf('set(handles.Pair_reps,''String'',''%i'');',PairingPARAMS.Pair_reps))
set(handles.Pair_reps,'Value',PairingPARAMS.Pair_reps);


% UIWAIT makes PairingGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = PairingGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles;


% --- Executes on button press in Auditory_button.
function Auditory_button_Callback(hObject, eventdata, handles)
% hObject    handle to Auditory_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Auditory2PGUI

% --- Executes on button press in Electrical_button.
function Electrical_button_Callback(hObject, eventdata, handles)
% hObject    handle to Electrical_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

EStimGUI


function Pair_reps_Callback(hObject, eventdata, handles)
% hObject    handle to Pair_reps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Pair_reps as text
%        str2double(get(hObject,'String')) returns contents of Pair_reps as a double

load PairingPARAMS
PairingPARAMS.Pair_reps=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.Pair_reps,'Value',PairingPARAMS.Pair_reps);
save PairingPARAMS PairingPARAMS

% --- Executes during object creation, after setting all properties.
function Pair_reps_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Pair_reps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Pair_Done_button.
function Pair_Done_button_Callback(hObject, eventdata, handles)
% hObject    handle to Pair_Done_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

load PairingPARAMS
PairingPARAMS.Pair_reps=get(handles.Pair_reps,'Value');
load AudStimPARAMS
PairingPARAMS.AUD=AudStimPARAMS;
load EStimPARAMS
PairingPARAMS.ELEC=EstimPARAMS;
save PairingPARAMS PairingPARAMS

close(handles.figure1)
