function varargout = rudi_osci(varargin)
% RUDI_OSCI MATLAB code for rudi_osci.fig
%      RUDI_OSCI, by itself, creates a new RUDI_OSCI or raises the existing
%      singleton*.
%
%      H = RUDI_OSCI returns the handle to a new RUDI_OSCI or the handle to
%      the existing singleton*.
%
%      RUDI_OSCI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RUDI_OSCI.M with the given input arguments.
%
%      RUDI_OSCI('Property','Value',...) creates a new RUDI_OSCI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before rudi_osci_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to rudi_osci_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help rudi_osci

% Last Modified by GUIDE v2.5 14-Feb-2013 19:19:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @rudi_osci_OpeningFcn, ...
                   'gui_OutputFcn',  @rudi_osci_OutputFcn, ...
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


% --- Executes just before rudi_osci is made visible.
function rudi_osci_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to rudi_osci (see VARARGIN)

% Choose default command line output for rudi_osci
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes rudi_osci wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = rudi_osci_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

oscirunning=get(hObject,'Value')
if oscirunning==0
    SS.release();
    close(handles.figure1)
    return
else
    
    SS=daq.createSession('ni');
    SS.addAnalogInputChannel('dev1',0,'Voltage');
    SS.Rate=10000;
    while oscirunning==1
        
        [captureddata,times]=SS.startForeground();
        axrp=handles.axes1;
        plot(axrp,times,captureddata);
        drawnow
        pause(0.05)
    end
     SS.release();
end
        
    
