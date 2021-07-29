function varargout = DensitySynapsesMaker(varargin)
% DENSITYSYNAPSESMAKER MATLAB code for DensitySynapsesMaker.fig
%      DENSITYSYNAPSESMAKER, by itself, creates a new DENSITYSYNAPSESMAKER or raises the existing
%      singleton*.
%
%      H = DENSITYSYNAPSESMAKER returns the handle to a new DENSITYSYNAPSESMAKER or the handle to
%      the existing singleton*.
%
%      DENSITYSYNAPSESMAKER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DENSITYSYNAPSESMAKER.M with the given input arguments.
%
%      DENSITYSYNAPSESMAKER('Property','Value',...) creates a new DENSITYSYNAPSESMAKER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DensitySynapsesMaker_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DensitySynapsesMaker_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DensitySynapsesMaker

% Last Modified by GUIDE v2.5 30-Jul-2019 12:27:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DensitySynapsesMaker_OpeningFcn, ...
                   'gui_OutputFcn',  @DensitySynapsesMaker_OutputFcn, ...
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


% --- Executes just before DensitySynapsesMaker is made visible.
function DensitySynapsesMaker_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DensitySynapsesMaker (see VARARGIN)

% Choose default command line output for DensitySynapsesMaker
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

%Loading section
handles.RGB=2; % Green is the defalut
handles.SkipTransToBS=0;
set(handles.Load,'Enable','off');
%

%Transformation section
handles.NegativeExportTrans=0;
handles.TransTypeList={'nonreflective similarity','similarity','affine','projective','polynomial','pwl','lwm'};
handles.TransType=2; % similarity is the defalut
handles.MinTransPointsNumber=3;
% set(handles.uipanelTrans,'Visible','off');
set(handles.CancleTrans,'Enable','off');
set(handles.ConfirmTrans,'Enable','off');
set(handles.ConfirmTemp,'Enable','off');
set(handles.ExportTrans,'Enable','off');
%

%Background substraction section
handles.BSType=1;
handles.NegativeExportBS=0;
% set(handles.uipanelBS,'Visible','off');
set(handles.ExportBS,'Enable','off');
%

%Objects selection section
handles.OS=1;  % Synapses mode is the defalut
handles.HigherThanAreaTH=0;
set(handles.OSAreaHigherThanslider,'Value',handles.HigherThanAreaTH);
set(handles.OSAreaHigherThantext,'string',num2str(handles.HigherThanAreaTH)); 
handles.LowerThanAreaTH=200;
set(handles.OSAreaLowerThanslider,'Value',handles.LowerThanAreaTH);
set(handles.OSAreaLowerThantext,'string',num2str(handles.LowerThanAreaTH)); 
handles.NegativeExportOS=0;
set(handles.ExportOS,'Enable','off');
% set(handles.uipanelOS,'Visible','off');
set(handles.CheckOS,'Enable','off');
set(handles.ClearSelection,'Enable','off');
%

%Overlay section
handles.OverlayType=1;
set(handles.uipanelOverlay,'Visible','off');
set(handles.ShowOverlay,'Enable','off');
set(handles.ExportOverlay,'Enable','off');
handles.NegativeExportOverlay=0;
%

%Density section
set(handles.uipanelDensity,'Visible','off');
handles.LimitDensity=0;
handles.IncludePoints=0;
handles.ContourStart=1;
handles.ContourEnd=10;
handles.EnhancementFactor=1;
handles.ColorDensity=2;
handles.map=zeros(256,3);
handles.map(:,handles.ColorDensity)=linspace(0,1,256);
handles.AddScaleBarDensity=0;
%
guidata(hObject, handles);
% UIWAIT makes DensitySynapsesMaker wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = DensitySynapsesMaker_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in LoadTemplate.
function LoadTemplate_Callback(hObject, eventdata, handles)
% hObject    handle to LoadTemplate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[TFileName,PathName] = uigetfile({'*.jpg;*.tif;*.png;*.gif','All Image Files'}); %finds names of files and pathway
TFileName = cellstr(TFileName);  % for the case of one file 
handles.TemplateNames=TFileName;
addpath(PathName); %add the pathway we got from line 3 to the list
Template = imread(char(TFileName));
handles.Template = Template(:,:,1:3);
set(handles.Load,'Enable','on');
set(handles.LoadTemplate,'Enable','off');
guidata(hObject, handles);

% --- Executes when selected object is changed in uipanelRGB.
function uipanelRGB_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanelRGB 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
TagRGB=get(eventdata.NewValue,'Tag'); % Get Tag of selected number of joints.
switch TagRGB
    case 'Redradiobutton'
        handles.RGB=1;
    case 'Greenradiobutton'
        handles.RGB=2;
    case 'Blueradiobutton'
        handles.RGB=3;
end
guidata(hObject,handles);

% --- Executes on button press in Load.
function Load_Callback(hObject, eventdata, handles)
% hObject    handle to Load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileNames,PathName] = uigetfile({'*.jpg;*.tif;*.png;*.gif','All Image Files'},'MultiSelect','on'); %finds names of files and pathway
FileNames = cellstr(FileNames);  % for the case of one file 
ImageNumber=length(FileNames); % The number of images is like the number of names
handles.ImageNumber=ImageNumber;
handles.FileNames=FileNames;
addpath(PathName); %add the pathway we got from line 3 to the list
for i=1:ImageNumber %loads the actual data and converts it to gray scale
    D=imread(char(FileNames(i)));
    Data(i).Data=D(:,:,handles.RGB);
    clear D
end
handles.Data=Data;

set(handles.Load,'Enable','off');
if handles.SkipTransToBS==1
    handles.registeredImages=handles.Data;

    set(handles.uipanelBS,'Visible','on');
    handles.BinaryImageNumber=1;
    set(handles.BStext,'string',num2str(handles.BinaryImageNumber));
    axes(handles.OriginalScreen); 
    imshow(handles.registeredImages{handles.BinaryImageNumber});    
else    %handles.SkipTransToBS==0
    set(handles.uipanelTrans,'Visible','on');
    set(handles.ConfirmTemp,'Enable','on');
    axes(handles.OriginalScreen); 
    imshow(handles.Template);
    [x,y]=getpts(handles.OriginalScreen);
    if length(x)<handles.MinTransPointsNumber
        errordlg('You did not choose enough points for the chosen type of transformation');
        return
    end
    handles.TemplateNumberOfPoints=length(x);
    handles.TempfixedPoints=[x';y']';
end
guidata(hObject, handles);

% --- Executes on button press in ResetLoadingTemp.
function ResetLoadingTemp_Callback(hObject, eventdata, handles)
% hObject    handle to ResetLoadingTemp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in ResetLoad.
function ResetLoad_Callback(hObject, eventdata, handles)
% hObject    handle to ResetLoad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in checkboxSkipTrans.
function checkboxSkipTrans_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxSkipTrans (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxSkipTrans
% --- Executes on button press in SkipToBS.
handles.SkipTransToBS=get(hObject,'Value');
guidata(hObject,handles);
    
% --- Executes on button press in ConfirmTemp.
function ConfirmTemp_Callback(hObject, eventdata, handles)
% hObject    handle to ConfirmTemp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.fixedPoints=handles.TempfixedPoints;
handles.TransImageNumber=1;
set(handles.Transformtext,'string',num2str(handles.TransImageNumber));

axes(handles.Screen); 
imshow(handles.Template);
hold on
plot(handles.fixedPoints(:,1),-handles.fixedPoints(:,2),'yo');
labels={'1'};
for i=2:length(handles.fixedPoints(:,1))
    labels=[labels; num2str(i)];
end
handles.labels=labels;
hold on
text(handles.Screen,handles.fixedPoints(:,1),handles.fixedPoints(:,2),labels','VerticalAlignment','bottom','HorizontalAlignment','right')

axes(handles.OriginalScreen); 
imshow(handles.Data(handles.TransImageNumber).Data);
[x,y]=getpts(handles.OriginalScreen);
if length(x)<handles.MinTransPointsNumber
    errordlg('You did not choose enough points for the chosen type of transformation');
    return
end
if length(x)>handles.TemplateNumberOfPoints
    x=x(1:handles.TemplateNumberOfPoints);
    y=y(1:handles.TemplateNumberOfPoints);
end
handles.movingPoints=[x';y']';
if handles.TransType==7
    tform = fitgeotrans(handles.movingPoints, handles.fixedPoints,handles.TransTypeList{handles.TransType},6);
else
    tform = fitgeotrans(handles.movingPoints, handles.fixedPoints,handles.TransTypeList{handles.TransType});
end
Rfixed = imref2d(size(handles.Template));
handles.registered{handles.TransImageNumber} = imwarp(handles.Data(handles.TransImageNumber).Data,tform,'FillValues',0,'OutputView',Rfixed);
clear tform Rfixed
handles=rmfield(handles,'movingPoints');

set(handles.ConfirmTemp,'Enable','off');
set(handles.ConfirmTrans,'Enable','on');
guidata(hObject, handles);

% --- Executes when selected object is changed in uipanelTransType.
function uipanelTransType_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanelTransType 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
TagTT=get(eventdata.NewValue,'Tag'); % Get Tag of selected number of joints.
switch TagTT
    case 'nonreflectivesimilarityradiobutton'
        handles.TransType=1;
        handles.MinTransPointsNumber=2;
    case 'similarityradiobutton'
        handles.TransType=2;
        handles.MinTransPointsNumber=3;
    case 'affineradiobutton'
        handles.TransType=3;
        handles.MinTransPointsNumber=3;
    case 'projectiveradiobutton'
        handles.TransType=4;
        handles.MinTransPointsNumber=4;
    case 'polynomialradiobutton'
        handles.TransType=5;
        handles.MinTransPointsNumber=6;
    case 'piecewiselinearradiobutton'
        handles.TransType=6;
        handles.MinTransPointsNumber=4;
    case 'localweightedmeanradiobutton'
        handles.TransType=7;
        handles.MinTransPointsNumber=6;
end
guidata(hObject,handles);

% --- Executes on button press in CheckTrans.
function CheckTrans_Callback(hObject, eventdata, handles)
% hObject    handle to CheckTrans (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.Screen); 
imshow(handles.registered{handles.TransImageNumber});

set(handles.CancleTrans,'Enable','on');
set(handles.ConfirmTrans,'Enable','on');
guidata(hObject,handles);

% --- Executes on button press in SkipImageTrans.
function SkipImageTrans_Callback(hObject, eventdata, handles)
% hObject    handle to SkipImageTrans (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.registered{handles.TransImageNumber}=handles.Data(handles.TransImageNumber).Data;

handles.TransImageNumber=handles.TransImageNumber+1;
set(handles.Transformtext,'string',num2str(handles.TransImageNumber));
axes(handles.OriginalScreen); 
imshow(handles.Data(handles.TransImageNumber).Data);
guidata(hObject,handles);

% --- Executes on button press in CancleTrans.
function CancleTrans_Callback(hObject, eventdata, handles)
% hObject    handle to CancleTrans (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.OriginalScreen); 
imshow(handles.Data(handles.TransImageNumber).Data);
[x,y]=getpts(handles.OriginalScreen);
if length(x)<handles.MinTransPointsNumber
    errordlg('You did not choose enough points for the chosen type of transformation');
    return
end
if length(x)>handles.TemplateNumberOfPoints
    x=x(1:handles.TemplateNumberOfPoints);
    y=y(1:handles.TemplateNumberOfPoints);
end
handles.movingPoints=[x';y']';
if handles.TransType==7
    tform = fitgeotrans(handles.movingPoints, handles.fixedPoints,handles.TransTypeList{handles.TransType},6);
else
    tform = fitgeotrans(handles.movingPoints, handles.fixedPoints,handles.TransTypeList{handles.TransType});
end
Rfixed = imref2d(size(handles.Template));
handles.registered{handles.TransImageNumber} = imwarp(handles.Data(handles.TransImageNumber).Data,tform,'FillValues',0,'OutputView',Rfixed);
clear tform Rfixed
handles=rmfield(handles,'movingPoints');
guidata(hObject,handles);

% --- Executes on button press in ConfirmTrans.
function ConfirmTrans_Callback(hObject, eventdata, handles)
% hObject    handle to ConfirmTrans (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.registeredImages{handles.TransImageNumber}=handles.registered{handles.TransImageNumber};
cla(handles.Screen);

if handles.TransImageNumber<handles.ImageNumber
    handles.TransImageNumber=handles.TransImageNumber+1;
    set(handles.Transformtext,'string',num2str(handles.TransImageNumber));
    axes(handles.OriginalScreen); 
    imshow(handles.Data(handles.TransImageNumber).Data);
    [x,y]=getpts(handles.OriginalScreen);
    if length(x)<handles.MinTransPointsNumber
        errordlg('You did not choose enough points for the chosen type of transformation');
        return
    end
    if length(x)>handles.TemplateNumberOfPoints
        x=x(1:handles.TemplateNumberOfPoints);
        y=y(1:handles.TemplateNumberOfPoints);
    end
    handles.movingPoints=[x';y']';
    if handles.TransType==7
        tform = fitgeotrans(handles.movingPoints, handles.fixedPoints,handles.TransTypeList{handles.TransType},6);
    else
        tform = fitgeotrans(handles.movingPoints, handles.fixedPoints,handles.TransTypeList{handles.TransType});
    end
    Rfixed = imref2d(size(handles.Template));
    handles.registered{handles.TransImageNumber} = imwarp(handles.Data(handles.TransImageNumber).Data,tform,'FillValues',0,'OutputView',Rfixed);
    clear tform Rfixed
    handles=rmfield(handles,'movingPoints');
else
    set(handles.uipanelBS,'Visible','on');
    set(handles.ExportTrans,'Enable','on');
    handles.BinaryImageNumber=1;
    set(handles.BStext,'string',num2str(handles.BinaryImageNumber));
    axes(handles.OriginalScreen); 
    imshow(handles.registeredImages{handles.BinaryImageNumber}); 
    handles=rmfield(handles,'Data');
end

guidata(hObject, handles);

% --- Executes on button press in NegativeExportTranscheckbox.
function NegativeExportTranscheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to NegativeExportTranscheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of NegativeExportTranscheckbox
handles.NegativeExportTrans=get(hObject,'Value');
guidata(hObject,handles);

% --- Executes on button press in ExportTrans.
function ExportTrans_Callback(hObject, eventdata, handles)
% hObject    handle to ExportTrans (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.NegativeExportTrans==1
    for n=1:handles.ImageNumber
        imwrite(imcomplement(handles.registeredImages{n}),[handles.FileNames{n},'Transformed.tif']); 
    end
else
    for n=1:handles.ImageNumber
        imwrite(handles.registeredImages{n},[handles.FileNames{n},'Transformed.tif']);  
    end
end
guidata(hObject, handles);

% --- Executes on button press in LoadForBS.
function LoadForBS_Callback(hObject, eventdata, handles)
% hObject    handle to LoadForBS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileNames,PathName] = uigetfile({'*.jpg;*.tif;*.png;*.gif','All Image Files'},'MultiSelect','on'); %finds names of files and pathway
FileNames = cellstr(FileNames);  % for the case of one file 
ImageNumber=length(FileNames); % The number of images is like the number of names
handles.ImageNumber=ImageNumber;
handles.FileNames=FileNames;
addpath(PathName); %add the pathway we got from line 3 to the list
for i=1:ImageNumber %loads the actual data and converts it to gray scale
    D=imread(char(FileNames(i)));
    handles.registeredImages{i}=D;
    clear D
end
handles.BinaryImageNumber=1;
set(handles.BStext,'string',num2str(handles.BinaryImageNumber));
axes(handles.OriginalScreen); 
imshow(handles.registeredImages{handles.BinaryImageNumber}); 
guidata(hObject, handles);

% --- Executes when selected object is changed in uibuttongroupBSType.
function uibuttongroupBSType_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uibuttongroupBSType 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

TagBSType=get(eventdata.NewValue,'Tag'); % Get Tag of selected number of joints.
switch TagBSType
    case 'RegularBSradiobutton'
        handles.BSType=1;
    case 'AdaptiveBSradiobutton'
        handles.BSType=2;
end
guidata(hObject,handles);

% --- Executes on slider movement.
function BSTHslider_Callback(hObject, eventdata, handles)
% hObject    handle to BSTHslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.BinarizationTH=get(hObject,'Value'); %gets the value from the slider
set(handles.BackgroundTHtext,'string',num2str(handles.BinarizationTH)); %updates the value in the text
TH=handles.BinarizationTH; %converts the value from precents to value between 0 and 1

if handles.BSType==1
    Binary=imbinarize(handles.registeredImages{handles.BinaryImageNumber},TH);
else % handles.BSType==2 means 'Adaptive'
    Binary=imbinarize(handles.registeredImages{handles.BinaryImageNumber},'adaptive','Sensitivity',TH); %converts to binary and substract background
end
handles.Binary=Binary; %saves the binary image

axes(handles.OriginalScreen);
imshow(handles.registeredImages{handles.BinaryImageNumber});
axes(handles.Screen); 
imshow(Binary); %presents the binary image in the "Screen" axes
set(handles.BackgroundConfirm,'Enable','on'); % enables the confirm button

guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function BSTHslider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BSTHslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in BackgroundConfirm.
function BackgroundConfirm_Callback(hObject, eventdata, handles)
% hObject    handle to BackgroundConfirm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.Binarized{handles.BinaryImageNumber}=handles.Binary;
handles=rmfield(handles,'Binary');
if handles.BinaryImageNumber<handles.ImageNumber
    handles.BinaryImageNumber=handles.BinaryImageNumber+1;
    set(handles.BStext,'string',num2str(handles.BinaryImageNumber));
    axes(handles.Screen); 
    imshow(handles.registeredImages{handles.BinaryImageNumber});    
else
    set(handles.BackgroundConfirm,'Enable','off');
    set(handles.BSTHslider,'Enable','off');
    set(handles.uipanelOS,'Visible','on');
    set(handles.ExportBS,'Enable','on');
    handles.OSImageNumber=1;
    axes(handles.Screen);
    imshow(handles.Binarized{handles.OSImageNumber});
    handles=rmfield(handles,'registeredImages');
end
set(handles.BackgroundConfirm,'Enable','off');
guidata(hObject,handles);


% --- Executes on button press in NegativeExportBScheckbox.
function NegativeExportBScheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to NegativeExportBScheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of NegativeExportBScheckbox
handles.NegativeExportBS=get(hObject,'Value');
guidata(hObject, handles);

% --- Executes on button press in ExportBS.
function ExportBS_Callback(hObject, eventdata, handles)
% hObject    handle to ExportBS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.NegativeExportBS==1
    for n=1:handles.ImageNumber
        imwrite(imcomplement(handles.Binarized{n}),[handles.FileNames{n},'Binarized.tif']); 
    end
else
    for n=1:handles.ImageNumber
        imwrite(handles.Binarized{n},[handles.FileNames{n},'Binarized.tif']); 
    end
end
guidata(hObject, handles);


% --- Executes on button press in SkipSelection.
function SkipSelection_Callback(hObject, eventdata, handles)
% hObject    handle to SkipSelection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.OSImages=handles.Binarized;
set(handles.uipanelOverlay,'Visible','on');
set(handles.ShowOverlay,'Enable','on');
guidata(hObject, handles);

% --- Executes on button press in LoadForOS.
function LoadForOS_Callback(hObject, eventdata, handles)
% hObject    handle to LoadForOS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileNames,PathName] = uigetfile({'*.jpg;*.tif;*.png;*.gif','All Image Files'},'MultiSelect','on'); %finds names of files and pathway
FileNames = cellstr(FileNames);  % for the case of one file 
ImageNumber=length(FileNames); % The number of images is like the number of names
handles.ImageNumber=ImageNumber;
handles.FileNames=FileNames;
addpath(PathName); %add the pathway we got from line 3 to the list
for i=1:ImageNumber %loads the actual data and converts it to gray scale
    D=imread(char(FileNames(i)));
    handles.Binarized{i}=D;
    clear D
end
handles.OSImageNumber=1;
set(handles.OStext,'string',num2str(handles.OSImageNumber));
axes(handles.OriginalScreen); 
imshow(handles.Binarized{handles.OSImageNumber}); 
guidata(hObject, handles);

% --- Executes when selected object is changed in uibuttongroupOSMode.
function uibuttongroupOSMode_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uibuttongroupOSMode 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
TagOS=get(eventdata.NewValue,'Tag'); % Get Tag of selected number of joints.
switch TagOS
    case 'SelectionbyAreaMode'
        handles.OS=1;
        set(handles.OSAreaHigherThanslider,'Enable','on');
        set(handles.OSAreaLowerThanslider,'Enable','on');
        set(handles.OSAreaHigherThantext,'Enable','on');
        set(handles.OSAreaLowerThantext,'Enable','on');
    case 'ManualSelectionModeradiobutton'
        handles.OS=2;
        if isfield(handles,'OSimage')
            handles=rmfield(handles,'OSimage');
        end
        if isfield(handles,'stats')
            handles=rmfield(handles,'stats');
        end
        set(handles.OSAreaHigherThanslider,'Enable','off');
        set(handles.OSAreaLowerThanslider,'Enable','off');
        set(handles.OSAreaHigherThantext,'Enable','off');
        set(handles.OSAreaLowerThantext,'Enable','off');
        handles.OSimage=handles.Binarized{handles.OSImageNumber};
        axes(handles.Screen);
        handles.L=bwlabel(handles.OSimage);
        handles.stats = regionprops(handles.OSimage,'Centroid');
        imshow(handles.OSimage);
        [x,y]=getpts(handles.Screen);
        handles.OSimage=bwselect(handles.OSimage,x,y,8);
        imshow(handles.OSimage);
        set(handles.CheckOS,'Enable','on');
end
guidata(hObject,handles);

% --- Executes on slider movement.
function OSAreaHigherThanslider_Callback(hObject, eventdata, handles)
% hObject    handle to OSAreaHigherThanslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.HigherThanAreaTH=get(hObject,'Value'); %gets the value from the slider
set(handles.OSAreaHigherThantext,'string',num2str(handles.HigherThanAreaTH)); %updates the value in the text
set(handles.CheckOS,'Enable','on');
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function OSAreaHigherThanslider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to OSAreaHigherThanslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function OSAreaLowerThanslider_Callback(hObject, eventdata, handles)
% hObject    handle to OSAreaLowerThanslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.LowerThanAreaTH=get(hObject,'Value'); %gets the value from the slider
set(handles.OSAreaLowerThantext,'string',num2str(handles.LowerThanAreaTH)); %updates the value in the text
set(handles.CheckOS,'Enable','on');
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function OSAreaLowerThanslider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to OSAreaLowerThanslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on button press in CheckOS.
function CheckOS_Callback(hObject, eventdata, handles)
% hObject    handle to CheckOS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.OS==1
    if isfield(handles,'OSimage')
        handles=rmfield(handles,'OSimage');
    end
    handles.OSimage=handles.Binarized{handles.OSImageNumber};
    axes(handles.Screen);
    imshow(handles.OSimage)
    handles.L=bwlabel(handles.OSimage);
    stats = regionprops(handles.OSimage,{'Area','Centroid'});
    k=2;
    ObjectSelected(1)=0;
    for i=1:size(stats,1)
        if stats(i).Area<handles.HigherThanAreaTH || stats(i).Area>handles.LowerThanAreaTH
                ObjectSelected(k)=i;
                k=k+1;
        end
    end
    ObjectSelected(1)=[];
    handles.ObjectSelected=ObjectSelected;
    imshow(handles.OSimage)
    hold on
    if length(ObjectSelected)>=1
        for i=1:length(ObjectSelected)
            centroid=stats(ObjectSelected(i)).Centroid;
            plot(centroid(1),centroid(2),'rx');
            hold on
        end
    end
else %handles.OS==2
    axes(handles.Screen);
    imshow(handles.OSimage)
    set(handles.ClearSelection,'Enable','on');
end
set(handles.OSConfirm,'Enable','on'); % enables the confirm button
guidata(hObject,handles);

% --- Executes on button press in ClearSelection.
function ClearSelection_Callback(hObject, eventdata, handles)
% hObject    handle to ClearSelection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isfield(handles,'OSimage')
    handles=rmfield(handles,'OSimage');
end
if isfield(handles,'stats')
    handles=rmfield(handles,'stats');
end
handles.OSimage=handles.Binarized{handles.OSImageNumber};
axes(handles.Screen);
handles.L=bwlabel(handles.OSimage);
handles.stats = regionprops(handles.OSimage,'Centroid');
imshow(handles.OSimage);
[x,y]=getpts(handles.Screen);
handles.OSimage=bwselect(handles.OSimage,x,y,4);
set(handles.CheckOS,'Enable','on');
set(handles.ClearSelection,'Enable','off');
guidata(hObject,handles);

% --- Executes on button press in OSConfirm.
function OSConfirm_Callback(hObject, eventdata, handles)
% hObject    handle to OSConfirm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.OS==1
    if length(handles.ObjectSelected)>=1
        for i=1:length(handles.ObjectSelected)
            handles.OSimage(handles.L==handles.ObjectSelected(i))=0; %deletes the ith object
        end
    end
end
handles.OSImages{handles.OSImageNumber}=handles.OSimage;
handles=rmfield(handles,'OSimage');
if isfield(handles,'stats')
    handles=rmfield(handles,'stats');
end
if handles.OSImageNumber<handles.ImageNumber
    handles.OSImageNumber=handles.OSImageNumber+1;
    axes(handles.Screen); 
    imshow(handles.Binarized{handles.OSImageNumber});
    if handles.OS==2
        handles.OSimage=handles.Binarized{handles.OSImageNumber};
        axes(handles.Screen);
        handles.L=bwlabel(handles.OSimage);
        handles.stats = regionprops(handles.OSimage,'Centroid');
        imshow(handles.OSimage);
        [x,y]=getpts(handles.Screen);
        handles.OSimage=bwselect(handles.OSimage,x,y,4);
        set(handles.CheckOS,'Enable','on'); 
    end
else
%     set(handles.uipanelOSMode,'Visible','off');
    set(handles.ExportOS,'Enable','on');
    set(handles.uipanelOverlay,'Visible','on');
    set(handles.ShowOverlay,'Enable','on');
    handles=rmfield(handles,'Binarized');   
end
guidata(hObject,handles);

% --- Executes on button press in NegativeExportOScheckbox.
function NegativeExportOScheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to NegativeExportOScheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of NegativeExportOScheckbox
handles.NegativeExportOS=get(hObject,'Value');
guidata(hObject, handles);

% --- Executes on button press in ExportOS.
function ExportOS_Callback(hObject, eventdata, handles)
% hObject    handle to ExportOS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.NegativeExportOS==1
    for n=1:handles.ImageNumber
        imwrite(imcomplement(handles.OSImages{n}),[handles.FileNames{n},'AfterSelection.tif']); 
    end
else
    for n=1:handles.ImageNumber
        imwrite(handles.OSImages{n},[handles.FileNames{n},'AfterSelection.tif']); 
    end
end
guidata(hObject, handles);

% --- Executes when selected object is changed in uibuttongroupOverlay.
function uibuttongroupOverlay_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uibuttongroupOverlay 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
TagOverlayType=get(eventdata.NewValue,'Tag'); % Get Tag of selected number of joints.
switch TagOverlayType
    case 'OrginalOverlayradiobutton'
        handles.OverlayType=1;
    case 'Dotsradiobutton'
        handles.OverlayType=2;
end
guidata(hObject, handles);

% --- Executes on button press in ShowOverlay.
function ShowOverlay_Callback(hObject, eventdata, handles)
% hObject    handle to ShowOverlay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.OverlayType==1
    for n=1:handles.ImageNumber
        handles.stack(:,:,n)=handles.OSImages{n};   
    end
    handles.Overlay=mean(handles.stack,3);
    axes(handles.Screen); 
    cla(handles.Screen);
    imshow(handles.Template);
    hold on
    imshow(handles.Overlay);
else %handles.OverlayType==2
    k=1;
    for n=1:handles.ImageNumber
        stats = regionprops(handles.OSImages{n},'Centroid');
        centroids = cat(1,stats.Centroid);
        if size(centroids,1)>0
            handles.Centroids(k:k-1+length(centroids(:,1)),1)=centroids(:,1);
            handles.Centroids(k:k-1+length(centroids(:,1)),2)=centroids(:,2);
            k=k+length(centroids(:,1));
        end
        clear stats centroids
    end  
    axes(handles.Screen);
    imshow(handles.Template);
    hold on
    handles.Overlay=scatter(handles.Centroids(:,1),handles.Centroids(:,2),'w.');
end   
set(handles.ExportOverlay,'Enable','on');
set(handles.uipanelDensity,'Visible','on');
guidata(hObject, handles);

% --- Executes on button press in NegativeExportOverlaycheckbox.
function NegativeExportOverlaycheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to NegativeExportOverlaycheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of NegativeExportOverlaycheckbox
handles.NegativeExportOverlay=get(hObject,'Value');
guidata(hObject, handles);

% --- Executes on button press in ExportOverlay.
function ExportOverlay_Callback(hObject, eventdata, handles)
% hObject    handle to ExportOverlay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.OverlayType==2
    F = getframe(handles.Screen);
    O = frame2im(F);
    if handles.NegativeExportOverlay==1
        imwrite(imcomplement(O),'Overlay.tif'); 
    else
        imwrite(O,'Overlay.tif'); 
    end
else
    if handles.NegativeExportOverlay==1
       imwrite(imcomplement(handles.Overlay),'Overlay.tif'); 
    else
       imwrite(handles.Overlay,'Overlay.tif'); 
    end
end
guidata(hObject, handles);

% --- Executes on slider movement.
function ContourStartslider_Callback(hObject, eventdata, handles)
% hObject    handle to ContourStartslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.ContourStart=get(hObject,'Value'); %gets the value from the slider
handles.ContourStart=round(handles.ContourStart);
set(handles.ContourStartslider,'Value',handles.ContourStart);
set(handles.ContourStarttext,'string',num2str(handles.ContourStart)); %updates the value in the text
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function ContourStartslider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ContourStartslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function ContourEndslider_Callback(hObject, eventdata, handles)
% hObject    handle to ContourEndslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.ContourEnd=get(hObject,'Value'); %gets the value from the slider
handles.ContourEnd=round(handles.ContourEnd);
set(handles.ContourEndslider,'Value',handles.ContourEnd);
set(handles.ContourEndtext,'string',num2str(handles.ContourEnd)); %updates the value in the text
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function ContourEndslider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ContourEndslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function EnhancementFactorslider_Callback(hObject, eventdata, handles)
% hObject    handle to EnhancementFactorslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.EnhancementFactor=get(hObject,'Value'); %gets the value from the slider
set(handles.EnhancementFactortext,'string',num2str(handles.EnhancementFactor)); %updates the value in the text
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function EnhancementFactorslider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EnhancementFactorslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes when selected object is changed in uibuttongroupColorDensity.
function uibuttongroupColorDensity_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uibuttongroupColorDensity 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
TagColorDensity=get(eventdata.NewValue,'Tag'); % Get Tag of selected number of joints.
switch TagColorDensity
    case 'RedDensityradiobutton'
        handles.ColorDensity=1;
        handles=rmfield(handles,'map');
        handles.map=zeros(256,3);
        handles.map(:,handles.ColorDensity)=linspace(0.4,1,256);
        handles.map(1,:)=[1 1 1];
    case 'GreenDensityradiobutton'
        handles.ColorDensity=2;
        handles=rmfield(handles,'map');
        handles.map=zeros(256,3);
        handles.map(:,handles.ColorDensity)=linspace(1,0.5,256);
        handles.map(1,:)=[1 1 1];
    case 'BlueDensityradiobutton'
        handles.ColorDensity=3;
        handles=rmfield(handles,'map');
        handles.map=zeros(256,3);
        handles.map(:,handles.ColorDensity)=linspace(0.4,1,256);
    case 'HotDensityradiobutton'
        handles.ColorDensity=4;
        handles=rmfield(handles,'map');
        handles.map='hot';
    case 'JetDensityradiobutton'
        handles.ColorDensity=5;
        handles=rmfield(handles,'map');
        handles.map='jet';
    case 'CoolDensityradiobutton'
        handles.ColorDensity=6;
        handles=rmfield(handles,'map');
        handles.map='cool';
    case 'GrayDensityradiobutton'
        handles.ColorDensity=7;
        handles=rmfield(handles,'map');
        handles.map='gray';
    case 'ParulaDensityradiobutton'
        handles.ColorDensity=8;
        handles=rmfield(handles,'map');
        handles.map='parula';
end
guidata(hObject,handles);

% --- Executes on button press in AddScaleBarDensitycheckbox.
function AddScaleBarDensitycheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to AddScaleBarDensitycheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of AddScaleBarDensitycheckbox
handles.AddScaleBarDensity=get(hObject,'Value');
guidata(hObject, handles);

% --- Executes on button press in LimitDensitycheckbox.
function LimitDensitycheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to LimitDensitycheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of LimitDensitycheckbox
handles.LimitDensity=get(hObject,'Value');
guidata(hObject, handles);

% --- Executes on button press in IncludePointscheckbox.
function IncludePointscheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to IncludePointscheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of IncludePointscheckbox
handles.IncludePoints=get(hObject,'Value');
guidata(hObject, handles);

% --- Executes on button press in ShowDensity.
function ShowDensity_Callback(hObject, eventdata, handles)
% hObject    handle to ShowDensity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.OriginalScreen);
if handles.ContourEnd<handles.ContourStart
    errordlg('Your Contour Start value is higher than your Contour End value! Please choose other Values');
    return
end
axes(handles.Screen);
cla(handles.Screen);
if handles.OverlayType==1 %Original 
   k=1;
   for n=1:size(handles.stack,3)
       for i=1:size(handles.stack(:,:,n),1)
           for j=1:size(handles.stack(:,:,n),2)
               if handles.stack(i,j,n)>0
                  Xcoord(k)=j;
                  Ycoord(k)=i;
                  k=k+1;
               end
           end
       end
   end
   Coordinates=[Xcoord',Ycoord'];
   handles.Coordinates=Coordinates;
   [bandwidth,density,X,Y]=kde2d(Coordinates);
   figure
   imshow(imcomplement(handles.Template)); 
   hold on
   if handles.LimitDensity==1
        [M,C]=contour(X,Y,density,[handles.ContourStart,handles.ContourEnd]);hold on
%         contour(handles.Screen,flipud(handles.EnhancementFactor*handles.Overlay),[handles.ContourStart:10:handles.ContourEnd],'edgecolor','none');
   else
        [M,C]=contour(X,Y,density,handles.ContourEnd); hold on
%         contour(handles.Screen,flipud(handles.EnhancementFactor*handles.Overlay),handles.ContourStart);
    end
else %handles.OverlayType==2
%     axes(handles.Screen);
    [bandwidth,density,X,Y]=kde2d(handles.Centroids);
    figure
    imshow(imcomplement(handles.Template)); 
    axis([1 size(handles.Template,2) 1 size(handles.Template,1)]);
    hold on
    if handles.LimitDensity==1
        [M,C]=contourf(X,Y,density,handles.ContourStart:10:handles.ContourEnd,'edgecolor','none');hold on
    else
        [M,C]=contour(X,Y,density,handles.ContourEnd); ,hold on
    end
    if handles.IncludePoints==1
        plot(handles.Centroids(:,1),handles.Centroids(:,2),'r.','MarkerSize',5);
    end
%     [n,c] = hist3([handles.Cx', handles.Cy']);
%     [M,C] =contourf(c{1},c{2},n);
%     rotate(C,[0 0 1],90) 
%     cla(handles.Screen);
    k=0;
    i=1;
    while 1+k+M(2,1+k)<size(M,2)
        ContX{i}=M(1,2+k:1+k+M(2,1+k));
        ContY{i}=M(2,2+k:1+k+M(2,1+k));
%         H(i)=M(1,1+k);
        k=k+1+M(2,1+k); 
        i=i+1;
    end
%     MaxRange=H(length(H))-H(1);
    idx=1;
    for j=1:i-1
%         CurrentR=H(length(H))-H(j);
        x=ContX{j};
        y=ContY{j};
        if x(1)~=x(2)
            K = boundary(x',y',1);     
% %             if 1+floor((1-(CurrentR/MaxRange))*256)<=256
% %                 f=fill(x(K),y(K),handles.map(1+floor((1-(CurrentR/MaxRange))*256),:),'EdgeColor','none');
% %             else
% %                 f=fill(x(K),y(K),handles.map(256,:),'EdgeColor','none');
% %             end
            handles.BoundaryPoints(idx:idx-1+length(x(K)),1)=x(K);
            handles.BoundaryPoints(idx:idx-1+length(y(K)),2)=y(K);        
            idx=idx+length(x(K)); 
            hold on
            clear x y K 
        end    
    end
end
colormap(handles.map);  
if handles.AddScaleBarDensity==1
    contourcbar
end
set(handles.Screen,'xtick',[])
set(handles.Screen,'xticklabel',[])
set(handles.Screen,'ytick',[])
set(handles.Screen,'yticklabel',[])
F = getframe(handles.Screen);
handles.Density = frame2im(F);
guidata(hObject, handles);

% --- Executes on button press in ExportDensity.
function ExportDensity_Callback(hObject, eventdata, handles)
% hObject    handle to ExportDensity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

prompt = 'Please insert a name for the file';
UserInputName=char(inputdlg(prompt));
imwrite(handles.Density,[UserInputName,'Density.tif']); 
if handles.OverlayType==1 %Original 
    if size(handles.Coordinates,1)<=1048576
        xlswrite([UserInputName,'AllPoints.xlsx'],handles.Coordinates,['A1:B',num2str(size(handles.Coordinates,1))]);
    else
        part1=floor(size(handles.Coordinates,1)/2);
        part2=floor(size(handles.Coordinates,1)/2)+1;
        xlswrite([UserInputName,'AllPointsPart1.xlsx'],handles.Coordinates(1:part1,:),['A1:B',num2str(part1)]);
        xlswrite([UserInputName,'AllPointsPart2.xlsx'],handles.Coordinates(part2:size(handles.Coordinates,1),:),['A1:B',num2str(size(handles.Coordinates,1)-part1)]);
    end
else
    if size(handles.Centroids,1)<=1048576
%     xlswrite([UserInputName,'BoundaryPoints.xlsx'],handles.BoundaryPoints);
        xlswrite([UserInputName,'AllPoints.xlsx'],handles.Centroids);
    else
        part1=floor(size(handles.Centroids,1)/2);
        part2=floor(size(handles.Centroids,1)/2)+1;
        xlswrite([UserInputName,'AllPointsPart1.xlsx'],handles.Centroids(1:part1,:),['A1:B',num2str(part1)]);
        xlswrite([UserInputName,'AllPointsPart2.xlsx'],handles.Centroids(part2:size(handles.Centroids,1),:),['A1:B',num2str(size(handles.Centroids,1)-part1)]);
    end
end
guidata(hObject, handles);
