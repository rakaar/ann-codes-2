function varargout = LoadLibraryGUI(varargin)
% LOADLIBRARYGUI M-file for LoadLibraryGUI.fig
%      LOADLIBRARYGUI, by itself, creates a new LOADLIBRARYGUI or raises the existing
%      singleton*.
%
%      H = LOADLIBRARYGUI returns the handle to a new LOADLIBRARYGUI or the handle to
%      the existing singleton*.
%
%      LOADLIBRARYGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      outputwindow named CALLBACK in LOADLIBRARYGUI.M with the given input arguments.
%
%      LOADLIBRARYGUI('Property','Value',...) creates a new LOADLIBRARYGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before LoadLibraryGUI_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to LoadLibraryGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help LoadLibraryGUI

% Last Modified by GUIDE v2.5 30-Dec-2002 08:08:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @LoadLibraryGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @LoadLibraryGUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin & isstr(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before LoadLibraryGUI is made visible.
function LoadLibraryGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This outputwindow has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to LoadLibraryGUI (see VARARGIN)

% Choose default command line output for LoadLibraryGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
bkColor = get(handles.LoadLibrarygui,'Color');
set(handles.FileReader,'BackgroundColor',bkColor);
set(handles.ConstantsFile,'BackgroundColor',bkColor);

% UIWAIT makes LoadLibraryGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this outputwindow are returned to the command line.
function varargout = LoadLibraryGUI_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function ProjectName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ProjectName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function ProjectName_Callback(hObject, eventdata, handles)
% hObject    handle to ProjectName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ProjectName as text
%        str2double(get(hObject,'String')) returns contents of ProjectName as a double


% --- Executes during object creation, after setting all properties.
function DLLName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DLLName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function DLLName_Callback(hObject, eventdata, handles)
% hObject    handle to DLLName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DLLName as text
%        str2double(get(hObject,'String')) returns contents of DLLName as a double

if ~exist(get(hObject,'String'),'file')
    % Should error because not a valid file.
end
    
% --- Executes on button press in DLLButton.
function DLLButton_Callback(hObject, eventdata, handles)
% hObject    handle to DLLButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uigetfile('*.dll','Get DLL File');
if filename~=0
    set(handles.DLLName,'String', fullfile(pathname,filename));
end;

% --- Executes during object creation, after setting all properties.
function HeaderName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to HeaderName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function HeaderName_Callback(hObject, eventdata, handles)
% hObject    handle to HeaderName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of HeaderName as text
%        str2double(get(hObject,'String')) returns contents of HeaderName as a double
if ~exist(get(hObject,'String'),'file')
    % Should error because not a valid file.
end


% --- Executes on button press in HeaderButton.
function HeaderButton_Callback(hObject, eventdata, handles)
% hObject    handle to HeaderButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uigetfile('*.h','Get Header File');
if filename~=0
    set(handles.HeaderName,'String', fullfile(pathname,filename));
end;



% --- Executes during object creation, after setting all properties.
function AddIncludeDir_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AddIncludeDir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function AddIncludeDir_Callback(hObject, eventdata, handles)
% hObject    handle to AddIncludeDir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of AddIncludeDir as text
%        str2double(get(hObject,'String')) returns contents of AddIncludeDir as a double
if ~exist(get(hObject,'String'),'dir')
    % Should error because not a valid file.
    set(hObject,'String','');
end


% --- Executes on button press in AddIncludeDirButton.
function AddIncludeDirButton_Callback(hObject, eventdata, handles)
% hObject    handle to AddIncludeDirButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
includedir=uigetdir(pwd,'Get Additional Include Directory');
if includedir
    str = get(handles.AddIncludeDir,'String');
    if isempty(deblank(str))
        set(handles.AddIncludeDir,'String', includedir);
    else
        set(handles.AddIncludeDir,'String',[str,';',includedir]);
    end;
end;


% --- Executes during object creation, after setting all properties.
function PrototypeName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PrototypeName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


function PrototypeName_Callback(hObject, eventdata, handles)
% hObject    handle to PrototypeName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of PrototypeName as text
%        str2double(get(hObject,'String')) returns contents of PrototypeName as a double
if ~exist(get(hObject,'String'),'file')
    % Should error because not a valid file.
    set(hObject,'String','');
end


% --- Executes on button press in Prototypebutton.
function Prototypebutton_Callback(hObject, eventdata, handles)
% hObject    handle to Prototypebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uigetfile('*.txt','Get Prototype File');
if filename~=0
    set(handles.PrototypeName,'String', fullfile(pathname,filename));
end;


% --- Executes on button press in WindowsHeaders.
function WindowsHeaders_Callback(hObject, eventdata, handles)
% hObject    handle to WindowsHeaders (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of WindowsHeaders


% --- Executes on button press in mWrapper.
function mWrapper_Callback(hObject, eventdata, handles)
% hObject    handle to mWrapper (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of mWrapper
if get(hObject,'Value')==0
    bkColor = get(handles.LoadLibrarygui,'Color');
    set(handles.IncludeConstantsFile,'enable','off');
    set(handles.FileReader,'enable','off');
    set(handles.FileReaderButton,'enable','off');
    set(handles.ConstantsFile,'enable','off');
    set(handles.ConstantsFileButton,'enable','off');
    set(handles.FileReader,'BackgroundColor',bkColor);
    set(handles.ConstantsFile,'BackgroundColor',bkColor);
else
    set(handles.IncludeConstantsFile,'enable','on');
    set(handles.FileReader,'enable','on');
    set(handles.FileReaderButton,'enable','on');
    set(handles.ConstantsFile,'enable','on');
    set(handles.ConstantsFileButton,'enable','on');
    set(handles.FileReader,'BackgroundColor',[1,1,1]);
    set(handles.ConstantsFile,'BackgroundColor',[1,1,1]);
end    
% --- Executes during object creation, after setting all properties.
function OutputWindow_CreateFcn(hObject, eventdata, handles)
% hObject    handle to OutputWindow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function OutputWindow_Callback(hObject, eventdata, handles)
% hObject    handle to OutputWindow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of OutputWindow as text
%        str2double(get(hObject,'String')) returns contents of OutputWindow as a double


% --- Executes during object creation, after setting all properties.
function ErrorWindow_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ErrorWindow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function ErrorWindow_Callback(hObject, eventdata, handles)
% hObject    handle to ErrorWindow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ErrorWindow as text
%        str2double(get(hObject,'String')) returns contents of ErrorWindow as a double


% --- Executes on button press in OK.
function OK_Callback(hObject, eventdata, handles)
% hObject    handle to OK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
info = loadlibrarylocal(handles);
if get(handles.mWrapper,'Value')==1
    genmWrappers(info,handles);
end;
GUIClose(handles);

% --- Executes on button press in Apply.
function Apply_Callback(hObject, eventdata, handles)
% hObject    handle to Apply (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
info = loadlibrarylocal(handles);
project = get(handles.ProjectName,'String');
if get(handles.mWrapper,'Value')==1
    genmWrappers(info,handles);
end;

% --- Executes on button press in Cancel.
function Cancel_Callback(hObject, eventdata, handles)
% hObject    handle to Cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
GUIClose(handles);

% --- Single Exit point for GUI.
function GUIClose(handles)
closereq;


function info=loadlibrarylocal(handles)

project = get(handles.ProjectName,'String');
dllname = get(handles.DLLName,'String');
headername = get(handles.HeaderName,'String');
includedir=get(handles.AddIncludeDir,'String');;
prototype = get(handles.PrototypeName,'String');

if isempty(project)
    error('loadlibrarygui:invalidprojectname','You need a valid project name.')
end;
 if ~exist(dllname,'file')

    % Check to see if file is on system path.
    % First create a temp file
    tempname = [temp,num2str(rand(1)*1000)];
    while exist(tempname)
        tempname = [temp,num2str(rand(1)*1000)];
    end;
    
    % Pipe the system path info into the temp file
    eval(['!path >>',tempname]);
    % Read in path and parse it
    fid = fopen(tempname,'r');
    str = fscanf(fid,'%s');
    fclose(fid);
    delete(tempname);
    str = str(findstr(str,'=')+1:end);
    [syspath{1},str]=strtok(str,';');
    while ~isempty(str);
        [syspath{1}{end+1},str]=strtok(str,';');
    end;
    % Check to see if the file exists on the system path
    foundfile = false;
    for idx=1:length(syspath)
        foundfile = (exist([syspath{idx},'\',dllname],'file')>0)|foundfile;
    end;
    % If the file is not on the system path, MATLAB's path and the user did
    % not give us the full path to the file error.
    if ~foundfile
        error('loadlibrarygui:invaliddllname','You need a valid DLL file name on the system path or MATLAB path.')
    end;
 end;
if ~exist(headername,'file')
    error('loadlibrarygui:invalidheadername','You need a valid header file name.')
end;
if ~isempty(includedir)&~exist(includedir,'dir')
    error('loadlibrarygui:invalidIncludeDirname','You need a valid directory name in Additional Include dir or leave it blank.')
end;
if ~isempty(prototype)&~exist(prototype,'file')
    error('loadlibrarygui:invalidprototypename','You need a valid prototype file name or leave it blank.')
end;

% If the library is already loaded unload it before reloading.
if libisloaded(project)
    unloadlibrary(project);
end;

if get(handles.WindowsHeaders,'Value')==1
	% Build temp header that holds both original header and windows header.
	fid = fopen(headername,'r');
	str = fscanf(fid,'%c');
	fclose(fid);
	headername = [headername(1:end-2),'_win.h'];
	fid = fopen(headername,'w');
	fprintf(fid,'#include <windows.h>\n');
	fprintf(fid,'%s',str);
	fclose(fid);
end
	
% This means the library has not been loaded yet so we need to load it.
%    loadlibrary(dllname,headername,'notempdir','classname',project,'includepath',pwd,'-typefile=myvisatypes.txt');
warningSetting1 = warning('off','MATLAB:loadlibrary:functionnotfound');
warningSetting2 = warning('off','MATLAB:loadlibrary:typenotfound');
warningSetting3 = warning('off','MATLAB:loadlibrary:enumexists');
notfound =[];
perout = [];
try
    if isempty(prototype)
        if isempty(includedir)
            [notfound,perout]=loadlibrary(dllname,headername,'alias',project,'mfilename',project);
        else
            [notfound,perout]=loadlibrary(dllname,headername,'alias',project,'mfilename',project,'includepath',includedir);
        end;            
    else
        if isempty(includedir)
            [notfound,perout]=loadlibrary(dllname,headername,'alias',project,'mfilename',project,'addheader',['-typefile=',prototype]);
        else
            [notfound,perout]=loadlibrary(dllname,headername,'alias',project,'mfilename',project,'includepath',includedir,'addheader',['-typefile=',prototype]);
        end;
    end
catch
    if libisloaded(project)
        unloadlibrary(project);
    end;
end;
warning(warningSetting1);
warning(warningSetting2);
warning(warningSetting3);

if get(handles.WindowsHeaders,'Value')==1
	% Build temp header that holds both original header and windows header.
	delete(headername);
end
info = UpdateOutputWindow(handles);
UpdateErrorWindow(handles,notfound,perout);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function info = UpdateOutputWindow(handles)

project = get(handles.ProjectName,'String');
headername = get(handles.HeaderName,'String');
[pathstr,header] = fileparts(headername);

Cfcns   = GetCDeclarations([project,'.m']);
Mfcns   = libmethods(project,'-full');
names = processFunctions(Mfcns);

if length(names)==1&isempty(names{1})
    str = {'No Functions Found'};
    info.Mfcns = {''};
    info.Cfcns = {''};
    info.MfilesNames = {''};
elseif length(names)~=length(Cfcns)
    % We have a problem with some of the functions
    Cnames = processFunctions(Cfcns);
    [dummy,commenidxM,commenidxC] = intersect(names',Cnames');
    info.Mfcns = {Mfcns{commenidxM}}';
    info.Cfcns = {Cfcns{commenidxC}}';
    info.MfilesNames = {names{commenidxM}}';
    str{1} = ['Problems found: check "',project,'.m" file'];
    str{2} = '';
    for c=1:length(info.Mfcns)
        str{end+1} = info.Mfcns{c};
        str{end+1} = info.Cfcns{c};
        str{end+1} = '';
    end;
else
%     [names,index] = sort(names);
%     info.Mfcns = {Mfcns{index}}';
%     info.Cfcns = {Cfcns{index}}';
%     info.MfilesNames = names;
%You are sorting here, but you don't sort the output of project.m
% in genmwrappers.  This gets the orders all screwed up.
    info.Mfcns = Mfcns;
    info.Cfcns = Cfcns;
    info.MfilesNames = names;
    str = '';

    for c=1:length(info.Mfcns)
        str{end+1} = info.Mfcns{c};
        str{end+1} = info.Cfcns{c};
        str{end+1} = '';
    end;
end;
    
set(handles.OutputWindow,'String',str);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function Cfcns = GetCDeclarations(fname)
try
    fid = fopen(fname);
    str = fscanf(fid,'%c');
    fclose(fid);
catch
    error('loadlibrarygui:preprocessorfileioerror','Error opening the preprocessor file: %s',fname);
end;

% Strip off top 4 lines
for c=1:4
    [strLine,str] = strtok(str,sprintf('\n'));
end;
Cfcns=[];
while ~isempty(str)
            [strCDeclaration,str] = strtok(str,sprintf('\n'));
            [strMDeclaration,str] = strtok(str,sprintf('\n'));
            if length(strMDeclaration)>4
                if strcmp(strMDeclaration(1:4),'fcns')
                    Cfcns{end+1}=strCDeclaration(2:end-1);
                end;
            end;
end;
if isempty(Cfcns)
    return;
end;
Cfcns = {Cfcns{:}}';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function names = processFunctions(fcnList);
N=length(fcnList);
if N==0
    names{1,1}=[];
    return;
end;
names{N,1}=[];

for idx=1:N;
    str=fcnList{idx};
    if findstr(str,'(')
        [s,f]=regexp(str,'\s\w+\s*\(');
    else
        [s,f]=regexp(str,'\s\w+\s*$');
    end;
    names{idx,1}=strrep(strrep(str(s:f),'(',''),' ','');
end;
if isempty(names{end})
    names = {names{1:end-1}};
end
names = names';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function UpdateErrorWindow(handles,notfound,perout)
str{1} = '';
idx = 0;
for idx=1:length(notfound);
    str{idx} = ['Function: ',notfound{idx},' not handled.'];
end;
if ~isempty(perout)
    while ~isempty(perout);
        [str{end+1},perout]=strtok(perout,sprintf('\n'));
    end;
end
set(handles.ErrorWindow,'String',str);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function genmWrappers(info,handles)


project = get(handles.ProjectName,'String');
dllname = get(handles.DLLName,'String');
headername = get(handles.HeaderName,'String');
includedir=get(handles.AddIncludeDir,'String');;
prototype = get(handles.PrototypeName,'String');

[pathstr,header] = fileparts(headername);

% Create directory with same name as project
mkdir(project);

% move necessary files into project dir
% copyfile(dllname,project);
copyfile([project,'.m'],project);

% Create the load and unload files.
fid = fopen([pwd,'\',project,'\load',project,'.m'],'w');
% Function Declaration
if get(handles.IncludeConstantsFile,'Value')  %Add an optional output to the load file to return constants
    fprintf(fid,'function param = load%s;\n',project);
else
    fprintf(fid,'function load%s\n',project);
end;

% H1 line
fprintf(fid,'%%LOAD%s calls loadlibrary with the appropriate input arguments.\n',upper(project));
% Help
fprintf(fid,'%%\n');
fprintf(fid,'%% This function will call loadlibrary if needed with the predefined protocal file.\n');
fprintf(fid,'%% This file is automatically generated by the loadlibrarygui.\n');
fprintf(fid,'%%\n');
fprintf(fid,'%%   See also\n');
fprintf(fid,'%%   LOADLIBRARY, UNLOADLIBRARY, UNLOAD%s\n',upper(project));
key = '$';
str = sprintf('\n%%\n');
str = sprintf('%s%%\n',str);
str = sprintf('%s%% %sAuthor: %s\n',str,key,key);
str = sprintf('%s%% %sRevision: %s\n',str,key,key);
str = sprintf('%s%% %sDate: %s %s\n',str,key,datestr(now),key);
str = sprintf('%s%%\n',str);
str = sprintf('%s%% Local Functions Defined:\n',str);
str = sprintf('%s%%\n',str); 
str = sprintf('%s%%\n',str);
str = sprintf('%s%% %sNotes:\n',str,key); 
str = sprintf('%s%%\n',str); 
str = sprintf('%s%%\n',str); 
str = sprintf('%s%%\n',str); 
str = sprintf('%s%%\n',str); 
str = sprintf('%s%% %sEndNotes\n',str,key);
str = sprintf('%s%%\n',str);
str = sprintf('%s%% %sDescription:\n',str,key); 
str = sprintf('%s%%\n',str); 
str = sprintf('%s%%\n',str);
str = sprintf('%s%%\n',str);
str = sprintf('%s%%\n',str);
str = sprintf('%s%% %sEndDescription\n',str,key);

genericTop = str;

str = sprintf('%s\n\n%% If Library is loaded already unload it.\n',str);
str = sprintf('%s\nif libisloaded(''%s'')\n\tunload%s;\nend;\n\n',str,project,project);
fprintf(fid,'%s',str);

fprintf(fid,'warningSetting1 = warning(''off'',''MATLAB:loadlibrary:functionnotfound'');\n');
fprintf(fid,'warningSetting2 = warning(''off'',''MATLAB:loadlibrary:typenotfound'');\n');
fprintf(fid,'warningSetting3 = warning(''off'',''MATLAB:loadlibrary:enumexists'');\n');

% Add the one and only real command.
fprintf(fid,'\n%% Load the library.\n');
fprintf(fid,'loadlibrary(''%s'',@%s,''alias'',''%s'');\n\n',dllname,project,project);


%Option: If the users specified a constant file to include, 
%   add a call to load it here
if get(handles.IncludeConstantsFile,'Value')  %Add an optional output to the load file to return constants
    ConstantsFileLoader = get(handles.FileReader,'string');
    ConstantsFileName = get(handles.ConstantsFile,'string');
    
    fprintf(fid,'if nargout\n');
    
    %Copy the constants file loader into the project directory
    copyfile(ConstantsFileLoader,project);
    [junk,ConstantsFileLoader] = fileparts(ConstantsFileLoader);    %Just the function name

    fprintf(fid,'\tparam = %s(''%s'');\n',ConstantsFileLoader,ConstantsFileName);
    fprintf(fid,'end\n\n');
end;

fprintf(fid,'warning(warningSetting1);\n');
fprintf(fid,'warning(warningSetting2);\n');

fclose(fid);

% Now write out the unload library
% Create the load and unload files.
fid = fopen([project,'/unload',project,'.m'],'w');
% Function Declaration
fprintf(fid,'function unload%s\n',project);
% H1 line
fprintf(fid,'%%UNLOAD%s calls loadlibrary with the appropriate input arguments.\n',upper(project));
% Help
fprintf(fid,'%%\n');
fprintf(fid,'%% This function will call unloadlibrary on the library defined as %s\n',project);
fprintf(fid,'%%\n%% You must have cleared memory and not have any varables defined using \n%%\tthis library to work.\n');
fprintf(fid,'%%\n%% This file is automatically generated by the loadlibrarygui.\n');
fprintf(fid,'%%\n');
fprintf(fid,'%%   See also\n');
fprintf(fid,'%%   LOADLIBRARY, UNLOADLIBRARY, LOAD%s\n',upper(project));

fprintf(fid,'%s',genericTop);


% Add the one and only real command.
fprintf(fid,'%% unload the library.\n');
fprintf(fid,'unloadlibrary(''%s'');\n',project);
fclose(fid);

genericTop = sprintf('%s\n\nif nargin==0;\n\thelp(mfilename);\n\treturn;\nend;\n\n',genericTop);


str = sprintf('\n%% If Library is loaded already unload it.\n');
str = sprintf('%s\nif ~libisloaded(''%s'')\n\tload%s;\nend;\n\n',str,project,project);
genericStuff = str;

try
    [fcns,structs,enuminfo]=feval(project);
catch
    return;
end;

% if the project file did not see any files then you should not generate
% any wrappers until they fix the problem.
mFileList = info.MfilesNames;
if length(mFileList)==1&isempty(mFileList{1})
    return;
end;

%%%%%%%%%%%%
%% Remove any empty cells.
%%%%%%%%%%%%

for c=1:length(mFileList)
    % Create the load and unload files.
    fid = fopen([project,'/',mFileList{c},'.m'],'w');

    % Function Declaration
    fprintf(fid,'function varargout = %s(varargin)\n',mFileList{c});
    % H1 line
    fprintf(fid,'%%%s calls %s library with the appropriate arguments.\n',upper(mFileList{c}),project);
    % Help
    fprintf(fid,'%%\n');
    fprintf(fid,'%% The C declaration for this function is the following:\n%%\t%s\n%%\n',info.Cfcns{c});
    fprintf(fid,'%% The MATLAB Declaration looks like the following:\n%%\t%s\n%%\n',info.Mfcns{c});
    fprintf(fid,'%% This function will call loadlibrary on the library if needed.\n',project);
    fprintf(fid,'%% This file is automatically generated by the loadlibrarygui.\n');
    fprintf(fid,'%%\n');
    fprintf(fid,'%%   See also\n');
    fprintf(fid,'%%   LOADLIBRARY, UNLOADLIBRARY, LOAD%s, UNLOAD%s\n',upper(project),upper(project));
    fprintf(fid,'%s',genericTop);
    fprintf(fid,'%s',genericStuff);
    if iscell(fcns.LHS{c})
        nlhs=length(fcns.LHS{c});
    else
        nlhs = 1;
    end;
    if iscell(fcns.RHS{c})
        nrhs=length(fcns.RHS{c});
    else
        nrhs = 1;
    end;
    
    fprintf(fid,'\nif nargin~=%d;\n\terror(mfilename:WrongNumberIn,''Incorrect number of input arguments.'');\nend;\n',nrhs);    
    fprintf(fid,'\nif nargout~=%d;\n\terror(mfilename:WrongNumberOut,''Incorrect number of output arguments.'');\nend;\n\n',nlhs);    
    % Add the one and only real command.
    fprintf(fid,'%% Call external function in loaded DLL.\n');
    
    %     fprintf(fid,'[varargout]=calllib(''%s'',''%s'',varargin);\n\n',project,mFileList{c});
    %Fix:  use varargin{:} to deal the inputs.  INCLUDECONSTANTSFILE don't think you can do the same with
    %varargout, so do it manually
    outstr = '[';
    for ii=1:nlhs
        outstr = [outstr 'varargout{' num2str(ii) '} '];
    end;
    outstr(end) = ']';
    
    fprintf(fid,[outstr '=calllib(''%s'',''%s'',varargin{:});\n\n'],project,mFileList{c});
    fclose(fid);
    
end;



% --- Executes on button press in IncludeConstantsFile.
function IncludeConstantsFile_Callback(hObject, eventdata, handles)
% hObject    handle to IncludeConstantsFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of IncludeConstantsFile


% --- Executes during object creation, after setting all properties.
function ConstantsFile_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ConstantsFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function ConstantsFile_Callback(hObject, eventdata, handles)
% hObject    handle to ConstantsFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ConstantsFile as text
%        str2double(get(hObject,'String')) returns contents of ConstantsFile as a double


% --- Executes on button press in ConstantsFileButton.
function ConstantsFileButton_Callback(hObject, eventdata, handles)
% hObject    handle to ConstantsFileButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uigetfile('*.h','Get Constants File');
if filename~=0
    set(handles.ConstantsFile,'String', fullfile(pathname,filename));
end;

% --- Executes during object creation, after setting all properties.
function FileReader_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FileReader (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function FileReader_Callback(hObject, eventdata, handles)
% hObject    handle to FileReader (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FileReader as text
%        str2double(get(hObject,'String')) returns contents of FileReader as a double


% --- Executes on button press in FileReaderButton.
function FileReaderButton_Callback(hObject, eventdata, handles)
% hObject    handle to FileReaderButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uigetfile('*.m','Get Constants Reader File');
if filename~=0
    set(handles.FileReader,'String', fullfile(pathname,filename));
end;


% --------------------------------------------------------------------
function Help_Callback(hObject, eventdata, handles)
% hObject    handle to Help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function GUIHelp_Callback(hObject, eventdata, handles)
% hObject    handle to GUIHelp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    [xpath,name,ext,v]=fileparts(which('loadlibrarygui'));
    web([xpath,'\loadlibrarygui.html']);
catch
    errordlg('Can''t find Generic DLL GUI help file: "loadlibrarygui.html"','Help not found');
end;


% --------------------------------------------------------------------
function GenericDLLHelp_Callback(hObject, eventdata, handles)
% hObject    handle to GenericDLLHelp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    open('shared_library_doc.pdf');
catch
    errordlg('Can''t find Generic DLL help file: "shared_library_doc.pdf"','Help not found');
end;

