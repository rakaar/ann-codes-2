function varargout = InterStimIntGUI(varargin)
% INTERSTIMINTGUI M-file for InterStimIntGUI.fig
%      INTERSTIMINTGUI, by itself, creates a new INTERSTIMINTGUI or raises the existing
%      singleton*.
%
%      H = INTERSTIMINTGUI returns the handle to a new INTERSTIMINTGUI or the handle to
%      the existing singleton*.
%
%      INTERSTIMINTGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INTERSTIMINTGUI.M with the given input arguments.
%
%      INTERSTIMINTGUI('Property','Value',...) creates a new INTERSTIMINTGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before InterStimIntGUI_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to InterStimIntGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help InterStimIntGUI

% Last Modified by GUIDE v2.5 22-May-2009 14:24:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @InterStimIntGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @InterStimIntGUI_OutputFcn, ...
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


% --- Executes just before InterStimIntGUI is made visible.
function InterStimIntGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to InterStimIntGUI (see VARARGIN)

% Choose default command line output for InterStimIntGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

load MFISI_PARAM

eval(sprintf('set(handles.inter_stim_int,''String'',''%6.3f'');',MFISI_PARAM.val))

% UIWAIT makes InterStimIntGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = InterStimIntGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles;



function inter_stim_int_Callback(hObject, eventdata, handles)
% hObject    handle to inter_stim_int (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of inter_stim_int as text
%        str2double(get(hObject,'String')) returns contents of inter_stim_int as a double

load MFISI_PARAM
MFISI_PARAM.val=str2double(get(hObject,'String')); %returns contents of num_pt_val as a double
set(handles.inter_stim_int,'Value',MFISI_PARAM.val);
save MFISI_PARAM MFISI_PARAM

% --- Executes during object creation, after setting all properties.
function inter_stim_int_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inter_stim_int (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ISIdone.
function ISIdone_Callback(hObject, eventdata, handles)
% hObject    handle to ISIdone (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

load MFISI_PARAM
MFISI_PARAM.val=get(handles.inter_stim_int,'Value');
save MFISI_PARAM MFISI_PARAM
load AudStimPARAMS
AudStimPARAMS.MultFrame=1;
AudStimPARAMS.MultFrameVal=MFISI_PARAM.val;
save AudStimPARAMS AudStimPARAMS
close(handles.figure1)
