function varargout = DLSTool(varargin)
% DLSTOOL MATLAB code for DLSTool.fig
%      DLSTOOL, by itself, creates a new DLSTOOL or raises the existing
%      singleton*.
%
%      H = DLSTOOL returns the handle to a new DLSTOOL or the handle to
%      the existing singleton*.
%
%      DLSTOOL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DLSTOOL.M with the given input arguments.
%
%      DLSTOOL('Property','Value',...) creates a new DLSTOOL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DLSTool_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DLSTool_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DLSTool

% Last Modified by GUIDE v2.5 23-Dec-2017 20:57:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DLSTool_OpeningFcn, ...
                   'gui_OutputFcn',  @DLSTool_OutputFcn, ...
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



% --- Executes just before DLSTool is made visible.
function DLSTool_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DLSTool (see VARARGIN)

% Choose default command line output for DLSTool
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

set(handles.h_dMin, 'String', '');
set(handles.h_dMax, 'String', '');
set(handles.h_dStep, 'String', '');
set(handles.h_indref, 'String', '');
set(handles.h_lambda, 'String', '');
set(handles.h_eta, 'String', '');
set(handles.h_tcelsius, 'String', '');
set(handles.h_theta, 'String', '');
set(handles.h_a0start, 'String', '');
set(handles.h_a0min, 'String', '');
set(handles.h_a0max, 'String', '');
set(handles.h_a1start, 'String', '');
set(handles.h_a1min, 'String', '');
set(handles.h_a1max, 'String', '');
set(handles.h_fs, 'String', '');
set(handles.h_nt, 'String', '');
set(handles.h_nnHidden, 'String', '');
set(handles.h_autocorrLags, 'String', '');
set(handles.h_solvent, 'Value', 1);
set(handles.h_generateStatus, 'String', 'Status: Ready');
set(handles.h_dirName,'String','');
set(handles.h_DLSFitStatus, 'String', 'Status: Ready');
set(handles.h_DLSFitFilename, 'String', '');
set(handles.h_DLSFitDisplay, 'Value', 2);
set(handles.h_DLSFitClean, 'Value', 1);
set(handles.h_DLSFitRoFStatus, 'String', 'Status: Ready');
set(handles.h_DLSFitRoFDisplay, 'Value', 2);
set(handles.h_DLSFitRoFFitPoints, 'String', '');
set(handles.h_DLSFitRoFFilenameA0, 'String', '');
set(handles.h_DLSFitRoFFilenameA1, 'String', '');
set(handles.h_comandLogFilename, 'String', '');
set(handles.h_AutocorrDisplay, 'Value', 2);
set(handles.h_AutocorrStatus, 'String', 'Status: Ready');
set(handles.h_AutocorrFilename, 'String', '');
set(handles.h_NNTrainFilename, 'String', '');
set(handles.h_NNTrainFunction, 'Value', 6);
set(handles.h_NNTrainStatus, 'String', 'Status: Ready');
set(handles.h_NNFitDisplay, 'Value', 2);
set(handles.h_NNFitStatus, 'String', 'Status: Ready');
set(handles.h_NNFitFilename, 'String', '');
set(handles.h_ErrNNDLSFilenameNN, 'String' ,'');
set(handles.h_ErrNNDLSFilenameDLS, 'String', '');
set(handles.h_ErrNNDLSDisplay, 'Value', 2);
set(handles.h_ErrNNDLSStatus, 'String', 'Status: Ready');
 

% UIWAIT makes DLSTool wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = DLSTool_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function h_dMin_Callback(hObject, eventdata, handles)
% hObject    handle to h_dMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h_dMin as text
%        str2double(get(hObject,'String')) returns contents of h_dMin as a double


% --- Executes during object creation, after setting all properties.
function h_dMin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_dMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function h_dMax_Callback(hObject, eventdata, handles)
% hObject    handle to h_dMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h_dMax as text
%        str2double(get(hObject,'String')) returns contents of h_dMax as a double


% --- Executes during object creation, after setting all properties.
function h_dMax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_dMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function h_dStep_Callback(hObject, eventdata, handles)
% hObject    handle to h_dStep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h_dStep as text
%        str2double(get(hObject,'String')) returns contents of h_dStep as a double


% --- Executes during object creation, after setting all properties.
function h_dStep_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_dStep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in h_solvent.
function h_solvent_Callback(hObject, eventdata, handles)
% hObject    handle to h_solvent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns h_solvent contents as cell array
%        contents{get(hObject,'Value')} returns selected item from h_solvent


% --- Executes during object creation, after setting all properties.
function h_solvent_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_solvent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function h_lambda_Callback(hObject, eventdata, handles)
% hObject    handle to h_lambda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h_lambda as text
%        str2double(get(hObject,'String')) returns contents of h_lambda as a double


% --- Executes during object creation, after setting all properties.
function h_lambda_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_lambda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function h_tcelsius_Callback(hObject, eventdata, handles)
% hObject    handle to h_tcelsius (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h_tcelsius as text
%        str2double(get(hObject,'String')) returns contents of h_tcelsius as a double


% --- Executes during object creation, after setting all properties.
function h_tcelsius_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_tcelsius (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function h_theta_Callback(hObject, eventdata, handles)
% hObject    handle to h_theta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h_theta as text
%        str2double(get(hObject,'String')) returns contents of h_theta as a double


% --- Executes during object creation, after setting all properties.
function h_theta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_theta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function h_a0min_Callback(hObject, eventdata, handles)
% hObject    handle to h_a0min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h_a0min as text
%        str2double(get(hObject,'String')) returns contents of h_a0min as a double


% --- Executes during object creation, after setting all properties.
function h_a0min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_a0min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function h_a0max_Callback(hObject, eventdata, handles)
% hObject    handle to h_a0max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h_a0max as text
%        str2double(get(hObject,'String')) returns contents of h_a0max as a double


% --- Executes during object creation, after setting all properties.
function h_a0max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_a0max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function h_a0start_Callback(hObject, eventdata, handles)
% hObject    handle to h_a0start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h_a0start as text
%        str2double(get(hObject,'String')) returns contents of h_a0start as a double


% --- Executes during object creation, after setting all properties.
function h_a0start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_a0start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function h_a1min_Callback(hObject, eventdata, handles)
% hObject    handle to h_a1min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h_a1min as text
%        str2double(get(hObject,'String')) returns contents of h_a1min as a double


% --- Executes during object creation, after setting all properties.
function h_a1min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_a1min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function h_a1max_Callback(hObject, eventdata, handles)
% hObject    handle to h_a1max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h_a1max as text
%        str2double(get(hObject,'String')) returns contents of h_a1max as a double


% --- Executes during object creation, after setting all properties.
function h_a1max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_a1max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function h_a1start_Callback(hObject, eventdata, handles)
% hObject    handle to h_a1start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h_a1start as text
%        str2double(get(hObject,'String')) returns contents of h_a1start as a double


% --- Executes during object creation, after setting all properties.
function h_a1start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_a1start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function h_fs_Callback(hObject, eventdata, handles)
% hObject    handle to h_fs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h_fs as text
%        str2double(get(hObject,'String')) returns contents of h_fs as a double


% --- Executes during object creation, after setting all properties.
function h_fs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_fs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function h_nt_Callback(hObject, eventdata, handles)
% hObject    handle to h_nt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h_nt as text
%        str2double(get(hObject,'String')) returns contents of h_nt as a double


% --- Executes during object creation, after setting all properties.
function h_nt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_nt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function h_nnHidden_Callback(hObject, eventdata, handles)
% hObject    handle to h_nnHidden (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h_nnHidden as text
%        str2double(get(hObject,'String')) returns contents of h_nnHidden as a double


% --- Executes during object creation, after setting all properties.
function h_nnHidden_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_nnHidden (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function h_autocorrLags_Callback(hObject, eventdata, handles)
% hObject    handle to h_autocorrLags (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h_autocorrLags as text
%        str2double(get(hObject,'String')) returns contents of h_autocorrLags as a double


% --- Executes during object creation, after setting all properties.
function h_autocorrLags_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_autocorrLags (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonDefaultInitValues.
function pushbuttonDefaultInitValues_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonDefaultInitValues (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
default_dMin             = 5;
default_dStep            = 5;
default_dMax             = 500;
default_theta            = 90;
default_tcelsius         = 20;
default_pSize            = 5;
default_lambda           = 633;
default_solvent          = 'water';
default_solvent_nr       = 1;
default_fs               = 16000;
default_nt               = 32768;
default_nnHidden         = 150;
default_autocorrlags     = 999;

[dMin,dMax,dStep,indref,lambda,eta,tcelsius,theta,pSize,a0start,a0min,...
            a0max,a1start,a1min,a1max,fs,nt,nnHidden,autocorrLags,trainNNFlag]=...
            initConst(default_dMin,default_dStep,default_dMax,default_theta,...
            default_tcelsius,default_pSize,default_lambda,default_solvent,...
            default_fs,default_nt,default_nnHidden,default_autocorrlags,1);

 set(handles.h_dMin, 'String', num2str(dMin));
 set(handles.h_dMax, 'String', num2str(dMax));
 set(handles.h_dStep, 'String', num2str(dStep));
 set(handles.h_indref, 'String', num2str(indref));
 set(handles.h_lambda, 'String', num2str(lambda));
 set(handles.h_eta, 'String', num2str(eta));
 set(handles.h_tcelsius, 'String', num2str(tcelsius));
 set(handles.h_theta, 'String', num2str(theta));
 set(handles.h_a0start, 'String', num2str(a0start));
 set(handles.h_a0min, 'String', num2str(a0min));
 set(handles.h_a0max, 'String', num2str(a0max));
 set(handles.h_a1start, 'String', num2str(a1start));
 set(handles.h_a1min, 'String', num2str(a1min));
 set(handles.h_a1max, 'String', num2str(a1max));
 set(handles.h_fs, 'String', num2str(fs));
 set(handles.h_nt, 'String', num2str(nt));
 set(handles.h_nnHidden, 'String', num2str(nnHidden));
 set(handles.h_autocorrLags, 'String', num2str(autocorrLags));
 set(handles.h_solvent, 'Value', default_solvent_nr);
 set(handles.h_generateStatus, 'String', 'Status: Ready');
 set(handles.h_dirName,'String','');
 set(handles.h_DLSFitStatus, 'String', 'Status: Ready');
 set(handles.h_DLSFitFilename, 'String', '');
 set(handles.h_DLSFitDisplay, 'Value', 2);
 set(handles.h_DLSFitClean, 'Value', 1);
 set(handles.h_DLSFitRoFStatus, 'String', 'Status: Ready');
 set(handles.h_DLSFitRoFDisplay, 'Value', 2);
 set(handles.h_DLSFitRoFFitPoints, 'String', '20');
 set(handles.h_DLSFitRoFFilenameA0, 'String', '');
 set(handles.h_DLSFitRoFFilenameA1, 'String', '');
 set(handles.h_comandLogFilename, 'String', '');
 set(handles.h_AutocorrDisplay, 'Value', 2);
 set(handles.h_AutocorrStatus, 'String', 'Status: Ready');
 set(handles.h_AutocorrFilename, 'String', '');
 set(handles.h_NNTrainFilename, 'String', '');
 set(handles.h_NNTrainFunction, 'Value', 6);
 set(handles.h_NNTrainStatus, 'String', 'Status: Ready');
 set(handles.h_NNFitDisplay, 'Value', 2);
 set(handles.h_NNFitStatus, 'String', 'Status: Ready');
 set(handles.h_NNFitFilename, 'String', '');
 set(handles.h_ErrNNDLSFilenameNN, 'String' ,'');
 set(handles.h_ErrNNDLSFilenameDLS, 'String', '');
 set(handles.h_ErrNNDLSDisplay, 'Value', 2);
 set(handles.h_ErrNNDLSStatus, 'String', 'Status: Ready');
 

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
diary(get(handles.h_comandLogFilename,'String'));



function h_comandLogFilename_Callback(hObject, eventdata, handles)
% hObject    handle to h_comandLogFilename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h_comandLogFilename as text
%        str2double(get(hObject,'String')) returns contents of h_comandLogFilename as a double


% --- Executes during object creation, after setting all properties.
function h_comandLogFilename_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_comandLogFilename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function h_indref_Callback(hObject, eventdata, handles)
% hObject    handle to h_indref (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h_indref as text
%        str2double(get(hObject,'String')) returns contents of h_indref as a double


% --- Executes during object creation, after setting all properties.
function h_indref_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_indref (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function h_eta_Callback(hObject, eventdata, handles)
% hObject    handle to h_eta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h_eta as text
%        str2double(get(hObject,'String')) returns contents of h_eta as a double


% --- Executes during object creation, after setting all properties.
function h_eta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_eta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonClearInitValues.
function pushbuttonClearInitValues_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonClearInitValues (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.h_dMin, 'String', '');
set(handles.h_dMax, 'String', '');
set(handles.h_dStep, 'String', '');
set(handles.h_indref, 'String', '');
set(handles.h_lambda, 'String', '');
set(handles.h_eta, 'String', '');
set(handles.h_tcelsius, 'String', '');
set(handles.h_theta, 'String', '');
set(handles.h_a0start, 'String', '');
set(handles.h_a0min, 'String', '');
set(handles.h_a0max, 'String', '');
set(handles.h_a1start, 'String', '');
set(handles.h_a1min, 'String', '');
set(handles.h_a1max, 'String', '');
set(handles.h_fs, 'String', '');
set(handles.h_nt, 'String', '');
set(handles.h_nnHidden, 'String', '');
set(handles.h_autocorrLags, 'String', '');
set(handles.h_solvent, 'Value', 1);
set(handles.h_generateStatus, 'String', 'Status: Ready');
set(handles.h_dirName,'String','');
set(handles.h_DLSFitStatus, 'String', 'Status: Ready');
set(handles.h_DLSFitFilename, 'String', '');
set(handles.h_DLSFitDisplay, 'Value', 2);
set(handles.h_DLSFitClean, 'Value', 1);
set(handles.h_DLSFitRoFStatus, 'String', 'Status: Ready');
set(handles.h_DLSFitRoFDisplay, 'Value', 2);
set(handles.h_DLSFitRoFFitPoints, 'String', '');
set(handles.h_DLSFitRoFFilenameA0, 'String', '');
set(handles.h_DLSFitRoFFilenameA1, 'String', '');
set(handles.h_comandLogFilename, 'String', '');
set(handles.h_AutocorrDisplay, 'Value', 2);
set(handles.h_AutocorrStatus, 'String', 'Status: Ready');
set(handles.h_AutocorrFilename, 'String', '');
set(handles.h_NNTrainFilename, 'String', '');
set(handles.h_NNTrainFunction, 'Value', 6);
set(handles.h_NNTrainStatus, 'String', 'Status: Ready');
set(handles.h_NNFitDisplay, 'Value', 2);
set(handles.h_NNFitStatus, 'String', 'Status: Ready');
set(handles.h_NNFitFilename, 'String', '');
set(handles.h_ErrNNDLSFilenameNN, 'String' ,'');
set(handles.h_ErrNNDLSFilenameDLS, 'String', '');
set(handles.h_ErrNNDLSDisplay, 'Value', 2);
set(handles.h_ErrNNDLSStatus, 'String', 'Status: Ready');
 


% --- Executes on button press in pushbuttonGenerateTimeSeries.
function pushbuttonGenerateTimeSeries_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonGenerateTimeSeries (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
indref=str2double(get(handles.h_indref, 'String'));
eta=str2double(get(handles.h_eta, 'String'));
fs=str2double(get(handles.h_fs, 'String'));
nt=str2double(get(handles.h_nt, 'String'));
dirName=get(handles.h_dirName,'String');

dMin=str2double(get(handles.h_dMin, 'String'));
dMax=str2double(get(handles.h_dMax, 'String'));
dStep=str2double(get(handles.h_dStep, 'String'));
lambda=str2double(get(handles.h_lambda, 'String'));
tcelsius=str2double(get(handles.h_tcelsius, 'String'));
theta=str2double(get(handles.h_theta, 'String'));

dirName = [dirName '_d' num2str(dMin) '-' num2str(dStep) '-' ...
     num2str(dMax) '-theta-' num2str(theta) '-lambda-' num2str(lambda) ...
	 '-indref-' num2str(indref) '-eta-' num2str(eta) '-tcelsius-' num2str(tcelsius) ...
	 '-fs-' num2str(fs) '-nt-' num2str(nt)];
    
mkdir(dirName);
cd(dirName);
    
set(handles.h_generateStatus, 'String', 'Status: In Progress');
    
[~,~,~,~]=batchGenTsStepSize(dirName,dMin,dStep,dMax,theta,lambda,...
     indref,eta,tcelsius,fs,nt,1);
    
set(handles.h_generateStatus, 'String', 'Status: Complete');
    
cd('..');

msgbox('Time Series Matrix Generation Complete');

    



function h_dirName_Callback(hObject, eventdata, handles)
% hObject    handle to h_dirName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h_dirName as text
%        str2double(get(hObject,'String')) returns contents of h_dirName as a double


% --- Executes during object creation, after setting all properties.
function h_dirName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_dirName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in h_generateVaryingParameter.
function h_generateVaryingParameter_Callback(hObject, eventdata, handles)
% hObject    handle to h_generateVaryingParameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns h_generateVaryingParameter contents as cell array
%        contents{get(hObject,'Value')} returns selected item from h_generateVaryingParameter


% --- Executes during object creation, after setting all properties.
function h_generateVaryingParameter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_generateVaryingParameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function h_generateMin_Callback(hObject, eventdata, handles)
% hObject    handle to h_generateMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h_generateMin as text
%        str2double(get(hObject,'String')) returns contents of h_generateMin as a double


% --- Executes during object creation, after setting all properties.
function h_generateMin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_generateMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function h_generateMax_Callback(hObject, eventdata, handles)
% hObject    handle to h_generateMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h_generateMax as text
%        str2double(get(hObject,'String')) returns contents of h_generateMax as a double


% --- Executes during object creation, after setting all properties.
function h_generateMax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_generateMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function h_generateStep_Callback(hObject, eventdata, handles)
% hObject    handle to h_generateStep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h_generateStep as text
%        str2double(get(hObject,'String')) returns contents of h_generateStep as a double


% --- Executes during object creation, after setting all properties.
function h_generateStep_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_generateStep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in h_DLSFitBrowseTimeSeries.
function h_DLSFitBrowseTimeSeries_Callback(hObject, eventdata, handles)
% hObject    handle to h_DLSFitBrowseTimeSeries (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,FilePath ]= uigetfile('*.*','Select time series matrix file');
ExPath = fullfile(FilePath, FileName);
set(handles.h_DLSFitStatus, 'String', 'Status: File selected');
set(handles.h_DLSFitFilename, 'String', ExPath);



% --- Executes on selection change in h_DLSFitDisplay.
function h_DLSFitDisplay_Callback(hObject, eventdata, handles)
% hObject    handle to h_DLSFitDisplay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns h_DLSFitDisplay contents as cell array
%        contents{get(hObject,'Value')} returns selected item from h_DLSFitDisplay


% --- Executes during object creation, after setting all properties.
function h_DLSFitDisplay_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_DLSFitDisplay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in h_DLSFitClean.
function h_DLSFitClean_Callback(hObject, eventdata, handles)
% hObject    handle to h_DLSFitClean (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns h_DLSFitClean contents as cell array
%        contents{get(hObject,'Value')} returns selected item from h_DLSFitClean


% --- Executes during object creation, after setting all properties.
function h_DLSFitClean_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_DLSFitClean (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in h_pushbuttonDLSFit.
function h_pushbuttonDLSFit_Callback(hObject, eventdata, handles)
% hObject    handle to h_pushbuttonDLSFit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ExPath = get(handles.h_DLSFitFilename, 'String');
currentPath = pwd;
mTS = load(ExPath);

[filepath,filename,fileext] = fileparts(ExPath);
cd(filepath);

indref=str2double(get(handles.h_indref, 'String'));
eta=str2double(get(handles.h_eta, 'String'));
fs=str2double(get(handles.h_fs, 'String'));
dMin=str2double(get(handles.h_dMin, 'String'));
dMax=str2double(get(handles.h_dMax, 'String'));
dStep=str2double(get(handles.h_dStep, 'String'));
lambda=str2double(get(handles.h_lambda, 'String'));
tcelsius=str2double(get(handles.h_tcelsius, 'String'));
theta=str2double(get(handles.h_theta, 'String'));
a0start=str2double(get(handles.h_a0start, 'String'));
a0min=str2double(get(handles.h_a0min, 'String'));
a0max=str2double(get(handles.h_a0max, 'String'));
a1start=str2double(get(handles.h_a1start, 'String'));
a1min=str2double(get(handles.h_a1min, 'String'));
a1max=str2double(get(handles.h_a1max, 'String'));
dispMode=get(handles.h_DLSFitDisplay, 'Value');
cleanMode=get(handles.h_DLSFitClean, 'Value');

if dispMode == 2
    dispMode = 0;
end

if cleanMode == 2
    cleanMode = 0;
end

set(handles.h_DLSFitStatus, 'String', 'Status: In Progress');

dm=dMin:dStep:dMax;

[~,~,~,~] = batchDLSFitFindA0A1Size(mTS, dm, ...
    1, (dMax-dMin)/dStep+1, 1, fs, theta, lambda, indref, eta, tcelsius, ...
    a0start, a0min, a0max, a1start, a1min, a1max, dispMode, cleanMode);
    
set(handles.h_DLSFitStatus, 'String', 'Status: Complete');
    
cd(currentPath);
msgbox('DLS Fit Complete');


% --- Executes on button press in h_pushbuttonDLSRoF.
function h_pushbuttonDLSRoF_Callback(hObject, eventdata, handles)
% hObject    handle to h_pushbuttonDLSRoF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ExPathA0 = get(handles.h_DLSFitRoFFilenameA0, 'String');
ExPathA1 = get(handles.h_DLSFitRoFFilenameA1, 'String');
a0FitDLS = load(ExPathA0);
a1FitDLS = load(ExPathA1);

currentPath = pwd;
[filepath,filename,fileext] = fileparts(ExPathA0);
cd(filepath);

indref=str2double(get(handles.h_indref, 'String'));
eta=str2double(get(handles.h_eta, 'String'));
fs=str2double(get(handles.h_fs, 'String'));
dMin=str2double(get(handles.h_dMin, 'String'));
dMax=str2double(get(handles.h_dMax, 'String'));
dStep=str2double(get(handles.h_dStep, 'String'));
lambda=str2double(get(handles.h_lambda, 'String'));
tcelsius=str2double(get(handles.h_tcelsius, 'String'));
theta=str2double(get(handles.h_theta, 'String'));
dispMode=get(handles.h_DLSFitRoFDisplay, 'Value');
deltaFit=str2double(get(handles.h_DLSFitRoFFitPoints, 'String'));

if dispMode == 2
    dispMode = 0;
end

set(handles.h_DLSFitRoFStatus, 'String', 'Status: In Progress');

[~] = batchDLSRollOffFrequencySize(a0FitDLS, a1FitDLS, dMin, dMax, dStep, ...
    lambda,tcelsius,theta,indref,eta,fs,deltaFit,'png', dispMode);
    
set(handles.h_DLSFitRoFStatus, 'String', 'Status: Complete');
    
cd(currentPath);
msgbox('Finding Roll-off Frequency Complete');

% --- Executes on selection change in h_DLSFitRoFDisplay.
function h_DLSFitRoFDisplay_Callback(hObject, eventdata, handles)
% hObject    handle to h_DLSFitRoFDisplay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns h_DLSFitRoFDisplay contents as cell array
%        contents{get(hObject,'Value')} returns selected item from h_DLSFitRoFDisplay


% --- Executes during object creation, after setting all properties.
function h_DLSFitRoFDisplay_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_DLSFitRoFDisplay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in h_DLSFitRoFBrowseA0.
function h_DLSFitRoFBrowseA0_Callback(hObject, eventdata, handles)
% hObject    handle to h_DLSFitRoFBrowseA0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,FilePath ]= uigetfile('*.*','Select a0 file');
ExPath = fullfile(FilePath, FileName);
set(handles.h_DLSFitRoFStatus, 'String', 'Status: a0 file selected');
set(handles.h_DLSFitRoFFilenameA0, 'String', ExPath);

% --- Executes on button press in h_DLSFitRoFBrowseA1.
function h_DLSFitRoFBrowseA1_Callback(hObject, eventdata, handles)
% hObject    handle to h_DLSFitRoFBrowseA1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,FilePath ]= uigetfile('*.*','Select a1 file');
ExPath = fullfile(FilePath, FileName);
set(handles.h_DLSFitRoFStatus, 'String', 'Status: a1 file selected');
set(handles.h_DLSFitRoFFilenameA1, 'String', ExPath);



function h_DLSFitRoFFitPoints_Callback(hObject, eventdata, handles)
% hObject    handle to h_DLSFitRoFFitPoints (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h_DLSFitRoFFitPoints as text
%        str2double(get(hObject,'String')) returns contents of h_DLSFitRoFFitPoints as a double


% --- Executes during object creation, after setting all properties.
function h_DLSFitRoFFitPoints_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_DLSFitRoFFitPoints (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in h_AutocorrStart.
function h_AutocorrStart_Callback(hObject, eventdata, handles)
% hObject    handle to h_AutocorrStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ExPath = get(handles.h_AutocorrFilename, 'String');
currentPath = pwd;
mTS = load(ExPath);

[filepath,filename,fileext] = fileparts(ExPath);
cd(filepath);

indsave=2;
fs=str2double(get(handles.h_fs, 'String'));
dMin=str2double(get(handles.h_dMin, 'String'));
dMax=str2double(get(handles.h_dMax, 'String'));
dStep=str2double(get(handles.h_dStep, 'String'));

dispMode=get(handles.h_AutocorrDisplay, 'Value');
autocorrLags=str2double(get(handles.h_autocorrLags, 'String'));

if dispMode == 2
    dispMode = 0;
end

set(handles.h_AutocorrStatus, 'String', 'Status: In Progress');

[~,~]=run_analizor_autocor_2(filename,mTS,autocorrLags,fs,'png',indsave,...
    dMin,dMax,dStep,1,(dMax-dMin)/dStep+1,1,dispMode);

set(handles.h_AutocorrStatus, 'String', 'Status: Complete');
    
cd(currentPath);
msgbox('Autocorrelation Computation Complete');

% --- Executes on selection change in h_AutocorrDisplay.
function h_AutocorrDisplay_Callback(hObject, eventdata, handles)
% hObject    handle to h_AutocorrDisplay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns h_AutocorrDisplay contents as cell array
%        contents{get(hObject,'Value')} returns selected item from h_AutocorrDisplay


% --- Executes during object creation, after setting all properties.
function h_AutocorrDisplay_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_AutocorrDisplay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in h_AutocorrBrowse.
function h_AutocorrBrowse_Callback(hObject, eventdata, handles)
% hObject    handle to h_AutocorrBrowse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,FilePath ]= uigetfile('*.*','Select time series matrix file');
ExPath = fullfile(FilePath, FileName);
set(handles.h_AutocorrStatus, 'String', 'Status: File selected');
set(handles.h_AutocorrFilename, 'String', ExPath);


% --- Executes on button press in h_NNTrainBrowse.
function h_NNTrainBrowse_Callback(hObject, eventdata, handles)
% hObject    handle to h_NNTrainBrowse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,FilePath ]= uigetfile('*.*','Select autocorrelation matrix file');
ExPath = fullfile(FilePath, FileName);
set(handles.h_NNTrainStatus, 'String', 'Status: File selected');
set(handles.h_NNTrainFilename, 'String', ExPath);


% --- Executes on selection change in h_NNTrainFunction.
function h_NNTrainFunction_Callback(hObject, eventdata, handles)
% hObject    handle to h_NNTrainFunction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns h_NNTrainFunction contents as cell array
%        contents{get(hObject,'Value')} returns selected item from h_NNTrainFunction


% --- Executes during object creation, after setting all properties.
function h_NNTrainFunction_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_NNTrainFunction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in h_NnTrainStart.
function h_NnTrainStart_Callback(hObject, eventdata, handles)
% hObject    handle to h_NnTrainStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ExPath = get(handles.h_NNTrainFilename, 'String');
currentPath = pwd;
acf = load(ExPath);

[filepath,filename,fileext] = fileparts(ExPath);
cd(filepath);

dMin=str2double(get(handles.h_dMin, 'String'));
dStep=str2double(get(handles.h_dStep, 'String'));
dMax=str2double(get(handles.h_dMax, 'String'));
nnHidden=str2double(get(handles.h_nnHidden, 'String'));
trainFcnId=get(handles.h_NNTrainFunction, 'Value');
dm = dMin:dStep:dMax;

switch trainFcnId
    case 1
        trainFcn = 'trainlm';
    case 2
        trainFcn = 'trainbfg';
    case 3
        trainFcn = 'trainrp';
    case 4
        trainFcn = 'trainscg';
    case 5
        trainFcn = 'traincgb';
    case 6
        trainFcn = 'traincgf';
    case 7
        trainFcn = 'traincgp';
    case 8
        trainFcn = 'trainoss';
    case 9
        trainFcn = 'traingdx';
end

set(handles.h_NNTrainStatus, 'String', 'Status: In Progress');

[~, ~] = nnDlsTrain(acf,dm,nnHidden,trainFcn);

set(handles.h_NNTrainStatus, 'String', 'Status: Complete');
    
cd(currentPath);
msgbox('Neural Network Training Complete');


% --- Executes on button press in h_NNFitBrowse.
function h_NNFitBrowse_Callback(hObject, eventdata, handles)
% hObject    handle to h_NNFitBrowse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,FilePath ]= uigetfile('*.*','Select time series matrix file');
ExPath = fullfile(FilePath, FileName);
set(handles.h_NNFitStatus, 'String', 'Status: File selected');
set(handles.h_NNFitFilename, 'String', ExPath);

% --- Executes on selection change in h_NNFitDisplay.
function h_NNFitDisplay_Callback(hObject, eventdata, handles)
% hObject    handle to h_NNFitDisplay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns h_NNFitDisplay contents as cell array
%        contents{get(hObject,'Value')} returns selected item from h_NNFitDisplay


% --- Executes during object creation, after setting all properties.
function h_NNFitDisplay_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_NNFitDisplay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in h_NNFitStart.
function h_NNFitStart_Callback(hObject, eventdata, handles)
% hObject    handle to h_NNFitStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ExPath = get(handles.h_NNFitFilename, 'String');
currentPath = pwd;
mTS = load(ExPath);

[filepath,filename,fileext] = fileparts(ExPath);
cd(filepath);

fs=str2double(get(handles.h_fs, 'String'));
dMin=str2double(get(handles.h_dMin, 'String'));
dMax=str2double(get(handles.h_dMax, 'String'));
dStep=str2double(get(handles.h_dStep, 'String'));
nnHidden=str2double(get(handles.h_nnHidden, 'String'));
dispMode=get(handles.h_NNFitDisplay, 'Value');
autocorrLags=str2double(get(handles.h_autocorrLags, 'String'));

if dispMode == 2
    dispMode = 0;
end

set(handles.h_NNFitStatus, 'String', 'Status: In Progress');

[~] = dlsNNFit (filename,mTS,dMin,dMax,dStep,1,(dMax-dMin)/dStep+1,1,autocorrLags,nnHidden,fs,dispMode)

set(handles.h_NNFitStatus, 'String', 'Status: Complete');
    
cd(currentPath);
msgbox('Neural Network Fit Complete');


% --- Executes on button press in h_ErrNNDLSStart.
function h_ErrNNDLSStart_Callback(hObject, eventdata, handles)
% hObject    handle to h_ErrNNDLSStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ExPath = get(handles.h_ErrNNDLSFilenameDLS, 'String');
dFitDLS = load(ExPath);

ExPath = get(handles.h_ErrNNDLSFilenameNN, 'String');
dFitNN = load(ExPath);

currentPath = pwd;

[filepath,filename,fileext] = fileparts(ExPath);
cd(filepath);

dMin=str2double(get(handles.h_dMin, 'String'));
dMax=str2double(get(handles.h_dMax, 'String'));
dStep=str2double(get(handles.h_dStep, 'String'));
dispMode=get(handles.h_NNFitDisplay, 'Value');

if dispMode == 2
    dispMode = 0;
end
d=dMin:dStep:dMax;
    
[~,~,~,~]=estimateErrFitDLSVsNN(d,dFitDLS,dFitNN,'png',dispMode);

cd(currentPath);
msgbox('NN & DLS Error Evaluation Complete');

% --- Executes on selection change in h_ErrNNDLSDisplay.
function h_ErrNNDLSDisplay_Callback(hObject, eventdata, handles)
% hObject    handle to h_ErrNNDLSDisplay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns h_ErrNNDLSDisplay contents as cell array
%        contents{get(hObject,'Value')} returns selected item from h_ErrNNDLSDisplay


% --- Executes during object creation, after setting all properties.
function h_ErrNNDLSDisplay_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_ErrNNDLSDisplay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in h_ErrNNDLSBrowseFilenameDLS.
function h_ErrNNDLSBrowseFilenameDLS_Callback(hObject, eventdata, handles)
% hObject    handle to h_ErrNNDLSBrowseFilenameDLS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,FilePath ]= uigetfile('*.*','Select DLS Sizes File');
ExPath = fullfile(FilePath, FileName);
set(handles.h_ErrNNDLSStatus, 'String', 'Status: DLS File Selected');
set(handles.h_ErrNNDLSFilenameDLS, 'String', ExPath);


% --- Executes on button press in h_ErrNNDLSBrowseFilenameNN.
function h_ErrNNDLSBrowseFilenameNN_Callback(hObject, eventdata, handles)
% hObject    handle to h_ErrNNDLSBrowseFilenameNN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,FilePath ]= uigetfile('*.*','Select DLS Sizes File');
ExPath = fullfile(FilePath, FileName);
set(handles.h_ErrNNDLSStatus, 'String', 'Status: NN File Selected');
set(handles.h_ErrNNDLSFilenameNN, 'String', ExPath);
