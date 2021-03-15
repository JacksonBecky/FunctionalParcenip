function separate_choose_workspace_gui()

  % clear all

   roi_file = evalin('base','roi_file');
   roi_name = roi_file(1:(length(roi_file)-4));
   workspace = strcat('sorted_seeds_', roi_name);
   load(workspace, 'sortedB','sorted_seeds');
   
   %getting participant folder for title
a=0;
currentFolder = pwd;
for s = 1:length(currentFolder);
    if (currentFolder(s))=='\';
        if  a==0;
            a=s;
        elseif s>a;
            a=s;
        end
        
    end
end

p_folder = currentFolder((a+1):(length(currentFolder)));

if p_folder(1,1) == '_';
    p_folder = p_folder(2:(length(p_folder)));
end
   

   
    i = 1;
    button_2_control = [];
    button_coordination = 0;
    
    my_fig=figure('Units','Centimeters',...
           'NumberTitle','Off',...
           'Menubar','None',...
           'Toolbar','None',...
           'Position',[5 2 20 17],...
           'Resize','off',...
           'Name','FunctionalParcenip',...
           'Tag','viewer_gui');
    
    colormap jet
    matrix_handles = guihandles(my_fig);
     
    axes('Parent',matrix_handles.viewer_gui,...
         'Units','Centimeters',...
         'XTick', [],...
         'YTick', [],...
         'Color', 'none',...
         'XColor',[0.8 0.8 0.8],... 
         'YColor',[0.8 0.8 0.8],... 
         'Box', 'off',...
         'Position',[0 15 20 1]);   
    text(0.45,0.5,p_folder,...
        'FontSize', 20,...
        'FontWeight', 'bold') 
    
    axes('Parent',matrix_handles.viewer_gui,...
         'Units','Centimeters',...
         'Position',[1 1 13 13]);
     
    my_matrix = imagesc(sortedB);
           
    set(gca,'Parent',matrix_handles.viewer_gui, 'Tag','sorted_matrix');
    matrix_handles = guihandles(my_matrix);
    
    %# create button to start
    h_start = uicontrol('parent',my_fig,'style','pushbutton',...
        'string','Start',...
        'units', 'Centimeters',...
        'position',[15 9 4 2],...
        'callback',@Start_Callback,...
        'UserData',true);

    %# create button to create output
    h_create = uicontrol('parent',my_fig,'style','pushbutton',...
          'string','Select Seed',... 
          'units', 'Centimeters',...
          'position',[15 6 4 2],...
          'callback',@Create_Callback,...
          'UserData',true);
      
    %# create exit button
    h_exit = uicontrol('parent',my_fig,'style','pushbutton',...
          'string','Exit',... 
          'units', 'Centimeters',...
          'position',[15 3 4 2],...
          'callback',@Exit_Callback,...
          'UserData',true);   
      
  


   
    % --- Executes on button press.
function Start_Callback(hObject, eventdata, handles)
    % hObject    handle to Done (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    
    try
        
        if i == 1;
            
            i = 2;
            button_2_control = 2;
            button_coordination = 1;

            dcm_obj = datacursormode;
            set(dcm_obj,'Enable', 'on', 'DisplayStyle', 'window', 'UpdateFcn',@myupdatefcn)

            pause

            info_struct = getCursorInfo(dcm_obj);
            my_info = info_struct.Position(1,1);
            assignin('base','var_1',my_info);
            
    %        Start_Callback()
   
    %    elseif i == 2
 
            i = 3;
            button_2_control = 3;        
            button_coordination = 1;

            dcm_obj = datacursormode;
            set(dcm_obj,'Enable', 'on', 'DisplayStyle', 'window', 'UpdateFcn',@myupdatefcn)

            pause

            info_struct = getCursorInfo(dcm_obj);
            my_info = info_struct.Position(1,1);
            assignin('base','var_2',my_info)
            button_coordination = 3;
            
            i=4;
 
        end
            
    catch
        
        return
            
    end
    
end

% --- Executes on button press.
function Create_Callback(hObject, eventdata, handles)
    % hObject    handle to Done (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

%button_disp = {'Select 1st Seed','Select 2nd Seed', 'Output'};
button_disp = {'Select Seed','Select 2nd Seed', 'Output'};
    
    if button_coordination == 1;
       button_coordination = 2;
    
       press_enter
        
       if ~isempty(button_2_control)
                  
           set(hObject,'UserData',~get(hObject,'UserData'),'string',button_disp(i));

       end 
       
    end
       
    if i == 4;
       
        button_2_control = [];
        button_coordination = 1;
            
        var_1 = evalin('base','var_1');
        var_2 = evalin('base','var_2');

%         if var_1 < var_2
%             clustered_seeds = var_1 : var_2;            
%         else
%             clustered_seeds = var_2 : var_1;            
%         end
%                 
%         clustered_seeds = clustered_seeds';
%             
%         seeds_non_zeros = evalin('base', 'sorted_seeds');
%         clustered_seeds = seeds_non_zeros(clustered_seeds);
%         
%         [FileName,PathName,FilterIndex] = uiputfile('*.img');
%         
%         if FilterIndex == 0
%             disp('Please select an appropriate filename')
            
            
        else
%             [~,FileName,~] = fileparts(FileName); 
%             surf_path_name = [PathName, FileName];
% 
%             extract_spectral_create_unweighted_gwi_pico_group(clustered_seeds, surf_path_name)

    %        assignin('base','clustered_seeds',clustered_seeds);

            set(hObject,'UserData',~get(hObject,'UserData'),'string',button_disp(1));
            i = 1;
        
        end
    
    end
        
        
 
          

% --- Executes on button press.
function Exit_Callback(hObject, eventdata, handles)
    % hObject    handle to Done (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    
    close();
    %display('Goodbye');
    %clear all
    

    
end
   



end



function press_enter

% Initialize the java engine
import java.awt.*;
import java.awt.event.*;
        
% Create a Robot-object to do the key-pressing
rob=Robot;
        
% Press Enter
rob.keyPress(KeyEvent.VK_ENTER)
rob.keyRelease(KeyEvent.VK_ENTER)

end

% --- Executes on button press.
function output_txt = myupdatefcn(~,event_obj)
% ~            Currently not used (empty)
% event_obj    Object containing event data structure
% output_txt   Data cursor text (string or cell array 
%              of strings)

    pos = get(event_obj,'Position');
    output_txt = {['Seed: ', num2str(pos(1))],...
                   'Select Seed When Ready'}; % needs to be fixed to change when the output needs to be selected
           
    
end

