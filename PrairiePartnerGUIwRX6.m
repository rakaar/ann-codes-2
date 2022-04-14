function varargout = PrairiePartnerGUIwRX6(varargin)
% PRAIRIEPARTNERGUIWRX6 M-file for PrairiePartnerGUIwRX6.fig
%      PRAIRIEPARTNERGUIWRX6, by itself, creates a new PRAIRIEPARTNERGUIWRX6 or raises the existing
%      singleton*.
%
%      H = PRAIRIEPARTNERGUIWRX6 returns the handle to a new PRAIRIEPARTNERGUIWRX6 or the handle to
%      the existing singleton*.
%
%      PRAIRIEPARTNERGUIWRX6('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PRAIRIEPARTNERGUIWRX6.M with the given input arguments.
%
%      PRAIRIEPARTNERGUIWRX6('Property','Value',...) creates a new PRAIRIEPARTNERGUIWRX6 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PrairiePartnerGUIwRX6_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PrairiePartnerGUIwRX6_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help PrairiePartnerGUIwRX6

% Last Modified by GUIDE v2.5 04-May-2009 16:56:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PrairiePartnerGUIwRX6_OpeningFcn, ...
                   'gui_OutputFcn',  @PrairiePartnerGUIwRX6_OutputFcn, ...
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


% --- Executes just before PrairiePartnerGUIwRX6 is made visible.
function PrairiePartnerGUIwRX6_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PrairiePartnerGUIwRX6 (see VARARGIN)

% Choose default command line output for PrairiePartnerGUIwRX6
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

interrupt_load=0;save interrupt_load interrupt_load
interrupt_estim=0;save interrupt_estim interrupt_estim
interrupt_aud=0;save interrupt_aud interrupt_aud
interrupt_opto=0; save interrupt_opto interrupt_opto
load PP_PARAMS
set(handles.num_file,'String',PP_PARAMS.file_number);
set(handles.num_file,'Value',PP_PARAMS.file_number);

handles.buttons_PP=[0 0 0];

% UIWAIT makes PrairiePartnerGUIwRX6 wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = PrairiePartnerGUIwRX6_OutputFcn(hObject, eventdata, handles) 
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
        %fprintf('\nElectrical Stim + Ephys')
        set(handles.disp_protocol,'String','For Electrical Stimulation Ephys')
        set(handles.disp_status,'String','Not Started')
        PP_handles=handles;
        save Estim_handles PP_handles
        EStimGUI
        uiresume
%         Analysis2PGUI
%         uiresume
    case 11
        set(handles.disp_protocol,'String','Intrinsic Imaging with Auditory Stimulation')
        set(handles.disp_status,'String','Not Started')
        PP_handles=handles;
        save AuditoryII_handles PP_handles
        AuditoryIntrinsicGUI
        uiresume
    case 12
        set(handles.disp_protocol,'String','Electrical Stim Pairing with Auditory Stimulation')
        set(handles.disp_status,'String','Not Started')
        PP_handles=handles;
        save Pairing_handles PP_handles
        save Auditory_handles PP_handles
        save Estim_handles PP_handles
        PairingGUI
        uiresume
    case 13
        set(handles.disp_protocol,'String','Time Course of E-Stim Pairing with Aud Stim (2-tones)')
        set(handles.disp_status,'String','Not Started')
        PP_handles=handles;
        save PairingTC_handles PP_handles
        save AuditoryTC_handles PP_handles
        save EstimTC_handles PP_handles
        PairingTimeCourseGUI
        load Pairing_TC_PARAMS
        set(handles.disp_protocol,'String',Pairing_TC_PARAMS.protocol_str)
        clear Pairing_TC_PARAMS
        uiresume
    case 14
        set(handles.disp_protocol,'String','Visual Stimulation with LED (w/ or w/o E or A Pair) for Ephys')
        set(handles.disp_status,'String','Not Started')
        PP_handles=handles;
        save VisualLED_handles PP_handles
        load VisLEDStimPARAMS
        if VisLEDStimPARAMS.check_avp==1
            save Auditory_handles PP_handles
        end
       
        VisualLEDStimGUI
        load VisLEDStimPARAMS
        %set(handles.disp_protocol,'String',VisLEDStimPARAMS.protocol_str)
        clear VisLEDStimPARAMS
        uiresume
    case 15
        set(handles.disp_protocol,'String','Optogenetic Stimulation for Ephys')
        set(handles.disp_status,'String','Not Started')
        PP_handles=handles;
        save Opto_handles PP_handles
        load OptoParams
        if OptoParams.check_auditory==1
               save Auditory_handles PP_handles
        end
        OptoGui
        load OptoParams
        %set(handles.disp_protocol,'String',VisLEDStimPARAMS.protocol_str)
        clear OptoParams
        uiresume
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
            %1
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
        %1
%         if length(AudStimPARAMS.type)==4
%             if AudStimPARAMS.type=='MSEQ';
%                 1
%                 [finished_stim]=prairie_aud_struct_RX6_L(AudStimPARAMS,handles);
%             else
%                 [finished_stim]=prairie_aud_struct_RX6(AudStimPARAMS,handles);
%             end
%         else
%             [finished_stim]=prairie_aud_struct_RX6(AudStimPARAMS,handles);
%         end
           [finished_stim,AudStimPARAMS]=prairie_aud_struct_RX6(AudStimPARAMS,handles);
            if finished_stim==1
                set(handles.start_button,'BackgroundColor',[0.8314    0.8157    0.7843])
                set(handles.disp_status,'String','Done Auditory Stimulation')
                load PP_PARAMS
                PP_PARAMS.type='AudStimEphys';
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
                PP_PARAMS.type='AudStimEphys';
                PP_PARAMS.protocol=AudStimPARAMS;
                PP_PARAMS.completed=0;
            end
            clk=clock;dt=date;
            cd C:\EXPERIMENTS\DATA\EPHYS\PP_files
            eval(sprintf('save PP_file_%s_%i_%i_%i-%i PP_PARAMS',dt,clk(4),clk(5),fix(clk(6)),PP_PARAMS.file_number))
            cd C:\EXPERIMENTS\CODES
            if PP_PARAMS.completed==1
                cd C:\EXPERIMENTS\DATA\EPHYS\EP_files
                eval(sprintf('save EPhys_data_%s_%i_%i_%i-%i ephysdata PP_PARAMS',dt,clk(4),clk(5),fix(clk(6)),PP_PARAMS.file_number))
                cd C:\EXPERIMENTS\CODES
            end
    case 10
        set(handles.disp_status,'String','Started Electrical Stimulation')
        
        load EstimPARAMS
        interrupt_estim=0;
        save interrupt_estim interrupt_estim
        
            [finished_stim]=prairie_estim_struct(EstimPARAMS,handles);
            if finished_stim==1
                set(handles.start_button,'BackgroundColor',[0.8314    0.8157    0.7843])
                set(handles.disp_status,'String','Done Electrical Stimulation')
                load PP_PARAMS
                PP_PARAMS.type='EStimEphys';
                PP_PARAMS.protocol=EstimPARAMS;
                load trig_inputs
                ephysdata=trig_inputs;
                PP_PARAMS.triggers=[]; %change here if we are    
                %acquiring trigger inputs
                clear trig_inputs
                PP_PARAMS.completed=1;
            else
                load PP_PARAMS
                PP_PARAMS.type='EStimEphys';
                PP_PARAMS.protocol=EstimPARAMS;
                PP_PARAMS.completed=0;
            end
            clk=clock;dt=date;
            cd C:\EXPERIMENTS\DATA\EPHYS\PP_files
            eval(sprintf('save PP_file_%s_%i_%i_%i-%i PP_PARAMS',dt,clk(4),clk(5),fix(clk(6)),PP_PARAMS.file_number))
            cd C:\EXPERIMENTS\CODES
            if PP_PARAMS.completed==1
                cd C:\EXPERIMENTS\DATA\EPHYS\EP_files
                eval(sprintf('save EPhys_data_%s_%i_%i_%i-%i ephysdata PP_PARAMS',dt,clk(4),clk(5),fix(clk(6)),PP_PARAMS.file_number))
                cd C:\EXPERIMENTS\CODES
            end
    case 11
        %%% For Intrinsic Imaging
        set(handles.disp_status,'String','Started Auditory Stimulation')
        
        load AudStimIIPARAMS
        interrupt_aud=0;
        save interrupt_aud interrupt_aud
        if AudStimIIPARAMS.piptrainmode==0
            [finished_stim]=prairie_aud_struct_intrinsic(AudStimIIPARAMS,handles);
        elseif AudStimIIPARAMS.piptrainmode==1
            [finished_stim]=prairie_aud_struct_intrinsic_piptrainmode(AudStimIIPARAMS,handles);
        end
        if finished_stim==1
                set(handles.start_button,'BackgroundColor',[0.8314    0.8157    0.7843])
                set(handles.disp_status,'String','Done Auditory Stimulation')
                load PP_PARAMS
                PP_PARAMS.type='AudStimII';
                PP_PARAMS.protocol=AudStimIIPARAMS;
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
                PP_PARAMS.type='AudStimII';
                PP_PARAMS.protocol=AudStimIIPARAMS;
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
    case 12
        %%% For Pairing
        set(handles.disp_status,'String','Started Pairing Experiment')
        
        load PairingPARAMS
        interrupt_pair=0;
        save interrupt_pair interrupt_pair
        if PairingPARAMS.ep16check==0
            [finished_stim]=prairie_pairing_struct_RX6(PairingPARAMS,handles);
            if finished_stim==1
                set(handles.start_button,'BackgroundColor',[0.8314    0.8157    0.7843])
                set(handles.disp_status,'String','Done Pairing')
                load PP_PARAMS
                PP_PARAMS.type='Pairing';
                PP_PARAMS.protocol=PairingPARAMS;
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
                PP_PARAMS.type='Pairing';
                PP_PARAMS.protocol=PairingPARAMS;
                load trig_inputs
                PP_PARAMS.triggers=trig_inputs; %change here if we are
                %acquiring trigger inputs
                clear trig_inputs
                PP_PARAMS.completed=0;
            end
            clk=clock;dt=date;
            cd C:\EXPERIMENTS\DATA\EPHYS\PP_files
            eval(sprintf('save PP_file_%s_%i_%i_%i-%i PP_PARAMS',dt,clk(4),clk(5),fix(clk(6)),PP_PARAMS.file_number))
            cd C:\EXPERIMENTS\CODES
        elseif PairingPARAMS.ep16check==1
            [finished_stim]=prairie_pairing_struct_RX6(PairingPARAMS,handles);
            if finished_stim==1
                set(handles.start_button,'BackgroundColor',[0.8314    0.8157    0.7843])
                set(handles.disp_status,'String','Done Pairing')
                load PP_PARAMS
                PP_PARAMS.type='Pairing';
                PP_PARAMS.protocol=PairingPARAMS;
                load trig_inputs
                ephysdata=trig_inputs;
                PP_PARAMS.triggers=[]; %change here if we are    
                %acquiring trigger inputs
                %clear trig_inputs
                PP_PARAMS.completed=1;
            else
                load PP_PARAMS
                PP_PARAMS.type='Pairing';
                PP_PARAMS.protocol=PairingPARAMS;
                load trig_inputs
                ephysdata=trig_inputs;
                PP_PARAMS.triggers=[]; %change here if we are    
                %acquiring trigger inputs
                clear trig_inputs
                PP_PARAMS.completed=0;
            end
            clk=clock;dt=date;
            cd C:\EXPERIMENTS\DATA\EPHYS\PP_files
            eval(sprintf('save PP_file_%s_%i_%i_%i-%i PP_PARAMS',dt,clk(4),clk(5),fix(clk(6)),PP_PARAMS.file_number))
            cd C:\EXPERIMENTS\CODES
            if PP_PARAMS.completed==1
                cd C:\EXPERIMENTS\DATA\EPHYS\EP_files
                eval(sprintf('save EPhys_data_%s_%i_%i_%i-%i ephysdata PP_PARAMS',dt,clk(4),clk(5),fix(clk(6)),PP_PARAMS.file_number))
                cd C:\EXPERIMENTS\CODES
            end
        end
            
    case 13
        %%% For Pairing
        set(handles.disp_status,'String','Started Pairing Time Course Experiment')
        
        load Pairing_TC_PARAMS
        interrupt_pairtc=0;
        save interrupt_pairtc interrupt_pairtc
        [finished_stim]=prairie_pairing_tc_struct_RX6(Pairing_TC_PARAMS,handles);
        if finished_stim==1
                set(handles.start_button,'BackgroundColor',[0.8314    0.8157    0.7843])
                set(handles.disp_status,'String','Done Pairing')
                load PP_PARAMS
                PP_PARAMS.type='PairingTC';
                PP_PARAMS.protocol=Pairing_TC_PARAMS;
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
                PP_PARAMS.type='PairingTC';
                PP_PARAMS.protocol=Pairing_TC_PARAMS;
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
    case 14
        set(handles.disp_status,'String','Started Visual Stimulation')
        
        load VisLEDStimPARAMS
        interrupt_vis=0;
        save interrupt_vis interrupt_vis
        %1
        %         if length(AudStimPARAMS.type)==4
        %             if AudStimPARAMS.type=='MSEQ';
        %                 1
        %                 [finished_stim]=prairie_aud_struct_RX6_L(AudStimPARAMS,handles);
        %             else
        %                 [finished_stim]=prairie_aud_struct_RX6(AudStimPARAMS,handles);
        %             end
        %         else
        %             [finished_stim]=prairie_aud_struct_RX6(AudStimPARAMS,handles);
        %         end
        if VisLEDStimPARAMS.check_vis_only==1
            [finished_stim,VisLEDStimPARAMS]=prairie_visLED_struct(VisLEDStimPARAMS,handles);
        elseif VisLEDStimPARAMS.check_avp==1
            [finished_stim,VisLEDStimPARAMS]=prairie_visLEDAUD_struct_RX6(VisLEDStimPARAMS,handles);
        end
        if finished_stim==1
            set(handles.start_button,'BackgroundColor',[0.8314    0.8157    0.7843])
            set(handles.disp_status,'String','Done VIsual Stimulation')
            load PP_PARAMS
            PP_PARAMS.type='VisLEDStimEphys';
            PP_PARAMS.protocol=VisLEDStimPARAMS;
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
            PP_PARAMS.type='VisLEDStimEphys';
            PP_PARAMS.protocol=VisLEDStimPARAMS;
            PP_PARAMS.completed=0;
        end
        clk=clock;dt=date;
        cd C:\EXPERIMENTS\DATA\EPHYS\PP_files
        eval(sprintf('save PP_file_%s_%i_%i_%i-%i PP_PARAMS',dt,clk(4),clk(5),fix(clk(6)),PP_PARAMS.file_number))
        cd C:\EXPERIMENTS\CODES
        if PP_PARAMS.completed==1
            cd C:\EXPERIMENTS\DATA\EPHYS\EP_files
            eval(sprintf('save EPhys_data_%s_%i_%i_%i-%i ephysdata PP_PARAMS',dt,clk(4),clk(5),fix(clk(6)),PP_PARAMS.file_number))
            cd C:\EXPERIMENTS\CODES
        end
        
    case 15
        set(handles.disp_status,'String','Started Optogenetic Stimulation')
        
        load OptoParams
        interrupt_opto=0;
        save interrupt_opto interrupt_opto
       
        if OptoParams.check_auditory==1
            [finished_stim,OptoParams]=prairie_OptoAud_struct(OptoParams,handles);
        elseif OptoParams.check_visual==1
            [finished_stim,OptoParams]=prairie_OptovisLED_struct(OptoParams,handles);
        elseif OptoParams.check_all==1
            [finished_stim,OptoParams]=prairie_OptovisLEDAUD_struct_RX6(OptoParams,handles);
        elseif OptoParams.check_none==1
            [finished_stim,OptoParams]=prairie_Opto_struct_sa(OptoParams,handles);
        elseif OptoParams.check_optoSSA==1
             [finished_stim,OptoParams]=prairie_Opto_struct(OptoParams,handles);%% edit this sudha
        end
        if finished_stim==1
            set(handles.start_button,'BackgroundColor',[0.8314    0.8157    0.7843])
            set(handles.disp_status,'String','Done Optogenetic Stimulation')
            load PP_PARAMS
            PP_PARAMS.type='Opto-Ephys';
            PP_PARAMS.protocol=OptoParams;
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
            PP_PARAMS.type='Opto-Ephys';
            PP_PARAMS.protocol=OptoParams;
            PP_PARAMS.completed=0;
        end
        clk=clock;dt=date;
        cd C:\EXPERIMENTS\DATA\EPHYS\PP_files
        eval(sprintf('save PP_file_%s_%i_%i_%i-%i PP_PARAMS',dt,clk(4),clk(5),fix(clk(6)),PP_PARAMS.file_number))
        cd C:\EXPERIMENTS\CODES
        if PP_PARAMS.completed==1
            cd C:\EXPERIMENTS\DATA\EPHYS\EP_files
            eval(sprintf('save EPhys_data_%s_%i_%i_%i-%i ephysdata PP_PARAMS',dt,clk(4),clk(5),fix(clk(6)),PP_PARAMS.file_number))
            cd C:\EXPERIMENTS\CODES
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


