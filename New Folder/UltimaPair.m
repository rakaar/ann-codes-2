function varargout = UltimaPair(varargin)
% ULTIMAPAIR M-file for UltimaPair.fig
%      ULTIMAPAIR, by itself, creates a new ULTIMAPAIR or raises the existing
%      singleton*.
%
%      H = ULTIMAPAIR returns the handle to a new ULTIMAPAIR or the handle to
%      the existing singleton*.
%
%      ULTIMAPAIR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ULTIMAPAIR.M with the given input arguments.
%
%      ULTIMAPAIR('Property','Value',...) creates a new ULTIMAPAIR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before UltimaPair_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to UltimaPair_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help UltimaPair

% Last Modified by GUIDE v2.5 01-Jul-2008 16:06:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @UltimaPair_OpeningFcn, ...
                   'gui_OutputFcn',  @UltimaPair_OutputFcn, ...
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


% --- Executes just before UltimaPair is made visible.
function UltimaPair_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to UltimaPair (see VARARGIN)

% Choose default command line output for UltimaPair
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes UltimaPair wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = UltimaPair_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in what_to_do.
function what_to_do_Callback(hObject, eventdata, handles)
% hObject    handle to what_to_do (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns what_to_do contents as cell array
%        contents{get(hObject,'Value')} returns selected item from what_to_do


% --- Executes during object creation, after setting all properties.
function what_to_do_CreateFcn(hObject, eventdata, handles)
% hObject    handle to what_to_do (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in start_button.
function start_button_Callback(hObject, eventdata, handles)
% hObject    handle to start_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in exit_button.
function exit_button_Callback(hObject, eventdata, handles)
% hObject    handle to exit_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in stop_button.
function stop_button_Callback(hObject, eventdata, handles)
% hObject    handle to stop_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


