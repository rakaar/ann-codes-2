function varargout = PrairiePartnerGUIRX6(varargin)
% PRAIRIEPARTNERGUI M-file for PrairiePartnerGUI.fig
%      PRAIRIEPARTNERGUI, by itself, creates a new PRAIRIEPARTNERGUI or raises the existing
%      singleton*.
%
%      H = PRAIRIEPARTNERGUI returns the handle to a new PRAIRIEPARTNERGUI or the handle to
%      the existing singleton*.
%
%      PRAIRIEPARTNERGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PRAIRIEPARTNERGUI.M with the given input arguments.
%
%      PRAIRIEPARTNERGUI('Property','Value',...) creates a new PRAIRIEPARTNERGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PrairiePartnerGUI_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PrairiePartnerGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help PrairiePartnerGUI

% Last Modified by GUIDE v2.5 07-Jul-2008 15:04:59

% Begin initialization code - DO NOT EDIT
1
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PrairiePartnerGUIRX6_OpeningFcn, ...
                   'gui_OutputFcn',  @PrairiePartnerGUIRX6_OutputFcn, ...
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


% --- Executes just before PrairiePartnerGUI is made visible.
function PrairiePartnerGUIRX6_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PrairiePartnerGUI (see VARARGIN)

% Choose default command line output for PrairiePartnerGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

interrupt_load=0;save interrupt_load interrupt_load
interrupt_estim=0;save interrupt_estim interrupt_estim
interrupt_aud=0;save interrupt_aud interrupt_aud
load PP_PARAMS
set(handles.num_file,'String',PP_PARAMS.file_number);
set(handles.num_file,'Value',PP_PARAMS.file_number);

handles.buttons_PP=[0 0 0];
% UIWAIT makes PrairiePartnerGUI wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = PrairiePartnerGUIRX6_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure

varargout{1} = handles;


% --- Executes on selection change in what_to_do.
function what_to_do_Callback(hObject, eventdata, handles)
% hObject    handle to what_to_do (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns what_to_do contents as cell array
%        contents{get(hObject,'Value')} returns selected item from what_to_do

%handles
wtd_val=get(handles.what_to_do,'Value');
switch wtd_val
    case 1
        set(handles.disp_protocol,'String','Choose what to do')
        set(handles.disp_status,'String','Nothing Chosen')
    case 2
        set(handles.disp_protocol,'String','For Dye Loading')
        set(handles.disp_status,'String','Not Started')
        PP_handles=handles;
        save Loading_handles PP_handles
        LoadingGUI
        uiresume
    case 3
        set(handles.disp_protocol,'String','For Electrical Stimulation')
        set(handles.disp_status,'String','Not Started')
        PP_handles=handles;
        save Estim_handles PP_handles
        EStimGUI
        uiresume
    case 4
        set(handles.disp_protocol,'String','For Auditory Stimulation')
        set(handles.disp_status,'String','Not Started')
        PP_handles=handles;
        save Auditory_handles PP_handles
        Auditory2PGUI
        uiresume
    case 5
        fprintf('\nAnalysis')
        Analysis2PGUI
        uiresume
    case 6
        %fprintf('\nAuditory Image + Ephys')
        set(handles.disp_protocol,'String','For Auditory Stimulation Image + Ephys')
        set(handles.disp_status,'String','Not Started')
        PP_handles=handles;
        save Auditory_handles PP_handles
        Auditory2PGUI
        uiresume
    case 7
        %fprintf('\nAuditory Ephys')
        set(handles.disp_protocol,'String','For Auditory Stimulation Ephys')
        set(handles.disp_status,'String','Not Started')
        PP_handles=handles;
        save Auditory_handles PP_handles
        Auditory2PGUI
        uiresume
    case 8
        fprintf('\nAuditory Ephys Search')
%         Analysis2PGUI
%         uiresume
    case 9
        fprintf('\nElectrical Stim Image + Ephys')
%         Analysis2PGUI
%         uiresume
    case 10
        fprintf('\nElectrical Stim + Ephys')
%         Analysis2PGUI
%         uiresume
end


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

set(hObject,'BackgroundColor',[1 0 0])
wtd_val=get(handles.what_to_do,'Value');
switch wtd_val
    case 2
        set(handles.disp_status,'String','Started Loading')
        interrupt_load=0;
        save interrupt_load interrupt_load
        load LoadingPARAMS
        [finished_loading]=prairie_load_struct(LoadingPARAMS,handles);
        if finished_loading==1
            set(handles.start_button,'BackgroundColor',[0.8314    0.8157    0.7843])
            set(handles.disp_status,'String','Done Loading')
        end
    case 3
        set(handles.disp_status,'String','Started Electrical Stimulation')
        load EstimPARAMS
        interrupt_estim=0;
        save interrupt_estim interrupt_estim
        if EstimPARAMS.frame_check==1
            [finished_stim]=prairie_estim_struct_frames(EstimPARAMS,handles);
            if finished_stim==1
                set(handles.start_button,'BackgroundColor',[0.8314    0.8157    0.7843])
                set(handles.disp_status,'String','Done Electrical Stimulation')
                load PP_PARAMS
                PP_PARAMS.type='EStim';
                PP_PARAMS.protocol=EstimPARAMS;
                load trig_inputs
                PP_PARAMS.triggers=trig_inputs; %change here if we are
                %acquiring trigger inputs
                clear trig_inputs
                PP_PARAMS.completed=1;
            else
                load PP_PARAMS
                PP_PARAMS.type='EStim';
                PP_PARAMS.protocol=EstimPARAMS;
                load trig_inputs
                PP_PARAMS.triggers=trig_inputs; %change here if we are
                %acquiring trigger inputs
                clear trig_inputs
                PP_PARAMS.completed=0;
            end
            clk=clock;dt=date;
            cd G:\MATLAB701\work\2p\DATA\PP_files
            eval(sprintf('save PP_file_%s_%i_%i_%i-%i PP_PARAMS',dt,clk(4),clk(5),fix(clk(6)),PP_PARAMS.file_number))
            cd G:\MATLAB701\work\2p\TEST
        elseif EstimPARAMS.linescan_check==1
            [finished_stim]=prairie_estim_struct_lines(EstimPARAMS,handles);
            if finished_stim==1
                set(handles.start_button,'BackgroundColor',[0.8314    0.8157    0.7843])
                set(handles.disp_status,'String','Done Electrical Stimulation')
                load PP_PARAMS
                PP_PARAMS.type='EStim';
                PP_PARAMS.protocol=EstimPARAMS;
                load trig_inputs
                PP_PARAMS.triggers=trig_inputs; %change here if we are
                %acquiring trigger inputs
                clear trig_inputs
                PP_PARAMS.completed=1;
            else
                load PP_PARAMS
                PP_PARAMS.type='EStim';
                PP_PARAMS.protocol=EstimPARAMS;
                load trig_inputs
                PP_PARAMS.triggers=trig_inputs; %change here if we are
                %acquiring trigger inputs
                clear trig_inputs
                PP_PARAMS.completed=0;
            end
            clk=clock;dt=date;
            cd G:\MATLAB701\work\2p\DATA\PP_files
            eval(sprintf('save PP_file_%s_%i_%i_%i-%i PP_PARAMS',dt,clk(4),clk(5),fix(clk(6)),PP_PARAMS.file_number))
            cd G:\MATLAB701\work\2p\TEST
        end
    case 4
        set(handles.disp_status,'String','Started Auditory Stimulation')
        
        load AudStimPARAMS
        interrupt_aud=0;
        save interrupt_aud interrupt_aud
        if AudStimPARAMS.frame_check==1
            1
            [finished_stim]=prairie_aud_struct_frames_RX6(AudStimPARAMS,handles);
            if finished_stim==1
                set(handles.start_button,'BackgroundColor',[0.8314    0.8157    0.7843])
                set(handles.disp_status,'String','Done Auditory Stimulation')
                load PP_PARAMS
                PP_PARAMS.type='AudStim';
                PP_PARAMS.protocol=AudStimPARAMS;
                load trig_inputs
                PP_PARAMS.triggers=trig_inputs; %change here if we are
                %acquiring trigger inputs
                clear trig_inputs
                load AUD_IMG_STIM
                PP_PARAMS.AUD_IMG_STIM=AUD_IMG_STIM;
                clear AUD_IMG_STIM
                PP_PARAMS.completed=1;
            else
                load PP_PARAMS
                PP_PARAMS.type='AudStim';
                PP_PARAMS.protocol=AudStimPARAMS;
                load trig_inputs
                PP_PARAMS.triggers=trig_inputs; %change here if we are
                %acquiring trigger inputs
                clear trig_inputs
                PP_PARAMS.completed=0;
            end
            clk=clock;dt=date;
            cd G:\MATLAB701\work\2p\DATA\PP_files
            eval(sprintf('save PP_file_%s_%i_%i_%i-%i PP_PARAMS',dt,clk(4),clk(5),fix(clk(6)),PP_PARAMS.file_number))
            cd G:\MATLAB701\work\2p\TEST
        elseif AudStimPARAMS.linescan_check==1
            [finished_stim]=prairie_aud_struct_lines_RX6(AudStimPARAMS,handles);
            if finished_stim==1
                set(handles.start_button,'BackgroundColor',[0.8314    0.8157    0.7843])
                set(handles.disp_status,'String','Done Auditory Stimulation')
                load PP_PARAMS
                PP_PARAMS.type='AudStim';
                PP_PARAMS.protocol=AudStimPARAMS;
                load trig_inputs
                PP_PARAMS.triggers=trig_inputs; %change here if we are
                %acquiring trigger inputs
                clear trig_inputs
                load AUD_IMG_STIM
                PP_PARAMS.AUD_IMG_STIM=AUD_IMG_STIM;
                clear AUD_IMG_STIM
                PP_PARAMS.completed=1;
            else
                load PP_PARAMS
                PP_PARAMS.type='AudStim';
                PP_PARAMS.protocol=AudStimPARAMS;
                load trig_inputs
                PP_PARAMS.triggers=trig_inputs; %change here if we are
                %acquiring trigger inputs
                clear trig_inputs
                PP_PARAMS.completed=0;
            end
            clk=clock;dt=date;
            cd G:\MATLAB701\work\2p\DATA\PP_files
            eval(sprintf('save PP_file_%s_%i_%i_%i-%i PP_PARAMS',dt,clk(4),clk(5),fix(clk(6)),PP_PARAMS.file_number))
            cd G:\MATLAB701\work\2p\TEST
        end
    case 5
        fprintf('\nStart Analysis\n')
    case 6
        set(handles.disp_status,'String','Started Auditory Stimulation')
        
        load AudStimPARAMS
        interrupt_aud=0;
        save interrupt_aud interrupt_aud
        if AudStimPARAMS.frame_check==1
            [finished_stim]=prairie_aud_struct_frames_RX6(AudStimPARAMS,handles);
            if finished_stim==1
                set(handles.start_button,'BackgroundColor',[0.8314    0.8157    0.7843])
                set(handles.disp_status,'String','Done Auditory Stimulation')
                load PP_PARAMS
                PP_PARAMS.type='AudStimImgEphys';
                PP_PARAMS.protocol=AudStimPARAMS;
                load trig_inputs
                for inums=1:length(fieldnames(trig_inputs))
                    eval(sprintf('ephysdata.iter%i=trig_inputs.iter%i(:,3);',inums,inums))
                    eval(sprintf('trig_inputs.iter%i=trig_inputs.iter%i(:,1:2);',inums,inums))
                end
                PP_PARAMS.triggers=trig_inputs; %change here if we are    
                %acquiring trigger inputs
                clear trig_inputs
                load AUD_IMG_STIM
                PP_PARAMS.AUD_IMG_STIM=AUD_IMG_STIM;
                clear AUD_IMG_STIM
                PP_PARAMS.completed=1;
            else
                load PP_PARAMS
                PP_PARAMS.type='AudStimImgEphys';
                PP_PARAMS.protocol=AudStimPARAMS;
                PP_PARAMS.completed=0;
            end
            clk=clock;dt=date;
            cd G:\MATLAB701\work\2p\DATA\PP_files
            eval(sprintf('save PP_file_%s_%i_%i_%i-%i PP_PARAMS',dt,clk(4),clk(5),fix(clk(6)),PP_PARAMS.file_number))
            cd G:\MATLAB701\work\2p\TEST
            if PP_PARAMS.completed==1
                cd G:\MATLAB701\work\2p\DATA\EPHYSDATA
                eval(sprintf('save EPhys_data_%s_%i_%i_%i-%i ephysdata',dt,clk(4),clk(5),fix(clk(6)),PP_PARAMS.file_number))
                cd G:\MATLAB701\work\2p\TEST
            end
        elseif AudStimPARAMS.linescan_check==1
            [finished_stim]=prairie_aud_struct_lines_RX6(AudStimPARAMS,handles);
            if finished_stim==1
                set(handles.start_button,'BackgroundColor',[0.8314    0.8157    0.7843])
                set(handles.disp_status,'String','Done Auditory Stimulation')
                load PP_PARAMS
                PP_PARAMS.type='AudStimImgEphys';
                PP_PARAMS.protocol=AudStimPARAMS;
                PP_PARAMS.completed=1;
            else
                load PP_PARAMS
                PP_PARAMS.type='AudStimImgEphys';
                PP_PARAMS.protocol=AudStimPARAMS;
                PP_PARAMS.completed=0;
            end
            clk=clock;dt=date;
            cd G:\MATLAB701\work\2p\DATA\PP_files
            eval(sprintf('save PP_file_%s_%i_%i_%i-%i PP_PARAMS',dt,clk(4),clk(5),fix(clk(6)),PP_PARAMS.file_number))
            cd G:\MATLAB701\work\2p\TEST
        end
    case 7
        set(handles.disp_status,'String','Started Auditory Stimulation')
        
        load AudStimPARAMS
        interrupt_aud=0;
        save interrupt_aud interrupt_aud
        1
            [finished_stim]=prairie_aud_struct(AudStimPARAMS,handles);
            if finished_stim==1
                set(handles.start_button,'BackgroundColor',[0.8314    0.8157    0.7843])
                set(handles.disp_status,'String','Done Auditory Stimulation')
                load PP_PARAMS
                PP_PARAMS.type='AudStimImgEphys';
                PP_PARAMS.protocol=AudStimPARAMS;
                load trig_inputs
                ephysdata=trig_inputs;
                PP_PARAMS.triggers=[]; %change here if we are    
                %acquiring trigger inputs
                clear trig_inputs
                load AUD_IMG_STIM
                PP_PARAMS.AUD_IMG_STIM=AUD_IMG_STIM;
                clear AUD_IMG_STIM
                PP_PARAMS.completed=1;
            else
                load PP_PARAMS
                PP_PARAMS.type='AudStimImgEphys';
                PP_PARAMS.protocol=AudStimPARAMS;
                PP_PARAMS.completed=0;
            end
            clk=clock;dt=date;
            cd G:\MATLAB701\work\2p\DATA\PP_files
            eval(sprintf('save PP_file_%s_%i_%i_%i-%i PP_PARAMS',dt,clk(4),clk(5),fix(clk(6)),PP_PARAMS.file_number))
            cd G:\MATLAB701\work\2p\TEST
            if PP_PARAMS.completed==1
                cd G:\MATLAB701\work\2p\DATA\EPHYSDATA
                eval(sprintf('save EPhys_data_%s_%i_%i_%i-%i ephysdata',dt,clk(4),clk(5),fix(clk(6)),PP_PARAMS.file_number))
                cd G:\MATLAB701\work\2p\TEST
            end
end
       
uiresume

% --- Executes on button press in exit_button.
function exit_button_Callback(hObject, eventdata, handles)
% hObject    handle to exit_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

daqreset
wtd_val=get(handles.what_to_do,'Value');
switch wtd_val
    case 2
        interrupt_load=1;
        save interrupt_load interrupt_load
    case 3
        interrupt_estim=1;
        save interrupt_estim interrupt_estim
    case 4
        interrupt_aud=1;
        save interrupt_aud interrupt_aud
end
        
close(handles.figure1)
uiresume

% --- Executes on button press in stop_button.
function stop_button_Callback(hObject, eventdata, handles)
% hObject    handle to stop_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.start_button,'BackgroundColor',[0.8314    0.8157    0.7843])
daqreset
wtd_val=get(handles.what_to_do,'Value');
switch wtd_val
    case 2
        interrupt_load=1;
        save interrupt_load interrupt_load
    case 3
        interrupt_estim=1;
        save interrupt_estim interrupt_estim
    case 4
        interrupt_aud=1;
        save interrupt_aud interrupt_aud
end

uiresume





function num_file_Callback(hObject, eventdata, handles)
% hObject    handle to num_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of num_file as text
%        str2double(get(hObject,'String')) returns contents of num_file as a double

load PP_PARAMS
%handles
%eval(sprintf('set(handles.num_file,''String'',''%i'');',PP_PARAMS.file_number))
fnum=str2num(get(handles.num_file,'String'));
PP_PARAMS.file_number=fnum;
set(handles.num_file,'String',PP_PARAMS.file_number)
set(handles.num_file,'Value',PP_PARAMS.file_number)
save PP_PARAMS PP_PARAMS
uiresume

% --- Executes during object creation, after setting all properties.
function num_file_CreateFcn(hObject, eventdata, handles)
% hObject    handle to num_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


