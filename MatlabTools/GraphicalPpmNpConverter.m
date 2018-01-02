function varargout = GraphicalPpmNpConverter(varargin)
% GRAPHICALPPMNPCONVERTER MATLAB code for GraphicalPpmNpConverter.fig
%      GRAPHICALPPMNPCONVERTER, by itself, creates a new GRAPHICALPPMNPCONVERTER or raises the existing
%      singleton*.
%
%      H = GRAPHICALPPMNPCONVERTER returns the handle to a new GRAPHICALPPMNPCONVERTER or the handle to
%      the existing singleton*.
%
%      GRAPHICALPPMNPCONVERTER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GRAPHICALPPMNPCONVERTER.M with the given input arguments.
%
%      GRAPHICALPPMNPCONVERTER('Property','Value',...) creates a new GRAPHICALPPMNPCONVERTER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GraphicalPpmNpConverter_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GraphicalPpmNpConverter_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GraphicalPpmNpConverter

% Last Modified by GUIDE v2.5 01-Jan-2018 12:19:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GraphicalPpmNpConverter_OpeningFcn, ...
                   'gui_OutputFcn',  @GraphicalPpmNpConverter_OutputFcn, ...
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


% --- Executes just before GraphicalPpmNpConverter is made visible.
function GraphicalPpmNpConverter_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GraphicalPpmNpConverter (see VARARGIN)

% Choose default command line output for GraphicalPpmNpConverter
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GraphicalPpmNpConverter wait for user response (see UIRESUME)
% uiwait(handles.figure1);
disp('[+++] Graphical Ppm Np Converter v1.0 Started');
set(handles.h_ppmv, 'String', '');
set(handles.h_d, 'String', '');
set(handles.h_scatteringVolume, 'String', '');
set(handles.h_np, 'String', '');


% --- Outputs from this function are returned to the command line.
function varargout = GraphicalPpmNpConverter_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in h_ppmv2np.
function h_ppmv2np_Callback(hObject, eventdata, handles)
% hObject    handle to h_ppmv2np (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ppmv=str2double(get(handles.h_ppmv, 'String'));
d=str2double(get(handles.h_d, 'String'));
scatteringVolume=str2double(get(handles.h_scatteringVolume, 'String'));
origFormat = get(0,'format');
format('shortE');
np = ppmv2np(ppmv,d,scatteringVolume);
set(handles.h_np,'String', num2str(np,'%10.2e'));
disp('   [+] Ppm Volume to number of particles converter');
disp(['   [-] ppmv=' num2str(ppmv) ', d=' num2str(d) ' nm, sV=' ...
    num2str(scatteringVolume) ' mm3, '...
    'Number of particles=' num2str(np,'%10.2e')]);
set(0,'format',origFormat);

% --- Executes on button press in h_np2ppmv.
function h_np2ppmv_Callback(hObject, eventdata, handles)
% hObject    handle to h_np2ppmv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
np=str2double(get(handles.h_np, 'String'));
d=str2double(get(handles.h_d, 'String'));
scatteringVolume=str2double(get(handles.h_scatteringVolume, 'String'));
origFormat = get(0,'format');
format('shortE');
ppmv = np2ppmv(np,d,scatteringVolume);
set(handles.h_ppmv,'String', num2str(ppmv));
disp('   [+] Ppm Volume to number of particles converter');
disp(['   [-] Number of particles=' num2str(ppmv) ', d=' num2str(d)...
    ' nm, sV=' num2str(scatteringVolume) ' mm3, '...
    'ppmv=' num2str(np)]);
set(0,'format',origFormat);


% --- Executes on button press in h_Clear.
function h_Clear_Callback(hObject, eventdata, handles)
% hObject    handle to h_Clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.h_ppmv, 'String', '');
set(handles.h_d, 'String', '');
set(handles.h_scatteringVolume, 'String', '');
set(handles.h_np, 'String', '');


% --- Executes on button press in h_Default.
function h_Default_Callback(hObject, eventdata, handles)
% hObject    handle to h_Default (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.h_ppmv, 'String', '1000');
set(handles.h_d, 'String', '5');
set(handles.h_scatteringVolume, 'String', '1');
set(handles.h_np, 'String', '');


function h_ppmv_Callback(hObject, eventdata, handles)
% hObject    handle to h_ppmv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h_ppmv as text
%        str2double(get(hObject,'String')) returns contents of h_ppmv as a double


% --- Executes during object creation, after setting all properties.
function h_ppmv_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_ppmv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function h_d_Callback(hObject, eventdata, handles)
% hObject    handle to h_d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h_d as text
%        str2double(get(hObject,'String')) returns contents of h_d as a double


% --- Executes during object creation, after setting all properties.
function h_d_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function h_scatteringVolume_Callback(hObject, eventdata, handles)
% hObject    handle to h_scatteringVolume (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h_scatteringVolume as text
%        str2double(get(hObject,'String')) returns contents of h_scatteringVolume as a double


% --- Executes during object creation, after setting all properties.
function h_scatteringVolume_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_scatteringVolume (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function h_np_Callback(hObject, eventdata, handles)
% hObject    handle to h_np (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h_np as text
%        str2double(get(hObject,'String')) returns contents of h_np as a double


% --- Executes during object creation, after setting all properties.
function h_np_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_np (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
