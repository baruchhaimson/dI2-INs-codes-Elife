function varargout = IsoSurfaces_GUI(varargin)
% ISOSURFACES_GUI MATLAB code for IsoSurfaces_GUI.fig
%      ISOSURFACES_GUI, by itself, creates a new ISOSURFACES_GUI or raises the existing
%      singleton*.
%
%      H = ISOSURFACES_GUI returns the handle to a new ISOSURFACES_GUI or the handle to
%      the existing singleton*.
%
%      ISOSURFACES_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ISOSURFACES_GUI.M with the given input arguments.
%
%      ISOSURFACES_GUI('Property','Value',...) creates a new ISOSURFACES_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before IsoSurfaces_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to IsoSurfaces_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help IsoSurfaces_GUI

% Last Modified by GUIDE v2.5 28-Apr-2015 14:07:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @IsoSurfaces_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @IsoSurfaces_GUI_OutputFcn, ...
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


% --- Executes just before IsoSurfaces_GUI is made visible.
function IsoSurfaces_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to IsoSurfaces_GUI (see VARARGIN)

% Choose default command line output for IsoSurfaces_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes IsoSurfaces_GUI wait for user response (see UIRESUME)
% uiwait(handles.IsoSurfaces);
Data=load('Interpolated_data.mat'); %loads data saved in the previous GUI

%extracts information for future use.
handles.total_V=Data.Interpolated_data.total_V;
handles.N_dim_total_V=ndims(handles.total_V);

%The following handles blocks are necessary for being enabled/disabled during the program.  
handles.Gray_block= [handles.GrayThreshold_text, handles.GrayT_edit,...
    handles.GrayTQ_pushbutton];
handles.R_block= [handles.RedThreshold_text, handles.RedT_edit,...
    handles.RedTQ_pushbutton];
handles.G_block= [handles.GreenThreshold_text, handles.GreenT_edit,...
    handles.GreenTQ_pushbutton];
handles.B_block= [handles.BlueThreshold_text, handles.BlueT_edit,...
    handles.BlueTQ_pushbutton];
handles.RGB_block= [handles.RedThreshold_text, handles.RedT_edit,...
    handles.RedTQ_pushbutton,handles.GreenThreshold_text, handles.GreenT_edit,...
    handles.GreenTQ_pushbutton,handles.BlueThreshold_text, handles.BlueT_edit,...
    handles.BlueTQ_pushbutton];
handles.RGBCheckboxes_block= [handles.RedChannel_checkbox, handles.GreenChannel_checkbox,...
    handles.BlueChannel_checkbox,handles.ChannelChoicerQ_pushbutton];

set(handles.RGB_block,'Enable', 'off'); %The defualt status of this block


if handles.N_dim_total_V==3 %gray scale
    set(handles.RGBCheckboxes_block,'Enable', 'off'); %disables RGB checkboxes and therefore 
                                                      %the RGB block,too (as you will see below).
elseif handles.N_dim_total_V==4 %RGB
    set(handles.Gray_block,'Enable', 'off');          %disables Gray_block
end

handles.RedChannel_choice=0;   % The defualt is set to be 0, i.e These channels
handles.GreenChannel_choice=0; % are not selected. This is important for the visualization level
handles.BlueChannel_choice=0;  % because otherwise the variable for unselected channel will not be identified. 

guidata(hObject, handles); 

% --- Outputs from this function are returned to the command line.
function varargout = IsoSurfaces_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in Imtool_pushbutton.
function Imtool_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Imtool_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%%validation of input for the number of slice
NumberOfSlice_str= get(handles.NumberOfSlice_edit,'string');
if strcmp(NumberOfSlice_str,'')
    errordlg('You did not enter the number of slice');
    set(handles.NumberOfSlice_edit,'string','');
    return 
elseif isnan(handles.Num_of_slice)  
    errordlg('You must enter one positive number for the slice number');
    set(handles.NumberOfSlice_edit,'string','');
    return              
elseif  handles.Num_of_slice<1  || handles.Num_of_slice>size(handles.total_V,3)
    errordlg({'The slice number should be above 0 and should not exceed' num2str(size(handles.total_V,3))});
    set(handles.NumberOfSlice_edit,'string','');
    return
end
%%%

if handles.N_dim_total_V==3 %gray scale
    imtool(handles.total_V(:,:,handles.Num_of_slice))
elseif handles.N_dim_total_V==4 %RGB
    imtool(squeeze(handles.total_V(:,:,handles.Num_of_slice,:)))
end

function NumberOfSlice_edit_Callback(hObject, eventdata, handles)
% hObject    handle to NumberOfSlice_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NumberOfSlice_edit as text
%        str2double(get(hObject,'String')) returns contents of NumberOfSlice_edit as a double
handles.Num_of_slice=str2double(get(hObject,'String'));
guidata(hObject, handles); 

% --- Executes during object creation, after setting all properties.
function NumberOfSlice_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumberOfSlice_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function GrayT_edit_Callback(hObject, eventdata, handles)
% hObject    handle to GrayT_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of GrayT_edit as text
%        str2double(get(hObject,'String')) returns contents of GrayT_edit as a double
handles.GrayT=str2double(get(hObject,'String'));
guidata(hObject, handles); 

% --- Executes during object creation, after setting all properties.
function GrayT_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to GrayT_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function RedT_edit_Callback(hObject, eventdata, handles)
% hObject    handle to RedT_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RedT_edit as text
%        str2double(get(hObject,'String')) returns contents of RedT_edit as a double
handles.RedT=str2double(get(hObject,'String'));
guidata(hObject, handles); 

% --- Executes during object creation, after setting all properties.
function RedT_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RedT_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function GreenT_edit_Callback(hObject, eventdata, handles)
% hObject    handle to GreenT_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of GreenT_edit as text
%        str2double(get(hObject,'String')) returns contents of GreenT_edit as a double
handles.GreenT=str2double(get(hObject,'String'));
guidata(hObject, handles); 

% --- Executes during object creation, after setting all properties.
function GreenT_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to GreenT_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function BlueT_edit_Callback(hObject, eventdata, handles)
% hObject    handle to BlueT_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of BlueT_edit as text
%        str2double(get(hObject,'String')) returns contents of BlueT_edit as a double
handles.BlueT=str2double(get(hObject,'String'));
guidata(hObject, handles); 

% --- Executes during object creation, after setting all properties.
function BlueT_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BlueT_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in RedChannel_checkbox.
function RedChannel_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to RedChannel_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of RedChannel_checkbox
RedChannel_choice=get(hObject,'Value');
handles.RedChannel_choice=RedChannel_choice;
if RedChannel_choice %red was chosen
    set(handles.R_block,'Enable', 'on');
else
    set(handles.R_block,'Enable', 'off'); %disables if the red choose was deleted again
    set(handles.RedT_edit,'string','');
end
guidata(hObject, handles);

% --- Executes on button press in GreenChannel_checkbox.
function GreenChannel_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to GreenChannel_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of GreenChannel_checkbox
GreenChannel_choice=get(hObject,'Value');
handles.GreenChannel_choice=GreenChannel_choice;
if GreenChannel_choice %green was chosen
    set(handles.G_block,'Enable', 'on');
else
    set(handles.G_block,'Enable', 'off'); %disables if the green choose was deleted again
    set(handles.GreenT_edit,'string','');
end
guidata(hObject, handles);

% --- Executes on button press in BlueChannel_checkbox.
function BlueChannel_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to BlueChannel_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of BlueChannel_checkbox
BlueChannel_choice=get(hObject,'Value');
handles.BlueChannel_choice=BlueChannel_choice;
if BlueChannel_choice %blue was chosen
    set(handles.B_block,'Enable', 'on');
else
    set(handles.B_block,'Enable', 'off'); %disables if the blue choose was deleted again
    set(handles.BlueT_edit,'string','');
end
guidata(hObject, handles);

% --- Executes on button press in Visualize_pushbutton.
function Visualize_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Visualize_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

hwait_bar=waitbar(0,'Visualizing IsoSurfaces,Please Wait...');
%if RGB and the user didn't choose any channel:
if handles.N_dim_total_V==4
    if handles.RedChannel_choice+handles.GreenChannel_choice+handles.BlueChannel_choice==0
        errordlg('You did not choose a channel');
        return
    end
end

total_V=handles.total_V; %for convenience

%isosurfaces 
F=figure('Name','IsoSurfaces','NumberTitle','off');
if handles.N_dim_total_V==3 %gray scale
    %%%validation of gray threshold input
    GrayT_str= get(handles.GrayT_edit,'string');
        if strcmp(GrayT_str,'')
            errordlg('You did not enter a number for the gray threshold');
            set(handles.GrayT_edit,'string','');
            close(F)
            return 
        elseif isnan(handles.GrayT)  
            errordlg('You must enter one positive number for the gray threshold');
            set(handles.GrayT_edit,'string','');
            close(F)
            return
        elseif  handles.GrayT<0 || handles.GrayT>255 
            errordlg('The gray threshold must be a number between 0 to 255');
            set(handles.GrayT_edit,'string','');
            close(F)
            return
        end
    %%%
        V_reduced_gray=reducevolume(totalV,[3,3,2]); %especially important for "slow" computers
                                                      %can be skipped for
                                                      %quick computers.
        Vs = smooth3(V_reduced_gray);                 %smoothening is important for isosurfaces creation.
        colormap(gray);
        hiso = patch(isosurface(Vs,handles.GrayT),'FaceColor',[0.5,0.5,0.5],'EdgeColor','none');
        isonormals(Vs,hiso)
        daspect([1 1 1]); %original ratios
        view(35,30);
        axis tight
        lightangle(45,30);
        lighting gouraud
        set(hiso,'SpecularColorReflectance',0);
        set(hiso,'SpecularExponent',50);
        cameratoolbar(gcf)
elseif handles.N_dim_total_V==4 %the same as the gray channel for each of RGB channels
    if handles.RedChannel_choice
        %%%validation of red threshold input
        RedT_str= get(handles.RedT_edit,'string');
        if strcmp(RedT_str,'')
            errordlg('You did not enter a number for the red threshold');
            set(handles.RedT_edit,'string','');
            close(F)
            return
        elseif isnan(handles.RedT)  
            errordlg('You must enter one positive number for the red threshold');
            set(handles.RedT_edit,'string','');
            close(F)
            return
        elseif  handles.RedT<0 || handles.RedT>255 
            errordlg('The red threshold must be a number between 0 to 255');
            set(handles.RedT_edit,'string','');
            close(F)
            return
        end
        %%%
        V_reduced_r=reducevolume(total_V(:,:,:,1),[3,3,2]);
        Vs = smooth3(V_reduced_r);
        hiso = patch(isosurface(Vs,handles.RedT),'FaceColor',[1,0,1],'EdgeColor','none');
        isonormals(Vs,hiso)
        daspect([1 1 1]);
        view(35,30);
        axis off
        lightangle(45,30);
        lighting gouraud
        set(hiso,'SpecularColorReflectance',0);
        set(hiso,'SpecularExponent',50);
        cameratoolbar(gcf)
    end
    %green channel
    if handles.GreenChannel_choice
        %%%validation of green threshold input
        GreenT_str= get(handles.GreenT_edit,'string');
        if strcmp(GreenT_str,'')
            errordlg('You did not enter a number for the green threshold');
            set(handles.GreenT_edit,'string','');
            close(F)
            return
        elseif isnan(handles.GreenT)  
            errordlg('You must enter one positive number for the green threshold');
            set(handles.GreenT_edit,'string','');
            close(F)
            return
        elseif  handles.GreenT<0 || handles.GreenT>255 
            errordlg('The green threshold must be a number between 0 to 255');
            set(handles.GreenT_edit,'string','');
            close(F)
            return
        end
        %%%
        hold on
        V_reduced_g=reducevolume(total_V(:,:,:,2),[3,3,2]);
        Vs = smooth3(V_reduced_g);
        hiso = patch(isosurface(Vs,handles.GreenT),'FaceColor',[1,1,0],'EdgeColor','none');
        isonormals(Vs,hiso)
        daspect([1 1 1]);
        view(35,30);
        axis off
        lightangle(45,30);
        lighting gouraud
        set(hiso,'SpecularColorReflectance',0);
        set(hiso,'SpecularExponent',50);
        cameratoolbar(gcf)
    end
    %blue channel
    if handles.BlueChannel_choice
        %%%validation of blue threshold input
        BlueT_str= get(handles.BlueT_edit,'string');
        if strcmp(BlueT_str,'')
            errordlg('You did not enter a number for the blue threshold');
            set(handles.BlueT_edit,'string','');
            close(F)
            return
        elseif isnan(handles.BlueT)  
            errordlg('You must enter one positive number for the blue threshold');
            set(handles.BlueT_edit,'string','');
            close(F)
            return
        elseif  handles.BlueT<0 || handles.BlueT>255 
            errordlg('The blue threshold must be a number between 0 to 255');
            set(handles.BlueT_edit,'string','');
            close(F)
            return
        end
        %%%
        hold on
        V_reduced_b=reducevolume(total_V(:,:,:,3),[3,3,2]);
        Vs = smooth3(V_reduced_b);
        hiso = patch(isosurface(Vs,handles.BlueT),'FaceColor',[0,0,1],'EdgeColor','none');
        isonormals(Vs,hiso)
        cameratoolbar(gcf) %these settings are written for each channel as
        daspect([1 1 1]);  %the user can choose each one independently.
        view(35,30);
        axis tight 
        lightangle(45,30);
        lighting gouraud
        set(hiso,'SpecularColorReflectance',0);
        set(hiso,'SpecularExponent',50);
    end
end
waitbar(1);
close(hwait_bar);


% --- Executes on button press in Return_pushbutton.
function Return_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Return_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(IsoSurfaces_GUI)
Transition_GUI

% --- Executes when user attempts to close IsoSurfaces.
function IsoSurfaces_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to IsoSurfaces (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
Transition_GUI
delete(hObject);

% --- Executes on button press in ChannelChoicerQ_pushbutton.
function ChannelChoicerQ_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to ChannelChoicerQ_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox('Choose a channel you want to visualize as isosurface.','Channels checkboxes Help')


% --- Executes on button press in NofSliceQ_pushbutton.
function NofSliceQ_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to NofSliceQ_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox({'In order to use "Imtool", there is a need to select a representative slice.'...
    'The user should select one slice along the Z axis (between 1 to' num2str(size(handles.total_V,3))},...
    'Number of Slice Help')


% --- Executes on button press in ImtoolQ_pushbutton.
function ImtoolQ_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to ImtoolQ_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox({'This function enables visualization of a specific slice along the Z axis.'...
    'The user can utilize the function "Inspect pixel values" (the second icon from the left)'...
    'in order to choose an appropriate threshold.'},'Imtool Help')

% --- Executes on button press in GrayTQ_pushbutton.
function GrayTQ_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to GrayTQ_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox({'The isosurface will be created around pixels with values above the treshold.'...
    'It is highly recommended to use "Imtool" in order to choose an appropriate threshold.'},'Gray Threshold Help')

% --- Executes on button press in RedTQ_pushbutton.
function RedTQ_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to RedTQ_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox({'The isosurface will be created around pixels with values above the treshold.'...
    'It is highly recommended to use "Imtool" in order to choose an appropriate threshold.'},'Red Threshold Help')

% --- Executes on button press in GreenTQ_pushbutton.
function GreenTQ_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to GreenTQ_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox({'The isosurface will be created around pixels with values above the treshold.'...
    'It is highly recommended to use "Imtool" in order to choose an appropriate threshold.'},'Green Threshold Help')

% --- Executes on button press in BlueTQ_pushbutton.
function BlueTQ_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to BlueTQ_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox({'The isosurface will be created around pixels with values above the treshold.'...
    'It is highly recommended to use "Imtool" in order to choose an appropriate threshold.'},'Blue Threshold Help')
