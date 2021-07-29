function varargout = Project_GUI_screen_II(varargin)
% PROJECT_GUI_SCREEN_II MATLAB code for Project_GUI_screen_II.fig
%      PROJECT_GUI_SCREEN_II, by itself, creates a new PROJECT_GUI_SCREEN_II or raises the existing
%      singleton*.
%
%      H = PROJECT_GUI_SCREEN_II returns the handle to a new PROJECT_GUI_SCREEN_II or the handle to
%      the existing singleton*.
%
%      PROJECT_GUI_SCREEN_II('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROJECT_GUI_SCREEN_II.M with the given input arguments.
%
%      PROJECT_GUI_SCREEN_II('Property','Value',...) creates a new PROJECT_GUI_SCREEN_II or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Project_GUI_screen_II_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Project_GUI_screen_II_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Project_GUI_screen_II

% Last Modified by GUIDE v2.5 26-Apr-2015 19:27:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Project_GUI_screen_II_OpeningFcn, ...
                   'gui_OutputFcn',  @Project_GUI_screen_II_OutputFcn, ...
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


% --- Executes just before Project_GUI_screen_II is made visible.
function Project_GUI_screen_II_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Project_GUI_screen_II (see VARARGIN)

% Choose default command line output for Project_GUI_screen_II
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Project_GUI_screen_II wait for user response (see UIRESUME)
% uiwait(handles.Project_screenII_GUI);

%The following handles blocks are necessary for being enabled/disabled during the program.  
handles.Interpolation_block=[handles.StepSize_text,handles.StepSize_edit,handles.StepSizeQ_pushbutton,...
    handles.Ratio_text,handles.Ratio_edit,handles.RatioQ_pushbutton,handles.GrayScale_radiobutton...
    handles.RGB_radiobutton,handles.RGB_choiceQ_pushbutton,handles.Interpolate_pushbutton];
handles.Options_block= [handles.Whole_Volume_visualiztion_pushbutton, handles.Isosurfaces_pushbutton,...
    handles.Contours_pushbutton,handles.Section_Veiwer_pushbutton,...
    handles.WholeVolumeVisualizationQ_pushbutton,handles.IsosurfacesQ_pushbutton,...
    handles.ContoursQ_pushbutton,handles.SectionViewerQ_pushbutton];
set(handles.Options_block,'Enable', 'off'); %sets the option block 'off'-it will be enabled only after interpolation  
set(handles.ResetInterpolation_pushbutton,'Enable', 'off'); %sets the reset interpolation button 'off'-it will be enabled only after interpolation  

Data=load('Main_data.mat'); %loads data saved in the previous GUI

handles.images=Data.Main_data.images;         %extract information for future use.
handles.image_info=Data.Main_data.image_info;
handles.num_images=Data.Main_data.num_images;
handles.RGB_choice='GrayScale_radiobutton';   %sets the default of 'RGB_choice' to 'gray scale'
                                              %it will be changed if the
                                              %user will choose RGB
                                              %interpolation. Important if
                                              %the user doesn't change the
                                              %default.
                                               

guidata(hObject, handles); %updates handles 


% --- Outputs from this function are returned to the command line.
function varargout = Project_GUI_screen_II_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function StepSize_edit_Callback(hObject, eventdata, handles)
% hObject    handle to StepSize_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of StepSize_edit as text
%        str2double(get(hObject,'String')) returns contents of StepSize_edit as a double

%This and The Ratio edit boxes are necessary because this information can't
%be extracted from most of images formats. Therefore, I ask the user to
%insert these two variables.



% --- Executes during object creation, after setting all properties.
function StepSize_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to StepSize_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function Ratio_edit_Callback(hObject, eventdata, handles)
% hObject    handle to Ratio_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Ratio_edit as text
%        str2double(get(hObject,'String')) returns contents of Ratio_edit as a double

%This and The StepSize edit boxes are necessary because this information can't
%be extracted from most of images formats. Therefore, I ask the user to
%insert these two variables.

% --- Executes during object creation, after setting all properties.
function Ratio_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ratio_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in Interpolate_pushbutton.
function Interpolate_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Interpolate_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%%Validation of StepSize and Ratio edit boxes inputs- empty,not a number or negative value
d_str= get(handles.StepSize_edit,'string');
if strcmp(d_str,'')
    errordlg('You did not enter a number for the Step Size');
    set(handles.StepSize_edit,'string','');
    return
end
d= str2double(d_str);
if isnan(d) || d<=0 
    errordlg('You must enter one positive number for the Step Size');
    set(handles.StepSize_edit,'string','');
    return
end

Ratio_str= get(handles.Ratio_edit,'string');
if strcmp(Ratio_str,'')
    errordlg('You did not enter a number for the Ratio');
    set(handles.Ratio_edit,'string','');
    return
end
Ratio= str2double(Ratio_str);
if isnan(Ratio) || Ratio<=0 
    errordlg('You must enter one positive number for the Ratio');
    set(handles.Ratio_edit,'string','');
    return
end
%%%end of inputs validation

%extracting information from handles structure for convenience
images=handles.images;
image_info=handles.image_info;
num_images=handles.num_images;

RGB_choice = handles.RGB_choice; %gets the RGB choice: GrayScale(default) or RGB

hwait_bar=waitbar(0,'Interpolating,Please Wait...');

%extracting information from handles structure for convenience
length_image=image_info.Height;
width_image=image_info.Width;
height_volume=ceil((num_images-1)*d*Ratio); %the height in pixels to be interpolated
                                            %according to the step size and
                                            %ratio. must be rounded
                                            %"ceil" in order preventing
                                            %data loss (one plane/hight of
                                            %pixel)

%creation of grids in the appropriate dimension for interpolation process                                            
[x,y,z]=ndgrid(1:length_image,1:width_image,1:(d*Ratio):height_volume+1);
[x_q,y_q,z_q]=ndgrid(1:length_image,1:width_image,1:height_volume);

%initiation of a variable that will contain all input data(for GrayScale choice)
%or the input data of red channel (for RGB choice).
V_r=zeros(length_image,width_image,num_images);
waitbar(0.2);
switch RGB_choice
    case 'RGB_radiobutton' %interpolation of each channel separately
        V_g=V_r;           %a variable that will contain the input data of green channel
        V_b=V_r;           %a variable that will contain the input data of blue channel
        for i=1:num_images %loading the images of each channel in its variable 
        V_r(:,:,i)=images(i).image(:,:,1);
        V_g(:,:,i)=images(i).image(:,:,2);
        V_b(:,:,i)=images(i).image(:,:,3);
        end
        %creates a 3-D interpolant from a vector of sample points,x,y,z, and corresponding values,v.
        %I chose to use 'spline interpolation' which is the most
        %appropriate and contains the less amount of errors than all the
        %other optional methods. However, it requires more memory and computation time than the others,
        %but in our case it's not so significant.
        F_r=griddedInterpolant(x,y,z,V_r,'spline'); 
        F_g=griddedInterpolant(x,y,z,V_g,'spline');
        F_b=griddedInterpolant(x,y,z,V_b,'spline');
        
        %evaluates F at a set of query points in the matrix Xq, Yq and Zq, defined earlier.
        V_rq=F_r(x_q,y_q,z_q);
        V_gq=F_g(x_q,y_q,z_q);
        V_bq=F_b(x_q,y_q,z_q);
        
        waitbar(0.8);
        
        %generation of a new variable "total_V", that will contain all the
        %data
        total_V(:,:,:,1)=V_rq;
        total_V(:,:,:,2)=V_gq;
        total_V(:,:,:,3)=V_bq;
    
        %for the GrayScale, I did transformation from RGB to Gray Scale and then the same as
        %for the RGB, just for a single channel.
    case 'GrayScale_radiobutton' 
        for i=1:num_images
            V_r(:,:,i)=rgb2gray(images(i).image);
        end
        F_r=griddedInterpolant(x,y,z,V_r,'spline');
        V_rq=F_r(x_q,y_q,z_q);
        waitbar(0.8);
        total_V=V_rq;
end
    
total_V=uint8(round(total_V)); %after interpolation, there is a need to round the values
                               %and make them uint8, the appropriate format
                               %for images.
                               %trimming of values beyond 255 and 0 (generated by interpolation) 
                               %are not necessary because uint8 makes them
                               %255 and 0 respectively.
waitbar(1);
Interpolated_data.total_V=total_V;                 %generates a new structure and saves it
save('Interpolated_data.mat','Interpolated_data'); %for a use in other GUIs.
close(hwait_bar)

%%%The lines below coding for the message about the type and height of interpolation done. 
type_str='RGB';
if length(total_V(1,1,1,:))==1
    type_str='Gray Scale';
end
height_str=num2str(height_volume);
HeadersString= sprintf('height:\n\nIntrapolation Type:');
DetailsString= sprintf([height_str '\n\n' type_str]);
set(handles.Intrapolation_Done_text,'string','Intrapolation Done','FontWeight','bold',...
    'ForegroundColor','r')
set(handles.Headers_Intrapolation_text,'string',HeadersString)
set(handles.Intrapolation_details_text,'string',DetailsString)
%%%

%After interpolation there is need to enable all the program options,
%and to allow reset interpolation
set(handles.Options_block,'Enable','on');
set(handles.ResetInterpolation_pushbutton,'Enable', 'on');

%and to disable to interpolation block 
set(handles.Interpolation_block,'Enable','off'); 

guidata(hObject, handles); %updates handles

% --- Executes on button press in Return_ScreenII_Button.
function Return_ScreenII_Button_Callback(hObject, eventdata, handles)
% hObject    handle to Return_ScreenII_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(Project_GUI_screen_II) %closes the GUI


% --- Executes on button press in Whole_Volume_visualiztion_pushbutton.
function Whole_Volume_visualiztion_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Whole_Volume_visualiztion_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(Project_GUI_screen_II)
Whole_Volume_Visualization_GUI;


% --- Executes on button press in Isosurfaces_pushbutton.
function Isosurfaces_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Isosurfaces_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(Project_GUI_screen_II)
IsoSurfaces_GUI;


% --- Executes on button press in Contours_pushbutton.
function Contours_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Contours_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(Project_GUI_screen_II)
Contours_GUI;


% --- Executes on button press in Section_Veiwer_pushbutton.
function Section_Veiwer_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Section_Veiwer_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(Project_GUI_screen_II)
SectionViewer_GUI;

% --- Executes when selected object is changed in InterpolationType_uipanel.
function InterpolationType_uipanel_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in InterpolationType_uipanel 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
handles.RGB_choice=get(eventdata.NewValue,'Tag'); % Get Tag of selected object.
guidata(hObject,handles);


% --- Executes on button press in ResetInterpolation_pushbutton.
function ResetInterpolation_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to ResetInterpolation_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete('Interpolated_data.mat');                           %deletes the interpolated data.
set(handles.Options_block,'Enable', 'off');                %disables the option block.
set(handles.Interpolation_block,'Enable', 'on');           %enables the interpolation block.
set(handles.Intrapolation_Done_text,'string','');          %deletes the message.
set(handles.Headers_Intrapolation_text,'string','');       %
set(handles.Intrapolation_details_text,'string','');       %
set(handles.ResetInterpolation_pushbutton,'Enable', 'off');%disables the reset interpolation button.


% --- Executes when user attempts to close Project_screenII_GUI.
function Project_screenII_GUI_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to Project_screenII_GUI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);


% --- Executes on button press in RatioQ_pushbutton.
function RatioQ_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to RatioQ_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox({'The ratio means how many pixels are equivalent to 1 um. Therefore,'...
    'the input must be a positive single number'},'Ratio Help')

% --- Executes on button press in StepSizeQ_pushbutton.
function StepSizeQ_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to StepSizeQ_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox({'The Step Size is the distance (um) between one image to another. Therefore,'...
    'the input must be a positive single number'},'Step Size Help')

% --- Executes on button press in RGB_choiceQ_pushbutton.
function RGB_choiceQ_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to RGB_choiceQ_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox({'You can choose to perform interpolation to each channel (preserves the RGB information)'...
    'or to transform the picture to gray scale and then interpolate it'},'RGB choice Help')

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
