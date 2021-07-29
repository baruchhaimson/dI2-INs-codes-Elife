function varargout = SectionViewer_GUI(varargin)
% SECTIONVIEWER_GUI MATLAB code for SectionViewer_GUI.fig
%      SECTIONVIEWER_GUI, by itself, creates a new SECTIONVIEWER_GUI or raises the existing
%      singleton*.
%
%      H = SECTIONVIEWER_GUI returns the handle to a new SECTIONVIEWER_GUI or the handle to
%      the existing singleton*.
%
%      SECTIONVIEWER_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SECTIONVIEWER_GUI.M with the given input arguments.
%
%      SECTIONVIEWER_GUI('Property','Value',...) creates a new SECTIONVIEWER_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SectionViewer_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SectionViewer_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SectionViewer_GUI

% Last Modified by GUIDE v2.5 28-Apr-2015 18:10:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SectionViewer_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @SectionViewer_GUI_OutputFcn, ...
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


% --- Executes just before SectionViewer_GUI is made visible.
function SectionViewer_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SectionViewer_GUI (see VARARGIN)

% Choose default command line output for SectionViewer_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SectionViewer_GUI wait for user response (see UIRESUME)
% uiwait(handles.SectionViewer);
Data=load('Interpolated_data.mat');%loads data saved in the previous GUI
%extracts information for future use.
handles.total_V=Data.Interpolated_data.total_V;
handles.N_dim_total_V=ndims(handles.total_V);

%Initation of images shown by axes. Important for the first "cleaning' process in
%begining of the visualization function. 
handles.Plane=[];
handles.ReferenceImage=[];

%The following handles blocks are necessary for being enabled/disabled during the program.
handles.XaxisCuttingPoint_block=[handles.XaxisCuttingPoint_text,handles.XaxisCuttingPoint_edit];
handles.YaxisCuttingPoint_block=[handles.YaxisCuttingPoint_text,handles.YaxisCuttingPoint_edit];
handles.ZaxisCuttingPoint_block=[handles.ZaxisCuttingPoint_text,handles.ZaxisCuttingPoint_edit];

handles.AnglesRelativeToXaxis_block=[handles.AngleRelativeXAxis_text,handles.AngleRelativeXAxis_edit];
handles.AnglesRelativeToYaxis_block=[handles.AngleRelativeYAxis_text,handles.AngleRelativeYAxis_edit];
handles.AnglesRelativeToZaxis_block=[handles.AngleRelativeZAxis_text,handles.AngleRelativeZAxis_edit];

set(handles.YaxisCuttingPoint_block,'Enable','off'); %The defualt status of this block
set(handles.ZaxisCuttingPoint_block,'Enable','off'); %The defualt status of this block
set(handles.AnglesRelativeToXaxis_block,'Enable','off'); %The defualt status of this block
handles.SectionRelativeTo_choice='Xaxis_radiobutton'; %%The defualt choice status 

handles.XaxisCuttingPoint='';%initiation for the reference table (for saving reference details)
handles.YaxisCuttingPoint='';
handles.ZaxisCuttingPoint='';
handles.AngleRelativeXAxis='';
handles.AngleRelativeYAxis='';
handles.AngleRelativeZAxis='';

guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = SectionViewer_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function XaxisCuttingPoint_edit_Callback(hObject, eventdata, handles)
% hObject    handle to XaxisCuttingPoint_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of XaxisCuttingPoint_edit as text
%        str2double(get(hObject,'String')) returns contents of XaxisCuttingPoint_edit as a double
handles.XaxisCuttingPoint=str2double(get(hObject,'String'));
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function XaxisCuttingPoint_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to XaxisCuttingPoint_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function YaxisCuttingPoint_edit_Callback(hObject, eventdata, handles)
% hObject    handle to YaxisCuttingPoint_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of YaxisCuttingPoint_edit as text
%        str2double(get(hObject,'String')) returns contents of YaxisCuttingPoint_edit as a double
handles.YaxisCuttingPoint=str2double(get(hObject,'String'));
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function YaxisCuttingPoint_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to YaxisCuttingPoint_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function ZaxisCuttingPoint_edit_Callback(hObject, eventdata, handles)
% hObject    handle to ZaxisCuttingPoint_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ZaxisCuttingPoint_edit as text
%        str2double(get(hObject,'String')) returns contents of ZaxisCuttingPoint_edit as a double
handles.ZaxisCuttingPoint=str2double(get(hObject,'String'));
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function ZaxisCuttingPoint_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ZaxisCuttingPoint_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function AngleRelativeXAxis_edit_Callback(hObject, eventdata, handles)
% hObject    handle to AngleRelativeXAxis_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of AngleRelativeXAxis_edit as text
%        str2double(get(hObject,'String')) returns contents of AngleRelativeXAxis_edit as a double
handles.AngleRelativeXAxis=str2double(get(hObject,'String'));
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function AngleRelativeXAxis_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AngleRelativeXAxis_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function AngleRelativeYAxis_edit_Callback(hObject, eventdata, handles)
% hObject    handle to AngleRelativeYAxis_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of AngleRelativeYAxis_edit as text
%        str2double(get(hObject,'String')) returns contents of AngleRelativeYAxis_edit as a double
handles.AngleRelativeYAxis=str2double(get(hObject,'String'));
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function AngleRelativeYAxis_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AngleRelativeYAxis_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function AngleRelativeZAxis_edit_Callback(hObject, eventdata, handles)
% hObject    handle to AngleRelativeZAxis_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of AngleRelativeZAxis_edit as text
%        str2double(get(hObject,'String')) returns contents of AngleRelativeZAxis_edit as a double
handles.AngleRelativeZAxis=str2double(get(hObject,'String'));
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function AngleRelativeZAxis_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AngleRelativeZAxis_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in SaveSection_pushbutton.
function SaveSection_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to SaveSection_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if ~isempty(handles.Plane) %Validation that the user use this function only after visualization of a section. 
    F=getimage(handles.SectionPicture_axes); %selects axes in GUI
    figure(); %new figure
    image(F); %shows selected axes in new figure
    daspect([1 1 1]); %original ratios
    prompt='Insert a name for the image';
    dlg_title='Save Section';
    ImageName = inputdlg(prompt,dlg_title);
    SavingName=[pwd '\Saved_Files\' char(ImageName)];
    saveas(gcf,SavingName,'jpg'); %saves figure
    close(gcf); 
else
    errordlg('You must visualize a section first');
    return
end


% --- Executes on button press in SaveReference_pushbutton.
function SaveReference_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to SaveReference_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if ~isempty(handles.ReferenceImage); %Validation that the user use this function only after visualization of a section.
    AngleRelativeXAxis=get(handles.AngleRelativeXAxis_edit,'string'); %extracts information
    AngleRelativeYAxis=get(handles.AngleRelativeYAxis_edit,'string');
    AngleRelativeZAxis=get(handles.AngleRelativeZAxis_edit,'string');
    XaxisCuttingPoint=get(handles.XaxisCuttingPoint_edit,'string');
    YaxisCuttingPoint=get(handles.YaxisCuttingPoint_edit,'string');
    ZaxisCuttingPoint=get(handles.ZaxisCuttingPoint_edit,'string');
    F=getimage(handles.Referance_axes); %selects axes in GUI
    figure(); %new figure
    image(F); %shows selected axes in new figure
    %%%the reference image need to be created in the new figure
    handles.ReferenceImage=patch('vertices',handles.vertex_matrix,'faces',handles.faces_matrix,'facecolor','none',...
        'edgecolor',[1 0 0]);
    axis on;
    axis tight;
    hold on
    handles.Plane=patch('vertices',handles.vertex_matrix_plane,'faces',[1 2 4 3]);
    daspect([1 1 1]);
    view(3);
    %%%
    prompt='Insert a name for the Renfernce image and Details';
    dlg_title='Save Reference';
    ImageName = inputdlg(prompt,dlg_title);
    SavingName=[pwd '\Saved_Files\' char(ImageName) '_reference'];
    saveas(gcf,SavingName,'jpg'); %saves figure
    %Creation of a cell array for reference details
    T ={'Axis' 'Angle Relative to Axis' 'Axis Cutting Point';...
        'x' num2str(AngleRelativeXAxis) num2str(XaxisCuttingPoint);...
        'y' num2str(AngleRelativeYAxis) num2str(YaxisCuttingPoint);...
        'z' num2str(AngleRelativeZAxis) num2str(ZaxisCuttingPoint)};
    xlswrite(SavingName,T); %creates an excel file for the details with the same name as the figure
    close(gcf); 
else
    errordlg('You must visualize a section first');
    return
end

% --- Executes on button press in Plus100_pushbutton.
function Plus100_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Plus100_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if ~isempty(handles.Plane) %Validation that the user use this function only after visualization of a section.
    %adds 100 to the previous cutting point and calls again to the visualization function 
    switch handles.SectionRelativeTo_choice
        case 'Xaxis_radiobutton'
            handles.XaxisCuttingPoint=handles.XaxisCuttingPoint+100;
            set(handles.XaxisCuttingPoint_edit,'string',num2str(handles.XaxisCuttingPoint));
        case 'Yaxis_radiobutton'
            handles.YaxisCuttingPoint=handles.YaxisCuttingPoint+100;
            set(handles.YaxisCuttingPoint_edit,'string',num2str(handles.YaxisCuttingPoint));
        case 'Zaxis_radiobutton'
            handles.ZaxisCuttingPoint=handles.ZaxisCuttingPoint+100;
            set(handles.ZaxisCuttingPoint_edit,'string',num2str(handles.ZaxisCuttingPoint));
    end
    guidata(hObject, handles);
    Visualize_pushbutton_Callback(hObject, eventdata, handles)
else
    errordlg('You must visualize a section first');
    return
end
    
    
    

% --- Executes on button press in Minus100_pushbutton.
function Minus100_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Minus100_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if ~isempty(handles.Plane) %Validation that the user use this function only after visualization of a section.
    %Subtracts 100 from the previous cutting point and calls again to the visualization function 
    switch handles.SectionRelativeTo_choice
        case 'Xaxis_radiobutton'
            handles.XaxisCuttingPoint=handles.XaxisCuttingPoint-100;
            set(handles.XaxisCuttingPoint_edit,'string',num2str(handles.XaxisCuttingPoint));
        case 'Yaxis_radiobutton'
            handles.YaxisCuttingPoint=handles.YaxisCuttingPoint-100;
            set(handles.YaxisCuttingPoint_edit,'string',num2str(handles.YaxisCuttingPoint));
        case 'Zaxis_radiobutton'
            handles.ZaxisCuttingPoint=handles.ZaxisCuttingPoint-100;
            set(handles.ZaxisCuttingPoint_edit,'string',num2str(handles.ZaxisCuttingPoint));
    end
    guidata(hObject, handles);
    Visualize_pushbutton_Callback(hObject, eventdata, handles)
else
    errordlg('You must visualize a section first');
    return
end

% --- Executes on button press in Plus10_pushbutton.
function Plus10_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Plus10_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if ~isempty(handles.Plane) %Validation that the user use this function only after visualization of a section.
    %adds 10 to the previous cutting point and calls again to the visualization function 
    switch handles.SectionRelativeTo_choice
        case 'Xaxis_radiobutton'
            handles.XaxisCuttingPoint=handles.XaxisCuttingPoint+10;
            set(handles.XaxisCuttingPoint_edit,'string',num2str(handles.XaxisCuttingPoint));
        case 'Yaxis_radiobutton'
            handles.YaxisCuttingPoint=handles.YaxisCuttingPoint+10;
            set(handles.YaxisCuttingPoint_edit,'string',num2str(handles.YaxisCuttingPoint));
        case 'Zaxis_radiobutton'
            handles.ZaxisCuttingPoint=handles.ZaxisCuttingPoint+10;
            set(handles.ZaxisCuttingPoint_edit,'string',num2str(handles.ZaxisCuttingPoint));
    end
    guidata(hObject, handles);
    Visualize_pushbutton_Callback(hObject, eventdata, handles)
else
    errordlg('You must visualize a section first');
    return
end

% --- Executes on button press in Minus10_pushbutton.
function Minus10_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Minus10_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if ~isempty(handles.Plane)%Validation that the user use this function only after visualization of a section.
    %Subtracts 10 from the previous cutting point and calls again to the visualization function 
    switch handles.SectionRelativeTo_choice
        case 'Xaxis_radiobutton'
            handles.XaxisCuttingPoint=handles.XaxisCuttingPoint-10;
            set(handles.XaxisCuttingPoint_edit,'string',num2str(handles.XaxisCuttingPoint));
        case 'Yaxis_radiobutton'
            handles.YaxisCuttingPoint=handles.YaxisCuttingPoint-10;
            set(handles.YaxisCuttingPoint_edit,'string',num2str(handles.YaxisCuttingPoint));
        case 'Zaxis_radiobutton'
            handles.ZaxisCuttingPoint=handles.ZaxisCuttingPoint-10;
            set(handles.ZaxisCuttingPoint_edit,'string',num2str(handles.ZaxisCuttingPoint));
    end
    guidata(hObject, handles);
    Visualize_pushbutton_Callback(hObject, eventdata, handles)
else
    errordlg('You must visualize a section first');
    return
end

% --- Executes on button press in Plus1_pushbutton.
function Plus1_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Plus1_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if ~isempty(handles.Plane) %Validation that the user use this function only after visualization of a section.
    %adds 1 to the previous cutting point and calls again to the visualization function 
    switch handles.SectionRelativeTo_choice
        case 'Xaxis_radiobutton'
            handles.XaxisCuttingPoint=handles.XaxisCuttingPoint+1;
            set(handles.XaxisCuttingPoint_edit,'string',num2str(handles.XaxisCuttingPoint));
        case 'Yaxis_radiobutton'
            handles.YaxisCuttingPoint=handles.YaxisCuttingPoint+1;
            set(handles.YaxisCuttingPoint_edit,'string',num2str(handles.YaxisCuttingPoint));
        case 'Zaxis_radiobutton'
            handles.ZaxisCuttingPoint=handles.ZaxisCuttingPoint+1;
            set(handles.ZaxisCuttingPoint_edit,'string',num2str(handles.ZaxisCuttingPoint));
    end
    guidata(hObject, handles);
    Visualize_pushbutton_Callback(hObject, eventdata, handles)
else
    errordlg('You must visualize a section first');
    return
end

% --- Executes on button press in Minus1_pushbutton.
function Minus1_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Minus1_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if ~isempty(handles.Plane) %Validation that the user use this function only after visualization of a section.
    %Subtracts 1 from the previous cutting point and calls again to the visualization function 
    switch handles.SectionRelativeTo_choice
        case 'Xaxis_radiobutton'
            handles.XaxisCuttingPoint=handles.XaxisCuttingPoint-1;
            set(handles.XaxisCuttingPoint_edit,'string',num2str(handles.XaxisCuttingPoint));
        case 'Yaxis_radiobutton'
            handles.YaxisCuttingPoint=handles.YaxisCuttingPoint-1;
            set(handles.YaxisCuttingPoint_edit,'string',num2str(handles.YaxisCuttingPoint));
        case 'Zaxis_radiobutton'
            handles.ZaxisCuttingPoint=handles.ZaxisCuttingPoint-1;
            set(handles.ZaxisCuttingPoint_edit,'string',num2str(handles.ZaxisCuttingPoint));
    end
    guidata(hObject, handles);
    Visualize_pushbutton_Callback(hObject, eventdata, handles)
else
    errordlg('You must visualize a section first');
    return
end


% --- Executes when selected object is changed in SectionRelativeTo_uipanel.
function SectionRelativeTo_uipanel_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in SectionRelativeTo_uipanel 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)


handles.SectionRelativeTo_choice=get(eventdata.NewValue,'Tag'); % Get Tag of selected object.

%changes in blocks enabling and deletion of edit boxes' contents
switch handles.SectionRelativeTo_choice
    case 'Xaxis_radiobutton'
        set(handles.XaxisCuttingPoint_block,'Enable','on');
        set(handles.YaxisCuttingPoint_block,'Enable','off');
        set(handles.ZaxisCuttingPoint_block,'Enable','off');
        set(handles.YaxisCuttingPoint_edit,'string','');
        set(handles.ZaxisCuttingPoint_edit,'string','');
        set(handles.AnglesRelativeToXaxis_block,'Enable','off');
        set(handles.AnglesRelativeToYaxis_block,'Enable','on');
        set(handles.AnglesRelativeToZaxis_block,'Enable','on');
        set(handles.AngleRelativeXAxis_edit,'string','');
        set(handles.AngleRelativeYAxis_edit,'string','');
        set(handles.AngleRelativeZAxis_edit,'string','');
    case 'Yaxis_radiobutton'
        set(handles.YaxisCuttingPoint_block,'Enable','on');
        set(handles.XaxisCuttingPoint_block,'Enable','off');
        set(handles.ZaxisCuttingPoint_block,'Enable','off');
        set(handles.XaxisCuttingPoint_edit,'string','');
        set(handles.ZaxisCuttingPoint_edit,'string','');
        set(handles.AnglesRelativeToYaxis_block,'Enable','off');
        set(handles.AnglesRelativeToXaxis_block,'Enable','on');
        set(handles.AnglesRelativeToZaxis_block,'Enable','on');
        set(handles.AngleRelativeXAxis_edit,'string','');
        set(handles.AngleRelativeYAxis_edit,'string','');
        set(handles.AngleRelativeZAxis_edit,'string','');
    case 'Zaxis_radiobutton'
        set(handles.ZaxisCuttingPoint_block,'Enable','on');
        set(handles.YaxisCuttingPoint_block,'Enable','off');
        set(handles.XaxisCuttingPoint_block,'Enable','off');
        set(handles.YaxisCuttingPoint_edit,'string','');
        set(handles.XaxisCuttingPoint_edit,'string','');
        set(handles.AnglesRelativeToZaxis_block,'Enable','off');
        set(handles.AnglesRelativeToYaxis_block,'Enable','on');
        set(handles.AnglesRelativeToXaxis_block,'Enable','on');
        set(handles.AngleRelativeXAxis_edit,'string','');
        set(handles.AngleRelativeYAxis_edit,'string','');
        set(handles.AngleRelativeZAxis_edit,'string','');
end
guidata(hObject,handles);

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

%deletion of axes images after each time the Visualize button is being
%pushed. Because the function activity time takes few moments, if one press
%quick enough "Visualize" or "+100" etc, the screen won't update fast
%enough and the last section will remain (relevant for the reference
%image).
set(handles.Plane,'xdata',0)
set(handles.Plane,'ydata',0)
set(handles.Plane,'zdata',0)
set(handles.ReferenceImage,'xdata',0)
set(handles.ReferenceImage,'ydata',0)
set(handles.ReferenceImage,'zdata',0)
refreshdata(handles.Referance_axes);

%Another relatively long condition.
%In this one I used few mathematical considerations of analytic geometry.
%I found it hard to explain by writing next to the code, and I think it
%will be better to explain it on a board (if needed).

switch handles.SectionRelativeTo_choice
    case 'Xaxis_radiobutton'
        %%%validation of X axis Cutting Point input
        XaxisCuttingPoint_str= get(handles.XaxisCuttingPoint_edit,'string');
        if strcmp(XaxisCuttingPoint_str,'')
            errordlg('You did not enter the X cutting-point');
            set(handles.XaxisCuttingPoint_edit,'string','');
            return 
        elseif isnan(handles.XaxisCuttingPoint)  
            errordlg('You must enter a number for the X cutting-point');
            set(handles.XaxisCuttingPoint_edit,'string','');
            return
        end
        %%%
        %%%validation of  Angle Relative Y Axis input
        AngleRelativeYAxis_str= get(handles.AngleRelativeYAxis_edit,'string');
        if strcmp(AngleRelativeYAxis_str,'')
            errordlg('You did not enter the angle relative to the Y axis');
            set(handles.AngleRelativeYAxis_edit,'string','');
            return 
        elseif isnan(handles.AngleRelativeYAxis)  
            errordlg('You must enter a number for the angle relative to the Y axis');
            set(handles.AngleRelativeYAxis_edit,'string','');
            return
        end
        %%%
        %%%validation of  Angle Relative Z Axis input
        AngleRelativeZAxis_str= get(handles.AngleRelativeZAxis_edit,'string');
        if strcmp(AngleRelativeZAxis_str,'')
            errordlg('You did not enter the angle relative to the Z axis');
            set(handles.AngleRelativeZAxis_edit,'string','');
            return 
        elseif isnan(handles.AngleRelativeZAxis)  
            errordlg('You must enter a number for the angle relative to the Z axis');
            set(handles.AngleRelativeZAxis_edit,'string','');
            return
        end
        %%%
        %%%Because I use tand function, I need to make sure that the angle
        %%%is not odd multiple of 90 degrees, because tan(90) is not
        %%%defined. Therefore, I checked whether the angle divided by 90,
        %%%when devied by 2 has a remainder of one.
        %%%In addition, I add 0.05 to the angles,because I want to allow
        %%%the user to use 90. (but as I said I am preventing him from
        %%%using 89.95 which is less intuitive number)
        if rem(((handles.AngleRelativeYAxis+0.05)/90),2)==1 
            errordlg('The angle relative to Y axis is too close odd multiple of 90');
            set(handles.AngleRelativeYAxis_edit,'string','');
            return
        end
        if rem(((handles.AngleRelativeZAxis+0.05)/90),2)==1 
            errordlg('The angle relative to Z axis is too close odd multiple of 90');
            set(handles.AngleRelativeZAxis_edit,'string','');
            return
        end
        %%%end of inputs validations
        
        plane_image=uint8(zeros(length_image,height_volume)); %initiation 
        d=handles.XaxisCuttingPoint; %for convenience
        M1=tand(handles.AngleRelativeYAxis+0.05); %slope relative to Y
        M2=tand(handles.AngleRelativeZAxis+0.05); %slope relative to Z
        if handles.N_dim_total_V==3
            for k=1:height_volume
                 for i=1:length_image
                    j=ceil(M1*i+M2*k+d); %equation of a plane in space, for further details please contact me
                    if j>=1 &&j<=width_image
                    plane_image(i,k)=total_V(j,i,k);
                    end
                end
            end
        else %handles.N_dim_total_V==4
            for k=1:height_volume
                for i=1:length_image
                j=ceil(M1*i+M2*k+d);
                if j>=1 &&j<=width_image
                    plane_image(i,k,1)=total_V(j,i,k,1);
                    plane_image(i,k,2)=total_V(j,i,k,2);
                    plane_image(i,k,3)=total_V(j,i,k,3);
                end
                end
            end
        end
        %for convenience, for reference volume limits (see below)
        l=width_image;
        w=length_image;
        h=height_volume;
        %
        %limits considerations,for further details please contact me
        if M1+M2+d>=1 
            min_j_a=ceil(M1+M2+d);
            Vertex_1=[1,min_j_a,1]; %the following vertexes are made for the reference plane
        else
            min_i_a=ceil((1-M2-d)/M1);
            Vertex_1=[min_i_a,1,1];
        end
        if M1*length_image+M2+d<=width_image 
            min_j_b=floor(M1*length_image+M2+d);
            Vertex_2=[length_image,min_j_b,1];
        else
            min_i_b=floor((width_image-M2-d)/M1);
            Vertex_2=[min_i_b,width_image,1];
        end
        %
        if M1+M2*height_volume+d>=1 
            max_j_a=ceil(M1+M2*height_volume+d);
            Vertex_3=[1,max_j_a,height_volume];
        else
            max_i_a=ceil((1-M2*height_volume-d)/M1);
            Vertex_3=[max_i_a,1,height_volume];
        end
        if M1*length_image+M2*height_volume+d<=width_image 
            max_j_b=floor(M1*length_image+M2*height_volume+d);
            Vertex_4=[length_image,max_j_b,height_volume];
        else
            max_i_b=floor((width_image-M2*height_volume-d)/M1);
            Vertex_4=[max_i_b,width_image,height_volume];
        end
    case 'Yaxis_radiobutton'
        %%%validation of Y axis Cutting Point input
        YaxisCuttingPoint_str= get(handles.YaxisCuttingPoint_edit,'string');
        if strcmp(YaxisCuttingPoint_str,'')
            errordlg('You did not enter the Y cutting-point');
            set(handles.YaxisCuttingPoint_edit,'string','');
            return 
        elseif isnan(handles.YaxisCuttingPoint)  
            errordlg('You must enter a number for the Y cutting-point');
            set(handles.YaxisCuttingPoint_edit,'string','');
            return
        end
        %%%
        %%%validation of  Angle Relative X Axis input
        AngleRelativeXAxis_str= get(handles.AngleRelativeXAxis_edit,'string');
        if strcmp(AngleRelativeXAxis_str,'')
            errordlg('You did not enter the angle relative to the X axis');
            set(handles.AngleRelativeXAxis_edit,'string','');
            return 
        elseif isnan(handles.AngleRelativeXAxis)  
            errordlg('You must enter a number for the angle relative to the X axis');
            set(handles.AngleRelativeXAxis_edit,'string','');
            return
        end
        %%%
        %%%validation of  Angle Relative Z Axis input
        AngleRelativeZAxis_str= get(handles.AngleRelativeZAxis_edit,'string');
        if strcmp(AngleRelativeZAxis_str,'')
            errordlg('You did not enter the angle relative to the Z axis');
            set(handles.AngleRelativeZAxis_edit,'string','');
            return 
        elseif isnan(handles.AngleRelativeZAxis)  
            errordlg('You must enter a number for the angle relative to the Z axis');
            set(handles.AngleRelativeZAxis_edit,'string','');
            return
        end
        %%%Because I use tand function, I need to make sure that the angle
        %%%is not odd multiple of 90 degrees, because tan(90) is not
        %%%defined. Therefore, I checked whether the angle divided by 90,
        %%%when devied by 2 has a remainder of one.
        %%%In addition, I add 0.05 to the angles,because I want to allow
        %%%the user to use 90. (but as I said I am preventing him from
        %%%using 89.95 which is less intuitive number)
        if rem(((handles.AngleRelativeXAxis+0.05)/90),2)==1 
            errordlg('The angle relative to X axis is too close odd multiple of 90');
            set(handles.AngleRelativeXAxis_edit,'string','');
            return
        end
        if rem(((handles.AngleRelativeZAxis+0.05)/90),2)==1 
            errordlg('The angle relative to Z axis is too close odd multiple of 90');
            set(handles.AngleRelativeZAxis_edit,'string','');
            return
        end

        plane_image=uint8(zeros(width_image,height_volume)); %initiation
        d=handles.YaxisCuttingPoint;%for convenience
        M1=tand(handles.AngleRelativeXAxis+0.05); %slope relative to X
        M2=tand(handles.AngleRelativeZAxis+0.05); %slope relative to Z
        if handles.N_dim_total_V==3
            for k=1:height_volume
                 for i=1:width_image
                    j=ceil(M1*i+M2*k+d);  %equation of a plane in space, for further details please contact me
                    if j>=1 &&j<=length_image
                    plane_image(i,k)=total_V(i,j,k);
                    end
                end
            end
        else %handles.N_dim_total_V==4
            for k=1:height_volume
                for i=1:width_image
                j=ceil(M1*i+M2*k+d);
                if j>=1 &&j<=length_image
                    plane_image(i,k,1)=total_V(i,j,k,1);
                    plane_image(i,k,2)=total_V(i,j,k,2);
                    plane_image(i,k,3)=total_V(i,j,k,3);
                end
                end
            end
        end
        %for convenience, for reference volume limits (see below)
        l=length_image;
        w=width_image;
        h=height_volume;
        %
        %limits considerations,for further details please contact me
        if M1+M2+d>=1 
            min_j_a=ceil(M1+M2+d);
            Vertex_1=[1,min_j_a,1];%the following vertexes are made for the reference plane
        else
            min_i_a=ceil((1-M2-d)/M1);
            Vertex_1=[min_i_a,1,1];
        end
        if M1*width_image+M2+d<=length_image 
            min_j_b=floor(M1*width_image+M2+d);
            Vertex_2=[width_image,min_j_b,1];
        else
            min_i_b=floor((length_image-M2-d)/M1);
            Vertex_2=[min_i_b,length_image,1];
        end
        %
        if M1+M2*height_volume+d>=1 
            max_j_a=ceil(M1+M2*height_volume+d);
            Vertex_3=[1,max_j_a,height_volume];
        else
            max_i_a=ceil((1-M2*height_volume-d)/M1);
            Vertex_3=[max_i_a,1,height_volume];
        end
        if M1*width_image+M2*height_volume+d<=length_image 
            max_j_b=floor(M1*width_image+M2*height_volume+d);
            Vertex_4=[width_image,max_j_b,height_volume];
        else
            max_i_b=floor((length_image-M2*height_volume-d)/M1);
            Vertex_4=[max_i_b,length_image,height_volume];
        end
    case 'Zaxis_radiobutton'
        %%%validation of Z axis Cutting Point input
        ZaxisCuttingPoint_str= get(handles.ZaxisCuttingPoint_edit,'string');
        if strcmp(ZaxisCuttingPoint_str,'')
            errordlg('You did not enter the Z cutting-point');
            set(handles.YaxisCuttingPoint_edit,'string','');
            return 
        elseif isnan(handles.ZaxisCuttingPoint)  
            errordlg('You must enter a number for the Z cutting-point');
            set(handles.ZaxisCuttingPoint_edit,'string','');
            return
        end
        %%%
        %%%validation of  Angle Relative X Axis input
        AngleRelativeXAxis_str= get(handles.AngleRelativeXAxis_edit,'string');
        if strcmp(AngleRelativeXAxis_str,'')
            errordlg('You did not enter the angle relative to the X axis');
            set(handles.AngleRelativeXAxis_edit,'string','');
            return 
        elseif isnan(handles.AngleRelativeXAxis)  
            errordlg('You must enter a number for the angle relative to the X axis');
            set(handles.AngleRelativeXAxis_edit,'string','');
            return
        end
        %%%
        %%%validation of  Angle Relative Y Axis input
        AngleRelativeYAxis_str= get(handles.AngleRelativeYAxis_edit,'string');
        if strcmp(AngleRelativeYAxis_str,'')
            errordlg('You did not enter the angle relative to the Y axis');
            set(handles.AngleRelativeYAxis_edit,'string','');
            return 
        elseif isnan(handles.AngleRelativeYAxis)  
            errordlg('You must enter a number for the angle relative to the Y axis');
            set(handles.AngleRelativeYAxis_edit,'string','');
            return
        end
        %%%Because I use tand function, I need to make sure that the angle
        %%%is not odd multiple of 90 degrees, because tan(90) is not
        %%%defined. Therefore, I checked whether the angle divided by 90,
        %%%when devied by 2 has a remainder of one.
        %%%In addition, I add 0.05 to the angles,because I want to allow
        %%%the user to use 90. (but as I said I am preventing him from
        %%%using 89.95 which is less intuitive number)
        if rem(((handles.AngleRelativeXAxis+0.05)/90),2)==1 
            errordlg('The angle relative to X axis is too close odd multiple of 90');
            set(handles.AngleRelativeXAxis_edit,'string','');
            return
        end
        if rem(((handles.AngleRelativeYAxis+0.05)/90),2)==1 
            errordlg('The angle relative to Y axis is too close odd multiple of 90');
            set(handles.AngleRelativeYAxis_edit,'string','');
            return
        end
        plane_image=uint8(zeros(width_image,length_image));%initiation
        d=handles.ZaxisCuttingPoint;%for convenience
        M1=tand(handles.AngleRelativeXAxis+0.05); %slope relative to X
        M2=tand(handles.AngleRelativeYAxis+0.05); %slope relative to Y
        if handles.N_dim_total_V==3
            for k=1:length_image
                 for i=1:width_image
                    j=ceil(M1*i+M2*k+d);  %equation of a plane in space, for further details please contact me
                    if j>=1 &&j<=height_volume
                    plane_image(i,k)=total_V(i,k,j);
                    end
                end
            end
        else %handles.N_dim_total_V==4
            for k=1:length_image
                for i=1:width_image
                j=ceil(M1*i+M2*k+d);
                if j>=1 &&j<=height_volume
                    plane_image(i,k,1)=total_V(i,k,j,1);
                    plane_image(i,k,2)=total_V(i,k,j,2);
                    plane_image(i,k,3)=total_V(i,k,j,3);
                end
                end
            end
        end
        %for convenience, for reference volume limits (see below)
        l=height_volume;
        w=width_image;
        h=length_image;
        %
        %limits considerations,for further details please contact me
        if M1+M2+d>=1 
            min_j_a=ceil(M1+M2+d);
            Vertex_1=[1,min_j_a,1];%the following vertexes are made for the reference plane
        else
            min_i_a=ceil((1-M2-d)/M1);
            Vertex_1=[min_i_a,1,1];
        end
        if M1*width_image+M2+d<=height_volume 
            min_j_b=floor(M1*width_image+M2+d);
            Vertex_2=[width_image,min_j_b,1];
        else
            min_i_b=floor((height_volume-M2-d)/M1);
            Vertex_2=[min_i_b,height_volume,1];
        end
%
        if M1+M2*length_image+d>=1 
            max_j_a=ceil(M1+M2*length_image+d);
            Vertex_3=[1,max_j_a,length_image];
        else
            max_i_a=ceil((1-M2*length_image-d)/M1);
            Vertex_3=[max_i_a,1,length_image];
        end
        if M1*width_image+M2*length_image+d<=height_volume 
            max_j_b=floor(M1*width_image+M2*length_image+d);
            Vertex_4=[width_image,max_j_b,length_image];
        else
            max_i_b=floor((height_volume-M2*length_image-d)/M1);
            Vertex_4=[max_i_b,height_volume,length_image];
        end

end

%pesentaion of section image:
axes(handles.SectionPicture_axes); %choose the axes
handles.SectionPicture=imshow(rot90(plane_image)); %showing the image in the right orientation
daspect([1 1 1]); %original ratio
axis tight 

%%%generation of the reference image
%generation of reference volume
LL=[0 0 0];
LLx=LL(1); LLy=LL(2); LLz=LL(3);
handles.vertex_matrix=[LLx,LLy,LLz;LLx,LLy+l,LLz;LLx+w,LLy+l,LLz;...
    LLx+w,LLy,LLz;LLx,LLy,LLz+h;LLx,LLy+l,LLz+h;LLx+w,LLy+l,LLz+h;...
    LLx+w,LLy,LLz+h;];
handles.faces_matrix=[1 2 3 4;5 6 7 8;1 2 6 5; 3 4 8 7; 1 4 8 5;2 3 7 6];

axes(handles.Referance_axes);%choose the axes
%visualization
handles.ReferenceImage=patch('vertices',handles.vertex_matrix,'faces',handles.faces_matrix,'facecolor','none',...
    'edgecolor',[1 0 0]);
view(3);
axis on;
axis tight;
%generation of reference plane
hold on
handles.vertex_matrix_plane=[Vertex_1;Vertex_2;Vertex_3;Vertex_4];
handles.Plane=patch('vertices',handles.vertex_matrix_plane,'faces',[1 2 4 3]);
daspect([1 1 1]);%original ratio

guidata(hObject, handles);

% --- Executes on button press in Return_pushbutton.
function Return_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Return_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(SectionViewer_GUI)
Transition_GUI

% --- Executes when user attempts to close SectionViewer.
function SectionViewer_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to SectionViewer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
Transition_GUI
delete(hObject);

% --- Executes on button press in SectionRelativeToQ_pushbutton.
function SectionRelativeToQ_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to SectionRelativeToQ_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox({'The sections are made relatively to one fixed axis.'...
    'Then, the user asked to choose the angles relative to the two other axises.'},'Section Relative To Help')

% --- Executes on button press in CuttingPointsQ_pushbutton.
function CuttingPointsQ_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to CuttingPointsQ_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox({'Since the sections are made relatively to one fixed axis,'...
    'the sections can be specified according to thier axis cutting point.'...
    'This is resulted in movement of the section forward and backward.'},'Cutting Points Help')

% --- Executes on button press in CuttingPointModifierQ_pushbutton.
function CuttingPointModifierQ_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to CuttingPointModifierQ_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox('A quick tool for changing cutting points. It generates motion of sectionforward and backward.','Cutting Point Modifier Help')

% --- Executes on button press in AngleSettingsQ_pushbutton.
function AngleSettingsQ_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to AngleSettingsQ_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox({'The sections are made relatively to one fixed axis.'...
    'Then, the user asked to choose the angles relative to the two other axises.'},'Angle Settings Help')
