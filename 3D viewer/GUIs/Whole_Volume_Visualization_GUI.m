function varargout = Whole_Volume_Visualization_GUI(varargin)
% WHOLE_VOLUME_VISUALIZATION_GUI MATLAB code for Whole_Volume_Visualization_GUI.fig
%      WHOLE_VOLUME_VISUALIZATION_GUI, by itself, creates a new WHOLE_VOLUME_VISUALIZATION_GUI or raises the existing
%      singleton*.
%
%      H = WHOLE_VOLUME_VISUALIZATION_GUI returns the handle to a new WHOLE_VOLUME_VISUALIZATION_GUI or the handle to
%      the existing singleton*.
%
%      WHOLE_VOLUME_VISUALIZATION_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WHOLE_VOLUME_VISUALIZATION_GUI.M with the given input arguments.
%
%      WHOLE_VOLUME_VISUALIZATION_GUI('Property','Value',...) creates a new WHOLE_VOLUME_VISUALIZATION_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Whole_Volume_Visualization_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Whole_Volume_Visualization_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Whole_Volume_Visualization_GUI

% Last Modified by GUIDE v2.5 27-Apr-2015 20:08:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Whole_Volume_Visualization_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @Whole_Volume_Visualization_GUI_OutputFcn, ...
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


% --- Executes just before Whole_Volume_Visualization_GUI is made visible.
function Whole_Volume_Visualization_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Whole_Volume_Visualization_GUI (see VARARGIN)

% Choose default command line output for Whole_Volume_Visualization_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Whole_Volume_Visualization_GUI wait for user response (see UIRESUME)
% uiwait(handles.WholeVolumeVisualization);

%The following handles blocks are necessary for being enabled/disabled during the program.  
handles.Alpha_block= [handles.Threshold_text, handles.Threshold_edit,...
    handles.NumberOfSlice_text,handles.NumberOfSlice_edit,...
    handles.Imtool_pushbutton,handles.ThresholdQ_pushbutton...
    ,handles.NofSliceQ_pushbutton,handles.ImtoolQ_pushbutton];

set(handles.Alpha_block,'Enable', 'off'); %The defualt status of this block


Data=load('Interpolated_data.mat');%loads data saved in the previous GUI

%extracts information for future use.
handles.total_V=Data.Interpolated_data.total_V;
handles.N_dim_total_V=ndims(handles.total_V);   %Number of dimensions:3, if gray scale, 4 if RGB.

handles.Alpha_choice='NoAlpha_radiobutton';%sets the default of 'Alpha_choice' to 'No Alpha'
                                           %it will be changed if the
                                           %user will choose 'Relative
                                           %Alpha' or 'Customized Alpha'. 
                                           %Important if the user doesn't change the
                                           %default.
                                           
guidata(hObject, handles); %updates handles 

% --- Outputs from this function are returned to the command line.
function varargout = Whole_Volume_Visualization_GUI_OutputFcn(hObject, eventdata, handles) 
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

if handles.N_dim_total_V==3      %gray scale
    imtool(handles.total_V(:,:,handles.Num_of_slice))
elseif handles.N_dim_total_V==4  %RGB
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



function Threshold_edit_Callback(hObject, eventdata, handles)
% hObject    handle to Threshold_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Threshold_edit as text
%        str2double(get(hObject,'String')) returns contents of Threshold_edit as a double
handles.Threshold=str2double(get(hObject,'String'));
guidata(hObject, handles); 


% --- Executes during object creation, after setting all properties.
function Threshold_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Threshold_edit (see GCBO)
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

hwait_bar=waitbar(0,'Visualizing Whole Volume,Please Wait...');

total_V=handles.total_V; %for convenience

%initiation of alpha matrix depends on gray scale/RGB.
%"ones" function was chosen as alpha values are in the range between 0 to 1
%0=full transparency, 1=no transparency.
if handles.N_dim_total_V==3 
    Alpha_Matrix=ones(size(total_V),'like',total_V);
elseif handles.N_dim_total_V==4
    Alpha_Matrix=ones(size(total_V(:,:,:,1)),'like',total_V);
end

switch handles.Alpha_choice
    case 'RelativeAlpha_radiobutton'
        if handles.N_dim_total_V==3
            Alpha_Matrix=total_V./85; %85 was chosen as the RGB to gray scale transformation is
                                      %0.2989 * R + 0.5870 * G + 0.1140 *B,
                                      %and because I was must to use a
                                      %single number for the division, I
                                      %chose the average of 255-which is
                                      %85.
                                      
        elseif handles.N_dim_total_V==4
            Alpha_Matrix=max(total_V,[],4)./255; %For RGB relative alpha values determination
                                                 %I chose to consider the
                                                 %highest value of all channels for each
                                                 %voxel. Therefore, I
                                                 %search for the max values
                                                 %in the 4th dimension (for
                                                 %each channel),and get 3D matrix of the max values of each voxel
                                                 %then,it divided by 255,
                                                 %what resulted in values
                                                 %between 0 and 1.
        end
    case 'CustomizedAlpha_radiobutton'
        %%%validation of the threshold input
        Threshold_str= get(handles.Threshold_edit,'string');
        if strcmp(Threshold_str,'')
            errordlg('You did not enter a number for the threshold');
            set(handles.Threshold_edit,'string','');
            close(hwait_bar);
            return
        elseif isnan(handles.Threshold)  
            errordlg('You must enter one positive number for the threshold');
            set(handles.Threshold_edit,'string','');
            close(hwait_bar);
            return
        elseif  handles.Threshold<0 || handles.Threshold>255 
            errordlg('The threshold must be a number between 0 to 255');
            set(handles.Threshold_edit,'string','');
             close(hwait_bar);
            return
        end
        %%%
        
        if handles.N_dim_total_V==3
            Alpha_Matrix=total_V>=handles.Threshold; %take the voxels compling
                                                     %the condition,and
                                                     %takes them as alpha
                                                     %values,because 1
                                                     %means both over or
                                                     %equal the threshold
                                                     %and no transparency,
                                                     %and 0 means both
                                                     %under threshold and
                                                     %full transparency.
        elseif handles.N_dim_total_V==4
            Alpha_Matrix=total_V>=handles.Threshold;
            Alpha_Matrix=~sum(Alpha_Matrix,4)==0;    %Here I do the same as for
                                                     %the gray scale, but consider as 1
                                                     %only voxels which are over the threshold
                                                     %for one or more channels (and again,1
                                                     %means both compling 
                                                     %with the condition 
                                                     %and no transparency.
        end
end
waitbar(0.2);
 
handles.f=figure('Name','Whole Volume Viewer','NumberTitle','off');
vol3d('CData',total_V,'alpha',Alpha_Matrix); %vol3d is a function of Joe Conti, 
                                             %improved by Oliver Woodford,
                                             %that was published on 10 Feb 2009 (Updated 16 Apr 2011)
                                             %on http://www.mathworks.com/matlabcentral/fileexchange/22940-vol3d-v2
                                             %because it's surly not the main
                                             %feature of my project, and there is no need
                                             %to invent the wheel again, I let
                                             %myself using it. Of course,
                                             %all the credit belongs to the aformentioned people.
                                             %I added the function below.


if handles.N_dim_total_V==3 %gray scale
    colormap(gray);
end
waitbar(0.8);
cameratoolbar(handles.f);
daspect([1 1 1]);
view(3);
axis tight;
guidata(hObject,handles);
waitbar(1);
close(hwait_bar)



% --- Executes on button press in Return_pushbutton.
function Return_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Return_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(Whole_Volume_Visualization_GUI)
Transition_GUI %returns to transition GUI (like interpolation_GUI but has only the option menu

% --- Executes when selected object is changed in WholeVolumeVisualization_uipanel.
function WholeVolumeVisualization_uipanel_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in WholeVolumeVisualization_uipanel 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
handles.Alpha_choice=get(eventdata.NewValue,'Tag'); % Get Tag of selected object.
guidata(hObject,handles);
set(handles.Threshold_edit,'string','');
%switches between blocks depending on the choice made.
if strcmp(handles.Alpha_choice,'CustomizedAlpha_radiobutton') 
    set(handles.Alpha_block,'Enable', 'on');
else
    set(handles.Alpha_block,'Enable', 'off');
    set(handles.NumberOfSlice_edit,'string','');
end
    

% --- Executes on button press in NoAlphaQ_pushbutton.
function NoAlphaQ_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to NoAlphaQ_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox({'Volume visualization  without transparency manipulation'},'No Alpha Help')

% --- Executes on button press in RelativeAlphaQ_pushbutton.
function RelativeAlphaQ_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to RelativeAlphaQ_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox({'Volume visualization while pixels with low values become transparent'...
    'and pixels with high values are still visible'},'Relative Alpha Help')

% --- Executes on button press in CustomizedAlpha_pushbutton.
function CustomizedAlpha_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to CustomizedAlpha_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox({'Volume visualization using input threshold. Pixels under this threshold'...
    'will become transparent. It is highly recommended to use "Imtool"'...
    'in order to choose appropriate threshold.'},'Customized Alpha Help')

% --- Executes on button press in ThresholdQ_pushbutton.
function ThresholdQ_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to ThresholdQ_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox({'Values under the threshold will become transparent.'...
    'It is highly recommended to use "Imtool" in order to choose an appropriate threshold.'},'Threshold Help')

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


% --- Executes when user attempts to close WholeVolumeVisualization.
function WholeVolumeVisualization_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to WholeVolumeVisualization (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
Transition_GUI;
delete(hObject);

function [model] = vol3d(varargin)
%H = VOL3D Volume render 3-D data. 
% VOL3D uses the orthogonal plane 2-D texture mapping technique for 
% volume rending 3-D data in OpenGL. Use the 'texture' option to fine 
% tune the texture mapping technique. This function is best used with
% fast OpenGL hardware.
%
% vol3d                   Provide a demo of functionality.
%
% H = vol3d('CData',data) Create volume render object from input 
%                         3-D data. Use interp3 on data to increase volume
%                         rendering resolution. Returns a struct 
%                         encapsulating the pseudo-volume rendering object.
%                         XxYxZ array represents scaled colormap indices.
%                         XxYxZx3 array represents truecolor RGB values for
%                         each voxel (along the 4th dimension).
%
% vol3d(...,'Alpha',alpha) XxYxZ array of alpha values for each voxel, in
%                          range [0,1]. Default: data (interpreted as
%                          scaled alphamap indices).
%
% vol3d(...,'Parent',axH)  Specify parent axes. Default: gca.
%
% vol3d(...,'XData',x)  1x2 x-axis bounds. Default: [0 size(data, 2)].
% vol3d(...,'YData',y)  1x2 y-axis bounds. Default: [0 size(data, 1)].
% vol3d(...,'ZData',z)  1x2 z-axis bounds. Default: [0 size(data, 3)].
%
% vol3d(...,'texture','2D')  Only render texture planes parallel to nearest
%                            orthogonal viewing plane. Requires doing
%                            vol3d(h) to refresh if the view is rotated
%                            (i.e. using cameratoolbar).
%
% vol3d(...,'texture','3D')  Default. Render x,y,z texture planes
%                            simultaneously. This avoids the need to
%                            refresh the view but requires faster OpenGL
%                            hardware peformance.
%
% vol3d(H)  Refresh view. Updates rendering of texture planes 
%           to reduce visual aliasing when using the 'texture'='2D'
%           option.
%
% NOTES
% Use vol3dtool (from the original vol3d FEX submission) for editing the
% colormap and alphamap. Adjusting these maps will allow you to explore
% your 3-D volume data at various intensity levels. See documentation on 
% alphamap and colormap for more information.
%
% Use interp3 on input date to increase/decrease resolution of data
%
% Examples:
%
% % Visualizing fluid flow
% v = flow(50);
% h = vol3d('cdata',v,'texture','2D');
% view(3); 
% % Update view since 'texture' = '2D'
% vol3d(h);  
% alphamap('rampdown'), alphamap('decrease'), alphamap('decrease')
% 
% % Visualizing MRI data
% load mri.mat
% D = squeeze(D);
% h = vol3d('cdata',D,'texture','3D');
% view(3);  
% axis tight;  daspect([1 1 .4])
% alphamap('rampup');
% alphamap(.06 .* alphamap);
%
% See also alphamap, colormap, opengl, isosurface

% Copyright Joe Conti, 2004
% Improvements by Oliver Woodford, 2008-2011, with permission of the
% copyright holder.

if nargin == 0
    demo_vol3d;
    return
end

if isstruct(varargin{1})
    model = varargin{1};
    if length(varargin) > 1
       varargin = {varargin{2:end}};
    end
else
    model = localGetDefaultModel;
end

if length(varargin)>1
  for n = 1:2:length(varargin)
    switch(lower(varargin{n}))
        case 'cdata'
            model.cdata = varargin{n+1};
        case 'parent'
            model.parent = varargin{n+1};
        case 'texture'
            model.texture = varargin{n+1};
        case 'alpha'
            model.alpha = varargin{n+1};
        case 'xdata'
            model.xdata = varargin{n+1}([1 end]);
        case 'ydata'
            model.ydata = varargin{n+1}([1 end]);
        case 'zdata'
            model.zdata = varargin{n+1}([1 end]);
    end
    
  end
end

if isempty(model.parent)
    model.parent = gca;
end

[model] = local_draw(model);

%------------------------------------------%
function [model] = localGetDefaultModel

model.cdata = [];
model.alpha = [];
model.xdata = [];
model.ydata = [];
model.zdata = [];
model.parent = [];
model.handles = [];
model.texture = '3D';
tag = tempname;
model.tag = ['vol3d_' tag(end-11:end)];

%------------------------------------------%
function [model,ax] = local_draw(model)

cdata = model.cdata; 
siz = size(cdata);

% Define [x,y,z]data
if isempty(model.xdata)
    model.xdata = [0 siz(2)];
end
if isempty(model.ydata)
    model.ydata = [0 siz(1)];
end
if isempty(model.zdata)
    model.zdata = [0 siz(3)];
end

try
   delete(model.handles);
catch
end

ax = model.parent;
cam_dir = camtarget(ax) - campos(ax);
[m,ind] = max(abs(cam_dir));

opts = {'Parent',ax,'cdatamapping',[],'alphadatamapping',[],'facecolor','texturemap','edgealpha',0,'facealpha','texturemap','tag',model.tag};

if ndims(cdata) > 3
    opts{4} = 'direct';
else
    cdata = double(cdata);
    opts{4} = 'scaled';
end

if isempty(model.alpha)
    alpha = cdata;
    if ndims(model.cdata) > 3
        alpha = sqrt(sum(double(alpha).^2, 4));
        alpha = alpha - min(alpha(:));
        alpha = 1 - alpha / max(alpha(:));
    end
    opts{6} = 'scaled';
else
    alpha = model.alpha;
    if ~isequal(siz(1:3), size(alpha))
        error('Incorrect size of alphamatte');
    end
    opts{6} = 'none';
end

h = findobj(ax,'type','surface','tag',model.tag);
for n = 1:length(h)
  try
     delete(h(n));
  catch
  end
end

is3DTexture = strcmpi(model.texture,'3D');
handle_ind = 1;

% Create z-slice
if(ind==3 || is3DTexture )    
  x = [model.xdata(1), model.xdata(2); model.xdata(1), model.xdata(2)];
  y = [model.ydata(1), model.ydata(1); model.ydata(2), model.ydata(2)];
  z = [model.zdata(1), model.zdata(1); model.zdata(1), model.zdata(1)];
  diff = model.zdata(2)-model.zdata(1);
  delta = diff/size(cdata,3);
  for n = 1:size(cdata,3)

   cslice = squeeze(cdata(:,:,n,:));
   aslice = double(squeeze(alpha(:,:,n)));
   h(handle_ind) = surface(x,y,z,cslice,'alphadata',aslice,opts{:});
   z = z + delta;
   handle_ind = handle_ind + 1;
  end

end

% Create x-slice
if (ind==1 || is3DTexture ) 
  x = [model.xdata(1), model.xdata(1); model.xdata(1), model.xdata(1)];
  y = [model.ydata(1), model.ydata(1); model.ydata(2), model.ydata(2)];
  z = [model.zdata(1), model.zdata(2); model.zdata(1), model.zdata(2)];
  diff = model.xdata(2)-model.xdata(1);
  delta = diff/size(cdata,2);
  for n = 1:size(cdata,2)

   cslice = squeeze(cdata(:,n,:,:));
   aslice = double(squeeze(alpha(:,n,:)));
   h(handle_ind) = surface(x,y,z,cslice,'alphadata',aslice,opts{:});
   x = x + delta;
   handle_ind = handle_ind + 1;
  end
end

% Create y-slice
if (ind==2 || is3DTexture)
  x = [model.xdata(1), model.xdata(1); model.xdata(2), model.xdata(2)];
  y = [model.ydata(1), model.ydata(1); model.ydata(1), model.ydata(1)];
  z = [model.zdata(1), model.zdata(2); model.zdata(1), model.zdata(2)];
  diff = model.ydata(2)-model.ydata(1);
  delta = diff/size(cdata,1);
  for n = 1:size(cdata,1)

   cslice = squeeze(cdata(n,:,:,:));
   aslice = double(squeeze(alpha(n,:,:)));
   h(handle_ind) = surface(x,y,z,cslice,'alphadata',aslice,opts{:});
   y = y + delta;
   handle_ind = handle_ind + 1;
  end
end

model.handles = h;

function demo_vol3d
figure;
load mri.mat
vol3d('cdata', squeeze(D), 'xdata', [0 1], 'ydata', [0 1], 'zdata', [0 0.7]);
colormap(bone(256));
alphamap([0 linspace(0.1, 0, 255)]);
axis equal off
set(gcf, 'color', 'w');
view(3);
