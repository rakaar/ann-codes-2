function varargout = PeriodicRandomGUI(varargin)
% PERIODICRANDOMGUI MATLAB code for PeriodicRandomGUI.fig
%      PERIODICRANDOMGUI, by itself, creates a new PERIODICRANDOMGUI or raises the existing
%      singleton*.
%
%      H = PERIODICRANDOMGUI returns the handle to a new PERIODICRANDOMGUI or the handle to
%      the existing singleton*.
%
%      PERIODICRANDOMGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PERIODICRANDOMGUI.M with the given input arguments.
%
%      PERIODICRANDOMGUI('Property','Value',...) creates a new PERIODICRANDOMGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PeriodicRandomGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PeriodicRandomGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PeriodicRandomGUI

% Last Modified by GUIDE v2.5 08-Apr-2022 11:18:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PeriodicRandomGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @PeriodicRandomGUI_OutputFcn, ...
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


% --- Executes just before PeriodicRandomGUI is made visible.
function PeriodicRandomGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PeriodicRandomGUI (see VARARGIN)

% Choose default command line output for PeriodicRandomGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
load PERRANDPARAMS
cd (curdir)

%%%%%%%%%%% CURRENT INITIAL SET OF PARAMS SB, 01042022
%           num_tones: 2
%               freq1: 8500
%               freq2: 12000
%               freq3: 0
%               
%              
%               tdur1: 0.0500
%               tdur2: 0.0500
%               tdur3: 0
%               
%             sil_dur: 0.2500
%            db_atten: 20
%        ntoks_period: 3
%           total_dur: 4
%     n_periods_trial: 3
%          stim_start: 0.5000
%          total_reps: 6
%

%%%%ann
eval(sprintf('set(handles.num_tones,''String'',''%i'');',PERRANDPARAMS.num_tones))
set(handles.num_tones,'Value',PERRANDPARAMS.num_tones);
eval(sprintf('set(handles.freq1,''String'',''%6.3f'');',PERRANDPARAMS.freq1))
set(handles.freq1,'Value',PERRANDPARAMS.freq1);
eval(sprintf('set(handles.freq1,''String'',''%6.3f'');',PERRANDPARAMS.freq2))
set(handles.freq2,'Value',PERRANDPARAMS.freq2);
eval(sprintf('set(handles.freq1,''String'',''%6.3f'');',PERRANDPARAMS.freq3))
set(handles.freq3,'Value',PERRANDPARAMS.freq3);
eval(sprintf('set(handles.tdur1,''String'',''%6.6f'');',PERRANDPARAMS.tdur1))
set(handles.tdur1,'Value',PERRANDPARAMS.tdur1);
eval(sprintf('set(handles.tdur2,''String'',''%6.6f'');',PERRANDPARAMS.tdur2))
set(handles.tdur2,'Value',PERRANDPARAMS.tdur2);
eval(sprintf('set(handles.tdur3,''String'',''%6.6f'');',PERRANDPARAMS.tdur3))
set(handles.tdur3,'Value',PERRANDPARAMS.tdur3);
eval(sprintf('set(handles.total_dur,''String'',''%6.6f'');',PERRANDPARAMS.total_dur))
set(handles.total_dur,'Value',PERRANDPARAMS.total_dur);
eval(sprintf('set(handles.stim_start,''String'',''%6.6f'');',PERRANDPARAMS.stim_start))
set(handles.stim_start,'Value',PERRANDPARAMS.stim_start);
eval(sprintf('set(handles.sil_dur,''String'',''%6.6f'');',PERRANDPARAMS.sil_dur))
set(handles.sil_dur,'Value',PERRANDPARAMS.sil_dur);
eval(sprintf('set(handles.sil_dur,''String'',''%6.6f'');',PERRANDPARAMS.sil_dur))
set(handles.sil_dur,'Value',PERRANDPARAMS.sil_dur);
eval(sprintf('set(handles.db_atten,''String'',''%i'');',PERRANDPARAMS.db_atten))
set(handles.db_atten,'Value',PERRANDPARAMS.db_atten);
eval(sprintf('set(handles.ntoks_period,''String'',''%i'');',PERRANDPARAMS.ntoks_period))
set(handles.ntoks_period,'Value',PERRANDPARAMS.ntoks_period);
eval(sprintf('set(handles.n_periods_trial,''String'',''%i'');',PERRANDPARAMS.n_periods_trial))
set(handles.n_periods_trial,'Value',PERRANDPARAMS.n_periods_trial);
eval(sprintf('set(handles.total_reps,''String'',''%i'');',PERRANDPARAMS.total_reps))
set(handles.total_reps,'Value',PERRANDPARAMS.total_reps);

%%% ann


% UIWAIT makes PeriodicRandomGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = PeriodicRandomGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles;



function num_tones_Callback(hObject, eventdata, handles)
% hObject    handle to num_tones (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of num_tones as text
%        str2double(get(hObject,'String')) returns contents of num_tones as a double
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
load PERRANDPARAMS
cd (curdir)

PERRANDPARAMS.num_tones=str2double(get(hObject,'String')); %returns contents of num_tones as a double
set(handles.num_tones,'Value',PERRANDPARAMS.num_tones);

curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save PERRANDPARAMS PERRANDPARAMS
cd (curdir)

% --- Executes during object creation, after setting all properties.
function num_tones_CreateFcn(hObject, eventdata, handles)
% hObject    handle to num_tones (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in which_tone_properties.
% function which_tone_properties_Callback(hObject, eventdata, handles)
% % hObject    handle to which_tone_properties (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hints: contents = cellstr(get(hObject,'String')) returns which_tone_properties contents as cell array
% %        contents{get(hObject,'Value')} returns selected item from which_tone_properties
% 
% 
% % --- Executes during object creation, after setting all properties.
% function which_tone_properties_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to which_tone_properties (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: popupmenu controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end
% 


function freq1_Callback(hObject, eventdata, handles)
% hObject    handle to freq1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of freq1 as text
%        str2double(get(hObject,'String')) returns contents of freq1 as a double
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
load PERRANDPARAMS
cd (curdir)

PERRANDPARAMS.freq1=str2double(get(hObject,'String')); %returns contents of num_tones as a double
set(handles.freq1,'Value',PERRANDPARAMS.freq1);

curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save PERRANDPARAMS PERRANDPARAMS
cd (curdir)

% --- Executes during object creation, after setting all properties.
function freq1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to freq1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function freq2_Callback(hObject, eventdata, handles)
% hObject    handle to freq2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of freq2 as text
%        str2double(get(hObject,'String')) returns contents of freq2 as a double
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
load PERRANDPARAMS
cd (curdir)

PERRANDPARAMS.freq2=str2double(get(hObject,'String')); %returns contents of num_tones as a double
set(handles.freq2,'Value',PERRANDPARAMS.freq2);

curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save PERRANDPARAMS PERRANDPARAMS
cd (curdir)

% --- Executes during object creation, after setting all properties.
function freq2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to freq2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function freq3_Callback(hObject, eventdata, handles)
% hObject    handle to freq3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of freq3 as text
%        str2double(get(hObject,'String')) returns contents of freq3 as a double
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
load PERRANDPARAMS
cd (curdir)

PERRANDPARAMS.freq3=str2double(get(hObject,'String')); %returns contents of num_tones as a double
set(handles.freq3,'Value',PERRANDPARAMS.freq3);

curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save PERRANDPARAMS PERRANDPARAMS
cd (curdir)

% --- Executes during object creation, after setting all properties.
function freq3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to freq3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% 
% function freq4_Callback(hObject, eventdata, handles)
% % hObject    handle to freq4 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hints: get(hObject,'String') returns contents of freq4 as text
% %        str2double(get(hObject,'String')) returns contents of freq4 as a double
% 
% 
% % --- Executes during object creation, after setting all properties.
% function freq4_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to freq4 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: edit controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end
% 
% 
% 
% function freq5_Callback(hObject, eventdata, handles)
% % hObject    handle to freq5 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hints: get(hObject,'String') returns contents of freq5 as text
% %        str2double(get(hObject,'String')) returns contents of freq5 as a double
% 
% 
% % --- Executes during object creation, after setting all properties.
% function freq5_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to freq5 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: edit controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end
% 
% 
% 
% function freq6_Callback(hObject, eventdata, handles)
% % hObject    handle to freq6 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hints: get(hObject,'String') returns contents of freq6 as text
% %        str2double(get(hObject,'String')) returns contents of freq6 as a double
% 
% 
% % --- Executes during object creation, after setting all properties.
% function freq6_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to freq6 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: edit controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end
% 
% 
% 
% function freq7_Callback(hObject, eventdata, handles)
% % hObject    handle to freq7 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hints: get(hObject,'String') returns contents of freq7 as text
% %        str2double(get(hObject,'String')) returns contents of freq7 as a double
% 
% 
% % --- Executes during object creation, after setting all properties.
% function freq7_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to freq7 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: edit controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end
% 
% 
% 
% function freq8_Callback(hObject, eventdata, handles)
% % hObject    handle to freq8 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hints: get(hObject,'String') returns contents of freq8 as text
% %        str2double(get(hObject,'String')) returns contents of freq8 as a double
% 
% 
% % --- Executes during object creation, after setting all properties.
% function freq8_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to freq8 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: edit controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end



function tdur1_Callback(hObject, eventdata, handles)
% hObject    handle to tdur1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tdur1 as text
%        str2double(get(hObject,'String')) returns contents of tdur1 as a double
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
load PERRANDPARAMS
cd (curdir)

PERRANDPARAMS.tdur1=str2double(get(hObject,'String')); %returns contents of num_tones as a double
set(handles.tdur1,'Value',PERRANDPARAMS.tdur1);

curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save PERRANDPARAMS PERRANDPARAMS
cd (curdir)

% --- Executes during object creation, after setting all properties.
function tdur1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tdur1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tdur2_Callback(hObject, eventdata, handles)
% hObject    handle to tdur2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tdur2 as text
%        str2double(get(hObject,'String')) returns contents of tdur2 as a double
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
load PERRANDPARAMS
cd (curdir)

PERRANDPARAMS.tdur2=str2double(get(hObject,'String')); %returns contents of num_tones as a double
set(handles.tdur2,'Value',PERRANDPARAMS.tdur2);

curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save PERRANDPARAMS PERRANDPARAMS
cd (curdir)

% --- Executes during object creation, after setting all properties.
function tdur2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tdur2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tdur3_Callback(hObject, eventdata, handles)
% hObject    handle to tdur3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tdur3 as text
%        str2double(get(hObject,'String')) returns contents of tdur3 as a double
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
load PERRANDPARAMS
cd (curdir)

PERRANDPARAMS.tdur3=str2double(get(hObject,'String')); %returns contents of num_tones as a double
set(handles.tdur3,'Value',PERRANDPARAMS.tdur3);

curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save PERRANDPARAMS PERRANDPARAMS
cd (curdir)

% --- Executes during object creation, after setting all properties.
function tdur3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tdur3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% 
% 
% function tdur4_Callback(hObject, eventdata, handles)
% % hObject    handle to tdur4 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hints: get(hObject,'String') returns contents of tdur4 as text
% %        str2double(get(hObject,'String')) returns contents of tdur4 as a double
% 
% 
% % --- Executes during object creation, after setting all properties.
% function tdur4_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to tdur4 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: edit controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end
% 
% 
% 
% function tdur5_Callback(hObject, eventdata, handles)
% % hObject    handle to tdur5 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hints: get(hObject,'String') returns contents of tdur5 as text
% %        str2double(get(hObject,'String')) returns contents of tdur5 as a double
% 
% 
% % --- Executes during object creation, after setting all properties.
% function tdur5_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to tdur5 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: edit controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end
% 
% 
% 
% function tdur6_Callback(hObject, eventdata, handles)
% % hObject    handle to tdur6 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hints: get(hObject,'String') returns contents of tdur6 as text
% %        str2double(get(hObject,'String')) returns contents of tdur6 as a double
% 
% 
% % --- Executes during object creation, after setting all properties.
% function tdur6_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to tdur6 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: edit controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end
% 
% 
% 
% function tdur7_Callback(hObject, eventdata, handles)
% % hObject    handle to tdur7 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hints: get(hObject,'String') returns contents of tdur7 as text
% %        str2double(get(hObject,'String')) returns contents of tdur7 as a double
% 
% 
% % --- Executes during object creation, after setting all properties.
% function tdur7_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to tdur7 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: edit controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end
% 
% 
% 
% function tdur8_Callback(hObject, eventdata, handles)
% % hObject    handle to tdur8 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hints: get(hObject,'String') returns contents of tdur8 as text
% %        str2double(get(hObject,'String')) returns contents of tdur8 as a double
% 
% 
% % --- Executes during object creation, after setting all properties.
% function tdur8_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to tdur8 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: edit controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end



function sil_dur_Callback(hObject, eventdata, handles)
% hObject    handle to sil_dur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sil_dur as text
%        str2double(get(hObject,'String')) returns contents of sil_dur as a double

curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
load PERRANDPARAMS
cd (curdir)

PERRANDPARAMS.sil_dur=str2double(get(hObject,'String')); %returns contents of num_tones as a double
set(handles.sil_dur,'Value',PERRANDPARAMS.sil_dur);

curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save PERRANDPARAMS PERRANDPARAMS
cd (curdir)

% --- Executes during object creation, after setting all properties.
function sil_dur_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sil_dur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function db_atten_Callback(hObject, eventdata, handles)
% hObject    handle to db_atten (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of db_atten as text
%        str2double(get(hObject,'String')) returns contents of db_atten as a double
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
load PERRANDPARAMS
cd (curdir)

PERRANDPARAMS.db_atten=str2double(get(hObject,'String')); %returns contents of num_tones as a double
set(handles.db_atten,'Value',PERRANDPARAMS.db_atten);

curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save PERRANDPARAMS PERRANDPARAMS
cd (curdir)

% --- Executes during object creation, after setting all properties.
function db_atten_CreateFcn(hObject, eventdata, handles)
% hObject    handle to db_atten (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ntoks_period_Callback(hObject, eventdata, handles)
% hObject    handle to ntoks_period (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ntoks_period as text
%        str2double(get(hObject,'String')) returns contents of ntoks_period as a double
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
load PERRANDPARAMS
cd (curdir)

PERRANDPARAMS.ntoks_period=str2double(get(hObject,'String')); %returns contents of num_tones as a double
set(handles.ntoks_period,'Value',PERRANDPARAMS.ntoks_period);

curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save PERRANDPARAMS PERRANDPARAMS
cd (curdir)


% --- Executes during object creation, after setting all properties.
function ntoks_period_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ntoks_period (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function total_dur_Callback(hObject, eventdata, handles)
% hObject    handle to total_dur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of total_dur as text
%        str2double(get(hObject,'String')) returns contents of total_dur as a double
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
load PERRANDPARAMS
cd (curdir)

PERRANDPARAMS.total_dur=str2double(get(hObject,'String')); %returns contents of num_tones as a double
set(handles.total_dur,'Value',PERRANDPARAMS.total_dur);

curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save PERRANDPARAMS PERRANDPARAMS
cd (curdir)


% --- Executes during object creation, after setting all properties.
function total_dur_CreateFcn(hObject, eventdata, handles)
% hObject    handle to total_dur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function n_periods_trial_Callback(hObject, eventdata, handles)
% hObject    handle to n_periods_trial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of n_periods_trial as text
%        str2double(get(hObject,'String')) returns contents of n_periods_trial as a double

curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
load PERRANDPARAMS
cd (curdir)

PERRANDPARAMS.n_periods_trial=str2double(get(hObject,'String')); %returns contents of num_tones as a double
set(handles.n_periods_trial,'Value',PERRANDPARAMS.n_periods_trial);

curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save PERRANDPARAMS PERRANDPARAMS
cd (curdir)
% --- Executes during object creation, after setting all properties.
function n_periods_trial_CreateFcn(hObject, eventdata, handles)
% hObject    handle to n_periods_trial (see GCBO)
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
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
load PERRANDPARAMS
cd (curdir)

PERRANDPARAMS.stim_start=str2double(get(hObject,'String')); %returns contents of num_tones as a double
set(handles.stim_start,'Value',PERRANDPARAMS.stim_start);

curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save PERRANDPARAMS PERRANDPARAMS
cd (curdir)

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

curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
load PERRANDPARAMS
cd (curdir)

PERRANDPARAMS.total_reps=str2double(get(hObject,'String')); %returns contents of num_tones as a double
set(handles.total_reps,'Value',PERRANDPARAMS.total_reps);

curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save PERRANDPARAMS PERRANDPARAMS
cd (curdir)


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


load PERRANDPARAMS

 PERRANDPARAMS.frame_dur=get(handles.frame_dur,'Value');fdur=PERRANDPARAMS.frame_dur;
PERRANDPARAMS.total_frames_lines=get(handles.total_frames_lines,'Value');tfl=PERRANDPARAMS.total_frames_lines;

PERRANDPARAMS.stim_start=get(handles.stim_start,'Value');sf=PERRANDPARAMS.stim_start;
PERRANDPARAMS.num_tones=get(handles.num_tones,'Value');num_tones=PERRANDPARAMS.num_tones;
PERRANDPARAMS.freq1=get(handles.freq1,'Value');freq1=PERRANDPARAMS.freq1;
PERRANDPARAMS.freq2=get(handles.freq2,'Value');freq2=PERRANDPARAMS.freq2;
PERRANDPARAMS.freq3=get(handles.freq3,'Value');freq3=PERRANDPARAMS.freq3;

PERRANDPARAMS.tdur1=get(handles.tdur1,'Value');tdur1=PERRANDPARAMS.tdur1;
PERRANDPARAMS.tdur2=get(handles.tdur2,'Value');tdur2=PERRANDPARAMS.tdur2;
PERRANDPARAMS.tdur3=get(handles.tdur3,'Value');tdur3=PERRANDPARAMS.tdur3;

PERRANDPARAMS.sil_dur=get(handles.sil_dur,'Value');sil_dur=PERRANDPARAMS.sil_dur;
PERRANDPARAMS.db_atten=get(handles.db_atten,'Value');db_atten=PERRANDPARAMS.db_atten;

PERRANDPARAMS.sil_dur=get(handles.sil_dur,'Value');sil_dur=PERRANDPARAMS.sil_dur;
PERRANDPARAMS.db_atten=get(handles.db_atten,'Value');db_atten=PERRANDPARAMS.db_atten;
PERRANDPARAMS.ntoks_period=get(handles.ntoks_period,'Value');ntoks_period=PERRANDPARAMS.ntoks_period;
PERRANDPARAMS.tot_dur=get(handles.tot_dur,'Value');tot_dur=PERRANDPARAMS.tot_dur;
PERRANDPARAMS.n_period_trial=get(handles.n_period_trial,'Value');n_period_trial=PERRANDPARAMS.n_period_trial;
PERRANDPARAMS.total_reps=get(handles.total_reps,'Value');total_reps=PERRANDPARAMS.total_reps;



curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save PERRANDPARAMS PERRANDPARAMS
cd (curdir)

load AudStimPARAMS
AudStimPARAMS.type='PERRAND';
AudStimPARAMS.stim_protocol=PERRANDPARAMS;

close(handles.figure1)
total_prairie_iterations=total_reps;
each_prairie_dur=tfl*fdur;

eval(sprintf('itercheck_str=''Set PAIRIE Number of ITERATIONS to AT LEAST %i'';',total_prairie_iterations))
load PER_RAND_handles
set(AA_handles.check_disp,'String',display_str)
    set(AA_handles.check_disp,'BackgroundColor',disp_bgcolor)
    set(AA_handles.check_disp,'FontSize',9)
    eval(sprintf('prot_str=per rand stim:with %i dB atten, Starts at frame/line %i'';',atten,sf))
    set(AA_handles.disp_protocol,'String',prot_str)
    
AudStimPARAMS.protocol_str=prot_str;
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save AudStimPARAMS AudStimPARAMS
cd (curdir)
%save AudStimPARAMS AudStimPARAMS


