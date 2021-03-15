%%%%% Functional ParceNip GUI created by Becky Jackson and Claude Bajada (Neuroscience and Aphasia Research Unit, University of Manchester). 

function varargout = functional_parcenip_gui(varargin)
% FUNCTIONAL_PARCENIP2STEP MATLAB code for functional_parcenip_gui.fig
%      FUNCTIONAL_PARCENIP2STEP, by itself, creates a new FUNCTIONAL_PARCENIP2STEP or raises the existing
%      singleton*.
%
%      H = FUNCTIONAL_PARCENIP2STEP returns the handle to a new FUNCTIONAL_PARCENIP2STEP or the handle to
%      the existing singleton*.
%
%      FUNCTIONAL_PARCENIP2STEP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FUNCTIONAL_PARCENIP2STEP.M with the given input arguments.
%
%      FUNCTIONAL_PARCENIP2STEP('Property','Value',...) creates a new FUNCTIONAL_PARCENIP2STEP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before functional_parcenip2step_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to functional_parcenip2step_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help functional_parcenip2step

% Last Modified by GUIDE v2.5 07-Aug-2015 15:40:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @functional_parcenip2step_OpeningFcn, ...
                   'gui_OutputFcn',  @functional_parcenip2step_OutputFcn, ...
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


% --- Executes just before functional_parcenip2step is made visible.
function functional_parcenip2step_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to functional_parcenip2step (see VARARGIN)

% Choose default command line output for functional_parcenip2step
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes functional_parcenip2step wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = functional_parcenip2step_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes when figure1 is resized.
function figure1_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%user selects folder containing participant folders of functional imaging
%data
functional_images = uigetdir('','Please select root folder containing subject folders with functional images');

%get participant folders
 cd(functional_images);
 folders = dir('*');
 folders = folders(3:length(folders));% made work without any character in here by del first 2 folders as gets folder . and folder ..
 display_folders = struct2cell(folders);
 display_folders = display_folders(1,:)';
 display_functional_images = cellstr(functional_images)
 number_participants = length(folders);
 
 %returns pathname and participant folders
 set(handles.text2, 'String', display_functional_images)
 set(handles.listbox1, 'String', display_folders)
 handles.functional_images = functional_images;
 handles.folders = folders;
 handles.number_participants = number_participants;
 guidata(hObject, handles)
 
 



% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[roi_file roi_path] = uigetfile('*.img','Please select binary ROI file with same dimensions as functional images'); % also nii? works with nii?
full_roi_file = strcat(roi_path, roi_file);
set(handles.text4, 'String', full_roi_file)
handles.roi_file = roi_file;
handles.full_roi_file = full_roi_file;
guidata(hObject, handles)



% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%%%%%%%%%%%%%%%%%%%%%%%%%%%
% allows looping through participant folders - will fail if other folders
% in directory or if participant folder names are of different lengths
folders = handles.folders; %getting from callback of data folder choice, don't update from here
functional_images = handles.functional_images; %getting from callback of data folder choice, don't update from here
roi_file = handles.roi_file; %getting from callback of roifile choice, don't update from here
full_roi_file = handles.full_roi_file; %getting from callback of roifile choice, don't update from here
group_folder_location = handles.group_folder_location; %getting from callback of roifile choice, don't update from here
number_participants = handles.number_participants;

% allows looping through participant folders - will fail if other folders
% in directory or if participant folder names are of different lengths
for i=1:length(folders);
    tmp(i,:)=folders(i,1).name;
end
subcode = (tmp);% subject folder names
ss=size(subcode);
do_sub=1:ss(1);
%do_sub=1:length(subcode); 


%MAKE GROUP results FOLDER
roi_name = roi_file(1:(length(roi_file)-4));
timeseries_filename = strcat('my_timeseries_', roi_name, '.txt');
group_folder = strcat(group_folder_location, '\FuncPARCENIP_Results_', roi_name);
if ~exist(group_folder, 'dir')
  mkdir(group_folder);
else
    choice = menu('Warning: Results folder already exists. Continuing will overwrite. Do you want to continue?','Yes','No');
    if choice==2 | choice==0
        return;
    end
end


%get timeseries of voxels in the ROI for each participant    
h = waitbar(0,'Please wait...');
steps = length(do_sub);

for s = do_sub;

    cd (strcat(functional_images, '\', subcode(s,:)))
    func_image = dir('*.nii' );
    func_image = func_image.name;
    coords = extract_coords(full_roi_file); 
    my_timeseries = extract_timeseries(coords, func_image); % coords come from the previous function, func_image is one participant's functional image
    %put together with seeds 
    my_timeseries = (horzcat(coords, my_timeseries))';
    %save timeseries inc roi name as text file
    save(timeseries_filename, 'my_timeseries', '-ASCII')
    waitbar(s / steps)

end
close(h) % test

%get number of voxels in roi from 1st p's timeseries
%cd (strcat(functional_images, '\', subcode(1,:)));
%timeseries_filename = strcat('my_timeseries_', roi_name, '.txt');
%my_timeseries = load(timeseries_filename)
%roi_vox = length(my_timeseries);


% main 1st level analysis + set up for group analysis

groupB= zeros(length(my_timeseries),length(my_timeseries)); % auto changes by roi voxel size now
cd(functional_images);

for s = do_sub;
    
    cd (strcat(functional_images, '\', subcode(s,:)))

    % get timeseries + separate timeseries (x) and voxels seeds (seeds)
    my_timeseries = load(timeseries_filename);
    x = my_timeseries(4:133,:); %separates timeseries from coordinates
    seeds = my_timeseries(1:3,:); %separates coordinates from timeseries
    seeds = seeds';

    B = 1 - squareform(pdist(x', 'cosine'));
    fig1 = figure; imagesc(B); axis square
    export_fig(strcat(functional_images, '\', subcode(s,:),'\_unsortedsimilarity_matrix',roi_name ,'.tif'), fig1);
    close 
 

    %takes p's info for group level in next step   
    %z transform each individual's matrix
    ztrans_B=.5.*log((1+B)./(1-B));
    
    groupB = groupB + ztrans_B; %for group %removed +1 if issues
    
    %sorts individual's matrix and saves as figure
    [sortedB, p] = extract_spectral_reorder(B);
    sorted_seeds = (seeds(p,:));
    fig2 = figure; imagesc(sortedB); axis square
    export_fig(strcat(functional_images, '\', subcode(s,:),'\_sortedsimilarity_matrix',roi_name ,'.tif'), fig2);
    close 
    

    % create a dummy image and make  graded 'rainbow' maps for each p
    [image, header] = extract_read_image(full_roi_file); 
    image = zeros(size(image));
    
    for i = 1 : length(sorted_seeds)
    
        image(sorted_seeds(i,1),sorted_seeds(i,2),sorted_seeds(i,3)) = i;
    
    end
    
    header.fname = (strcat('graded_similarity_map_',roi_name ,'.img'));
    header.dt = [16,0];
    spm_write_vol(header, image);
    
    % saves individual's results - inc roi filename so doesn't overwrite
    savefile = strcat('sorted_seeds_', roi_file(1:(length(roi_file)-4)), '.mat');
    save(savefile, 'sorted_seeds', 'sortedB');
end


% average UNORDERED SIMILARITY MATRICES (BASED ON COSINE) over p's

%meangroupB_2d = groupB / length(subcode);
meangroupB_2d_before_tranform = groupB /number_participants; 
%transform back from z score
meangroupB_2d = (exp(2.*meangroupB_2d_before_tranform) - 1) ./ (exp(2.*meangroupB_2d_before_tranform) + 1);
meangroupB_2d(isnan(meangroupB_2d))=1;

cd (group_folder);
seeds = my_timeseries(1:3,:);
seeds = seeds';
    
%spectral reorder group results + save figure
[sortedmeangroupB, p] = extract_spectral_reorder(meangroupB_2d);
sorted_seeds = (seeds(p,:));
fig2 = figure; imagesc(sortedmeangroupB); axis square
axis square
export_fig('_GROUP_sortedsimilarity_matrix_av_sim.tif', fig2);
close 
save workspace_sorted_group_av_sim

% make rainbow image for group
% create a dummy image - use a mask for this
 [image, header] = extract_read_image(full_roi_file);
image = zeros(size(image));

%then create the rainbow cluster
for i = 1 : length(sorted_seeds)
    
   image(sorted_seeds(i,1),sorted_seeds(i,2),sorted_seeds(i,3)) = i; 
 

end
header.fname = 'graded_similarity_map_group.img';
header.dt = [16,0];
spm_write_vol(header, image);











% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%investigate participant's cluster - displays sorted matrix and allows
%selection of hard cluster boundaries or areas for further investigation

roi_file = handles.roi_file; %getting from callback of roifile choice, don't update from here
full_roi_file = handles.full_roi_file; %getting from callback of roifile choice, don't update from here
functional_images = handles.functional_images; %getting from callback of data folder choice, don't update from here


% get individual participants folder selected in list box
index_selected = get(handles.listbox1,'Value');
list = get(handles.listbox1,'String');
participant_folder = list{index_selected};
ind_workspace_name = strcat(functional_images, '\', participant_folder, '\sorted_seeds_', roi_file(1:(length(roi_file)-4)), '.mat')
handles.ind_workspace_name = ind_workspace_name;
guidata(hObject, handles)
cd(strcat(functional_images,'\', participant_folder));
load(ind_workspace_name, 'sortedB','sorted_seeds');
roi_file = handles.roi_file
assignin('base','roi_file',roi_file);
%define_1st_level_cluster_gui(ind_workspace_name, full_roi_file, participant_folder)
separate_choose_workspace_gui()





% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

roi_file = handles.roi_file; %getting from callback of roifile choice, don't update from here
full_roi_file = handles.full_roi_file; %getting from callback of roifile choice, don't update from here
functional_images = handles.functional_images; %getting from callback of data folder choice, don't update from here
group_folder_location = handles.group_folder_location;
roi_name = roi_file(1:(length(roi_file)-4));

% get individual participants folder selected in list box

group_workspace_name = (strcat(group_folder_location, '\FuncPARCENIP_Results_', roi_name,'\workspace_sorted_group_av_sim.mat'));
 
handles.group_workspace_name = group_workspace_name;
guidata(hObject, handles)
cd(strcat(group_folder_location, '\FuncPARCENIP_Results_', roi_name));
load(group_workspace_name, 'sortedmeangroupB','sorted_seeds');
%define_1st_level_cluster_group_gui(group_workspace_name, full_roi_file) %
%not made, would have same issues as p version
separate_choose_workspace_group_gui() %note - is very similar to individual BUT key variable is different (or just does last p's) - eventually diff titles etc.


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
group_folder_location = uigetdir('','Please select location to create results folder');
display_group_folder_location = cellstr(group_folder_location);
set(handles.text12, 'String', display_group_folder_location)
 handles.group_folder_location = group_folder_location;
 guidata(hObject, handles)


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

   
    [image, header] = extract_read_image(handles.full_roi_file); 
    image = zeros(size(image)); 
    ind_workspace_name = handles.ind_workspace_name;
    

    var_1 = evalin('base','var_1');
    var_2 = evalin('base','var_2');
    load(ind_workspace_name, 'sortedB','sorted_seeds');
    if var_1 < var_2
            cluster_1 = sorted_seeds(var_1 : var_2,:);            
    else
            cluster_1 = sorted_seeds(var_2 : var_1,:);          
    end
                
for i = 1 : length(cluster_1)
    
   image(cluster_1(i,1),cluster_1(i,2),cluster_1(i,3)) = i; %before managed to make this give binary output - tried = 1 didn't work, made binary underneath instead
    
    
end

image=logical(image);
%header.fname = 'cluster1.img'; %name changes as poss more than one - choose name? change variable name within - just call cluster + do one at a time?
       % [header.fname,PathName,FilterIndex] = uiputfile('*.img');
         [header.fname,PathName,FilterIndex] = uiputfile('*.img');
        if FilterIndex == 0
            disp('Please select an appropriate filename')
        end
spm_write_vol(header, image);
image = zeros(size(image));

% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

  
    [image, header] = extract_read_image(handles.full_roi_file); 
    image = zeros(size(image)); 
    group_workspace_name = handles.group_workspace_name;
    

    var_1 = evalin('base','var_1');
    var_2 = evalin('base','var_2');
    load(group_workspace_name, 'sortedmeangroupB','sorted_seeds'); %n.b. is diff variable name to ind matrices
    if var_1 < var_2;
            cluster_1 = sorted_seeds(var_1 : var_2,:);            
    else
            cluster_1 = sorted_seeds(var_2 : var_1,:);          
    end
                
for i = 1 : length(cluster_1);
    
   image(cluster_1(i,1),cluster_1(i,2),cluster_1(i,3)) = i;  %before managed to make this give binary output - tried = 1 didn't work, made binary underneath instead
    
    
end
    image=logical(image);
         [header.fname,PathName,FilterIndex] = uiputfile('*.img');
        if FilterIndex == 0
            disp('Please select an appropriate filename')
        end
spm_write_vol(header, image);
image = zeros(size(image));
