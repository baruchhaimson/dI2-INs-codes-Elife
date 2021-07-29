function varargout = Project_GUI(varargin)
% PROJECT_GUI MATLAB code for Project_GUI.fig
%      PROJECT_GUI, by itself, creates a new PROJECT_GUI or raises the existing
%      singleton*.
%
%      H = PROJECT_GUI returns the handle to a new PROJECT_GUI or the handle to
%      the existing singleton*.
%
%      PROJECT_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROJECT_GUI.M with the given input arguments.
%
%      PROJECT_GUI('Property','Value',...) creates a new PROJECT_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Project_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Project_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Project_GUI

% Last Modified by GUIDE v2.5 29-Apr-2015 15:44:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Project_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @Project_GUI_OutputFcn, ...
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Introduction%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Date:30.4.15
%Name: Baruch Haimson
%I.D: 302917075

%The following program allows creation of a volume by interpolation
%of a series of pictures along a single axis.
%In addition, it supplies a set of volume's visualization options.

%However, The following conditions must be accomplished for the program
%in order to work properly:
%A.The images must be in the same size.
%B.The images must be in the same resolution.
%C.The step size between the images must be constant.
%D.The Ratio between the number of pixels to real distance must be
%constant.

%Because it's quite difficult to understand what is the meaning of each line of the code,
%I highly recommend to begin try using the program, and just
%then reading the code itself.
%For this purpose, I attached two example sets of images (in my project
%file) you can use.

%Importantly, the program was written in a way that was more easy for me  
%to understand, and therefore it is very likely that there are commands
%that could be written more efficiently.

%I tried to supply simple explanations next to each feature of the program, 
%in order to enable new users understand easly. These explanations
%are marked by '?' pushbuttons.
%In cases it still unclear what the role of a certain feature, 
%you can contact me for further explantions. 

%Because of technical reasons, the first GUI must always remains open (however can be minimized),
%while the rest of the GUIs can be closed. Exiting the first GUI will cause
%the closre of all other GUIs (and deletion of the temporary variables).

%Finally, during the program I used the terms X,Y and Z axises in order to describe
%the width, length and height of volume, respectively. The width and length
%are properties of the original images, and the height stems from the
%interpolation process (depends on the step size, ratio between number of
%pixel to actual distance and number of images.
 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes just before Project_GUI is made visible.
function Project_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Project_GUI (see VARARGIN)

% Choose default command line output for Project_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Project_GUI wait for user response (see UIRESUME)
% uiwait(handles.Project_GUI);

if exist('project','file')==2 %Checks whether the project's file is in matlab's ?search path? 
    addpath(genpath(pwd))     %Adds the current path (the current file and all its subfolders) to matlab's search path
else
    errordlg('Please set your current path to the file of my project');
end

%Presentation of representative images of the program's features in the
%correseponding axes systems.
axes(handles.Whole_Volume_Visualization_Axes); 
image1=imread('WholeVolumeVisualization_Image.jpg');
imshow(image1)
axis fill

axes(handles.Isosurfaces_Axes);
image1=imread('IsoSurface_Image.jpg');
imshow(image1)
axis fill

axes(handles.Contours_Axes);
image1=imread('Contours_Image.jpg');
imshow(image1)
axis fill

axes(handles.SectionViewer_Axes);
image1=imread('SectionViewer_Image.JPG');
imshow(image1)
axis fill

guidata(hObject, handles);



% --- Outputs from this function are returned to the command line.
function varargout = Project_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in LoadImagespushbutton.
function LoadImagespushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to LoadImagespushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Asks the user to choose the images for the analysis. This command allows
%multiselection of the mentioned formats.
[images_names, pathname] = uigetfile({'*.tif';'*.BMP'; ...
   '*.PNG';'*.GIf';'*.JPEG';},'Pick an image','MultiSelect', 'on'); 
if isequal(images_names,0) %For case the user presses 'cancel'
    return
else                       %The user chose images
    hwait_bar=waitbar(0,'Loading Images, Please Wait...'); %waitbar in order to inform the user about the process progression
    path(char(pathname),path);  %Adds the path name to the ?search path? of matlab
    image_info=imfinfo(char(images_names(1))); %Gets the images information for future use 
    num_images=length(images_names); %Gets the images' number images 
    for i=1:num_images               %Creates a structre for all images and elevates the waitbar       
        images(i).image=imread(char(images_names(i))); 
        waitbar(i / num_images)
    end

    close(hwait_bar)
    %The next 4 lines creates a new structre with all the data and saves it, for use in the next GUI. 
    Main_data.images=images;
    Main_data.image_info=image_info;
    Main_data.num_images=num_images;
    save('Main_data.mat','Main_data');
    Project_GUI_screen_II %Calls the next GUI - for interpolation
end

% --- Executes on button press in Exitpushbutton.
function Exitpushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Exitpushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Exit_Choice = questdlg('Are you sure you want to exit?','Exit Dialog','Yes','No','Yes');
switch Exit_Choice
    case 'Yes'
        if exist('Main_data.mat')==2         %Checks whether a variable called 'Main_data.mat' 
            delete('Main_data.mat');         %exist, and if so, deletes it.
        end
        if exist('Interpolated_data.mat')==2 %Checks whether a variable called ''Interpolated_data.mat''
            delete('Interpolated_data.mat'); %(this variable is being created later)exist, and if so, deletes it.
        end
        rmpath(genpath(pwd)) %Deletes the path added at the beggining  
        close all
        exit
    case 'No'
        return
end



% --- Executes when user attempts to close Project_GUI.
function Project_GUI_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to Project_GUI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
if exist('Main_data.mat')==2         %similar to the Exitpushbutton_Callback
    delete('Main_data.mat');
end
if exist('Interpolated_data.mat')==2
    delete('Interpolated_data.mat');
end
rmpath(genpath(pwd))
close all



% --- Executes on button press in LoadImagesQ_pushbutton.
function LoadImagesQ_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to LoadImagesQ_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox({'In order to start a project you should load your basic images.'...
        'Please notice that the software is compatible only with the following formats:'...
        'BMP, JPEG,TIFF,PNG and GIF.'...
        'In addition, please make sure that you load all your images from the same file'},'Load Images Help');


% --- Executes on button press in IsosurfacesQ_pushbutton.
function IsosurfacesQ_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to IsosurfacesQ_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox('The "Isosurfaces" function allows creation of a surface around an input value of a pixel','Isosurfaces Help')

% --- Executes on button press in SectionViewerQ_pushbutton.
function SectionViewerQ_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to SectionViewerQ_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox('The "SectionViewer" function allows visualization of sections of your volume in any required angle.','Section Viewer Help')

% --- Executes on button press in ContoursQ_pushbutton.
function ContoursQ_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to ContoursQ_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox('The "Contours" function allows visualization of a single section or multiple sections as contours(topographic maps).','Contours Help')

% --- Executes on button press in WholeVolumeVisualizationQ_pushbutton.
function WholeVolumeVisualizationQ_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to WholeVolumeVisualizationQ_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox('The "Whole Volume Visualization" function allows visualization of the entire volume and optional alpha values modifications','Whole Volume Visualization Help')
