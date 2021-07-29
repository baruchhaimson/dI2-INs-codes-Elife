function varargout = Transition_GUI(varargin)
% TRANSITION_GUI MATLAB code for Transition_GUI.fig
%      TRANSITION_GUI, by itself, creates a new TRANSITION_GUI or raises the existing
%      singleton*.
%
%      H = TRANSITION_GUI returns the handle to a new TRANSITION_GUI or the handle to
%      the existing singleton*.
%
%      TRANSITION_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TRANSITION_GUI.M with the given input arguments.
%
%      TRANSITION_GUI('Property','Value',...) creates a new TRANSITION_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Transition_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Transition_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Transition_GUI

% Last Modified by GUIDE v2.5 21-Apr-2015 15:08:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Transition_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @Transition_GUI_OutputFcn, ...
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


% --- Executes just before Transition_GUI is made visible.
function Transition_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Transition_GUI (see VARARGIN)

% Choose default command line output for Transition_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Transition_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);
 addpath(genpath(pwd))

% --- Outputs from this function are returned to the command line.
function varargout = Transition_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in ResetInterpolation_pushbutton.
function ResetInterpolation_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to ResetInterpolation_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button = questdlg({'Do you realy want to reset the interpolation?',...
    'The current data will be deleted.'},'Return The Main Screen','Yes');
switch button
    case 'No'
        return
    case 'Yes'
        close(Transition_GUI);
        delete('Interpolated_data.mat');
        Project_GUI_screen_II
end

% --- Executes on button press in ReturnToMainScreen_pushbutton.
function ReturnToMainScreen_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to ReturnToMainScreen_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button = questdlg('Do you realy want to return to the main screen? The current data will be deleted.',...
    'Return The Main Screen','Yes');
switch button
    case 'No'
        return
    case 'Yes'
        close(Transition_GUI);
        delete('Main_data.mat');
        delete('Interpolated_data.mat');
        Project_GUI
end

% --- Executes on button press in WholeVolumeVisualization_pushbutton.
function WholeVolumeVisualization_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to WholeVolumeVisualization_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(Transition_GUI)
Whole_Volume_Visualization_GUI;

% --- Executes on button press in Isosurfaces_pushbutton.
function Isosurfaces_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Isosurfaces_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(Transition_GUI)
IsoSurfaces_GUI;

% --- Executes on button press in Contours_pushbutton.
function Contours_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Contours_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(Transition_GUI)
Contours_GUI;

% --- Executes on button press in SectionViewer_pushbutton.
function SectionViewer_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to SectionViewer_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(Transition_GUI)
SectionViewer_GUI;

% --- Executes on button press in WholeVolumeVisualizationQ_pushbutton.
function WholeVolumeVisualizationQ_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to WholeVolumeVisualizationQ_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox({'Whole Volume Visualization will allow screening the volume as a whole'...
    'together with the ability to manipulate Alpha values (transparency values).'},'Whole Volume Visualization Help')

% --- Executes on button press in IsosurfacesQ_pushbutton.
function IsosurfacesQ_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to IsosurfacesQ_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox({'Isosurfaces will allow creating "envelops" around pixels of an input threshold,'...
    'and thus to create a 3D reconstruction of the object.'},'Isosurfaces Help')

% --- Executes on button press in ContoursQ_pushbutton.
function ContoursQ_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to ContoursQ_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox('Contours will allow to present "topographic map"-like sections of the volume.','Contours Help')

% --- Executes on button press in SectionViewerQ_pushbutton.
function SectionViewerQ_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to SectionViewerQ_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox({'SectionViewer will allow presenting sections of the volume in requested angles.'},'SectionViewer Help')
