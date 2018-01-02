function varargout = GraphicalSedVsBrownianScanTool(varargin)
% GRAPHICALSEDVSBROWNIANSCANTOOL MATLAB code for GraphicalSedVsBrownianScanTool.fig
%      GRAPHICALSEDVSBROWNIANSCANTOOL, by itself, creates a new GRAPHICALSEDVSBROWNIANSCANTOOL or raises the existing
%      singleton*.
%
%      H = GRAPHICALSEDVSBROWNIANSCANTOOL returns the handle to a new GRAPHICALSEDVSBROWNIANSCANTOOL or the handle to
%      the existing singleton*.
%
%      GRAPHICALSEDVSBROWNIANSCANTOOL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GRAPHICALSEDVSBROWNIANSCANTOOL.M with the given input arguments.
%
%      GRAPHICALSEDVSBROWNIANSCANTOOL('Property','Value',...) creates a new GRAPHICALSEDVSBROWNIANSCANTOOL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GraphicalSedVsBrownianScanTool_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GraphicalSedVsBrownianScanTool_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GraphicalSedVsBrownianScanTool

% Last Modified by GUIDE v2.5 01-Jan-2018 12:06:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GraphicalSedVsBrownianScanTool_OpeningFcn, ...
                   'gui_OutputFcn',  @GraphicalSedVsBrownianScanTool_OutputFcn, ...
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


% --- Executes just before GraphicalSedVsBrownianScanTool is made visible.
function GraphicalSedVsBrownianScanTool_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GraphicalSedVsBrownianScanTool (see VARARGIN)

% Choose default command line output for GraphicalSedVsBrownianScanTool
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
set(handles.h_Solvent, 'Value', 1);
set(handles.h_MaterialDensity, 'String','');
set(handles.h_MinimumSize, 'String', '');
set(handles.h_MaximumSize, 'String', '');
set(handles.h_StepSize, 'String', '');
set(handles.h_Temperature, 'String', '');
set(handles.h_Materials, 'Value', 1);
set(handles.h_Display, 'Value', 2);
set(handles.h_pe, 'String', '');
set(handles.h_Save, 'Value', 2);

% UIWAIT makes GraphicalSedVsBrownianScanTool wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GraphicalSedVsBrownianScanTool_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function h_MaterialDensity_Callback(hObject, eventdata, handles)
% hObject    handle to h_MaterialDensity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h_MaterialDensity as text
%        str2double(get(hObject,'String')) returns contents of h_MaterialDensity as a double


% --- Executes during object creation, after setting all properties.
function h_MaterialDensity_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_MaterialDensity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function h_MinimumSize_Callback(hObject, eventdata, handles)
% hObject    handle to h_MinimumSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h_MinimumSize as text
%        str2double(get(hObject,'String')) returns contents of h_MinimumSize as a double


% --- Executes during object creation, after setting all properties.
function h_MinimumSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_MinimumSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function h_MaximumSize_Callback(hObject, eventdata, handles)
% hObject    handle to h_MaximumSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h_MaximumSize as text
%        str2double(get(hObject,'String')) returns contents of h_MaximumSize as a double


% --- Executes during object creation, after setting all properties.
function h_MaximumSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_MaximumSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function h_Temperature_Callback(hObject, eventdata, handles)
% hObject    handle to h_Temperature (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h_Temperature as text
%        str2double(get(hObject,'String')) returns contents of h_Temperature as a double


% --- Executes during object creation, after setting all properties.
function h_Temperature_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_Temperature (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function h_StepSize_Callback(hObject, eventdata, handles)
% hObject    handle to h_StepSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h_StepSize as text
%        str2double(get(hObject,'String')) returns contents of h_StepSize as a double


% --- Executes during object creation, after setting all properties.
function h_StepSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_StepSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in h_Solvent.
function h_Solvent_Callback(hObject, eventdata, handles)
% hObject    handle to h_Solvent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns h_Solvent contents as cell array
%        contents{get(hObject,'Value')} returns selected item from h_Solvent


% --- Executes during object creation, after setting all properties.
function h_Solvent_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_Solvent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in h_Materials.
function h_Materials_Callback(hObject, eventdata, handles)
% hObject    handle to h_Materials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns h_Materials contents as cell array
%        contents{get(hObject,'Value')} returns selected item from h_Materials


% --- Executes during object creation, after setting all properties.
function h_Materials_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_Materials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in h_DensitySet.
function h_DensitySet_Callback(hObject, eventdata, handles)
% hObject    handle to h_DensitySet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
material=get(handles.h_Materials, 'Value');
t=str2double(get(handles.h_Temperature, 'String'));
switch material
    case 1
        ro=2660; %soil
    case 2
        ro=water_density(t); %water
    case 3
        ro=air_density(t,50,101325); %air
    case 4
        ro=800; %organic
    case 5
        ro=2643; %Al
    case 6
        ro=19320; %Au
    case 7
        ro=7870; %Fe
    case 8
        ro=11341; %Pb
    case 9
        ro=18700; %U
    case 10
        ro=660; %Gasoline
    case 11
        ro=820; %Oil
    case 12
        ro=1700; %Nylon
    case 13
        ro=1185; %Rubber
    case 14
        ro=2800; %Cement
    case 15
        ro=2130; %Ceramic
    case 16
        ro=721; %Asphalt
    case 17
        ro=320; %Asbestos
    case 18
        ro=561; %Ash/Coal Dry
end
set(handles.h_MaterialDensity, 'String', num2str(ro));


% --- Executes on button press in h_StartScan.
function h_StartScan_Callback(hObject, eventdata, handles)
% hObject    handle to h_StartScan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
solvents = get(handles.h_Solvent,'String'); 
solvent = solvents{get(handles.h_Solvent,'Value')};
roMaterial=str2double(get(handles.h_MaterialDensity, 'String'));
i1=str2double(get(handles.h_MinimumSize, 'String'));
i2=str2double(get(handles.h_MaximumSize, 'String'));
istep=str2double(get(handles.h_StepSize, 'String'));
t=str2double(get(handles.h_Temperature, 'String'));
dispMode=get(handles.h_Display, 'Value');
saveMode=get(handles.h_Save, 'Value');
if dispMode==2
    dispMode=0;
end
if saveMode==2
    saveMde=0;
end
if saveMode == 1
    dirName = ['Solvent-' solvent '_ro-' num2str(roMaterial) '_size-' ...
        num2str(i1) '-' num2str(istep) '-' num2str(i2) '_t-' num2str(t)];

    mkdir(dirName);
    cd(dirName);
end

[~, ~, ~, dep]=vStokesVsBrownian(solvent,roMaterial,i1,i2,istep,t,dispMode,saveMode);
set(handles.h_pe, 'String', num2str(dep));

if saveMode == 1
    cd('..');
end

msgbox('Scan Complete');

% --- Executes on button press in h_Clear.
function h_Clear_Callback(hObject, eventdata, handles)
% hObject    handle to h_Clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.h_Solvent, 'Value', 1);
set(handles.h_MaterialDensity, 'String','');
set(handles.h_MinimumSize, 'String', '');
set(handles.h_MaximumSize, 'String', '');
set(handles.h_StepSize, 'String', '');
set(handles.h_Temperature, 'String', '');
set(handles.h_Materials, 'Value', 1);
set(handles.h_Display, 'Value', 2);
set(handles.h_pe, 'String', '');
set(handles.h_Save, 'Value', 2);

% --- Executes on button press in h_Default.
function h_Default_Callback(hObject, eventdata, handles)
% hObject    handle to h_Default (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.h_Solvent, 'Value', 1);
set(handles.h_MaterialDensity, 'String','2660');
set(handles.h_MinimumSize, 'String', '5000');
set(handles.h_MaximumSize, 'String', '50000');
set(handles.h_StepSize, 'String', '1');
set(handles.h_Temperature, 'String', '20');
set(handles.h_Materials, 'Value', 1);
set(handles.h_Display, 'Value', 2);
set(handles.h_Save, 'Value', 2);


% --- Executes on selection change in h_Display.
function h_Display_Callback(hObject, eventdata, handles)
% hObject    handle to h_Display (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns h_Display contents as cell array
%        contents{get(hObject,'Value')} returns selected item from h_Display


% --- Executes during object creation, after setting all properties.
function h_Display_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_Display (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in h_Help.
function h_Help_Callback(hObject, eventdata, handles)
% hObject    handle to h_Help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox('See https://www.engineeringtoolbox.com/denisity-materials-d_1652.html');


% --- Executes on selection change in h_Save.
function h_Save_Callback(hObject, eventdata, handles)
% hObject    handle to h_Save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns h_Save contents as cell array
%        contents{get(hObject,'Value')} returns selected item from h_Save


% --- Executes during object creation, after setting all properties.
function h_Save_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_Save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
