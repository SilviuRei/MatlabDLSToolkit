function varargout = GraphicalRayleighIntensityScanTool(varargin)
% GRAPHICALRAYLEIGHINTENSITYSCANTOOL MATLAB code for GraphicalRayleighIntensityScanTool.fig
%      GRAPHICALRAYLEIGHINTENSITYSCANTOOL, by itself, creates a new GRAPHICALRAYLEIGHINTENSITYSCANTOOL or raises the existing
%      singleton*.
%
%      H = GRAPHICALRAYLEIGHINTENSITYSCANTOOL returns the handle to a new GRAPHICALRAYLEIGHINTENSITYSCANTOOL or the handle to
%      the existing singleton*.
%
%      GRAPHICALRAYLEIGHINTENSITYSCANTOOL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GRAPHICALRAYLEIGHINTENSITYSCANTOOL.M with the given input arguments.
%
%      GRAPHICALRAYLEIGHINTENSITYSCANTOOL('Property','Value',...) creates a new GRAPHICALRAYLEIGHINTENSITYSCANTOOL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GraphicalRayleighIntensityScanTool_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GraphicalRayleighIntensityScanTool_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GraphicalRayleighIntensityScanTool

% Last Modified by GUIDE v2.5 02-Jan-2018 21:11:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GraphicalRayleighIntensityScanTool_OpeningFcn, ...
                   'gui_OutputFcn',  @GraphicalRayleighIntensityScanTool_OutputFcn, ...
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


% --- Executes just before GraphicalRayleighIntensityScanTool is made visible.
function GraphicalRayleighIntensityScanTool_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GraphicalRayleighIntensityScanTool (see VARARGIN)

% Choose default command line output for GraphicalRayleighIntensityScanTool
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GraphicalRayleighIntensityScanTool wait for user response (see UIRESUME)
% uiwait(handles.figure1);
disp('[+] Starting Rayleigh Intensity Scan Tool v 1.0');
set(handles.h_npMin, 'String', '');
set(handles.h_npMax, 'String', '');
set(handles.h_npStep, 'String', '');
set(handles.h_iThresholdMin, 'String', '');
set(handles.h_iThresholdMax, 'String', '');
set(handles.h_iThresholdStep, 'String', '');
set(handles.h_laserPowerMin, 'String', '')
set(handles.h_laserPowerMax, 'String', '');
set(handles.h_laserPowerStep, 'String', '');
set(handles.h_thetaMin, 'String', '');
set(handles.h_thetaMax, 'String', '');
set(handles.h_thetaStep, 'String', '');
set(handles.h_RMin, 'String', '');
set(handles.h_RMax, 'String', '');
set(handles.h_RStep, 'String', '');
set(handles.h_lambdaMin, 'String', '');
set(handles.h_lambdaMax, 'String', '');
set(handles.h_lambdaStep, 'String', '');
set(handles.h_indrefMinParticle, 'String', '');
set(handles.h_indrefMaxParticle, 'String', '');
set(handles.h_indrefStepParticle, 'String', '');
set(handles.h_dMin, 'String', '');
set(handles.h_dMax, 'String', '');
set(handles.h_dStep, 'String', '');
set(handles.h_scanningVariable, 'Value', 1);
set(handles.h_display, 'Value', 1);
set(handles.h_display, 'Value', 2);
set(handles.h_threshold, 'String', '');
set(handles.h_np, 'String', '');
set(handles.h_iThreshold, 'String', '');
set(handles.h_indrefParticle, 'String', '');
set(handles.h_d, 'String', '');
set(handles.h_laserPower, 'String', '');
set(handles.h_theta, 'String', '');
set(handles.h_R, 'String', '');
set(handles.h_lambda, 'String', '');
set(handles.h_laserSpotDiameter, 'String', '');
set(handles.h_laserSpotDiameterMin, 'String', '');
set(handles.h_laserSpotDiameterMax, 'String', '');
set(handles.h_laserSpotDiameterStep, 'String', '');
set(handles.h_temperature, 'String', '');
set(handles.h_temperatureMin, 'String', '');
set(handles.h_temperatureMax, 'String', '');
set(handles.h_temperatureStep, 'String', '');
set(handles.h_solvent, 'Value', 1);
set(handles.h_indrefMedium, 'String', '');
set(handles.h_particle, 'Value', 1);


% --- Outputs from this function are returned to the command line.
function varargout = GraphicalRayleighIntensityScanTool_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in h_scanningVariable.
function h_scanningVariable_Callback(hObject, eventdata, handles)
% hObject    handle to h_scanningVariable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns h_scanningVariable contents as cell array
%        contents{get(hObject,'Value')} returns selected item from h_scanningVariable


% --- Executes during object creation, after setting all properties.
function h_scanningVariable_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_scanningVariable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in h_save.
function h_save_Callback(hObject, eventdata, handles)
% hObject    handle to h_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns h_save contents as cell array
%        contents{get(hObject,'Value')} returns selected item from h_save


% --- Executes during object creation, after setting all properties.
function h_save_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in h_display.
function h_display_Callback(hObject, eventdata, handles)
% hObject    handle to h_display (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns h_display contents as cell array
%        contents{get(hObject,'Value')} returns selected item from h_display


% --- Executes during object creation, after setting all properties.
function h_display_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_display (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in h_scan.
function h_scan_Callback(hObject, eventdata, handles)
% hObject    handle to h_scan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

solvent=get(handles.h_solvent,'Value');
particle=get(handles.h_particle,'Value');
temperature = str2double(get(handles.h_temperature, 'String'));
wavelength = str2double(get(handles.h_lambda, 'String'));
pressure = 101.325; %kPa - normal air pressure
humidity = 0.5;
method = 'edlen';
xCO2 = 350;
density=water_density(temperature);
if solvent == 1
    indref=water_indref(temperature,density,wavelength);
elseif solvent == 2
    indref=air_indref(wavelength,temperature,pressure,humidity,method,xCO2);
end
set(handles.h_indrefMedium, 'String', num2str(indref));
switch particle
    case 1 %Smoke
        indref=1.55;
    case 2 %Water
        indref=water_indref(temperature,density,wavelength);
    case 3 %Air
        indref=air_indref(wavelength,temperature,pressure,humidity,method,xCO2);
    case 4 %Ice
        indref=1.309;
    case 5 %NaCl
        indref=1.544;
    case 6 %H2SO4
        indref=1.426;
    case 7 %SiO2
        indref=1.55;
    case 8 %Carbon
        indref=1.95;        
    case 9 %Mineral Dust
        indref=1.56;        
end
set(handles.h_indrefParticle, 'String', num2str(indref));

scanVar=get(handles.h_scanningVariable, 'Value');
dispMode=get(handles.h_display, 'Value');
saveMode=get(handles.h_save, 'Value');
if dispMode == 2
    dispMode = 0;
end
if saveMode == 2
    saveMode = 0;
end

npMin=str2double(get(handles.h_npMin, 'String'));
npMax=str2double(get(handles.h_npMax, 'String'));
npStep=str2double(get(handles.h_npStep, 'String'));
iThresholdMin=str2double(get(handles.h_iThresholdMin, 'String'));
iThresholdMax=str2double(get(handles.h_iThresholdMax, 'String'));
iThresholdStep=str2double(get(handles.h_iThresholdStep, 'String'));
thetaMin=str2double(get(handles.h_thetaMin, 'String'));
thetaMax=str2double(get(handles.h_thetaMax, 'String'));
thetaStep=str2double(get(handles.h_thetaStep, 'String'));
RMin=str2double(get(handles.h_RMin, 'String'));
RMax=str2double(get(handles.h_RMax, 'String'));
RStep=str2double(get(handles.h_RStep, 'String'));
lambdaMin=(str2double(get(handles.h_lambdaMin, 'String')));
lambdaMax=str2double(get(handles.h_lambdaMax, 'String'));
lambdaStep=str2double(get(handles.h_lambdaStep, 'String'));
indrefMinParticle=str2double(get(handles.h_indrefMinParticle, 'String'));
indrefMaxParticle=str2double(get(handles.h_indrefMaxParticle, 'String'));
indrefStepParticle=str2double(get(handles.h_indrefStepParticle, 'String'));
dMin=str2double(get(handles.h_dMin, 'String'));
dMax=str2double(get(handles.h_dMax, 'String'));
dStep=str2double(get(handles.h_dStep, 'String'));
np=str2double(get(handles.h_np, 'String'));
iThreshold=str2double(get(handles.h_iThreshold, 'String'));
indrefParticle=str2double(get(handles.h_indrefParticle, 'String'));
indrefMedium=str2double(get(handles.h_indrefMedium, 'String'));
d=(str2double(get(handles.h_d, 'String')));
laserPower=(str2double(get(handles.h_laserPower, 'String')));
laserPowerMin=(str2double(get(handles.h_laserPowerMin, 'String')));
laserPowerMax=(str2double(get(handles.h_laserPowerMax, 'String')));
laserPowerStep=(str2double(get(handles.h_laserPowerStep, 'String')));
laserSpotDiameter=(str2double(get(handles.h_laserSpotDiameter, 'String')));
laserSpotDiameterMin=(str2double(get(handles.h_laserSpotDiameterMin, 'String')));
laserSpotDiameterMax=(str2double(get(handles.h_laserSpotDiameterMax, 'String')));
laserSpotDiameterStep=(str2double(get(handles.h_laserSpotDiameterStep, 'String')));
theta=str2double(get(handles.h_theta, 'String'));
R=str2double(get(handles.h_R, 'String'));
lambda=str2double(get(handles.h_lambda, 'String'));
temperature=str2double(get(handles.h_temperature, 'String'));
temperatureMin=str2double(get(handles.h_temperatureMin, 'String'));
temperatureMax=str2double(get(handles.h_temperatureMax, 'String'));
temperatureStep=str2double(get(handles.h_temperatureStep, 'String'));
solvent=get(handles.h_solvent, 'Value');

indref=indrefParticle/indrefMedium;
indrefMin=indrefMinParticle/indrefMedium;
indrefMax=indrefMaxParticle/indrefMedium;
maxStepsIndrefParticle=(indrefMaxParticle-indrefMinParticle)/indrefStepParticle;
indrefStep=(indrefMax-indrefMin)/maxStepsIndrefParticle;
maxStepsIndref=(indrefMax-indrefMin)/indrefStep + 1;

disp('---------------------------------------------------------------------');
switch scanVar
    case 1 %Number of Particles
      dispText=['   [+] Scanning for:' newline '      Number of Particles: ' ...
            num2str(npMin,'%10.3e') '-' num2str(npStep) '-' num2str(npMax,'%10.3e') newline ...
            'Intensity Threshold: ' num2str(iThreshold) ' W/m2' newline ...
            'Laser Power: ' num2str(laserPower) ' W' newline ...
            'Laser Spot Diameter: ' num2str(laserSpotDiameter) ' mm' newline ... 
            'Scattering Angle: ' num2str(theta) ' deg' newline ...
            'Distance Sensor-Scattering Volume: ' num2str(R) ' m' newline ...
            'Light Wavelength: ' num2str(lambda) ' nm' newline...
            'Refractive Index: ' num2str(indref) newline ...
            'Particle Size: ' num2str(d) ' nm'];
       disp(dispText);
       if npMin>0
           npMin=log10(npMin);
       end
       npMax=log10(npMax);
       [~, ~, npThreshold] = batchScatteredRayleigh_np(np,iThreshold,laserPower,...
           laserSpotDiameter,theta,R,lambda,indref,d,npMin,npMax,npStep,dispMode,saveMode);
       set(handles.h_threshold, 'String', [num2str(npThreshold, '%10.3e') ' particles']);
       disp(['   [-] Scan Complete. Threshold Number of Particles: ' num2str(npThreshold,'%10.3e')]);
    
    case 2 %Theshold Intensity
      msgbox('Not implemented as it does not really make sense');
    
    case 3 %Refractive Index
      dispText=['   [+] Scanning for:' newline '      Number of Particles: ' ...
            num2str(np,'%10.3e') newline ...
            'Intensity Threshold: ' num2str(iThreshold) ' W/m2' newline ...
            'Laser Power: ' num2str(laserPower) ' W' newline ...
            'Laser Spot Diameter: ' num2str(laserSpotDiameter) ' mm' newline ...
            'Scattering Angle: ' num2str(theta) ' deg' newline ...
            'Distance Sensor-Scattering Volume: ' num2str(R) ' m' newline ...
            'Light Wavelength: ' num2str(lambda) ' nm' newline...
            'Refractive Index: ' num2str(indrefMin) '-' num2str(indrefStep) '-' num2str(indrefMax) newline ...
            'Particle Size: ' num2str(d) ' nm'];
       disp(dispText);
       [~,~,indref1Threshold,indref2Threshold] = batchScatteredRayleigh_indref(np,iThreshold,laserPower,...
            laserSpotDiameter,theta,R,lambda,indref,d,indrefMin,indrefMax,indrefStep,dispMode,saveMode);
       set(handles.h_threshold, 'String', [num2str(indref1Threshold) '/' num2str(indref2Threshold)]);
       disp(['   [-] Scan Complete. Threshold Relative Refractive Index: ' num2str(indref1Threshold) '/' ...
           num2str(indref2Threshold)]);
    
    case 4 %Particle Size
        dispText=['   [+] Scanning for:' newline '      Number of Particles: ' num2str(np) newline ...
            'Intensity Threshold: ' num2str(iThreshold) ' W/m2' newline ...
            'Laser Power: ' num2str(laserPower) ' W' newline ...
            'Laser Spot Diameter: ' num2str(laserSpotDiameter) ' mm' newline ...
            'Scattering Angle: ' num2str(theta) ' deg' newline ...
            'Distance Sensor-Scattering Volume: ' num2str(R) ' m' newline ...
            'Light Wavelength: ' num2str(lambda) ' nm' newline...
            'Refractive Index: ' num2str(indref) newline ...
            'Particle Size: ' num2str(dMin) '-' num2str(dStep) '-' num2str(dMax) ' nm'];
        disp(dispText);
        [~,~,dThreshold] = batchScatteredRayleigh_size(np,iThreshold, ...
            laserPower,laserSpotDiameter,theta,R,lambda,indref,0,dMin, ...
            dMax,dStep,dispMode,saveMode);
        set(handles.h_threshold, 'String', [num2str(dThreshold) ' nm']);
        disp(['   [-] Scan Complete. Threshold Particle Size: ' num2str(dThreshold) ' nm']);
    
    case 5 %Laser Power
        dispText=['   [+] Scanning for:' newline '      Number of Particles: ' num2str(np,'%10.3e') newline ...
            'Intensity Threshold: ' num2str(iThreshold) ' W/m2' newline ...
            'Laser Power: ' num2str(laserPowerMin) '-' num2str(laserPowerStep) '-' num2str(laserPowerMax) ...
            ' W' newline ...
            'Laser Spot Diameter: ' num2str(laserSpotDiameter) ' mm' newline...
            'Scattering Angle: ' num2str(thetaMin) '-' num2str(thetaStep) '-' num2str(thetaMax) ' deg' newline ...
            'Distance Sensor-Scattering Volume: ' num2str(R) ' m' newline ...
            'Light Wavelength: ' num2str(lambda) ' nm' newline...
            'Refractive Index: ' num2str(indref) newline ...
            'Particle Size: ' num2str(d) ' nm'];
       disp(dispText);
       [~,~,laserPowerThreshold] = batchScatteredRayleigh_laserPower(np,iThreshold,laserPower,laserSpotDiameter,...
          theta,R,lambda,indref,d,laserPowerMin,laserPowerMax,laserPowerStep,dispMode,saveMode);
       set(handles.h_threshold, 'String', [num2str(laserPowerThreshold) ' W']);
       disp(['   [-] Scan Complete. Threshold Laser Power: ' num2str(laserPowerThreshold) ' W']);        
    
    case 6 %Laser Spot Diameter   
       dispText=['   [+] Scanning for:' newline '      Number of Particles: ' num2str(np,'%10.3e') newline ...
            'Intensity Threshold: ' num2str(iThreshold) ' W/m2' newline ...
            'Laser Power: ' num2str(laserPower) ' W' newline ...
            'Laser Spot Diameter: ' num2str(laserSpotDiameterMin) '-' num2str(laserSpotDiameterStep) '-'...
            num2str(laserSpotDiameterMax) ' mm' newline ...
            'Scattering Angle: ' num2str(thetaMin) '-' num2str(thetaStep) '-' num2str(thetaMax) ' deg' newline ...
            'Distance Sensor-Scattering Volume: ' num2str(R) ' m' newline ...
            'Light Wavelength: ' num2str(lambda) ' nm' newline...
            'Refractive Index: ' num2str(indref) newline ...
            'Particle Size: ' num2str(d) ' nm'];
       disp(dispText);
        [~,~,laserSpotDiameterThreshold] = batchScatteredRayleigh_laserSpotDiameter(np,...
            iThreshold,laserPower,laserSpotDiameter,theta,R,lambda,indref,d,...
            laserSpotDiameterMin,laserSpotDiameterMax,laserSpotDiameterStep,dispMode,saveMode);
       set(handles.h_threshold, 'String', [num2str(laserSpotDiameterThreshold) ' mm']);
       disp(['   [-] Scan Complete. Threshold Laser Spot Diameter: ' num2str(laserSpotDiameterThreshold) ' mm']);  
       
    case 7 %Scattering Angle
       dispText=['   [+] Scanning for:' newline '      Number of Particles: ' num2str(np,'%10.3e') newline...
           'Intensity Threshold: ' num2str(iThreshold) ' W/m2' newline ...
           'Laser Power: ' num2str(laserPower) ' W'...
           'Laser Spot Diameter: ' num2str(laserSpotDiameter) ' mm' newline ...
           'Scattering Angle: ' num2str(thetaMin) '-' num2str(thetaStep) '-' num2str(thetaMax) ' deg' newline ...
           'Distance Sensor-Scattering Volume: ' num2str(R) ' m' newline ...
           'Light Wavelength: ' num2str(lambda) ' nm' newline...
           'Refractive Index: ' num2str(indref) newline ...
           'Particle Size: ' num2str(d) ' nm'];
      disp(dispText);
      [~,~,theta1Threshold,theta2Threshold] = batchScatteredRayleigh_theta(np,...
          iThreshold,laserPower,laserSpotDiameter,theta,R,lambda,indref,d,...
          thetaMin,thetaMax,thetaStep,dispMode,saveMode);
      set(handles.h_threshold, 'String', [num2str(theta1Threshold) '/' num2str(theta2Threshold) ' degrees']);
      disp(['   [-] Scan Complete. Threshold Theta: ' num2str(theta1Threshold) '/' num2str(theta2Threshold)...
           ' degrees']);
    
    case 8 %Sensor-Scattering Distance
      dispText=['   [+] Scanning for:' newline '      Number of Particles: ' num2str(np,'%10.3e') newline...
           'Intensity Threshold: ' num2str(iThreshold) ' W/m2' newline ...
           'Laser Power: ' num2str(laserPower) ' W'...
           'Laser Spot Diameter: ' num2str(laserSpotDiameter) ' mm' newline ...
           'Scattering Angle: ' num2str(theta) ' deg' newline ...
           'Distance Sensor-Scattering Volume: ' num2str(RMin) '-' num2str(RStep) '-' num2str(RMax) ' mm' newline ...
           'Light Wavelength: ' num2str(lambda) ' nm' newline...
           'Refractive Index: ' num2str(indref) newline ...
           'Particle Size: ' num2str(d) ' nm'];
      disp(dispText);
      [~,~,RThreshold]=batchScatteredRayleigh_R(np,iThreshold,laserPower,...
         laserSpotDiameter,theta,R,lambda,indref,d,RMin,RMax,RStep,dispMode,...
         saveMode);
      set(handles.h_threshold, 'String', [num2str(RThreshold), ' mm']);
      disp(['   [-] Scan Complete. Threshold Distance Sensor-Scattering Volume: '...
          num2str(RThreshold) ...
           ' mm']);
    
    case 9 %Light Wavelength
      dispText=['   [+] Scanning for:' newline '      Number of Particles: ' num2str(np,'%10.3e') newline...
           'Intensity Threshold: ' num2str(iThreshold) ' W/m2' newline ...
           'Laser Power: ' num2str(laserPower) ' W'...
           'Laser Spot Diameter: ' num2str(laserSpotDiameter) ' mm' newline ...
           'Scattering Angle: ' num2str(theta) ' deg' newline ...
           'Distance Sensor-Scattering Volume: ' num2str(R) ' mm' newline ...
           'Light Wavelength: ' num2str(lambdaMin) '-' num2str(lambdaStep) '-' num2str(lambdaMax) ' nm' newline...
           'Refractive Index: ' num2str(indref) newline ...
           'Particle Size: ' num2str(d) ' nm'];
      disp(dispText);
      [~,~,lambdaThreshold] = batchScatteredRayleigh_lambda(np,iThreshold,laserPower,...
        laserSpotDiameter,theta,R,lambda,indref,d,lambdaMin,lambdaMax,lambdaStep,...
        dispMode,saveMode);
      set(handles.h_threshold, 'String', [num2str(lambdaThreshold), ' nm']);
      disp(['   [-] Scan Complete. Threshold Light Wavelength: '...
          num2str(lambdaThreshold) ...
           ' nm']);
    
    case 10 %Temperature
      dispText=['   [+] Scanning for:' newline '      Number of Particles: ' num2str(np,'%10.3e') newline...
           'Intensity Threshold: ' num2str(iThreshold) ' W/m2' newline ...
           'Laser Power: ' num2str(laserPower) ' W'...
           'Laser Spot Diameter: ' num2str(laserSpotDiameter) ' mm' newline ...
           'Scattering Angle: ' num2str(theta) ' deg' newline ...
           'Distance Sensor-Scattering Volume: ' num2str(R) ' mm' newline ...
           'Light Wavelength: ' num2str(lambda) ' nm' newline...
           'Refractive Index: ' num2str(indref) newline ...
           'Particle Size: ' num2str(d) ' nm' newline ...
           'Temperature: ' num2str(temperatureMin) '-' num2str(temperatureStep) '-'...
           num2str(temperatureMax) ' C'];
      disp(dispText);
      [~,~,temperatureThreshold] = batchScatteredRayleigh_temperature(solvent,np,iThreshold,laserPower,...
        laserSpotDiameter,theta,R,lambda,indref,d,temperatureMin,...
        temperatureMax,temperatureStep,...
        dispMode,saveMode);
      set(handles.h_threshold, 'String', [num2str(temperatureThreshold), ' C']);
      disp(['   [-] Scan Complete. Threshold Temperature: '...
          num2str(temperatureThreshold) ...
           ' C']);
end    
        
% --- Executes on button press in h_default.
function h_default_Callback(hObject, eventdata, handles)
% hObject    handle to h_default (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

solvent=get(handles.h_solvent, 'Value');

set(handles.h_npMin, 'String', '1.e+4');
set(handles.h_npMax, 'String', '1.e+12');
set(handles.h_npStep, 'String', '1000');
set(handles.h_iThresholdMin, 'String', '0.001');
set(handles.h_iThresholdMax, 'String', '1');
set(handles.h_iThresholdStep, 'String', '0.001');
set(handles.h_laserPowerMin, 'String', '0')
set(handles.h_laserPowerMax, 'String', '12');
set(handles.h_laserPowerStep, 'String', '0.001');
set(handles.h_thetaMin, 'String', '0');
set(handles.h_thetaMax, 'String', '180');
set(handles.h_thetaStep, 'String', '1');
set(handles.h_RMin, 'String', '1');
set(handles.h_RMax, 'String', '100');
set(handles.h_RStep, 'String', '1');
set(handles.h_lambdaMin, 'String', '390');
set(handles.h_lambdaMax, 'String', '700');
set(handles.h_lambdaStep, 'String', '10');
set(handles.h_indrefMinParticle, 'String', '0');
set(handles.h_indrefMaxParticle, 'String', '2');
set(handles.h_indrefStepParticle, 'String', '0.1');
set(handles.h_dMin, 'String', '1');
set(handles.h_dMax, 'String', '1500');
set(handles.h_dStep, 'String', '1');
set(handles.h_laserSpotDiameterMin, 'String', '0');
set(handles.h_laserSpotDiameterMax, 'String', '10');
set(handles.h_laserSpotDiameterStep, 'String', '1');
set(handles.h_scanningVariable, 'Value', 1);
set(handles.h_display, 'Value', 1);
set(handles.h_save, 'Value', 2);
set(handles.h_threshold, 'String', '');
set(handles.h_temperature, 'String', '20');
set(handles.h_temperatureMin, 'String', '0');
set(handles.h_temperatureMax, 'String', '90');
set(handles.h_temperatureStep, 'String', '1');
set(handles.h_particle, 'Value', 1);
set(handles.h_laserPower, 'String', '2');
set(handles.h_np, 'String', '4.e+11');
set(handles.h_iThreshold, 'String', '0.001');
set(handles.h_d, 'String', '5');
set(handles.h_theta, 'String', '90');
set(handles.h_R, 'String', '10');
set(handles.h_lambda, 'String', '532');
set(handles.h_laserSpotDiameter, 'String', '1');


particle=get(handles.h_particle, 'Value');
switch particle
    case 1 %Smoke
        set(handles.h_indrefParticle, 'String','1.55');
    case 2 %Water
        set(handles.h_indrefParticle, 'String', '1.33');
    case 3 %Air
        set(handles.h_indrefParticle, 'String', '1.000268');
    case 4 %Ice
        set(handles.h_indrefParticle, 'String', '1.309');
    case 5 %NaCl
        set(handles.h_indrefParticle, 'String', '1.544');
    case 6 %H2SO4
        set(handles.h_indrefPartice, 'String', '1.426');
    case 7 %SiO2
        set(handles.h_indrefPartice, 'String', '1.55');
    case 8 %Carbon
        set(handles.h_indrefPartice, 'String', '1.95');        
    case 9 %Mineral Dust
        set(handles.h_indrefPartice, 'String', '1.56');        
end

if solvent == 1
    set(handles.h_indrefMedium, 'String', '1.33');
elseif solvent == 2
    set(handles.h_indrefMedium, 'String', '1.000268483');
end
% --- Executes on button press in h_clear.
function h_clear_Callback(hObject, eventdata, handles)
% hObject    handle to h_clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.h_npMin, 'String', '');
set(handles.h_npMax, 'String', '');
set(handles.h_npStep, 'String', '');
set(handles.h_iThresholdMin, 'String', '');
set(handles.h_iThresholdMax, 'String', '');
set(handles.h_iThresholdStep, 'String', '');
set(handles.h_laserPowerMin, 'String', '')
set(handles.h_laserPowerMax, 'String', '');
set(handles.h_laserPowerStep, 'String', '');
set(handles.h_thetaMin, 'String', '');
set(handles.h_thetaMax, 'String', '');
set(handles.h_thetaStep, 'String', '');
set(handles.h_RMin, 'String', '');
set(handles.h_RMax, 'String', '');
set(handles.h_RStep, 'String', '');
set(handles.h_lambdaMin, 'String', '');
set(handles.h_lambdaMax, 'String', '');
set(handles.h_lambdaStep, 'String', '');
set(handles.h_indrefMinParticle, 'String', '');
set(handles.h_indrefMaxParticle, 'String', '');
set(handles.h_indrefStepParticle, 'String', '');
set(handles.h_dMin, 'String', '');
set(handles.h_dMax, 'String', '');
set(handles.h_dStep, 'String', '');
set(handles.h_scanningVariable, 'Value', 1);
set(handles.h_display, 'Value', 1);
set(handles.h_display, 'Value', 2);
set(handles.h_threshold, 'String', '');
set(handles.h_np, 'String', '');
set(handles.h_iThreshold, 'String', '');
set(handles.h_indrefParticle, 'String', '');
set(handles.h_d, 'String', '');
set(handles.h_laserPower, 'String', '');
set(handles.h_theta, 'String', '');
set(handles.h_R, 'String', '');
set(handles.h_lambda, 'String', '');
set(handles.h_laserSpotDiameter, 'String', '');
set(handles.h_laserSpotDiameterMin, 'String', '');
set(handles.h_laserSpotDiameterMax, 'String', '');
set(handles.h_laserSpotDiameterStep, 'String', '');
set(handles.h_temperature, 'String', '');
set(handles.h_temperatureMin, 'String', '');
set(handles.h_temperatureMax, 'String', '');
set(handles.h_temperatureStep, 'String', '');
set(handles.h_solvent, 'Value', 1);
set(handles.h_particle, 'Value', 1);
set(handles.h_indrefMedium, 'String', '');


function h_npMin_Callback(hObject, eventdata, handles)
% hObject    handle to h_npMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h_npMin as text
%        str2double(get(hObject,'String')) returns contents of h_npMin as a double


% --- Executes during object creation, after setting all properties.
function h_npMin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_npMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function h_npMax_Callback(hObject, eventdata, handles)
% hObject    handle to h_npMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h_npMax as text
%        str2double(get(hObject,'String')) returns contents of h_npMax as a double


% --- Executes during object creation, after setting all properties.
function h_npMax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_npMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function h_npStep_Callback(hObject, eventdata, handles)
% hObject    handle to h_npStep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h_npStep as text
%        str2double(get(hObject,'String')) returns contents of h_npStep as a double


% --- Executes during object creation, after setting all properties.
function h_npStep_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_npStep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function h_iThresholdMin_Callback(hObject, eventdata, handles)
% hObject    handle to h_iThresholdMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h_iThresholdMin as text
%        str2double(get(hObject,'String')) returns contents of h_iThresholdMin as a double


% --- Executes during object creation, after setting all properties.
function h_iThresholdMin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_iThresholdMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function h_iThresholdMax_Callback(hObject, eventdata, handles)
% hObject    handle to h_iThresholdMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h_iThresholdMax as text
%        str2double(get(hObject,'String')) returns contents of h_iThresholdMax as a double


% --- Executes during object creation, after setting all properties.
function h_iThresholdMax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_iThresholdMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function h_iThresholdStep_Callback(hObject, eventdata, handles)
% hObject    handle to h_iThresholdStep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h_iThresholdStep as text
%        str2double(get(hObject,'String')) returns contents of h_iThresholdStep as a double


% --- Executes during object creation, after setting all properties.
function h_iThresholdStep_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_iThresholdStep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function h_indrefMinParticle_Callback(hObject, eventdata, handles)
% hObject    handle to h_indrefMinParticle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h_indrefMinParticle as text
%        str2double(get(hObject,'String')) returns contents of h_indrefMinParticle as a double


% --- Executes during object creation, after setting all properties.
function h_indrefMinParticle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_indrefMinParticle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function h_indrefMaxParticle_Callback(hObject, eventdata, handles)
% hObject    handle to h_indrefMaxParticle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h_indrefMaxParticle as text
%        str2double(get(hObject,'String')) returns contents of h_indrefMaxParticle as a double


% --- Executes during object creation, after setting all properties.
function h_indrefMaxParticle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_indrefMaxParticle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function h_indrefStepParticle_Callback(hObject, eventdata, handles)
% hObject    handle to h_indrefStepParticle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h_indrefStepParticle as text
%        str2double(get(hObject,'String')) returns contents of h_indrefStepParticle as a double


% --- Executes during object creation, after setting all properties.
function h_indrefStepParticle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_indrefStepParticle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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



function h_laserPowerMin_Callback(hObject, eventdata, handles)
% hObject    handle to h_laserPowerMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h_laserPowerMin as text
%        str2double(get(hObject,'String')) returns contents of h_laserPowerMin as a double


% --- Executes during object creation, after setting all properties.
function h_laserPowerMin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_laserPowerMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function h_laserPowerMax_Callback(hObject, eventdata, handles)
% hObject    handle to h_laserPowerMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h_laserPowerMax as text
%        str2double(get(hObject,'String')) returns contents of h_laserPowerMax as a double


% --- Executes during object creation, after setting all properties.
function h_laserPowerMax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_laserPowerMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function h_laserPowerStep_Callback(hObject, eventdata, handles)
% hObject    handle to h_laserPowerStep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h_laserPowerStep as text
%        str2double(get(hObject,'String')) returns contents of h_laserPowerStep as a double


% --- Executes during object creation, after setting all properties.
function h_laserPowerStep_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_laserPowerStep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function h_thetaMin_Callback(hObject, eventdata, handles)
% hObject    handle to h_thetaMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h_thetaMin as text
%        str2double(get(hObject,'String')) returns contents of h_thetaMin as a double


% --- Executes during object creation, after setting all properties.
function h_thetaMin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_thetaMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function h_thetaMax_Callback(hObject, eventdata, handles)
% hObject    handle to h_thetaMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h_thetaMax as text
%        str2double(get(hObject,'String')) returns contents of h_thetaMax as a double


% --- Executes during object creation, after setting all properties.
function h_thetaMax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_thetaMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function h_thetaStep_Callback(hObject, eventdata, handles)
% hObject    handle to h_thetaStep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h_thetaStep as text
%        str2double(get(hObject,'String')) returns contents of h_thetaStep as a double


% --- Executes during object creation, after setting all properties.
function h_thetaStep_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_thetaStep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function h_RMin_Callback(hObject, eventdata, handles)
% hObject    handle to h_RMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h_RMin as text
%        str2double(get(hObject,'String')) returns contents of h_RMin as a double


% --- Executes during object creation, after setting all properties.
function h_RMin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_RMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function h_RMax_Callback(hObject, eventdata, handles)
% hObject    handle to h_RMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h_RMax as text
%        str2double(get(hObject,'String')) returns contents of h_RMax as a double


% --- Executes during object creation, after setting all properties.
function h_RMax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_RMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function h_RStep_Callback(hObject, eventdata, handles)
% hObject    handle to h_RStep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h_RStep as text
%        str2double(get(hObject,'String')) returns contents of h_RStep as a double


% --- Executes during object creation, after setting all properties.
function h_RStep_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_RStep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function h_lambdaMin_Callback(hObject, eventdata, handles)
% hObject    handle to h_lambdaMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h_lambdaMin as text
%        str2double(get(hObject,'String')) returns contents of h_lambdaMin as a double


% --- Executes during object creation, after setting all properties.
function h_lambdaMin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_lambdaMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function h_lambdaMax_Callback(hObject, eventdata, handles)
% hObject    handle to h_lambdaMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h_lambdaMax as text
%        str2double(get(hObject,'String')) returns contents of h_lambdaMax as a double


% --- Executes during object creation, after setting all properties.
function h_lambdaMax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_lambdaMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function h_lambdaStep_Callback(hObject, eventdata, handles)
% hObject    handle to h_lambdaStep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h_lambdaStep as text
%        str2double(get(hObject,'String')) returns contents of h_lambdaStep as a double


% --- Executes during object creation, after setting all properties.
function h_lambdaStep_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_lambdaStep (see GCBO)
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



function h_iThreshold_Callback(hObject, eventdata, handles)
% hObject    handle to h_iThreshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h_iThreshold as text
%        str2double(get(hObject,'String')) returns contents of h_iThreshold as a double


% --- Executes during object creation, after setting all properties.
function h_iThreshold_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_iThreshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function h_indrefParticle_Callback(hObject, eventdata, handles)
% hObject    handle to h_indrefParticle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h_indrefParticle as text
%        str2double(get(hObject,'String')) returns contents of h_indrefParticle as a double


% --- Executes during object creation, after setting all properties.
function h_indrefParticle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_indrefParticle (see GCBO)
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



function h_laserPower_Callback(hObject, eventdata, handles)
% hObject    handle to h_laserPower (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h_laserPower as text
%        str2double(get(hObject,'String')) returns contents of h_laserPower as a double


% --- Executes during object creation, after setting all properties.
function h_laserPower_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_laserPower (see GCBO)
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



function h_R_Callback(hObject, eventdata, handles)
% hObject    handle to h_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h_R as text
%        str2double(get(hObject,'String')) returns contents of h_R as a double


% --- Executes during object creation, after setting all properties.
function h_R_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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



function h_laserSpotDiameterMin_Callback(hObject, eventdata, handles)
% hObject    handle to h_laserSpotDiameterMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h_laserSpotDiameterMin as text
%        str2double(get(hObject,'String')) returns contents of h_laserSpotDiameterMin as a double


% --- Executes during object creation, after setting all properties.
function h_laserSpotDiameterMin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_laserSpotDiameterMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function h_laserSpotDiameterMax_Callback(hObject, eventdata, handles)
% hObject    handle to h_laserSpotDiameterMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h_laserSpotDiameterMax as text
%        str2double(get(hObject,'String')) returns contents of h_laserSpotDiameterMax as a double


% --- Executes during object creation, after setting all properties.
function h_laserSpotDiameterMax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_laserSpotDiameterMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function h_laserSpotDiameterStep_Callback(hObject, eventdata, handles)
% hObject    handle to h_laserSpotDiameterStep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h_laserSpotDiameterStep as text
%        str2double(get(hObject,'String')) returns contents of h_laserSpotDiameterStep as a double


% --- Executes during object creation, after setting all properties.
function h_laserSpotDiameterStep_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_laserSpotDiameterStep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function h_laserSpotDiameter_Callback(hObject, eventdata, handles)
% hObject    handle to h_laserSpotDiameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h_laserSpotDiameter as text
%        str2double(get(hObject,'String')) returns contents of h_laserSpotDiameter as a double


% --- Executes during object creation, after setting all properties.
function h_laserSpotDiameter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_laserSpotDiameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in h_DefaultWater.
function h_DefaultWater_Callback(hObject, eventdata, handles)
% hObject    handle to h_DefaultWater (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.h_npMin, 'String', '1.e+4');
set(handles.h_npMax, 'String', '1.e+12');
set(handles.h_npStep, 'String', '1000');
set(handles.h_iThresholdMin, 'String', '0.001');
set(handles.h_iThresholdMax, 'String', '1');
set(handles.h_iThresholdStep, 'String', '0.001');
set(handles.h_laserPowerMin, 'String', '0')
set(handles.h_laserPowerMax, 'String', '1');
set(handles.h_laserPowerStep, 'String', '0.001');
set(handles.h_thetaMin, 'String', '0');
set(handles.h_thetaMax, 'String', '180');
set(handles.h_thetaStep, 'String', '1');
set(handles.h_RMin, 'String', '1');
set(handles.h_RMax, 'String', '100');
set(handles.h_RStep, 'String', '1');
set(handles.h_lambdaMin, 'String', '390');
set(handles.h_lambdaMax, 'String', '700');
set(handles.h_lambdaStep, 'String', '10');
set(handles.h_indrefMinParticle, 'String', '0');
set(handles.h_indrefMaxParticle, 'String', '2');
set(handles.h_indrefStepParticle, 'String', '0.1');
set(handles.h_dMin, 'String', '1');
set(handles.h_dMax, 'String', '1500');
set(handles.h_dStep, 'String', '1');
set(handles.h_laserSpotDiameterMin, 'String', '0');
set(handles.h_laserSpotDiameterMax, 'String', '10');
set(handles.h_laserSpotDiameterStep, 'String', '1');
set(handles.h_scanningVariable, 'Value', 1);
set(handles.h_display, 'Value', 1);
set(handles.h_save, 'Value', 2);
set(handles.h_threshold, 'String', '');
set(handles.h_np, 'String', '4.e+11');
set(handles.h_iThreshold, 'String', '0.001');
set(handles.h_indrefParticle, 'String', '1.33');
set(handles.h_d, 'String', '5');
set(handles.h_laserPower, 'String', '0.05');
set(handles.h_theta, 'String', '90');
set(handles.h_R, 'String', '10');
set(handles.h_lambda, 'String', '633');
set(handles.h_laserSpotDiameter, 'String', '1');


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



function h_temperatureMin_Callback(hObject, eventdata, handles)
% hObject    handle to h_temperatureMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h_temperatureMin as text
%        str2double(get(hObject,'String')) returns contents of h_temperatureMin as a double


% --- Executes during object creation, after setting all properties.
function h_temperatureMin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_temperatureMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function h_temperatureMax_Callback(hObject, eventdata, handles)
% hObject    handle to h_temperatureMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h_temperatureMax as text
%        str2double(get(hObject,'String')) returns contents of h_temperatureMax as a double


% --- Executes during object creation, after setting all properties.
function h_temperatureMax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_temperatureMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function h_temperatureStep_Callback(hObject, eventdata, handles)
% hObject    handle to h_temperatureStep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h_temperatureStep as text
%        str2double(get(hObject,'String')) returns contents of h_temperatureStep as a double


% --- Executes during object creation, after setting all properties.
function h_temperatureStep_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_temperatureStep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function h_temperature_Callback(hObject, eventdata, handles)
% hObject    handle to h_temperature (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h_temperature as text
%        str2double(get(hObject,'String')) returns contents of h_temperature as a double
solvent = get(handles.h_solvent, 'Value');
particle = get(handles.h_particle, 'Value');
temperature = str2double(get(handles.h_temperature, 'String'));
wavelength = str2double(get(handles.h_lambda, 'String'));
pressure = 101.325; %kPa - normal air pressure
humidity = 0.5;
method = 'edlen';
xCO2 = 350;
density=water_density(temperature);
if solvent == 1
    indref=water_indref(temperature,density,wavelength);
elseif solvent == 2
    indref=air_indref(wavelength,temperature,pressure,humidity,method,xCO2);
end
set(handles.h_indrefMedium, 'String', num2str(indref));
if particle == 2
    indref=water_indref(temperature,density,wavelength);
elseif particle == 3
    indref=air_indref(wavelength,temperature,pressure,humidity,method,xCO2);
end
set(handles.h_indrefParticle, 'String', num2str(indref));


% --- Executes during object creation, after setting all properties.
function h_temperature_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_temperature (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in h_particle.
function h_particle_Callback(hObject, eventdata, handles)
% hObject    handle to h_particle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns h_particle contents as cell array
%        contents{get(hObject,'Value')} returns selected item from h_particle


% --- Executes during object creation, after setting all properties.
function h_particle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_particle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function h_indrefMedium_Callback(hObject, eventdata, handles)
% hObject    handle to h_indrefMedium (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h_indrefMedium as text
%        str2double(get(hObject,'String')) returns contents of h_indrefMedium as a double


% --- Executes during object creation, after setting all properties.
function h_indrefMedium_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_indrefMedium (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in h_set.
function h_set_Callback(hObject, eventdata, handles)
% hObject    handle to h_set (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
solvent=get(handles.h_solvent,'Value');
particle=get(handles.h_particle,'Value');
temperature = str2double(get(handles.h_temperature, 'String'));
wavelength = str2double(get(handles.h_lambda, 'String'));
pressure = 101.325; %kPa - normal air pressure
humidity = 0.5;
method = 'edlen';
xCO2 = 350;
density=water_density(temperature);
if solvent == 1
    indref=water_indref(temperature,density,wavelength);
elseif solvent == 2
    indref=air_indref(wavelength,temperature,pressure,humidity,method,xCO2);
end
set(handles.h_indrefMedium, 'String', num2str(indref));
switch particle
    case 1 %Smoke
        indref=1.55;
    case 2 %Water
        indref=water_indref(temperature,density,wavelength);
    case 3 %Air
        indref=air_indref(wavelength,temperature,pressure,humidity,method,xCO2);
    case 4 %Ice
        indref=1.309;
    case 5 %NaCl
        indref=1.544;
    case 6 %H2SO4
        indref=1.426;
    case 7 %SiO2
        indref=1.55;
    case 8 %Carbon
        indref=1.95;        
    case 9 %Mineral Dust
        indref=1.56;        
end
set(handles.h_indrefParticle, 'String', num2str(indref));


% --- Executes during object creation, after setting all properties.
function h_default_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h_default (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
