function varargout = ContoursIntersectionVolume(varargin)
% CONTOURSINTERSECTIONVOLUME MATLAB code for ContoursIntersectionVolume.fig
%      CONTOURSINTERSECTIONVOLUME, by itself, creates a new CONTOURSINTERSECTIONVOLUME or raises the existing
%      singleton*.
%
%      H = CONTOURSINTERSECTIONVOLUME returns the handle to a new CONTOURSINTERSECTIONVOLUME or the handle to
%      the existing singleton*.
%
%      CONTOURSINTERSECTIONVOLUME('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CONTOURSINTERSECTIONVOLUME.M with the given input arguments.
%
%      CONTOURSINTERSECTIONVOLUME('Property','Value',...) creates a new CONTOURSINTERSECTIONVOLUME or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ContoursIntersectionVolume_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ContoursIntersectionVolume_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ContoursIntersectionVolume

% Last Modified by GUIDE v2.5 15-Aug-2019 12:38:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ContoursIntersectionVolume_OpeningFcn, ...
                   'gui_OutputFcn',  @ContoursIntersectionVolume_OutputFcn, ...
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


% --- Executes just before ContoursIntersectionVolume is made visible.
function ContoursIntersectionVolume_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ContoursIntersectionVolume (see VARARGIN)

% Choose default command line output for ContoursIntersectionVolume
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

axes(handles.Screen);
set(handles.Screen,'xtick',[])
set(handles.Screen,'xticklabel',[])
set(handles.Screen,'ytick',[])
set(handles.Screen,'yticklabel',[])

%Filtering
handles.SaveInorOut=1; 
handles.DensitynumberFiltering=1;
set(handles.uipanelFiltering,'Visible','off');
set(handles.CheckFiltering,'Enable','off');
set(handles.ClearFiltering,'Enable','off');
set(handles.ConfirmFiltering,'Enable','off');
set(handles.ScatterPointsAfterDeletion,'Enable','off');
%
handles.VisualizationType=2;
handles.ContoursNumber1=6;
handles.ContoursNumber2=6;
handles.MinTH1=0.2;
handles.MaxTH1=0.8;
handles.MinTH2=0.2;
handles.MaxTH2=0.8;
handles.Transparent1=255;
handles.Transparent2=255;
handles.Transparent1ON=0;
handles.Transparent2ON=0;
set(handles.Transparentslider1,'Enable','off');
set(handles.Transparenttext1,'Enable','off');
set(handles.Transparentslider2,'Enable','off');
set(handles.Transparenttext2,'Enable','off');
handles.PlotPoints=0;
handles.map1=zeros(256,3);
handles.map2=zeros(256,3);
handles.Color1=2;
handles.Color2=1;
handles.map1(:,handles.Color1)=linspace(0,1,256);
handles.map2(:,handles.Color2)=linspace(0,1,256);
handles.IntersectionPlotType=3;
handles.flag=0;
handles.NormalizedToPoints=0;
handles.AlphaValue1=1;
handles.AlphaValue2=1;
guidata(hObject, handles);
% UIWAIT makes ContoursIntersectionVolume wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ContoursIntersectionVolume_OutputFcn(hObject, eventdata, handles) 
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
Template=imread(char(TFileName));
handles.Template=mat2gray(Template(:,:,1:3));
set(handles.uipanelFiltering,'Visible','on');
set(handles.LoadTemplate,'Enable','off');
guidata(hObject, handles);

% --- Executes on button press in Load1.
function Load1_Callback(hObject, eventdata, handles)
% hObject    handle to Load1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName, pathname] = uigetfile({'*.xlsx';'*.xls';},'Select your Density 1 file'); 
if isequal(FileName,0) %For case the user presses 'cancel'
    return
else                      
    path(char(pathname),path);  %Adds the path name to the search path of matlab       
    handles.Density1=xlsread(char(FileName)); 
    handles.FileName1=FileName;
end
guidata(hObject, handles);

% --- Executes on button press in Load2.
function Load2_Callback(hObject, eventdata, handles)
% hObject    handle to Load2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName, pathname] = uigetfile({'*.xlsx';'*.xls';},'Select your Density 2 file'); 
if isequal(FileName,0) %For case the user presses 'cancel'
    return
else                      
    path(char(pathname),path);  %Adds the path name to the search path of matlab       
    handles.Density2=xlsread(char(FileName));
    handles.FileName2=FileName;
end
% handles.Density2=handles.Density2.*0.9+50;
guidata(hObject, handles);

% --- Executes on button press in ResetLoad1.
function ResetLoad1_Callback(hObject, eventdata, handles)
% hObject    handle to ResetLoad1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in ResetLoad2.
function ResetLoad2_Callback(hObject, eventdata, handles)
% hObject    handle to ResetLoad2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in ResetLoadTemplate.
function ResetLoadTemplate_Callback(hObject, eventdata, handles)
% hObject    handle to ResetLoadTemplate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes when selected object is changed in uibuttongroupDensityNumberFiltering.
function uibuttongroupDensityNumberFiltering_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uibuttongroupDensityNumberFiltering 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
TagDensitynumberFiltering=get(eventdata.NewValue,'Tag'); % Get Tag of selected number of joints.
switch TagDensitynumberFiltering
    case 'D1radiobutton'
        handles.DensitynumberFiltering=1; 
    case 'D2radiobutton'
        handles.DensitynumberFiltering=2;        
end
guidata(hObject,handles);

% --- Executes when selected object is changed in uibuttongroupRemoveInorOut.
function uibuttongroupRemoveInorOut_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uibuttongroupRemoveInorOut 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
TagInorOut=get(eventdata.NewValue,'Tag'); % Get Tag of selected number of joints.
switch TagInorOut
    case 'radiobuttonSavein'
        handles.SaveInorOut=1; 
    case 'radiobuttonSaveOut'
        handles.SaveInorOut=2;        
end
guidata(hObject,handles);

% --- Executes on button press in ShowTempandPoints.
function ShowTempandPoints_Callback(hObject, eventdata, handles)
% hObject    handle to ShowTempandPoints (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.Screen);
imshow(handles.Template);
hold on
if handles.DensitynumberFiltering==1 
    handles.Overlay1=scatter(handles.Density1(:,1),handles.Density1(:,2),'k.');
else
    handles.Overlay2=scatter(handles.Density2(:,1),handles.Density2(:,2),'k.');
end
hold on
set(handles.CheckFiltering,'Enable','on');
[handles.xF,handles.yF]=getpts(handles.Screen);
guidata(hObject,handles);

% --- Executes on button press in CheckFiltering.
function CheckFiltering_Callback(hObject, eventdata, handles)
% hObject    handle to CheckFiltering (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
p=patch(handles.Screen,handles.xF,handles.yF,'r','edgecolor','g');
alpha(p,0.1)
set(handles.CheckFiltering,'Enable','off');
set(handles.ClearFiltering,'Enable','on');
set(handles.ConfirmFiltering,'Enable','on');
guidata(hObject,handles);

% --- Executes on button press in ConfirmFiltering.
function ConfirmFiltering_Callback(hObject, eventdata, handles)
% hObject    handle to ConfirmFiltering (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.DensitynumberFiltering==1 
    handles.D1in= inpolygon(handles.Density1(:,1),handles.Density1(:,2),handles.xF,handles.yF);
    if handles.SaveInorOut==1
        Dx=handles.Density1(handles.D1in,1);
        Dy=handles.Density1(handles.D1in,2);
    else
        Dx=handles.Density1(~handles.D1in,1);
        Dy=handles.Density1(~handles.D1in,2);
    end
    handles=rmfield(handles,'Density1');
    handles.Density1=[Dx,Dy];
else
    handles.D2in= inpolygon(handles.Density2(:,1),handles.Density2(:,2),handles.xF,handles.yF);
    if handles.SaveInorOut==1
        Dx=handles.Density2(handles.D2in,1);
        Dy=handles.Density2(handles.D2in,2);
    else
        Dx=handles.Density2(~handles.D2in,1);
        Dy=handles.Density2(~handles.D2in,2);
    end
    handles=rmfield(handles,'Density2');
    handles.Density2=[Dx,Dy];
end
handles=rmfield(handles,'xF');
handles=rmfield(handles,'yF');
clear Dx Dy
set(handles.ConfirmFiltering,'Enable','off');
set(handles.ScatterPointsAfterDeletion,'Enable','on');
guidata(hObject,handles);

% --- Executes on button press in ClearFiltering.
function ClearFiltering_Callback(hObject, eventdata, handles)
% hObject    handle to ClearFiltering (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles=rmfield(handles,'xF');
handles=rmfield(handles,'yF');
set(handles.CheckFiltering,'Enable','on');
set(handles.ClearFiltering,'Enable','off');
[handles.xF,handles.yF]=getpts(handles.Screen);
guidata(hObject,handles);

% --- Executes on button press in ScatterPointsAfterDeletion.
function ScatterPointsAfterDeletion_Callback(hObject, eventdata, handles)
% hObject    handle to ScatterPointsAfterDeletion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.Screen);
cla(handles.Screen);
imshow(handles.Template);
hold on
if handles.DensitynumberFiltering==1 
    handles.Overlay1=scatter(handles.Density1(:,1),handles.Density1(:,2),'w.');
else
    handles.Overlay2=scatter(handles.Density2(:,1),handles.Density2(:,2),'w.');
end
set(handles.ScatterPointsAfterDeletion,'Enable','off');
guidata(hObject,handles);

% --- Executes on button press in ExportFiltering.
function ExportFiltering_Callback(hObject, eventdata, handles)
% hObject    handle to ExportFiltering (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.DensitynumberFiltering==1 
    xlswrite([handles.FileName1,'Filtered.xlsx'],handles.Density1,['A1:B',num2str(size(handles.Density1,1))]);
else
    xlswrite([handles.FileName2,'Filtered.xlsx'],handles.Density2,['A1:B',num2str(size(handles.Density2,1))]);
end
guidata(hObject,handles);

% --- Executes when selected object is changed in uibuttongroupVisualizationType.
function uibuttongroupVisualizationType_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uibuttongroupVisualizationType 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
TagVisualizationType=get(eventdata.NewValue,'Tag'); % Get Tag of selected number of joints.
switch TagVisualizationType
    case 'NoFillTemplateradiobutton'
        handles.VisualizationType=1; 
    case 'NoFillNoTemplateradiobutton'
        handles.VisualizationType=2;        
    case 'FilledTemplateradiobutton'
        handles.VisualizationType=3;
    case 'NoFillNoTemp3Dradiobutton'
        handles.VisualizationType=4;
end
guidata(hObject,handles);

% --- Executes when selected object is changed in uibuttongroupColor1.
function uibuttongroupColor1_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uibuttongroupColor1 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
TagColor1=get(eventdata.NewValue,'Tag'); % Get Tag of selected number of joints.
switch TagColor1
    case 'Redradiobutton1'
        handles.Color1=1;
        handles=rmfield(handles,'map1');
        handles.map1=zeros(256,3);
        handles.map1(:,handles.Color1)=linspace(0.4,1,256);
        handles.map1(1,:)=[1 1 1];
        set(handles.Redradiobutton2,'Enable','off');
        set(handles.Greenradiobutton2,'Enable','on');
        set(handles.Blueradiobutton2,'Enable','on');
        set(handles.Yellowradiobutton2,'Enable','on');
        set(handles.Cyanradiobutton2,'Enable','on');
        set(handles.Magentaradiobutton2,'Enable','on');
        set(handles.Jetradiobutton2,'Enable','on');
        set(handles.Hotradiobutton2,'Enable','on');   
    case 'Greenradiobutton1'
        handles.Color1=2;
        handles=rmfield(handles,'map1');
        handles.map1=zeros(256,3);
        handles.map1(:,handles.Color1)=linspace(0.4,1,256);
        handles.map1(1,:)=[1 1 1];
        set(handles.Redradiobutton2,'Enable','on');
        set(handles.Greenradiobutton2,'Enable','off');
        set(handles.Blueradiobutton2,'Enable','on');
        set(handles.Yellowradiobutton2,'Enable','on');
        set(handles.Cyanradiobutton2,'Enable','on');
        set(handles.Magentaradiobutton2,'Enable','on');
        set(handles.Jetradiobutton2,'Enable','on');
        set(handles.Hotradiobutton2,'Enable','on');  
    case 'Blueradiobutton1'
        handles.Color1=3;
        handles=rmfield(handles,'map1');
        handles.map1=zeros(256,3);
        handles.map1(:,handles.Color1)=linspace(0.4,1,256);
        handles.map1(1,:)=[1 1 1];
        set(handles.Redradiobutton2,'Enable','on');
        set(handles.Greenradiobutton2,'Enable','on');
        set(handles.Blueradiobutton2,'Enable','off');
        set(handles.Yellowradiobutton2,'Enable','on');
        set(handles.Cyanradiobutton2,'Enable','on');
        set(handles.Magentaradiobutton2,'Enable','on');
        set(handles.Jetradiobutton2,'Enable','on');
        set(handles.Hotradiobutton2,'Enable','on');  
    case 'Yellowradiobutton1'
        handles.Color1=4;
        handles=rmfield(handles,'map1');
        handles.map1=zeros(256,3);
        handles.map1(:,1)=linspace(0.4,1,256);
        handles.map1(:,2)=linspace(0.4,1,256);
        handles.map1(1,:)=[1 1 1];
        set(handles.Redradiobutton2,'Enable','on');
        set(handles.Greenradiobutton2,'Enable','on');
        set(handles.Blueradiobutton2,'Enable','on');
        set(handles.Yellowradiobutton2,'Enable','off');
        set(handles.Cyanradiobutton2,'Enable','on');
        set(handles.Magentaradiobutton2,'Enable','on');
        set(handles.Jetradiobutton2,'Enable','on');
        set(handles.Hotradiobutton2,'Enable','on');
    case 'Cyanradiobutton1'
        handles.Color1=5;
        handles=rmfield(handles,'map1');
        handles.map1=zeros(256,3);
        handles.map1(:,2)=linspace(0.4,1,256);
        handles.map1(:,3)=linspace(0.4,1,256);
        handles.map1(1,:)=[1 1 1];
        set(handles.Redradiobutton2,'Enable','on');
        set(handles.Greenradiobutton2,'Enable','on');
        set(handles.Blueradiobutton2,'Enable','on');
        set(handles.Yellowradiobutton2,'Enable','on');
        set(handles.Cyanradiobutton2,'Enable','off');
        set(handles.Magentaradiobutton2,'Enable','on');
        set(handles.Jetradiobutton2,'Enable','on');
        set(handles.Hotradiobutton2,'Enable','on');  
    case 'Magentaradiobutton1'
        handles.Color1=6;
        handles=rmfield(handles,'map1');
        handles.map1=zeros(256,3);
        handles.map1(:,1)=linspace(0.4,1,256);
        handles.map1(:,3)=linspace(0.4,1,256);
        handles.map1(1,:)=[1 1 1];
        set(handles.Redradiobutton2,'Enable','on');
        set(handles.Greenradiobutton2,'Enable','on');
        set(handles.Blueradiobutton2,'Enable','on');
        set(handles.Yellowradiobutton2,'Enable','on');
        set(handles.Cyanradiobutton2,'Enable','on');
        set(handles.Magentaradiobutton2,'Enable','off');
        set(handles.Jetradiobutton2,'Enable','on');
        set(handles.Hotradiobutton2,'Enable','on');  
    case 'Jetradiobutton1'
        handles.Color1=7;
        handles=rmfield(handles,'map1');
        handles.map1='jet';
        set(handles.Redradiobutton2,'Enable','on');
        set(handles.Greenradiobutton2,'Enable','on');
        set(handles.Blueradiobutton2,'Enable','on');
        set(handles.Yellowradiobutton2,'Enable','on');
        set(handles.Cyanradiobutton2,'Enable','on');
        set(handles.Magentaradiobutton2,'Enable','on');
        set(handles.Jetradiobutton2,'Enable','off');
        set(handles.Hotradiobutton2,'Enable','on');  
    case 'Hotradiobutton1'
        handles.Color1=8;
        handles=rmfield(handles,'map1');
        handles.map1='hot';
        set(handles.Redradiobutton2,'Enable','on');
        set(handles.Greenradiobutton2,'Enable','on');
        set(handles.Blueradiobutton2,'Enable','on');
        set(handles.Yellowradiobutton2,'Enable','on');
        set(handles.Cyanradiobutton2,'Enable','on');
        set(handles.Magentaradiobutton2,'Enable','on');
        set(handles.Jetradiobutton2,'Enable','on');
        set(handles.Hotradiobutton2,'Enable','off');  
end
guidata(hObject,handles);

% --- Executes when selected object is changed in uibuttongroupColor2.
function uibuttongroupColor2_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uibuttongroupColor2 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
TagColor2=get(eventdata.NewValue,'Tag'); % Get Tag of selected number of joints.
switch TagColor2
    case 'Redradiobutton2'
        handles.Color2=1;
        handles=rmfield(handles,'map2');
        handles.map2=zeros(256,3);
        handles.map2(:,handles.Color2)=linspace(0.4,1,256);
        handles.map2(1,:)=[1 1 1];
        set(handles.Redradiobutton1,'Enable','off');
        set(handles.Greenradiobutton1,'Enable','on');
        set(handles.Blueradiobutton1,'Enable','on');
        set(handles.Yellowradiobutton1,'Enable','on');
        set(handles.Cyanradiobutton1,'Enable','on');
        set(handles.Magentaradiobutton1,'Enable','on');
        set(handles.Jetradiobutton1,'Enable','on');
        set(handles.Hotradiobutton1,'Enable','on');   
    case 'Greenradiobutton2'
        handles.Color2=2;
        handles=rmfield(handles,'map2');
        handles.map2=zeros(256,3);
        handles.map2(:,handles.Color2)=linspace(0.4,1,256);
        handles.map2(1,:)=[1 1 1];
        set(handles.Redradiobutton1,'Enable','on');
        set(handles.Greenradiobutton1,'Enable','off');
        set(handles.Blueradiobutton1,'Enable','on');
        set(handles.Yellowradiobutton1,'Enable','on');
        set(handles.Cyanradiobutton1,'Enable','on');
        set(handles.Magentaradiobutton1,'Enable','on');
        set(handles.Jetradiobutton1,'Enable','on');
        set(handles.Hotradiobutton1,'Enable','on');  
    case 'Blueradiobutton2'
        handles.Color2=3;
        handles=rmfield(handles,'map2');
        handles.map2=zeros(256,3);
        handles.map2(:,handles.Color2)=linspace(0.4,1,256);
        handles.map2(1,:)=[1 1 1];
        set(handles.Redradiobutton1,'Enable','on');
        set(handles.Greenradiobutton1,'Enable','on');
        set(handles.Blueradiobutton1,'Enable','off');
        set(handles.Yellowradiobutton1,'Enable','on');
        set(handles.Cyanradiobutton1,'Enable','on');
        set(handles.Magentaradiobutton1,'Enable','on');
        set(handles.Jetradiobutton1,'Enable','on');
        set(handles.Hotradiobutton1,'Enable','on'); 
        case 'Yellowradiobutton2'
        handles.Color2=4;
        handles=rmfield(handles,'map2');
        handles.map2=zeros(256,3);
        handles.map2(:,1)=linspace(0.4,1,256);
        handles.map2(:,2)=linspace(0.4,1,256);
        handles.map2(1,:)=[1 1 1];
        set(handles.Redradiobutton1,'Enable','on');
        set(handles.Greenradiobutton1,'Enable','on');
        set(handles.Blueradiobutton1,'Enable','on');
        set(handles.Yellowradiobutton1,'Enable','off');
        set(handles.Cyanradiobutton1,'Enable','on');
        set(handles.Magentaradiobutton1,'Enable','on');
        set(handles.Jetradiobutton1,'Enable','on');
        set(handles.Hotradiobutton1,'Enable','on');
    case 'Cyanradiobutton2'
        handles.Color2=5;
        handles=rmfield(handles,'map2');
        handles.map2=zeros(256,3);
        handles.map2(:,2)=linspace(0.4,1,256);
        handles.map2(:,3)=linspace(0.4,1,256);
        handles.map2(1,:)=[1 1 1];
        set(handles.Redradiobutton1,'Enable','on');
        set(handles.Greenradiobutton1,'Enable','on');
        set(handles.Blueradiobutton1,'Enable','on');
        set(handles.Yellowradiobutton1,'Enable','on');
        set(handles.Cyanradiobutton1,'Enable','off');
        set(handles.Magentaradiobutton1,'Enable','on');
        set(handles.Jetradiobutton1,'Enable','on');
        set(handles.Hotradiobutton1,'Enable','on');  
    case 'Magentaradiobutton2'
        handles.Color2=6;
        handles=rmfield(handles,'map2');
        handles.map2=zeros(256,3);
        handles.map2(:,1)=linspace(0.4,1,256);
        handles.map2(:,3)=linspace(0.4,1,256);
        handles.map2(1,:)=[1 1 1];
        set(handles.Redradiobutton1,'Enable','on');
        set(handles.Greenradiobutton1,'Enable','on');
        set(handles.Blueradiobutton1,'Enable','on');
        set(handles.Yellowradiobutton1,'Enable','on');
        set(handles.Cyanradiobutton1,'Enable','on');
        set(handles.Magentaradiobutton1,'Enable','off');
        set(handles.Jetradiobutton1,'Enable','on');
        set(handles.Hotradiobutton1,'Enable','on'); 
    case 'Jetradiobutton2'
        handles.Color2=7;
        handles=rmfield(handles,'map2');
        handles.map2='jet';
        set(handles.Redradiobutton1,'Enable','on');
        set(handles.Greenradiobutton1,'Enable','on');
        set(handles.Blueradiobutton1,'Enable','on');
        set(handles.Yellowradiobutton1,'Enable','on');
        set(handles.Cyanradiobutton1,'Enable','on');
        set(handles.Magentaradiobutton1,'Enable','on');
        set(handles.Jetradiobutton1,'Enable','off');
        set(handles.Hotradiobutton1,'Enable','on');  
    case 'Hotradiobutton2'
        handles.Color2=8;
        handles=rmfield(handles,'map2');
        handles.map2='hot';
        set(handles.Redradiobutton1,'Enable','on');
        set(handles.Greenradiobutton1,'Enable','on');
        set(handles.Blueradiobutton1,'Enable','on');
        set(handles.Yellowradiobutton1,'Enable','on');
        set(handles.Cyanradiobutton1,'Enable','on');
        set(handles.Magentaradiobutton1,'Enable','on');
        set(handles.Jetradiobutton1,'Enable','on');
        set(handles.Hotradiobutton1,'Enable','off');  
end
guidata(hObject,handles);

% --- Executes on slider movement.
function ContoursNumberslider1_Callback(hObject, eventdata, handles)
% hObject    handle to ContoursNumberslider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.ContoursNumber1=get(hObject,'Value'); %gets the value from the slider
handles.ContoursNumber1=round(handles.ContoursNumber1);
set(handles.ContoursNumbertext1,'string',num2str(handles.ContoursNumber1)); %updates the value in the text
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function ContoursNumberslider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ContoursNumberslider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function ContoursNumberslider2_Callback(hObject, eventdata, handles)
% hObject    handle to ContoursNumberslider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.ContoursNumber2=get(hObject,'Value'); %gets the value from the slider
handles.ContoursNumber2=round(handles.ContoursNumber2);
set(handles.ContoursNumbertext2,'string',num2str(handles.ContoursNumber2)); %updates the value in the text
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function ContoursNumberslider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ContoursNumberslider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function MaxTHslider_Callback(hObject, eventdata, handles)
% hObject    handle to MaxTHslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.MaxTH1=get(hObject,'Value'); %gets the value from the slider
set(handles.MaxTH1text,'string',num2str(handles.MaxTH1)); %updates the value in the text
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function MaxTHslider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MaxTHslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function MinTH1slider_Callback(hObject, eventdata, handles)
% hObject    handle to MinTH1slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.MinTH1=get(hObject,'Value'); %gets the value from the slider
set(handles.MinTH1text,'string',num2str(handles.MinTH1)); %updates the value in the text
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function MinTH1slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MinTH1slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function MinTH2slider_Callback(hObject, eventdata, handles)
% hObject    handle to MinTH2slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.MinTH2=get(hObject,'Value'); %gets the value from the slider
set(handles.MinTH2text,'string',num2str(handles.MinTH2)); %updates the value in the text
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function MinTH2slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MinTH2slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function MaxTH2slider_Callback(hObject, eventdata, handles)
% hObject    handle to MaxTH2slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.MaxTH2=get(hObject,'Value'); %gets the value from the slider
set(handles.MaxTH2text,'string',num2str(handles.MaxTH2)); %updates the value in the text
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function MaxTH2slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MaxTH2slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on button press in Transparent1checkbox.
function Transparent1checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to Transparent1checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Transparent1checkbox
handles.Transparent1ON=get(hObject,'Value');
if handles.Transparent1ON==1
    set(handles.Transparentslider1,'Enable','on');
    set(handles.Transparenttext1,'Enable','on');
else
    set(handles.Transparentslider1,'Enable','off');
    set(handles.Transparenttext1,'Enable','off');
end
guidata(hObject,handles);
% --- Executes on button press in Transparent2checkbox.
function Transparent2checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to Transparent2checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Transparent2checkbox
handles.Transparent2ON=get(hObject,'Value');
if handles.Transparent2ON==1
    set(handles.Transparentslider2,'Enable','on');
    set(handles.Transparenttext2,'Enable','on');
else
    set(handles.Transparentslider2,'Enable','off');
    set(handles.Transparenttext2,'Enable','off');
end
guidata(hObject,handles);

% --- Executes on slider movement.
function Transparentslider1_Callback(hObject, eventdata, handles)
% hObject    handle to Transparentslider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.Transparent1=get(hObject,'Value'); %gets the value from the slider
handles.Transparent1=round(handles.Transparent1);
set(handles.Transparentslider1,'Value',handles.Transparent1);
set(handles.Transparenttext1,'string',num2str(handles.Transparent1)); %updates the value in the text
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function Transparentslider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Transparentslider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function Transparentslider2_Callback(hObject, eventdata, handles)
% hObject    handle to Transparentslider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.Transparent2=get(hObject,'Value'); %gets the value from the slider
handles.Transparent2=round(handles.Transparent2);
set(handles.Transparentslider2,'Value',handles.Transparent2);
set(handles.Transparenttext2,'string',num2str(handles.Transparent2)); %updates the value in the text
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function Transparentslider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Transparentslider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in PlotDatacheckbox.
function PlotDatacheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to PlotDatacheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of PlotDatacheckbox
handles.PlotPoints=get(hObject,'Value');
guidata(hObject,handles);


% --- Executes on button press in VisDensity1.
function VisDensity1_Callback(hObject, eventdata, handles)
% hObject    handle to VisDensity1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.Screen);
if isfield(handles,'X1Values')
    handles=rmfield(handles,'X1Values');
end
if isfield(handles,'Y1Values')
    handles=rmfield(handles,'Y1Values');
end
if isfield(handles,'Height1')
    handles=rmfield(handles,'Height1');
end
[bandwidth,density,X,Y]=kde2d([handles.Density1(:,1), handles.Density1(:,2)]);
MinV=min(min(density(density>0),[],2),[],1);
MaxV=max(max(density,[],2),[],1);
R=MaxV-MinV; 
V=linspace(handles.MinTH1*R,handles.MaxTH1*R,handles.ContoursNumber1);
if handles.VisualizationType==1
%     hold off
%     figure
%     ax1 = axes;
%     ax1.XLim=[1 size(handles.Template,2)];
%     ax1.YLim=[1 size(handles.Template,1)];
%     image(ax1,handles.Template); 
%     ax2 = axes;
%     [M,C]=contour(ax2,X,Y,density,'LevelList',V); 
%     linkaxes([ax1,ax2])
%     %%Hide the top axes
%     ax2.Visible = 'off';
%     ax2.XTick = [];
%     ax2.YTick = [];
%     %%Give each one its own colormap
%     colormap(ax1,'gray')
%     colormap(ax2,'cool')
    %%Then add colorbars and get everything lined up
%     set([ax1,ax2],'Position',[.17 .11 .685 .815]);

    hold off
    imshow(handles.Template); 
    hold on
    [M,C]=contour(X,Y,density,'LevelList',V); hold on
    set(C, 'LineColor',handles.map1(150,:));

elseif handles.VisualizationType==2
    hold off
    [M,C]=contour(X,Y,density,'LevelList',V); hold on
    colormap(handles.map1);
elseif handles.VisualizationType==3
    hold off
    imshow(handles.Template); 
    hold on
    [M,C]=contourf(X,Y,density,'LevelList',V); hold on
    set(C, 'LineColor',handles.map1(25,:));
    set(C, 'FaceColor',handles.map1(150,:));
    if handles.Transparent1ON==1
        drawnow;  % this is important, to ensure that FacePrims is ready in the next line!
        hFills = C.FacePrims;  % array of TriangleStrip objects
        [hFills.ColorType] = deal('truecoloralpha');  % default = 'truecolor'
        for idx = 1 : numel(hFills)            
            hFills(idx).ColorData(4) = handles.Transparent1;   % default=255
            hold on
        end
    end
else %handles.VisualizationType==4
    hold off
    [M,C]=contour3(X,Y,density,'LevelList',V); hold on
    colormap(handles.map1);
end
if handles.PlotPoints==1
    plot(handles.Density1(:,1),handles.Density1(:,2),'r.','MarkerSize',5);
end
k=0;
i=1;
while 1+k+M(2,1+k)<size(M,2)
    handles.X1Values(1+k:k+M(2,1+k))=M(1,2+k:1+k+M(2,1+k));
    handles.Y1Values(1+k:k+M(2,1+k))=M(2,2+k:1+k+M(2,1+k));
    handles.Height1(1+k:k+M(2,1+k))=M(1,1+k);
    k=k+1+M(2,1+k);
    i=i+1;
end
guidata(hObject,handles);

% --- Executes on button press in VisDensity2.
function VisDensity2_Callback(hObject, eventdata, handles)
% hObject    handle to VisDensity2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.Screen);
if isfield(handles,'X2Values')
    handles=rmfield(handles,'X2Values');
end
if isfield(handles,'Y2Values')
    handles=rmfield(handles,'Y2Values');
end
if isfield(handles,'Height2')
    handles=rmfield(handles,'Height2');
end
[bandwidth,density,X,Y]=kde2d([handles.Density2(:,1), handles.Density2(:,2)]);
MinV=min(min(density(density>0),[],2),[],1);
MaxV=max(max(density,[],2),[],1);
R=MaxV-MinV; 
V=linspace(handles.MinTH2*R,handles.MaxTH2*R,handles.ContoursNumber2);
if handles.VisualizationType==1
    hold off
    imshow(handles.Template); 
    hold on
    [M,C]=contour(X,Y,density,'LevelList',V); hold on
    set(C, 'LineColor',handles.map2(150,:));
elseif handles.VisualizationType==2
    hold off
    [M,C]=contour(X,Y,density,'LevelList',V); hold on
    colormap(handles.map2);
elseif handles.VisualizationType==3
    hold off
    imshow(handles.Template); 
    hold on
    [M,C]=contourf(X,Y,density,'LevelList',V); hold on
    set(C, 'LineColor',handles.map2(25,:));
    set(C, 'FaceColor',handles.map2(150,:));
    if handles.Transparent2ON==1
        drawnow;  % this is important, to ensure that FacePrims is ready in the next line!
        hFills = C.FacePrims;  % array of TriangleStrip objects
        [hFills.ColorType] = deal('truecoloralpha');  % default = 'truecolor'
        for idx = 1 : numel(hFills)
            hFills(idx).ColorData(4) = handles.Transparent2;   % default=255
            hold on
        end
    end
else %handles.VisualizationType==4
    hold off
    [M,C]=contour3(X,Y,density,'LevelList',V); hold on
    colormap(handles.map2);
end
if handles.PlotPoints==1
    plot(handles.Density2(:,1),handles.Density2(:,2),'r.','MarkerSize',5);
end
k=0;
i=1;
while 1+k+M(2,1+k)<size(M,2)
    handles.X2Values(1+k:k+M(2,1+k))=M(1,2+k:1+k+M(2,1+k));
    handles.Y2Values(1+k:k+M(2,1+k))=M(2,2+k:1+k+M(2,1+k));
    handles.Height2(1+k:k+M(2,1+k))=M(1,1+k);
    k=k+1+M(2,1+k);
    i=i+1;
end
guidata(hObject,handles);

% --- Executes on button press in VisualizeBoth.
function VisualizeBoth_Callback(hObject, eventdata, handles)
% hObject    handle to VisualizeBoth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.Screen);
if isfield(handles,'X1Values')
    handles=rmfield(handles,'X1Values');
end
if isfield(handles,'Y1Values')
    handles=rmfield(handles,'Y1Values');
end
if isfield(handles,'Height1')
    handles=rmfield(handles,'Height1');
end
if isfield(handles,'X2Values')
    handles=rmfield(handles,'X2Values');
end
if isfield(handles,'Y2Values')
    handles=rmfield(handles,'Y2Values');
end
if isfield(handles,'Height2')
    handles=rmfield(handles,'Height2');
end

[bandwidth1,density1,X1,Y1]=kde2d([handles.Density1(:,1), handles.Density1(:,2)]);
[bandwidth2,density2,X2,Y2]=kde2d([handles.Density2(:,1), handles.Density2(:,2)]);
MinV1=min(min(density1(density1>0),[],2),[],1);
MaxV1=max(max(density1,[],2),[],1);
R1=MaxV1-MinV1; 
V1=linspace(handles.MinTH1*R1,handles.MaxTH1*R1,handles.ContoursNumber1);
MinV2=min(min(density2(density2>0),[],2),[],1);
MaxV2=max(max(density2,[],2),[],1);
R2=MaxV2-MinV2; 
V2=linspace(handles.MinTH2*R2,handles.MaxTH2*R2,handles.ContoursNumber2);
if handles.VisualizationType==1
    hold off
    imshow(handles.Template); 
    hold on
    [M1,C1]=contour(X1,Y1,density1,'LevelList',V1); hold on
    set(C1, 'LineColor',handles.map1(150,:));
    [M2,C2]=contour(X2,Y2,density2,'LevelList',V2); hold on
    set(C2, 'LineColor',handles.map2(150,:));
elseif handles.VisualizationType==2
    hold off
    [M1,C1]=contour(X1,Y1,density1,'LevelList',V1); colormap(handles.map1); freezeColors; hold on
    [M2,C2]=contour(X2,Y2,density2,'LevelList',V2); colormap(handles.map2); freezeColors; hold on
elseif handles.VisualizationType==3
    hold off
    imshow(handles.Template); 
    hold on
    [M1,C1]=contourf(X1,Y1,density1,'LevelList',V1); hold on
    [M2,C2]=contourf(X2,Y2,density2,'LevelList',V2); hold on
    set(C1, 'LineColor',handles.map1(25,:));
    set(C1, 'FaceColor',handles.map1(150,:));
    if handles.Transparent1ON==1
        drawnow;  % this is important, to ensure that FacePrims is ready in the next line!
        hFills1 = C1.FacePrims;  % array of TriangleStrip objects
        [hFills1.ColorType] = deal('truecoloralpha');  % default = 'truecolor'
        for idx = 1 : numel(hFills1)
            hFills1(idx).ColorData(4) = handles.Transparent1;   % default=255
            hold on
        end
    end
    set(C2, 'LineColor',handles.map2(25,:));
    set(C2, 'FaceColor',handles.map2(150,:));
    if handles.Transparent2ON==1
        drawnow;  % this is important, to ensure that FacePrims is ready in the next line!
        hFills2 = C2.FacePrims;  % array of TriangleStrip objects
        [hFills2.ColorType] = deal('truecoloralpha');  % default = 'truecolor'
        for idx = 1 : numel(hFills2)
            hFills2(idx).ColorData(4) = handles.Transparent2;   % default=255
            hold on
        end
    end
else %handles.VisualizationType==4
    hold off
    [M1,C1]=contour3(X1,Y1,density1,'LevelList',V1); colormap(handles.map1); freezeColors; hold on
    [M2,C2]=contour3(X2,Y2,density2,'LevelList',V2); colormap(handles.map2); freezeColors; hold on
end
if handles.PlotPoints==1
    plot(handles.Density1(:,1),handles.Density1(:,2),'g.','MarkerSize',5);
    hold on
    plot(handles.Density2(:,1),handles.Density2(:,2),'r.','MarkerSize',5);
end
k=0;
i=1;
while 1+k+M1(2,1+k)<size(M1,2)
    handles.X1Values(1+k:k+M1(2,1+k))=M1(1,2+k:1+k+M1(2,1+k));
    handles.Y1Values(1+k:k+M1(2,1+k))=M1(2,2+k:1+k+M1(2,1+k));
    handles.Height1(1+k:k+M1(2,1+k))=M1(1,1+k);
    k=k+1+M1(2,1+k);
    i=i+1;
end
k=0;
i=1;
while 1+k+M2(2,1+k)<size(M2,2)
    handles.X2Values(1+k:k+M2(2,1+k))=M2(1,2+k:1+k+M2(2,1+k));
    handles.Y2Values(1+k:k+M2(2,1+k))=M2(2,2+k:1+k+M2(2,1+k));
    handles.Height2(1+k:k+M2(2,1+k))=M2(1,1+k);
    k=k+1+M2(2,1+k);
    i=i+1;
end
guidata(hObject,handles);

% --- Executes on button press in SaveImage.
function SaveImage_Callback(hObject, eventdata, handles)
% hObject    handle to SaveImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
F = getframe(handles.Screen);
ScreeImage = frame2im(F);
prompt = 'Please insert a name for the file';
UserInputName=char(inputdlg(prompt));
imwrite(ScreeImage,[UserInputName,'.tif']); 
guidata(hObject,handles);

% --- Executes on button press in NormalizedToPointscheckbox.
function NormalizedToPointscheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to NormalizedToPointscheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of NormalizedToPointscheckbox
handles.NormalizedToPoints=get(hObject,'Value');
guidata(hObject,handles);

% --- Executes on button press in FindIntersection.
function FindIntersection_Callback(hObject, eventdata, handles)
% hObject    handle to FindIntersection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.flag==0    
    %deleting zeros
    a1=find(handles.X1Values==0);
    b1=find(handles.Y1Values==0);
    a2=find(handles.X2Values==0);
    b2=find(handles.Y2Values==0);
    handles.X1Values(intersect(a1,b1))=[];
    handles.Y1Values(intersect(a1,b1))=[];
    handles.Height1(intersect(a1,b1))=[];
    handles.X2Values(intersect(a2,b2))=[];
    handles.Y2Values(intersect(a2,b2))=[];
    handles.Height2(intersect(a2,b2))=[];
    %EnhancementFactor
    handles.EnhancementFactor1=100*abs(1/(max(handles.Height1)-min(handles.Height1)));
    handles.EnhancementFactor2=100*abs(1/(max(handles.Height2)-min(handles.Height2)));
    handles.EnhancementFactor1Norm=abs(1/(max(handles.Height1)-min(handles.Height1)))*length(handles.Height1);
    handles.EnhancementFactor2Norm=abs(1/(max(handles.Height2)-min(handles.Height2)))*length(handles.Height2);
%     handles.EnhancementFactor=(handles.EnhancementFactor1+handles.EnhancementFactor2)/2;
    %Height normalization
    handles.modHeight1=handles.EnhancementFactor1*handles.Height1;
    handles.modHeight1N=handles.EnhancementFactor1Norm*handles.Height1;
    handles.modHeight2=handles.EnhancementFactor2*handles.Height2+(min(handles.modHeight1)-min(handles.EnhancementFactor2*handles.Height2));
    handles.modHeight2N=handles.EnhancementFactor2Norm*handles.Height2+(min(handles.modHeight1N)-min(handles.EnhancementFactor2Norm*handles.Height2));
    handles.flag=1;
end
%for all the points:
% How many points are in the area of the other distribution?
handles.PlanarAllPointsShp1 = alphaShape(handles.Density1(:,1),handles.Density1(:,2));
handles.PlanarAllPointsShp2 = alphaShape(handles.Density2(:,1),handles.Density2(:,2));

%for the contour points:
% How many points are in the area of the other distribution?
handles.PlanarContourPointsShp1 = alphaShape(handles.X1Values',handles.Y1Values','HoleThreshold',handles.EnhancementFactor1);
handles.PlanarContourPointsShp2 = alphaShape(handles.X2Values',handles.Y2Values','HoleThreshold',handles.EnhancementFactor2);

handles.PlanarContourPointsShp1N = alphaShape(handles.X1Values',handles.Y1Values','HoleThreshold',handles.EnhancementFactor1Norm);
handles.PlanarContourPointsShp2N = alphaShape(handles.X2Values',handles.Y2Values','HoleThreshold',handles.EnhancementFactor2Norm);

% How many points are in the volume of the other distribution?
handles.VolumeContourPointsShp1 = alphaShape(handles.X1Values',handles.Y1Values',handles.modHeight1',handles.EnhancementFactor1);
handles.VolumeContourPointsShp2 = alphaShape(handles.X2Values',handles.Y2Values',handles.modHeight2',handles.EnhancementFactor2);

handles.VolumeContourPointsShp1N = alphaShape(handles.X1Values',handles.Y1Values',handles.modHeight1N',handles.EnhancementFactor1Norm);
handles.VolumeContourPointsShp2N = alphaShape(handles.X2Values',handles.Y2Values',handles.modHeight2N',handles.EnhancementFactor2Norm);

% K1 = boundary(handles.Density1,1);
% K2 = boundary(handles.Density2,1);
% [in12,on12]=inpolygon(handles.Density1(:,1),handles.Density1(:,2),handles.Density2(K2,1),handles.Density2(K2,2));
% [in21,on21]=inpolygon(handles.Density2(:,1),handles.Density2(:,2),handles.Density1(K1,1),handles.Density1(K1,2));
% Points1in2=(sum(in12)+sum(on12))/size(handles.Density1,1);
% Points2in1=(sum(in21)+sum(on21))/size(handles.Density2,1);


% CK1 = boundary(handles.X1Values',handles.Y1Values',1);
% CK2 = boundary(handles.X2Values',handles.Y2Values',1);
% [Cin12,Con12]=inpolygon(handles.X1Values',handles.Y1Values',handles.X2Values(CK2)',handles.Y2Values(CK2)');
% [Cin21,Con21]=inpolygon(handles.X2Values',handles.Y2Values',handles.X2Values(CK1)',handles.Y2Values(CK1)');
% CPoints1in2=(sum(Cin12)+sum(Con12))/length(handles.X1Values);
% CPoints2in1=(sum(Cin21)+sum(Con21))/length(handles.X2Values);


% DT1 = delaunayTriangulation(handles.ConvexHullValues1(:,1),handles.ConvexHullValues1(:,2),handles.ConvexHullValues1(:,3));
% DT2 = delaunayTriangulation(handles.ConvexHullValues2(:,1),handles.ConvexHullValues2(:,2),handles.ConvexHullValues2(:,3));
% [Surface1.faces, Surface1.vertices]=freeBoundary(DT1);
% [Surface2.faces, Surface2.vertices]=freeBoundary(DT2);

% [~, Surf12] = SurfaceIntersection(Surface1, Surface2);
% handles.Surface1=Surface1;
% handles.Surface2=Surface2;
% handles.Surf12=Surf12;

% % [KS1, VSurf1] = convhull(Surface1.vertices(:,1),Surface1.vertices(:,2),Surface1.vertices(:,3));
% % [KS2, VSurf2] = convhull(Surface2.vertices(:,1),Surface2.vertices(:,2),Surface2.vertices(:,3));
% K1 = boundary(handles.Density1,1);
% K2 = boundary(handles.Density2,1);
% [in12,on12]=inpolygon(handles.Density1(:,1),handles.Density1(:,2),handles.Density2(K2,1),handles.Density2(K2,2));
% [in21,on21]=inpolygon(handles.Density2(:,1),handles.Density2(:,2),handles.Density1(K1,1),handles.Density1(K1,2));
% % in12 = inhull(handles.Density1,handles.Density2,[K2,K2],1);
% % in21 = inhull(handles.Density2,handles.Density1,[K1,K1],1);
% (sum(in12)+sum(on12))/size(handles.Density1,1);
% (sum(in21)+sum(on21))/size(handles.Density2,1);
% % [~, Vintersection] = convhull(Surf12.vertices(:,1),Surf12.vertices(:,2),Surf12.vertices(:,3));
% % handles.VSurf1=VSurf1;
% % handles.VSurf2=VSurf2;
% handles.Vintersection=Vintersection;
guidata(hObject,handles);

% --- Executes on slider movement.
function PlotingAlphaShapeslider_Callback(hObject, eventdata, handles)
% hObject    handle to PlotingAlphaShapeslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.EnhancementFactor=get(hObject,'Value'); %gets the value from the slider
set(handles.PlotingAlphaShapetext,'string',num2str(handles.EnhancementFactor)); %updates the value in the text
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function PlotingAlphaShapeslider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PlotingAlphaShapeslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes when selected object is changed in uibuttongroupIntersectionPlotType.
function uibuttongroupIntersectionPlotType_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uibuttongroupIntersectionPlotType 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
TagIntersectionPlotType=get(eventdata.NewValue,'Tag'); % Get Tag of selected number of joints.
switch TagIntersectionPlotType
    case 'AllPoints2Dradiobutton'
        handles.IntersectionPlotType=1; 
    case 'ContourPoints2Dradiobutton'
        handles.IntersectionPlotType=2;        
    case 'ContourPoints3Dradiobutton'
        handles.IntersectionPlotType=3;
end
guidata(hObject,handles);

% --- Executes on slider movement.
function AlphaValue2slider_Callback(hObject, eventdata, handles)
% hObject    handle to AlphaValue2slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.AlphaValue2=get(hObject,'Value'); %gets the value from the slider
set(handles.AlphaValue2text,'string',num2str(handles.AlphaValue2)); %updates the value in the text
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function AlphaValue2slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AlphaValue2slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function AlphaValue1slider_Callback(hObject, eventdata, handles)
% hObject    handle to AlphaValue1slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.AlphaValue1=get(hObject,'Value'); %gets the value from the slider
set(handles.AlphaValue1text,'string',num2str(handles.AlphaValue1)); %updates the value in the text
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function AlphaValue1slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AlphaValue1slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on button press in PlotAlphaShape.
function PlotAlphaShape_Callback(hObject, eventdata, handles)
% hObject    handle to PlotAlphaShape (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.Screen);
if handles.IntersectionPlotType==1
    plot(handles.PlanarAllPointsShp1,'FaceColor','r','FaceAlpha',0.1,'EdgeColor','none');
    hold on
    plot(handles.PlanarAllPointsShp2,'FaceColor','g','FaceAlpha',0.1,'EdgeColor','none');
elseif handles.IntersectionPlotType==2 
        imshow(handles.Template); 
        hold on
        plot(handles.PlanarContourPointsShp1,'FaceColor','g','FaceAlpha',0.1,'EdgeColor','none');
        hold on
        plot(handles.PlanarContourPointsShp2,'FaceColor','r','FaceAlpha',0.1,'EdgeColor','none');
else %handles.IntersectionPlotType==3
    if handles.NormalizedToPoints==0
        figure
        handles.VolumeContourPointsShp1.Alpha=handles.EnhancementFactor1/handles.AlphaValue1/10000;
        plot(handles.VolumeContourPointsShp1,'FaceColor','g','FaceAlpha',0.1,'EdgeColor','none');
        hold on
        handles.VolumeContourPointsShp2.Alpha=handles.EnhancementFactor2/handles.AlphaValue2/10000;
        plot(handles.VolumeContourPointsShp2,'FaceColor','r','FaceAlpha',0.1,'EdgeColor','none');
    else
        figure
        handles.VolumeContourPointsShp1N.Alpha=handles.EnhancementFactor1Norm/handles.AlphaValue1/10000;
        plot(handles.VolumeContourPointsShp1N,'FaceColor','g','FaceAlpha',0.1,'EdgeColor','none');
        hold on
        handles.VolumeContourPointsShp2N.Alpha=handles.EnhancementFactor2Norm/handles.AlphaValue2/10000;
        plot(handles.VolumeContourPointsShp2N,'FaceColor','r','FaceAlpha',0.1,'EdgeColor','none');
    end
end
guidata(hObject,handles);

% --- Executes on button press in SavePlot.
function SavePlot_Callback(hObject, eventdata, handles)
% hObject    handle to SavePlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
F = getframe(handles.Screen);
PLOT = frame2im(F);

prompt = 'Please insert a name for the file';
UserInputName=char(inputdlg(prompt));
imwrite(PLOT,[UserInputName,'IntersectionPlot.tif']); 
guidata(hObject, handles);

% --- Executes on button press in ExportData.
function ExportData_Callback(hObject, eventdata, handles)
% hObject    handle to ExportData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tf1in2 = inShape(handles.PlanarAllPointsShp2,handles.Density1(:,1),handles.Density1(:,2));
tf2in1 = inShape(handles.PlanarAllPointsShp1,handles.Density2(:,1),handles.Density2(:,2));
handles.PlanarAllPoints1in2=sum(tf1in2)/size(handles.Density1,1)*100;
handles.PlanarAllPoints2in1=sum(tf2in1)/size(handles.Density2,1)*100;

Ctf1in2 = inShape(handles.PlanarContourPointsShp2,handles.X1Values',handles.Y1Values');
Ctf2in1 = inShape(handles.PlanarContourPointsShp1,handles.X2Values',handles.Y2Values');
handles.PlanarContourPoints1in2=sum(Ctf1in2)/length(handles.X1Values)*100;
handles.PlanarContourPoints2in1=sum(Ctf2in1)/length(handles.X2Values)*100;

if handles.NormalizedToPoints==0
    VCtf1in2 = inShape(handles.VolumeContourPointsShp2,handles.X1Values',handles.Y1Values',handles.modHeight1');
    VCtf2in1 = inShape(handles.VolumeContourPointsShp1,handles.X2Values',handles.Y2Values',handles.modHeight2');
    handles.VolumeContourPoints1in2=sum(VCtf1in2)/length(handles.X1Values)*100;
    handles.VolumeContourPoints2in1=sum(VCtf2in1)/length(handles.X2Values)*100;
else
    VCtf1in2 = inShape(handles.VolumeContourPointsShp2N,handles.X1Values',handles.Y1Values',handles.modHeight1N');
    VCtf2in1 = inShape(handles.VolumeContourPointsShp1N,handles.X2Values',handles.Y2Values',handles.modHeight2N');
    handles.VolumeContourPoints1in2=sum(VCtf1in2)/length(handles.X1Values)*100;
    handles.VolumeContourPoints2in1=sum(VCtf2in1)/length(handles.X2Values)*100;
end
% V = volume(shp)


prompt = 'Please insert a name for the file';
UserInputName=char(inputdlg(prompt));
xlswrite([UserInputName,'Summary.xlsx'],[handles.PlanarAllPoints1in2,handles.PlanarAllPoints2in1],'A1:B1');
xlswrite([UserInputName,'Summary.xlsx'],[handles.PlanarContourPoints1in2,handles.PlanarContourPoints2in1],'A2:B2');
xlswrite([UserInputName,'Summary.xlsx'],[handles.VolumeContourPoints1in2,handles.VolumeContourPoints2in1],'A3:B3');
% xlswrite([UserInputName,'Summary'],[handles.VolumeContourPoints1in2N,handles.VolumeContourPoints2in1N],'A4:B4');
guidata(hObject, handles);


