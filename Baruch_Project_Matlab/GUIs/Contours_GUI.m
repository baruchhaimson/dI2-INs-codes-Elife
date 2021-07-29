function varargout = Contours_GUI(varargin)
% CONTOURS_GUI MATLAB code for Contours_GUI.fig
%      CONTOURS_GUI, by itself, creates a new CONTOURS_GUI or raises the existing
%      singleton*.
%
%      H = CONTOURS_GUI returns the handle to a new CONTOURS_GUI or the handle to
%      the existing singleton*.
%
%      CONTOURS_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CONTOURS_GUI.M with the given input arguments.
%
%      CONTOURS_GUI('Property','Value',...) creates a new CONTOURS_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Contours_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Contours_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Contours_GUI

% Last Modified by GUIDE v2.5 28-Apr-2015 14:12:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Contours_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @Contours_GUI_OutputFcn, ...
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


% --- Executes just before Contours_GUI is made visible.
function Contours_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Contours_GUI (see VARARGIN)

% Choose default command line output for Contours_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Contours_GUI wait for user response (see UIRESUME)
% uiwait(handles.Contours);

Data=load('Interpolated_data.mat');  %loads data saved in the previous GUI
%extracts information for future use.
handles.total_V=Data.Interpolated_data.total_V;
handles.N_dim_total_V=ndims(handles.total_V);

set(handles.GrayChannel_text,'Visible', 'off'); %The defualt status of this text

if handles.N_dim_total_V==3 %gray scale
    set(handles.Channels_uipanel,'Visible', 'off');
    set(handles.GrayChannel_text,'Visible', 'on');
end

%The following handles blocks are necessary for being enabled/disabled during the program.
handles.SerialPlains_block=[handles.NumOfPlains_text, handles.NumOfPlains_edit,...
    handles.NumberOfPlainsQ_pushbutton,handles.FirstPlain_text, handles.FirstPlain_edit,...
    handles.FirstPlainQ_pushbutton,handles.LastPlain_text, handles.LastPlain_edit,...
    handles.LastPlainQ_pushbutton,handles.NumOfContourLevelsSerial_text,...
    handles.NumOfContourLevelsSerial_edit,handles.NumOfContourLevelsSerialQ_pushbutton];
handles.SpecificPlain_block=[handles.PlainNumber_text, handles.PlainNumber_edit,...
    handles.PlainNumberQ_pushbutton,handles.NumOfContourLevels_text,...
    handles.NumOfContourLevels_edit,handles.NumOfContourLevelsQ_pushbutton...
    handles.FillInColors_checkbox,handles.FillInColorsQ_pushbutton];

handles.SerialPlains_edit_block=[handles.NumOfPlains_edit,handles.FirstPlain_edit,...
    handles.LastPlain_edit,handles.NumOfContourLevelsSerial_edit];
handles.SpecificPlain_edit_block=[handles.PlainNumber_edit,...
    handles.NumOfContourLevels_edit];

set(handles.SerialPlains_block,'Enable', 'off'); %The defualt status of this block

handles.Channels_choice='RedChannel_radiobutton'; %defualt choice (Important if the user doesn't change the defualt)
handles.Axises_choice='Xaxis_radiobutton'; %defualt choice (Important if the user doesn't change the defualt)
handles.PlainsNumberOptions_choice='SpecificPlain_radiobutton'; %defualt choice (Important if the user doesn't change the defualt)
handles.FillInColors_choice=0;%defualt choice (Important if the user doesn't change the defualt)
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = Contours_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function PlainNumber_edit_Callback(hObject, eventdata, handles)
% hObject    handle to PlainNumber_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of PlainNumber_edit as text
%        str2double(get(hObject,'String')) returns contents of PlainNumber_edit as a double
handles.PlainNumber=str2double(get(hObject,'String'));
guidata(hObject, handles); 

% --- Executes during object creation, after setting all properties.
function PlainNumber_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PlainNumber_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function NumOfPlains_edit_Callback(hObject, eventdata, handles)
% hObject    handle to NumOfPlains_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NumOfPlains_edit as text
%        str2double(get(hObject,'String')) returns contents of NumOfPlains_edit as a double
handles.NumOfPlains=str2double(get(hObject,'String'));
guidata(hObject, handles); 

% --- Executes during object creation, after setting all properties.
function NumOfPlains_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumOfPlains_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function FirstPlain_edit_Callback(hObject, eventdata, handles)
% hObject    handle to FirstPlain_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FirstPlain_edit as text
%        str2double(get(hObject,'String')) returns contents of FirstPlain_edit as a double
handles.FirstPlain=str2double(get(hObject,'String'));
guidata(hObject, handles); 

% --- Executes during object creation, after setting all properties.
function FirstPlain_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FirstPlain_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function LastPlain_edit_Callback(hObject, eventdata, handles)
% hObject    handle to LastPlain_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LastPlain_edit as text
%        str2double(get(hObject,'String')) returns contents of LastPlain_edit as a double
handles.LastPlain=str2double(get(hObject,'String'));
guidata(hObject, handles); 

% --- Executes during object creation, after setting all properties.
function LastPlain_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LastPlain_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes when selected object is changed in Channels_uipanel.
function Channels_uipanel_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in Channels_uipanel 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
if handles.N_dim_total_V==4 %may be important because if it gray scale it is invisible. 
    handles.Channels_choice=get(eventdata.NewValue,'Tag'); % Gets Tag of selected object.
    guidata(hObject,handles);
end

% --- Executes when selected object is changed in Axises_uipanel.
function Axises_uipanel_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in Axises_uipanel 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
handles.Axises_choice=get(eventdata.NewValue,'Tag'); % Gets Tag of selected object.
guidata(hObject,handles);

% --- Executes when selected object is changed in PlainsNumberOptions_uipanel.
function PlainsNumberOptions_uipanel_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in PlainsNumberOptions_uipanel 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
handles.PlainsNumberOptions_choice=get(eventdata.NewValue,'Tag'); % Gets Tag of selected object.
if strcmp(handles.PlainsNumberOptions_choice,'SerialPlains_radiobutton')
    set(handles.SerialPlains_block,'Enable', 'on');
    set(handles.SpecificPlain_block,'Enable', 'off');
    set(handles.SpecificPlain_edit_block,'string','');
else %handles.PlainsNumberOptions_choice='SpecificPlain_radiobutton'
    set(handles.SpecificPlain_block,'Enable', 'on');
    set(handles.SerialPlains_block,'Enable', 'off');
    set(handles.SerialPlains_edit_block,'string','');
end
guidata(hObject,handles);

% --- Executes on button press in FillInColors_checkbox.
function FillInColors_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to FillInColors_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of FillInColors_checkbox
handles.FillInColors_choice=get(hObject,'Value');
guidata(hObject,handles);

function NumOfContourLevels_edit_Callback(hObject, eventdata, handles)
% hObject    handle to NumOfContourLevels_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NumOfContourLevels_edit as text
%        str2double(get(hObject,'String')) returns contents of NumOfContourLevels_edit as a double
handles.NumOfContourLevels=str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function NumOfContourLevels_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumOfContourLevels_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function NumOfContourLevelsSerial_edit_Callback(hObject, eventdata, handles)
% hObject    handle to NumOfContourLevelsSerial_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NumOfContourLevelsSerial_edit as text
%        str2double(get(hObject,'String')) returns contents of NumOfContourLevelsSerial_edit as a double
handles.NumOfContourLevelsSerial=str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function NumOfContourLevelsSerial_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumOfContourLevelsSerial_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in Visualize_pushbutton.
function Visualize_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Visualize_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%for convenience
total_V=handles.total_V;
width_image=size(total_V,1);
length_image=size(total_V,2);
height_volume=size(total_V,3);

%color map for each channel
cm_red=[0:(1/63):1;zeros(2,64)]';
cm_green=[zeros(1,64);0:(1/63):1;zeros(1,64)]';
cm_blue=[zeros(2,64);0:(1/63):1]';

%Beggining of a very long condition which has the following structure:
%PlainsNumberOptions_choice->Gray Scale/RGB->Axises_choice->channel selected.
%In addition, there are validations of inputs along the way.


switch handles.PlainsNumberOptions_choice
    %%%%%%%%%%%SerialPlains section%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case 'SerialPlains_radiobutton'
        %%%validation of NumOfPlains input
        NumOfPlains_str= get(handles.NumOfPlains_edit,'string');
        if strcmp(NumOfPlains_str,'')
            errordlg('You did not enter the number of planes');
            set(handles.NumOfPlains_edit,'string','');
            return 
        elseif isnan(handles.NumOfPlains)  
            errordlg('You must enter one positive number for the number of planes');
            set(handles.NumOfPlains_edit,'string','');
            return
        end
        %%%
        %%%validation of FirstPlain input
        FirstPlain_str= get(handles.FirstPlain_edit,'string');
        if strcmp(FirstPlain_str,'')
            errordlg('You did not enter the number for the first plane');
            set(handles.FirstPlain_edit,'string','');
            return 
        elseif isnan(handles.FirstPlain)  
            errordlg('You must enter one positive number for the first plane');
            set(handles.FirstPlain_edit,'string','');
            return              
        end
        %%%
        %%%validation of LastPlain input
        LastPlain_str= get(handles.LastPlain_edit,'string');
        if strcmp(LastPlain_str,'')
            errordlg('You did not enter the number for the last plane');
            set(handles.LastPlain_edit,'string','');
            return 
        elseif isnan(handles.LastPlain)  
            errordlg('You must enter one positive number for the last plane');
            set(handles.LastPlain_edit,'string','');
            return              
        end
        %%%
        %%%validation that the first and last plane are different, and if not, recommendation to use "Specific Plane" menu
        if handles.FirstPlain==handles.LastPlain
            errordlg('You inserted the same plane number for the first and last plane, please use the "Specific Plane" menu');
            set(handles.FirstPlain_edit,'string','');
            set(handles.LastPlain_edit,'string','');
            return              
        end
        %%%
        %%%if the user asks for just one plane.->recommendation to use
        %%%"Specific Plane" menu.
        if handles.NumOfPlains==1
            errordlg('For just one plane, please use the "Specific Plane" menu');
            set(handles.NumOfPlains_edit,'string','');
            return              
        end
        %%%
         %%%validation of NumOfContourLevelsSerial input
        NumOfContourLevelsSerial_str= get(handles.NumOfContourLevelsSerial_edit,'string');
        if strcmp(NumOfContourLevelsSerial_str,'')
            errordlg('You did not enter the number of contour levels');
            set(handles.NumOfContourLevelsSerial_edit,'string','');
            return 
        elseif isnan(handles.NumOfContourLevelsSerial)  
            errordlg('You must enter one positive number for the number of contour levels');
            set(handles.NumOfContourLevelsSerial_edit,'string','');
            return
        elseif handles.NumOfContourLevelsSerial<=0 || handles.NumOfContourLevelsSerial>64 
            errordlg('The number of contour levels should be above 0 and should not exceed 64');
            set(handles.NumOfContourLevelsSerial_edit,'string','');
            return
        end
        %%%
        
 
        %serial contours require meshgrid generation  
        [x_q,y_q,z_q]=meshgrid(1:length_image,1:width_image,1:height_volume); %please notice that for x
        %which usually contains the width is now the length and vice versa
        %for the y. This is due to certain features of meshgrid and
        %contourslice functions. In order ro compensate on the
        %aformentioned change, I changed also the order in "contourslice",
        %as tou can see below, so the x will mean the width and y- the
        %length as usual.
        
        if handles.N_dim_total_V==3 %gray scale
            switch handles.Axises_choice
                    case 'Xaxis_radiobutton'
                        %%%validation inputs are in the possible range of X axis 
                        if  handles.NumOfPlains<=0 || handles.NumOfPlains>width_image 
                        errordlg({'The number of planes should be above 0 and should not exceed' num2str(width_image)});
                        set(handles.NumOfPlains_edit,'string','');
                        return
                        end
                        if  handles.FirstPlain<=0 || handles.FirstPlain>width_image 
                        errordlg({'The number of the first plane should be above 0 and should not exceed' num2str(width_image)});
                        set(handles.FirstPlain_edit,'string','');
                        return
                        end
                        if  handles.LastPlain<=0 || handles.LastPlain>width_image 
                        errordlg({'The number of the last plane should be above 0 and should not exceed' num2str(width_image)});
                        set(handles.LastPlain_edit,'string','');
                        return
                        end
                        %%%
                        hwait_bar=waitbar(0,'Visualizing Contours,Please Wait...');
                        f=figure('Name','Contours','NumberTitle','off');
                        colormap(gray);
                        contourslice(x_q,y_q,z_q,total_V,... 
                        [],handles.FirstPlain:(handles.LastPlain-handles.FirstPlain)/handles.NumOfPlains:handles.LastPlain,[],...
                        handles.NumOfContourLevelsSerial); %notice the order's change between x and y
                        daspect([1,1,1]);
                        cameratoolbar(f);
                    case 'Yaxis_radiobutton'
                        %%%validation inputs are in the possible range of Y axis 
                        if  handles.NumOfPlains<=0 || handles.NumOfPlains>length_image 
                        errordlg({'The number of planes should be above 0 and should not exceed' num2str(length_image)});
                        set(handles.NumOfPlains_edit,'string','');
                        return
                        end
                        if  handles.FirstPlain<=0 || handles.FirstPlain>length_image
                        errordlg({'The number of the first plane should be above 0 and should not exceed' num2str(length_image)});
                        set(handles.FirstPlain_edit,'string','');
                        return
                        end
                        if  handles.LastPlain<=0 || handles.LastPlain>length_image 
                        errordlg({'The number of the last plane should be above 0 and should not exceed' num2str(length_image)});
                        set(handles.LastPlain_edit,'string','');
                        return
                        end
                        %%%
                        hwait_bar=waitbar(0,'Visualizing Contours,Please Wait...');
                        f=figure('Name','Contours','NumberTitle','off');
                        colormap(gray);
                        contourslice(x_q,y_q,z_q,total_V,...
                        handles.FirstPlain:(handles.LastPlain-handles.FirstPlain)/handles.NumOfPlains:handles.LastPlain,[],[],...
                        handles.NumOfContourLevelsSerial); %notice the order's change between x and y
                        daspect([1,1,1]);
                        cameratoolbar(f);
                    case 'Zaxis_radiobutton'
                        %%%validation inputs are in the possible range of Z axis 
                        if  handles.NumOfPlains<=0 || handles.NumOfPlains>height_volume
                        errordlg({'The number of planes should be above 0 and should not exceed' num2str(height_volume)});
                        set(handles.NumOfPlains_edit,'string','');
                        return
                        end
                        if  handles.FirstPlain<=0 || handles.FirstPlain>height_volume
                        errordlg({'The number of the first plane should be above 0 and should not exceed' num2str(height_volume)});
                        set(handles.FirstPlain_edit,'string','');
                        return
                        end
                        if  handles.LastPlain<=0 || handles.LastPlain>height_volume 
                        errordlg({'The number of the last plane should be above 0 and should not exceed' num2str(height_volume)});
                        set(handles.LastPlain_edit,'string','');
                        return
                        end
                        %%%
                        hwait_bar=waitbar(0,'Visualizing Contours,Please Wait...');
                        f=figure('Name','Contours','NumberTitle','off');
                        colormap(gray);
                        contourslice(x_q,y_q,z_q,total_V,...
                        [],[],handles.FirstPlain:(handles.LastPlain-handles.FirstPlain)/handles.NumOfPlains:handles.LastPlain,...
                        handles.NumOfContourLevelsSerial);
                        daspect([1,1,1]);
                        cameratoolbar(f);
            end
        else %handles.N_dim_total_V==4 (RGB) -The same as the gray scale just for each channel separately
            switch handles.Channels_choice
                case 'RedChannel_radiobutton'
                    switch handles.Axises_choice
                        case 'Xaxis_radiobutton'
                            %%%validation inputs are in the possible range of X axis
                            if  handles.NumOfPlains<=0 || handles.NumOfPlains>width_image 
                            errordlg({'The number of planes should be above 0 and should not exceed' num2str(width_image)});
                            set(handles.NumOfPlains_edit,'string','');
                            return
                            end
                            if  handles.FirstPlain<=0 || handles.FirstPlain>width_image 
                            errordlg({'The number of the first plane should be above 0 and should not exceed' num2str(width_image)});
                            set(handles.FirstPlain_edit,'string','');
                            return
                            end
                            if  handles.LastPlain<=0 || handles.LastPlain>width_image 
                            errordlg({'The number of the last plane should be above 0 and should not exceed' num2str(width_image)});
                            set(handles.LastPlain_edit,'string','');
                            return
                            end
                            %%%
                            hwait_bar=waitbar(0,'Visualizing Contours,Please Wait...');
                            f=figure('Name','Contours','NumberTitle','off');
                            colormap(cm_red);
                            contourslice(x_q,y_q,z_q,total_V(:,:,:,1),...
                            [],handles.FirstPlain:(handles.LastPlain-handles.FirstPlain)/handles.NumOfPlains:handles.LastPlain,[],...
                            handles.NumOfContourLevelsSerial);
                            daspect([1,1,1]);
                            cameratoolbar(f);
                        case 'Yaxis_radiobutton'
                            %%%validation inputs are in the possible range of Y axis 
                            if  handles.NumOfPlains<=0 || handles.NumOfPlains>length_image 
                            errordlg({'The number of planes should be above 0 and should not exceed' num2str(length_image)});
                            set(handles.NumOfPlains_edit,'string','');
                            return
                            end
                            if  handles.FirstPlain<=0 || handles.FirstPlain>length_image
                            errordlg({'The number of the first plane should be above 0 and should not exceed' num2str(length_image)});
                            set(handles.FirstPlain_edit,'string','');
                            return
                            end
                            if  handles.LastPlain<=0 || handles.LastPlain>length_image 
                            errordlg({'The number of the last plane should be above 0 and should not exceed' num2str(length_image)});
                            set(handles.LastPlain_edit,'string','');
                            return
                            end
                            %%%
                            hwait_bar=waitbar(0,'Visualizing Contours,Please Wait...');
                            f=figure('Name','Contours','NumberTitle','off');
                            colormap(cm_red);
                            contourslice(x_q,y_q,z_q,total_V(:,:,:,1),...
                            handles.FirstPlain:(handles.LastPlain-handles.FirstPlain)/handles.NumOfPlains:handles.LastPlain,[],[],...
                            handles.NumOfContourLevelsSerial);
                            daspect([1,1,1]);
                            cameratoolbar(f);
                        case 'Zaxis_radiobutton'
                            %%%validation inputs are in the possible range of Z axis
                            if  handles.NumOfPlains<=0 || handles.NumOfPlains>height_volume
                            errordlg({'The number of planes should be above 0 and should not exceed' num2str(height_volume)});
                            set(handles.NumOfPlains_edit,'string','');
                            return
                            end
                            if  handles.FirstPlain<=0 || handles.FirstPlain>height_volume
                            errordlg({'The number of the first plane should be above 0 and should not exceed' num2str(height_volume)});
                            set(handles.FirstPlain_edit,'string','');
                            return
                            end
                            if  handles.LastPlain<=0 || handles.LastPlain>height_volume 
                            errordlg({'The number of the last plane should be above 0 and should not exceed' num2str(height_volume)});
                            set(handles.LastPlain_edit,'string','');
                            return
                            end
                            %%%
                            hwait_bar=waitbar(0,'Visualizing Contours,Please Wait...');
                            f=figure('Name','Contours','NumberTitle','off');
                            colormap(cm_red);
                            contourslice(x_q,y_q,z_q,total_V(:,:,:,1),...
                            [],[],handles.FirstPlain:(handles.LastPlain-handles.FirstPlain)/handles.NumOfPlains:handles.LastPlain,...
                            handles.NumOfContourLevelsSerial);
                            daspect([1,1,1]);
                            cameratoolbar(f);
                    end
                case 'GreenChannel_radiobutton'
                    switch handles.Axises_choice
                        case 'Xaxis_radiobutton'
                            %%%validation inputs are in the possible range of X axis
                            if  handles.NumOfPlains<=0 || handles.NumOfPlains>width_image 
                            errordlg({'The number of planes should be above 0 and should not exceed' num2str(width_image)});
                            set(handles.NumOfPlains_edit,'string','');
                            return
                            end
                            if  handles.FirstPlain<=0 || handles.FirstPlain>width_image 
                            errordlg({'The number of the first plane should be above 0 and should not exceed' num2str(width_image)});
                            set(handles.FirstPlain_edit,'string','');
                            return
                            end
                            if  handles.LastPlain<=0 || handles.LastPlain>width_image 
                            errordlg({'The number of the last plane should be above 0 and should not exceed' num2str(width_image)});
                            set(handles.LastPlain_edit,'string','');
                            return
                            end
                            %%%
                            hwait_bar=waitbar(0,'Visualizing Contours,Please Wait...');
                            f=figure('Name','Contours','NumberTitle','off');
                            colormap(cm_green);
                            contourslice(x_q,y_q,z_q,total_V(:,:,:,2),...
                            [],handles.FirstPlain:(handles.LastPlain-handles.FirstPlain)/handles.NumOfPlains:handles.LastPlain,[],...
                            handles.NumOfContourLevelsSerial)
                            daspect([1,1,1]);
                            cameratoolbar(f);
                        case 'Yaxis_radiobutton'
                            %%%validation inputs are in the possible range of Y axis 
                            if  handles.NumOfPlains<=0 || handles.NumOfPlains>length_image 
                            errordlg({'The number of planes should be above 0 and should not exceed' num2str(length_image)});
                            set(handles.NumOfPlains_edit,'string','');
                            return
                            end
                            if  handles.FirstPlain<=0 || handles.FirstPlain>length_image
                            errordlg({'The number of the first plane should be above 0 and should not exceed' num2str(length_image)});
                            set(handles.FirstPlain_edit,'string','');
                            return
                            end
                            if  handles.LastPlain<=0 || handles.LastPlain>length_image 
                            errordlg({'The number of the last plane should be above 0 and should not exceed' num2str(length_image)});
                            set(handles.LastPlain_edit,'string','');
                            return
                            end
                            %%%
                            hwait_bar=waitbar(0,'Visualizing Contours,Please Wait...');
                            f=figure('Name','Contours','NumberTitle','off');
                            colormap(cm_green);
                            contourslice(x_q,y_q,z_q,total_V(:,:,:,2),...
                            handles.FirstPlain:(handles.LastPlain-handles.FirstPlain)/handles.NumOfPlains:handles.LastPlain,[],[],...
                            handles.NumOfContourLevelsSerial);
                            daspect([1,1,1]);
                            cameratoolbar(f);
                        case 'Zaxis_radiobutton'
                            %%%validation inputs are in the possible range of Z axis
                            if  handles.NumOfPlains<=0 || handles.NumOfPlains>height_volume
                            errordlg({'The number of planes should be above 0 and should not exceed' num2str(height_volume)});
                            set(handles.NumOfPlains_edit,'string','');
                            return
                            end
                            if  handles.FirstPlain<=0 || handles.FirstPlain>height_volume
                            errordlg({'The number of the first plane should be above 0 and should not exceed' num2str(height_volume)});
                            set(handles.FirstPlain_edit,'string','');
                            return
                            end
                            if  handles.LastPlain<=0 || handles.LastPlain>height_volume 
                            errordlg({'The number of the last plane should be above 0 and should not exceed' num2str(height_volume)});
                            set(handles.LastPlain_edit,'string','');
                            return
                            end
                            %%%
                            hwait_bar=waitbar(0,'Visualizing Contours,Please Wait...');
                            f=figure('Name','Contours','NumberTitle','off');
                            colormap(cm_green);
                            contourslice(x_q,y_q,z_q,total_V(:,:,:,2),...
                            [],[],handles.FirstPlain:(handles.LastPlain-handles.FirstPlain)/handles.NumOfPlains:handles.LastPlain,...
                            handles.NumOfContourLevelsSerial)
                            daspect([1,1,1]);
                            cameratoolbar(f);
                     end
                  case 'BlueChannel_radiobutton'
                      switch handles.Axises_choice
                        case 'Xaxis_radiobutton'
                            %%%validation inputs are in the possible range of X axis
                            if  handles.NumOfPlains<=0 || handles.NumOfPlains>width_image 
                            errordlg({'The number of planes should be above 0 and should not exceed' num2str(width_image)});
                            set(handles.NumOfPlains_edit,'string','');
                            return
                            end
                            if  handles.FirstPlain<=0 || handles.FirstPlain>width_image 
                            errordlg({'The number of the first plane should be above 0 and should not exceed' num2str(width_image)});
                            set(handles.FirstPlain_edit,'string','');
                            return
                            end
                            if  handles.LastPlain<=0 || handles.LastPlain>width_image 
                            errordlg({'The number of the last plane should be above 0 and should not exceed' num2str(width_image)});
                            set(handles.LastPlain_edit,'string','');
                            return
                            end
                            %%%
                            hwait_bar=waitbar(0,'Visualizing Contours,Please Wait...');
                            f=figure('Name','Contours','NumberTitle','off');
                            colormap(cm_blue);
                            contourslice(x_q,y_q,z_q,total_V(:,:,:,3),...
                            [],handles.FirstPlain:(handles.LastPlain-handles.FirstPlain)/handles.NumOfPlains:handles.LastPlain,[],...
                            handles.NumOfContourLevelsSerial)
                            daspect([1,1,1]);
                            cameratoolbar(f);
                        case 'Yaxis_radiobutton'
                            %%%validation inputs are in the possible range of Y axis 
                            if  handles.NumOfPlains<=0 || handles.NumOfPlains>length_image 
                            errordlg({'The number of planes should be above 0 and should not exceed' num2str(length_image)});
                            set(handles.NumOfPlains_edit,'string','');
                            return
                            end
                            if  handles.FirstPlain<=0 || handles.FirstPlain>length_image
                            errordlg({'The number of the first plane should be above 0 and should not exceed' num2str(length_image)});
                            set(handles.FirstPlain_edit,'string','');
                            return
                            end
                            if  handles.LastPlain<=0 || handles.LastPlain>length_image 
                            errordlg({'The number of the last plane should be above 0 and should not exceed' num2str(length_image)});
                            set(handles.LastPlain_edit,'string','');
                            return
                            end
                            %%%
                            hwait_bar=waitbar(0,'Visualizing Contours,Please Wait...');
                            f=figure('Name','Contours','NumberTitle','off');
                            colormap(cm_blue);
                            contourslice(x_q,y_q,z_q,total_V(:,:,:,3),...
                            handles.FirstPlain:(handles.LastPlain-handles.FirstPlain)/handles.NumOfPlains:handles.LastPlain,[],[],...
                            handles.NumOfContourLevelsSerial)
                            daspect([1,1,1]);
                            cameratoolbar(f);
                        case 'Zaxis_radiobutton'
                            %%%validation inputs are in the possible range of Z axis
                            if  handles.NumOfPlains<=0 || handles.NumOfPlains>height_volume
                            errordlg({'The number of planes should be above 0 and should not exceed' num2str(height_volume)});
                            set(handles.NumOfPlains_edit,'string','');
                            return
                            end
                            if  handles.FirstPlain<=0 || handles.FirstPlain>height_volume
                            errordlg({'The number of the first plane should be above 0 and should not exceed' num2str(height_volume)});
                            set(handles.FirstPlain_edit,'string','');
                            return
                            end
                            if  handles.LastPlain<=0 || handles.LastPlain>height_volume 
                            errordlg({'The number of the last plane should be above 0 and should not exceed' num2str(height_volume)});
                            set(handles.LastPlain_edit,'string','');
                            return
                            end
                            %%%
                            hwait_bar=waitbar(0,'Visualizing Contours,Please Wait...');
                            f=figure('Name','Contours','NumberTitle','off');
                            colormap(cm_blue);
                            contourslice(x_q,y_q,z_q,total_V(:,:,:,3),...
                            [],[],handles.FirstPlain:(handles.LastPlain-handles.FirstPlain)/handles.NumOfPlains:handles.LastPlain,...
                            handles.NumOfContourLevelsSerial)
                            daspect([1,1,1]);
                            cameratoolbar(f);
                      end
            end
        end
      %%%%%%%%%%%SpecificPlain section%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
      case 'SpecificPlain_radiobutton'
          %%validation of PlainNumber input
          PlainNumber_str= get(handles.PlainNumber_edit,'string');
          if strcmp(PlainNumber_str,'')
              errordlg('You did not enter a plane number');
              set(handles.PlainNumber_edit,'string','');
              return 
          elseif isnan(handles.PlainNumber)  
              errordlg('You must enter one positive plane number');
              set(handles.PlainNumber_edit,'string','');
              return
          end
          %%%
          %%validation of NumOfContourLevels input
          NumOfContourLevels_str= get(handles.NumOfContourLevels_edit,'string');
          if strcmp(NumOfContourLevels_str,'')
              errordlg('You did not enter the number of contour levels');
              set(handles.NumOfContourLevels_edit,'string','');
              return 
          elseif isnan(handles.NumOfContourLevels)  
              errordlg('You must enter one positive number for the number of contour levels');
              set(handles.NumOfContourLevels_edit,'string','');
              return
          elseif handles.NumOfContourLevels<=0 || handles.NumOfContourLevels>64 
              errordlg('The number of contour levels should be above 0 and should not exceed 64');
              set(handles.NumOfContourLevels_edit,'string','');
              return
          end
          %%%
          switch handles.Axises_choice
                    %%%validation inputs are in the possible range of all
                    %%%axises for 'SpecificPlain' section.
                    case 'Xaxis_radiobutton'
                        %%%validation inputs are in the possible range of X axis
                        if  handles.PlainNumber<=0 || handles.PlainNumber>width_image
                            errordlg({'The plane number should be above 0 and should not exceed' num2str(width_image)});
                            set(handles.PlainNumber_edit,'string','');
                            return
                        end
                        %%%
                    case 'Yaxis_radiobutton'
                        %%%validation inputs are in the possible range of Y axis 
                        if  handles.PlainNumber<=0 || handles.PlainNumber>length_image
                            errordlg({'The plane number should be above 0 and should not exceed' num2str(length_image)});
                            set(handles.PlainNumber_edit,'string','');
                            return
                        end
                        %%%
                    case 'Zaxis_radiobutton'
                        %%%validation inputs are in the possible range of Z axis
                        if  handles.PlainNumber<=0 || handles.PlainNumber>height_volume
                            errordlg({'The plane number should be above 0 and should not exceed' num2str(height_volume)});
                            set(handles.PlainNumber_edit,'string','');
                            return
                        end
                        %%%
                   %%%
          end
          hwait_bar=waitbar(0,'Visualizing Contours,Please Wait...');
          if handles.N_dim_total_V==3
             switch handles.Axises_choice
                    case 'Xaxis_radiobutton'
                        if handles.FillInColors_choice
                            f=figure('Name','Contours','NumberTitle','off');
                            colormap(gray);
                            contourf(squeeze(total_V(handles.PlainNumber,:,:)),handles.NumOfContourLevels)
                            daspect([1,1,1]);
                            cameratoolbar(f);
                        else
                            f=figure('Name','Contours','NumberTitle','off');
                            colormap(gray);
                            contour(squeeze(total_V(handles.PlainNumber,:,:)),handles.NumOfContourLevels)
                            daspect([1,1,1]);
                            cameratoolbar(f);
                        end
                    case 'Yaxis_radiobutton'
                        if handles.FillInColors_choice
                            f=figure('Name','Contours','NumberTitle','off');
                            colormap(gray);
                            contourf(squeeze(total_V(:,handles.PlainNumber,:)),handles.NumOfContourLevels)
                            daspect([1,1,1]);
                            cameratoolbar(f);
                        else
                            f=figure('Name','Contours','NumberTitle','off');
                            colormap(gray);
                            contour(squeeze(total_V(:,handles.PlainNumber,:)),handles.NumOfContourLevels)
                            daspect([1,1,1]);
                            cameratoolbar(f);
                        end
                    case 'Zaxis_radiobutton'
                        if handles.FillInColors_choice
                            f=figure('Name','Contours','NumberTitle','off');
                            colormap(gray);
                            contourf(squeeze(total_V(:,:,handles.PlainNumber)),handles.NumOfContourLevels)
                            daspect([1,1,1]);
                            cameratoolbar(f);
                        else
                            f=figure('Name','Contours','NumberTitle','off');
                            colormap(gray);
                            contour(squeeze(total_V(:,:,handles.PlainNumber)),handles.NumOfContourLevels)
                            daspect([1,1,1]);
                            cameratoolbar(f);
                        end
             end
          else %handles.N_dim_total_V==4 (RGB) -The same as the gray scale just for each channel separately
              switch handles.Channels_choice
                case 'RedChannel_radiobutton'
                    switch handles.Axises_choice
                        case 'Xaxis_radiobutton'
                            if handles.FillInColors_choice
                                f=figure('Name','Contours','NumberTitle','off');
                                colormap(cm_red);
                                contourf(squeeze(squeeze(total_V(handles.PlainNumber,:,:,1))),handles.NumOfContourLevels)
                                daspect([1,1,1]);
                                cameratoolbar(f);
                            else
                                f=figure('Name','Contours','NumberTitle','off');
                                colormap(cm_red);
                                contour(squeeze(squeeze(total_V(handles.PlainNumber,:,:,1))),handles.NumOfContourLevels)
                                daspect([1,1,1]);
                                cameratoolbar(f);
                            end
                        case 'Yaxis_radiobutton'
                            if handles.FillInColors_choice
                                f=figure('Name','Contours','NumberTitle','off');
                                colormap(cm_red);
                                contourf(squeeze(squeeze(total_V(:,handles.PlainNumber,:,1))),handles.NumOfContourLevels)
                                daspect([1,1,1]);
                                cameratoolbar(f);
                            else
                                f=figure('Name','Contours','NumberTitle','off');
                                colormap(cm_red);
                                contour(squeeze(squeeze(total_V(:,handles.PlainNumber,:,1))),handles.NumOfContourLevels)
                                daspect([1,1,1]);
                                cameratoolbar(f);
                            end
                        case 'Zaxis_radiobutton'
                            if handles.FillInColors_choice
                                f=figure('Name','Contours','NumberTitle','off');
                                colormap(cm_red);
                                contourf(squeeze(squeeze(total_V(:,:,handles.PlainNumber,1))),handles.NumOfContourLevels)
                                daspect([1,1,1]);
                                cameratoolbar(f);
                            else
                                f=figure('Name','Contours','NumberTitle','off');
                                colormap(cm_red);
                                contour(squeeze(squeeze(total_V(:,:,handles.PlainNumber,1))),handles.NumOfContourLevels)
                                daspect([1,1,1]);
                                cameratoolbar(f);
                            end
                    end
                   case 'GreenChannel_radiobutton'
                    switch handles.Axises_choice
                        case 'Xaxis_radiobutton'
                            if handles.FillInColors_choice
                                f=figure('Name','Contours','NumberTitle','off');
                                colormap(cm_green);
                                contourf(squeeze(squeeze(total_V(handles.PlainNumber,:,:,2))),handles.NumOfContourLevels)
                                daspect([1,1,1]);
                                cameratoolbar(f);
                            else
                                f=figure('Name','Contours','NumberTitle','off');
                                colormap(cm_green);
                                contour(squeeze(squeeze(total_V(handles.PlainNumber,:,:,2))),handles.NumOfContourLevels)
                                daspect([1,1,1]);
                                cameratoolbar(f);
                            end
                        case 'Yaxis_radiobutton'
                            if handles.FillInColors_choice
                                f=figure('Name','Contours','NumberTitle','off');
                                colormap(cm_green);
                                contourf(squeeze(squeeze(total_V(:,handles.PlainNumber,:,2))),handles.NumOfContourLevels)
                                daspect([1,1,1]);
                                cameratoolbar(f);
                            else
                                f=figure('Name','Contours','NumberTitle','off');
                                colormap(cm_green);
                                contour(squeeze(squeeze(total_V(:,handles.PlainNumber,:,2))),handles.NumOfContourLevels)
                                daspect([1,1,1]);
                                cameratoolbar(f);
                            end
                        case 'Zaxis_radiobutton'
                            if handles.FillInColors_choice
                                f=figure('Name','Contours','NumberTitle','off');
                                colormap(cm_green);
                                contourf(squeeze(squeeze(total_V(:,:,handles.PlainNumber,2))),handles.NumOfContourLevels)
                                daspect([1,1,1]);
                                cameratoolbar(f);
                            else
                                f=figure('Name','Contours','NumberTitle','off');
                                colormap(cm_green);
                                contour(squeeze(squeeze(total_V(:,:,handles.PlainNumber,2))),handles.NumOfContourLevels)
                                daspect([1,1,1]);
                                cameratoolbar(f);
                            end
                    end
                   case 'BlueChannel_radiobutton'
                    switch handles.Axises_choice
                        case 'Xaxis_radiobutton'
                            if handles.FillInColors_choice
                                f=figure('Name','Contours','NumberTitle','off');
                                colormap(cm_blue);
                                contourf(squeeze(squeeze(total_V(handles.PlainNumber,:,:,3))),handles.NumOfContourLevels)
                                daspect([1,1,1]);
                                cameratoolbar(f);
                            else
                                f=figure('Name','Contours','NumberTitle','off');
                                colormap(cm_blue);
                                contour(squeeze(squeeze(total_V(handles.PlainNumber,:,:,3))),handles.NumOfContourLevels)
                                daspect([1,1,1]);
                                cameratoolbar(f);
                            end
                        case 'Yaxis_radiobutton'
                            if handles.FillInColors_choice
                                f=figure('Name','Contours','NumberTitle','off');
                                colormap(cm_blue);
                                contourf(squeeze(squeeze(total_V(:,handles.PlainNumber,:,3))),handles.NumOfContourLevels)
                                daspect([1,1,1]);
                                cameratoolbar(f);
                            else
                                f=figure('Name','Contours','NumberTitle','off');
                                colormap(cm_blue);
                                contour(squeeze(squeeze(total_V(:,handles.PlainNumber,:,3))),handles.NumOfContourLevels)
                                daspect([1,1,1]);
                                cameratoolbar(f);
                            end
                        case 'Zaxis_radiobutton'
                            if handles.FillInColors_choice
                                f=figure('Name','Contours','NumberTitle','off');
                                colormap(cm_blue);
                                contourf(squeeze(squeeze(total_V(:,:,handles.PlainNumber,3))),handles.NumOfContourLevels)
                                daspect([1,1,1]);
                                cameratoolbar(f);
                            else
                                f=figure('Name','Contours','NumberTitle','off');
                                colormap(cm_blue);
                                contour(squeeze(squeeze(total_V(:,:,handles.PlainNumber,3))),handles.NumOfContourLevels)
                                daspect([1,1,1]);
                                cameratoolbar(f);
                            end
                    end
              end
          end
end
waitbar(1);
close(hwait_bar);



% --- Executes on button press in Return_pushbutton.
function Return_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Return_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(Contours_GUI)
Transition_GUI

% --- Executes when user attempts to close Contours.
function Contours_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to Contours (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
Transition_GUI
delete(hObject);

% --- Executes on button press in PlainNumberQ_pushbutton.
function PlainNumberQ_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to PlainNumberQ_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox({'You should insert the plane number you want to visualize its contour.'...
    'Please consider your axis choice.'},'Plain Number Help')

% --- Executes on button press in NumberOfPlainsQ_pushbutton.
function NumberOfPlainsQ_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to NumberOfPlainsQ_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox({'You should insert the number of planes you want to visualize their contour.'...
    'Please consider your axis choice, number of planes not supposed to exceed axis length.'},'Number Of Plains Help')

% --- Executes on button press in FirstPlainQ_pushbutton.
function FirstPlainQ_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to FirstPlainQ_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox({'You should insert the number of the first plane you want to visualize its contour.'...
    'Please consider your axis choice, the first plane number not supposed to exceed axis length.'},'First Plain Help')

% --- Executes on button press in LastPlainQ_pushbutton.
function LastPlainQ_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to LastPlainQ_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox({'You should insert the number of the first plane you want to visualize its contour.'...
    'Please consider your axis choice, the first plane number not supposed to exceed axis length.'},'Last Plain Help')

% --- Executes on button press in AxisesQ_pushbutton.
function AxisesQ_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to AxisesQ_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox('Please choose along which axis the contour sections are being made','Axises Help')

% --- Executes on button press in PlainsNumberOptionsQ_pushbutton.
function PlainsNumberOptionsQ_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to PlainsNumberOptionsQ_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox('Do you want one specific contour section or a set of contour sections?','Plains Number Options Help')

% --- Executes on button press in ChannelsQ_pushbutton.
function ChannelsQ_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to ChannelsQ_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox({'The contours are made only for one channel.'...
    'Which channel do you choose?'},'Channels Help')

% --- Executes on button press in FillInColorsQ_pushbutton.
function FillInColorsQ_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to FillInColorsQ_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox('Do you want to fill in colores between each contour level?','Fill In Colors Help')

% --- Executes on button press in NumOfContourLevelsQ_pushbutton.
function NumOfContourLevelsQ_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to NumOfContourLevelsQ_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox('How many contour levels (contour lines) do you want in your topographic map?','Number Of Contour Levels Help')

% --- Executes on button press in NumOfContourLevelsSerialQ_pushbutton.
function NumOfContourLevelsSerialQ_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to NumOfContourLevelsSerialQ_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox('How many contour levels (contour lines) do you want in your topographic map?','Number Of Contour Levels Help')
