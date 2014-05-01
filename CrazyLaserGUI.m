function [] = BuildGUI
%BuildGUI creates all GUI components for CrazyLaserGUI
% Create all GUI components and initialize handles structure to pass to
%  all other functions in CrazyLaserGUI

    global fn
    
    %--- create Main Figure Window
    %- color: [red% green% blue%]
    %- resize: 'off' = can't resize GUI window
    %- renderer: 'opengl' =  IDK - came from FrogScan code.
    %- dockcontrols: 'off' = prevents GUI from being able to be put into
    %MATLAB console window.
    %- integerhandle: 'off' = IDK - came from FrogScan code.
    %- menubar: 'none' = disables automatic menu bar so we can create
    %exactly what we need.
    %- name: 'CrazyLaserGUI' = text that goes on window bar - title of GUI
    %- numbertitle: 'off' = gets rid of crazy long number placed before
    %'name' on title of GUI.
    %- toolbar: 'figure' = if we want a toolbar in our GUI.
    %- position: [x, y, Wx, Wy]; x, y = from bottom-left; Wx, Wy = Widths
    %- deletefcn: callback Function called when Main_Figure is deleted / exited.
    Main_Figure = figure(...
        'color',[0.9255 0.9137 0.8471],...
        'resize','off',...
        'renderer','opengl',...
        'dockcontrols','off',...
        'integerhandle','off',...
        'menubar','none',...
        'name','CrazyLaserGUI',...
        'numbertitle','off',...
        'toolbar','figure',...
        'position',[10 50 900 600],... %10 50 is about square from where windows toolbar starts
        'deletefcn',@MF_DeleteFn...
    );

    %--- Create data structure to pass around CrazyLaserGUI.
    %--- 'data' holds all object handles in data.handles, see OpeningFn
    data.Main_Figure = Main_Figure;

    %--- Set data as guidata for CrazyLaserGUI.
    guidata(Main_Figure, data);

    %-----------------------------------------------------------------%
    %%%                             Main        (Main_Figure)       %%%
    %-----------------------------------------------------------------%

     tlb = findall(Main_Figure,'type','uitoolbar'); % find the toolbar
         % find and delete unwanted toolbar buttons
         %- We will most likely want to edit this at some point!!
         tlb_cld = allchild(tlb); delete(tlb_cld([1:4,10:14]));

    if ishandle(Main_Figure), OpeningFn; end
    
    function OpeningFn
        % Clears console:
        clc;

        % Background color for GUI [red% green% blue%]:
        bkc = [0.9255 0.9137 0.8471]; 
        
        %-----------------------------------------------------------------%
        %%%                       ini File Parameters                   %%%
        %-----------------------------------------------------------------%
        
        %data.Parameters = load('frogscan.mat'); % - how FrogScan starts
        %--- Parameters:
        data.Parameters.ExampleValue = 0.0;
        data.Parameters.RpPosition = 0.0;
        data.Parameters.TpPosition = 0.0;
        
        data.Parameters.xSteps = 100;
        data.Parameters.zSteps = 100;
        data.Parameters.xDirection = 'F';
        data.Parameters.zDirection = 'B';
        data.Parameters.xPoints = 1;
        data.Parameters.zScans = 1;
        
        %-----------------------------------------------------------------%
        %%%                            Panels        (Main_Figure)      %%%
        %-----------------------------------------------------------------%
        
        %- parent: Main_Figure = Panel to inherit location from
        %- title: 'Motor Parameters' = Name to go inside box line surrounding panel
        %- units: 'normalized' = idk
        %- backgroundcolor: bkc = color defined above
        %- position: [x y Wx Wy] - in percentages of parent panel
        MotorParameters_panel = uipanel(...
            'parent',Main_Figure,...
            'title','Motor Parameters',...
            'units','normalized',...
            'backgroundcolor',bkc,...
            'position',[0.02 1/5 .29 .78]...
        );
        RunScans_panel = uipanel(...
            'parent',Main_Figure,...
            'title','Run Scans',...
            'units','normalized',...
            'backgroundcolor',bkc,...
            'position',[0.02 0.03 .623 .15]...
        );
        Constants_panel = uipanel(...
            'parent',Main_Figure,...
            'title','Constants',...
            'units','normalized',...
            'backgroundcolor',bkc,...
            'position',[1/3 .47 .31 .51]...
        );
        Spectrometer_panel = uipanel(...
            'parent',Main_Figure,...
            'title','Spectrometer',...
            'units','normalized',...
            'backgroundcolor',bkc,...
            'position',[2/3 .77 .31 .21]...
        );
        OtherActions_panel = uipanel(...
            'parent',Main_Figure,...
            'title','Other Actions',...
            'units','normalized',...
            'backgroundcolor',bkc,...
            'position',[2/3 0.47 .31 .28]...
        );
        Position_panel = uipanel(...
            'parent',Main_Figure,...
            'title','Position',...
            'units','normalized',...
            'backgroundcolor',bkc,...
            'position',[1/3 1/5 .31 1/4]...
        );
        Delays_panel = uipanel(...
            'parent',Main_Figure,...
            'title','Delays',...
            'units','normalized',...
            'backgroundcolor',bkc,...
            'position',[2/3 0.03 .31 .42]...
        );
    
        %-----------------------------------------------------------------%
        %%%                       Buttons & Text     (Main_Figure)      %%%
        %-----------------------------------------------------------------%
        
        %---------------------------- Main Figure ------------------------%
        %- uicontrol properties website guide:
        %- http://www.mathworks.com/help/matlab/ref/uicontrol_props.html

        %---------------- Static text (stext): -----------------
        
        %--- Constants Panel stext:
        XMotorPin_stext = uicontrol(...
            'parent',Constants_panel,...
            'units','normalized',...
            'style','text',...
            'string',' X Motor Pin:',...
            'fontsize',14,...
            'backgroundcolor',bkc,...
            'fontweight','bold',...
            'HorizontalAlignment','left',...
            'position',[0.06 .8 .5 0.085]...
        );
        ZMotorPin_stext = uicontrol(...
            'parent',Constants_panel,...
            'units','normalized',...
            'style','text',...
            'string',' Z Motor Pin:',...
            'fontsize',14,...
            'backgroundcolor',bkc,...
            'fontweight','bold',...
            'HorizontalAlignment','left',...
            'position',[0.06 .63 .5 0.085]...
        );
        XDirPin_stext = uicontrol(...
            'parent',Constants_panel,...
            'units','normalized',...
            'style','text',...
            'string',' X Direction Pin:',...
            'fontsize',14,...
            'backgroundcolor',bkc,...
            'fontweight','bold',...
            'HorizontalAlignment','left',...
            'position',[0.06 .37 .6 0.085]...
        );
        ZDirPin_stext = uicontrol(...
            'parent',Constants_panel,...
            'units','normalized',...
            'style','text',...
            'string',' Z Direction Pin:',...
            'fontsize',14,...
            'backgroundcolor',bkc,...
            'fontweight','bold',...
            'HorizontalAlignment','left',...
            'position',[0.06 .2 .6 0.085]...
        );
        XMotorPinValue_stext = uicontrol(...
            'parent',Constants_panel,...
            'units','normalized',...
            'style','text',...
            'string','6',...
            'fontsize',14,...
            'backgroundcolor',bkc,...
            'fontweight','bold',...
            'HorizontalAlignment','center',...
            'position',[0.8 .8 .085 0.085]...
        );
        ZMotorPinValue_stext = uicontrol(...
            'parent',Constants_panel,...
            'units','normalized',...
            'style','text',...
            'string','8',...
            'fontsize',14,...
            'backgroundcolor',bkc,...
            'fontweight','bold',...
            'HorizontalAlignment','center',...
            'position',[0.8 .6 .085 0.085]...
        );
        XDirPinValue_stext = uicontrol(...
            'parent',Constants_panel,...
            'units','normalized',...
            'style','text',...
            'string','11',...
            'fontsize',14,...
            'backgroundcolor',bkc,...
            'fontweight','bold',...
            'HorizontalAlignment','center',...
            'position',[0.8 .4 .085 0.085]...
        );
        ZDirPinValue_stext = uicontrol(...
            'parent',Constants_panel,...
            'units','normalized',...
            'style','text',...
            'string','13',...
            'fontsize',14,...
            'backgroundcolor',bkc,...
            'fontweight','bold',...
            'HorizontalAlignment','center',...
            'position',[0.8 .2 .085 0.085]...
        );
    
        %--- Motor Parameters stext:
        XSteps_stext = uicontrol(...
            'parent',MotorParameters_panel,...
            'units','normalized',...
            'style','text',...
            'string',' X Steps:',...
            'fontsize',14,...
            'fontweight','bold',...
            'backgroundcolor',bkc,...
            'HorizontalAlignment','left',...
            'position',[0.06 .895 .4 0.06]...
        );
        ZSteps_stext = uicontrol(...
            'parent',MotorParameters_panel,...
            'units','normalized',...
            'style','text',...
            'string',' Z Steps:',...
            'fontsize',14,...
            'fontweight','bold',...
            'backgroundcolor',bkc,...
            'HorizontalAlignment','left',...
            'position',[0.06 .79 .4 0.06]...
        );
        XDirection_stext = uicontrol(...
            'parent',MotorParameters_panel,...
            'units','normalized',...
            'style','text',...
            'string',' X Direction:',...
            'fontsize',14,...
            'fontweight','bold',...
            'backgroundcolor',bkc,...
            'HorizontalAlignment','left',...
            'position',[0.06 .67 .5 0.06]...
        );
        ZDirection_stext = uicontrol(...
            'parent',MotorParameters_panel,...
            'units','normalized',...
            'style','text',...
            'string',' Z Direction:',...
            'fontsize',14,...
            'fontweight','bold',...
            'backgroundcolor',bkc,...
            'HorizontalAlignment','left',...
            'position',[0.06 .56 .5 0.06]...
        );
        xSpectraCount_stext = uicontrol(...
            'parent',MotorParameters_panel,...
            'units','normalized',...
            'style','text',...
            'string',' # of X Spectra:',...
            'fontsize',14,...
            'fontweight','bold',...
            'backgroundcolor',bkc,...
            'HorizontalAlignment','left',...
            'position',[0.06 .44 .55 0.06]...
        );
        zScanCount_stext = uicontrol(...
            'parent',MotorParameters_panel,...
            'units','normalized',...
            'style','text',...
            'string',' # of Z Scans:',...
            'fontsize',14,...
            'fontweight','bold',...
            'backgroundcolor',bkc,...
            'HorizontalAlignment','left',...
            'position',[0.06 .33 .5 0.06]...
        );
        TotalMeasurementsText_stext = uicontrol(...
            'parent',MotorParameters_panel,...
            'units','normalized',...
            'style','text',...
            'string',' # Triggers:',...
            'fontsize',14,...
            'fontweight','bold',...
            'backgroundcolor',bkc,...
            'horizontalAlignment','left',...
            'position',[0.06 0.04 0.5 0.06]...
        );
        TotalMeasurementsValue_stext = uicontrol(...
            'parent',MotorParameters_panel,...
            'units','normalized',...
            'style','text',...
            'string','0',...
            'value',0,...
            'fontsize',14,...
            'fontweight','bold',...
            'backgroundcolor',bkc,...
            'horizontalAlignment','center',...
            'position',[0.704 0.04 0.18 0.06]...
        );
    
        %- Other Actions panel:
        XJog_stext = uicontrol(...
            'parent',OtherActions_panel,...
            'units','normalized',...
            'style','text',...
            'string','X',...
            'fontsize',14,...
            'backgroundcolor',bkc,...
            'fontweight','bold',...
            'HorizontalAlignment','center',...
            'position',[0.16 .56 0.08 0.16]...
        );
        ZJog_stext = uicontrol(...
            'parent',OtherActions_panel,...
            'units','normalized',...
            'style','text',...
            'string','Z',...
            'fontsize',14,...
            'backgroundcolor',bkc,...
            'fontweight','bold',...
            'HorizontalAlignment','center',...
            'position',[0.16 .31 0.08 0.16]...
        );
        JogStep_stext = uicontrol(...
            'parent',OtherActions_panel,...
            'units','normalized',...
            'style','text',...
            'string','Steps',...
            'fontsize',14,...
            'backgroundcolor',bkc,...
            'fontweight','bold',...
            'HorizontalAlignment','center',...
            'position',[0.3 .81 0.3 0.16]...
        );
        JogDirection_stext = uicontrol(...
            'parent',OtherActions_panel,...
            'units','normalized',...
            'style','text',...
            'string','Dir.',...
            'fontsize',14,...
            'backgroundcolor',bkc,...
            'fontweight','bold',...
            'HorizontalAlignment','center',...
            'position',[0.62 .81 0.3 0.16]...
        );
    
        LastScan_stext = uicontrol(...
            'parent',RunScans_panel,...
            'units','normalized',...
            'style','text',...
            'string','Full',...
            'fontsize',14,...
            'fontweight','bold',...
            'backgroundcolor',bkc,...
            'HorizontalAlignment','center',...
            'position',[0.87 0.35 0.10 0.35]...
        );
    
        %--- Position panel:
        StartPositionText_stext = uicontrol(...
            'parent',Position_panel,...
            'units','normalized',...
            'style','text',...
            'string',' Last Start:',...
            'fontsize',14,...
            'fontweight','bold',...
            'backgroundcolor',bkc,...
            'HorizontalAlignment','left',...
            'position',[0.06 .7 .39 0.18]...
        );
        StartPositionValue_stext = uicontrol(...
            'parent',Position_panel,...
            'units','normalized',...
            'style','text',...
            'string','-',...
            'fontsize',14,...
            'fontweight','bold',...
            'backgroundcolor',bkc,...
            'HorizontalAlignment','center',...
            'position',[0.58 .7 .3 0.18]...
        );
        CurrentPosition_stext = uicontrol(...
            'parent',Position_panel,...
            'units','normalized',...
            'style','text',...
            'string','-',...
            'fontsize',14,...
            'fontweight','bold',...
            'backgroundcolor',bkc,...
            'HorizontalAlignment','center',...
            'position',[.58 .24 .3 .2]...
        );
    
        SpectrumType_stext = uicontrol(...
            'parent',Spectrometer_panel,...
            'units','normalized',...
            'style','text',...
            'string','Avaspec 3048',...
            'fontsize',14,...
            'fontweight','bold',...
            'backgroundcolor',bkc,...
            'HorizontalAlignment','center',...
            'position',[0.1 .6 .8 0.28]...
        );
    
        SpectrumDelay_stext = uicontrol(...
            'parent',Delays_panel,...
            'units','normalized',...
            'style','text',...
            'string',' Spectrum Pulse:',...
            'fontsize',14,...
            'fontweight','bold',...
            'backgroundcolor',bkc,...
            'HorizontalAlignment','left',...
            'position',[0.07 0.8 0.59 0.12]...
        );
        DriverDelay_stext = uicontrol(...
            'parent',Delays_panel,...
            'units','normalized',...
            'style','text',...
            'string',' Driver Pulse:',...
            'fontsize',14,...
            'fontweight','bold',...
            'backgroundcolor',bkc,...
            'HorizontalAlignment','left',...
            'position',[0.07 0.6 0.59 0.12]...
        );

        %---------------- Editable text (etext): -----------------
        
        %--- Motor Parameters panel:
        XSteps_etext = uicontrol(...
            'parent',MotorParameters_panel,...
            'units','normalized',...
            'style','edit',...
            'string','0',...
            'fontsize',12,...
            'backgroundcolor','w',...
            'position',[0.7 .877 .2 0.06],...
            'callback',@EditCallback...
        );
        ZSteps_etext = uicontrol(...
            'parent',MotorParameters_panel,...
            'units','normalized',...
            'style','edit',...
            'string','0',...
            'fontsize',12,...
            'backgroundcolor','w',...
            'position',[0.7 .79 .2 0.06],...
            'callback',@EditCallback...
        );
        xSpectraCount_etext = uicontrol(...
            'parent',MotorParameters_panel,...
            'units','normalized',...
            'style','edit',...
            'string','1',...
            'fontsize',12,...
            'backgroundcolor','w',...
            'position',[0.7 .44 .2 0.06],...
            'callback',@EditCallback...
        );
        zScanCount_etext = uicontrol(...
            'parent',MotorParameters_panel,...
            'units','normalized',...
            'style','edit',...
            'string','1',...
            'fontsize',12,...
            'backgroundcolor','w',...
            'position',[0.7 .33 .2 0.06],...
            'callback',@EditCallback...
        );
    
        %--- Other Actions Panel:
        XJogSteps_etext = uicontrol(...
            'parent',OtherActions_panel,...
            'units','normalized',...
            'style','edit',...
            'string','0',...
            'fontsize',12,...
            'backgroundcolor','w',...
            'position',[.35 .56 .2 .16],...
            'callback',@EditCallback...
        );
        ZJogSteps_etext = uicontrol(...
            'parent',OtherActions_panel,...
            'units','normalized',...
            'style','edit',...
            'string','0',...
            'fontsize',12,...
            'backgroundcolor','w',...
            'position',[.35 .305 .2 .16],...
            'callback',@EditCallback...
        );
        XJogDirection_etext = uicontrol(...
            'parent',OtherActions_panel,...
            'units','normalized',...
            'style','edit',...
            'string','0',...
            'fontsize',12,...
            'backgroundcolor','w',...
            'position',[.67 .56 .2 .16],...
            'callback',@EditCallback...
        );
        ZJogDirection_etext = uicontrol(...
            'parent',OtherActions_panel,...
            'units','normalized',...
            'style','edit',...
            'string','0',...
            'fontsize',12,...
            'backgroundcolor','w',...
            'position',[.67 .305 .2 .16],...
            'callback',@EditCallback...
        );
    
        SpectrumDelay_etext = uicontrol(...
            'parent',Delays_panel,...
            'units','normalized',...
            'style','edit',...
            'string','100',...
            'fontsize',12,...
            'backgroundcolor','w',...
            'position',[0.73 0.8 0.2 0.12],...
            'callback',@EditCallback...
        );
        DriverDelay_etext = uicontrol(...
            'parent',Delays_panel,...
            'units','normalized',...
            'style','edit',...
            'string','10',...
            'fontsize',12,...
            'backgroundcolor','w',...
            'position',[0.73 0.6 0.2 0.12],...
            'callback',@EditCallback...
        );
    
        %--------------------- Check Boxes ----------------------
        XJog_checkbox = uicontrol(...
            'parent',OtherActions_panel,...
            'units','normalized',...
            'style','checkbox',...
            'backgroundcolor',bkc,...
            'position',[.07 .34 0.07 .1],...
            'callback',@CheckboxCallback...
        );
        ZJog_checkbox = uicontrol(...
            'parent',OtherActions_panel,...
            'units','normalized',...
            'style','checkbox',...
            'backgroundcolor',bkc,...
            'position',[.07 .59 .07 .1],...
            'callback',@CheckboxCallback...
        );

        %----------------------- Buttons ------------------------
        
        %--- Run Scans panel buttons:
        XScan_button = uicontrol(...
            'parent',RunScans_panel,...
            'units','normalized',...
            'style','pushbutton',...
            'fontsize',10,...
            'Enable','off',...
            'fontweight','bold',...
            'string','X Only',...
            'position',[0.05 0.2 0.15 0.65],...
            'callback',@ButtonCallback...
        );
        ZScan_button = uicontrol(...
            'parent',RunScans_panel,...
            'units','normalized',...
            'style','pushbutton',...
            'fontsize',10,...
            'Enable','off',...
            'fontweight','bold',...
            'string','Z Only',...
            'position',[0.25 0.2 0.15 0.65],...
            'callback',@ButtonCallback...
        );
        FullScan_button = uicontrol(...
            'parent',RunScans_panel,...
            'units','normalized',...
            'style','pushbutton',...
            'fontsize',10,...
            'Enable','off',...
            'fontweight','bold',...
            'string','Full',...
            'position',[0.45 0.2 0.15 0.65],...
            'callback',@ButtonCallback...
        );
        RepeatScan_button = uicontrol(...
            'parent',RunScans_panel,...
            'units','normalized',...
            'style','pushbutton',...
            'fontsize',10,...
            'enable','off',...
            'fontweight','bold',...
            'string','Repeat',...
            'position',[0.69 0.2 0.15 0.65],...
            'callback',@ButtonCallback...
        );
    
        %--- Motor Parameters panel:
        
        XScanUp_button = uicontrol(...
            'parent',MotorParameters_panel,...
            'units','normalized',...
            'style','togglebutton',...
            'fontsize',10,...
            'value',1,...
            'fontweight','bold',...
            'string','<html>&#8593</html>',...
            'position',[.7 .655 .1 .08],...
            'callback',@ButtonCallback...
        );
        XScanDown_button = uicontrol(...
            'parent',MotorParameters_panel,...
            'units','normalized',...
            'style','togglebutton',...
            'fontsize',10,...
            'value',0,...
            'fontweight','bold',...
            'string','<html>&#8595</html>',...
            'position',[.8 0.655 .1 0.08],...
            'callback',@ButtonCallback...
        );
        ZScanRight_button = uicontrol(...
            'parent',MotorParameters_panel,...
            'units','normalized',...
            'style','togglebutton',...
            'fontsize',10,...
            'value',1,...
            'fontweight','bold',...
            'string','<html>&#8594</html>',...
            'position',[.7 0.555 .1 0.08],...
            'callback',@ButtonCallback...
        );
        ZScanLeft_button = uicontrol(...
            'parent',MotorParameters_panel,...
            'units','normalized',...
            'style','togglebutton',...
            'fontsize',10,...
            'value',0,...
            'fontweight','bold',...
            'string','<html>&#8592</html>',...
            'position',[.8 0.555 .1 0.08],...
            'callback',@ButtonCallback...
        );
        MotorParametersSave_button = uicontrol(...
            'parent',MotorParameters_panel,...
            'units','normalized',...
            'style','pushbutton',...
            'fontsize',10,...
            'enable','off',...
            'fontweight','bold',...
            'string','Save',...
            'position',[1/3 0.19 1/3 0.1],...
            'callback',@ButtonCallback...
        );
    
        TakeSpectrum_button = uicontrol(...
            'parent',Spectrometer_panel,...
            'units','normalized',...
            'style','pushbutton',...
            'string','Take Spectrum',...
            'fontsize',10,...
            'enable','off',...
            'fontweight','bold',...
            'HorizontalAlignment','center',...
            'position',[0.25 .15 .5 0.3],...
            'callback',@ButtonCallback...
        );
    
        DelaysSave_button = uicontrol(...
            'parent',Delays_panel,...
            'units','normalized',...
            'style','pushbutton',...
            'string','Save',...
            'fontsize',10,...
            'enable','off',...
            'fontweight','bold',...
            'HorizontalAlignment','center',...
            'position',[1/3 0.1 1/3 0.2],...
            'callback',@ButtonCallback...
        );
    
        GetPosition_button = uicontrol(...
            'parent',Position_panel,...
            'units','normalized',...
            'style','pushbutton',...
            'string','Get Position:',...
            'fontsize',10,...
            'enable','off',...
            'fontweight','bold',...
            'HorizontalAlignment','center',...
            'position',[.1 0.2 2/5 0.3],...
            'callback',@ButtonCallback...
        );
    
        Jog_button = uicontrol(...
            'parent',OtherActions_panel,...
            'units','normalized',...
            'style','pushbutton',...
            'string','Jog!',...
            'fontsize',10,...
            'enable','off',...
            'fontweight','bold',...
            'HorizontalAlignment','center',...
            'position',[.46 0.05 .3 0.2],...
            'callback',@ButtonCallback...
        );
   
        %--------------------- Solid Lines: ---------------------
        ConstantsLine = uicontrol(...
            'parent',Constants_panel,...
            'units','normalized',...
            'style','text',...
            'backgroundcolor',[0 0 0],...
            'position',[0.25 .54 .5 .01]...
        );
    
        RunScansLine = uicontrol(...
            'parent',RunScans_panel,...
            'units','normalized',...
            'style','text',...
            'backgroundcolor',[0 0 0],...
            'position',[0.643 0.35 0.005 0.35]...
        );
    
        MotorParametersLine1 = uicontrol(...
            'parent',MotorParameters_panel,...
            'units','normalized',...
            'style','text',...
            'backgroundcolor',[0 0 0],...
            'position',[0.25 0.76 0.5 0.007]...
        );
        MotorParametersLine2 = uicontrol(...
            'parent',MotorParameters_panel,...
            'units','normalized',...
            'style','text',...
            'backgroundcolor',[0 0 0],...
            'position',[0.25 0.53 0.5 0.006]...
        );
        MotorParametersLine3 = uicontrol(...
            'parent',MotorParameters_panel,...
            'units','normalized',...
            'style','text',...
            'backgroundcolor',[0 0 0],...
            'position',[0.25 0.14 0.5 0.006]...
        );

        %-----------------------------------------------------------------%
        %%%                         Menu Bar       (Main_Figure)        %%%
        %-----------------------------------------------------------------%
        
        %--- This is how you make a lable on the top bar of the GUI.
        %- Main_Figure = which uipanel to put it on.
        %- label: 'File' = text to appear on menu to click on.
        File_menu = uimenu(...
            'parent', Main_Figure,...
            'label','File'...
        );
            ExitProgram = uimenu(...
                'parent',File_menu,...
                'label','Exit',...
                'separator','on',...
                'callback',@MenuCallback...
            );
        
        Run_menu = uimenu(...
            'parent', Main_Figure,...
            'label','Run'...
        );
            StartArduino = uimenu(...
                'parent', Run_menu,...
                'label','Arduino',...
                'separator','off',...
                'callback',@MenuCallback...
            );
            StartInductionSensor = uimenu(...
                'parent', Run_menu,...
                'label','Induction Sensor',...
                'separator','on',...
                'callback',@MenuCallback...
            );
        
        Test_menu = uimenu(...
            'parent', Main_Figure,...
            'label','Test',...
            'callback',@MenuCallback...
        );
            Test2_menu = uimenu(...
                'parent',Test_menu,...
                'label','Test2',...
                'Checked','off',...
                'callback',@MenuCallback...
            );
        
        %-----------------------------------------------------------------%
        %%%                       Data Array       (Main_Figure)        %%%
        %-----------------------------------------------------------------%

        %- HANDLES are used for events - button pressing, text changing, etc.
        %--- panel handles
        data.handles.MotorParameters_panel = MotorParameters_panel;
        data.handles.RunScans_panel = RunScans_panel;
        data.handles.Constants_panel = Constants_panel;
        data.handles.Position_panel = Position_panel;
        data.handles.OtherActions_panel = OtherActions_panel;
        data.handles.Spectrometer_panel = Spectrometer_panel;
        data.handles.Delays_panel = Delays_panel;
        
        %--- static text
        data.handles.XMotorPin_stext = XMotorPin_stext;
        data.handles.ZMotorPin_stext = ZMotorPin_stext;
        data.handles.XDirPin_stext = XDirPin_stext;
        data.handles.ZDirPin_stext = ZDirPin_stext;
        data.handles.XMotorPinValue_stext = XMotorPinValue_stext;
        data.handles.ZMotorPinValue_stext = ZMotorPinValue_stext;
        data.handles.XDirPinValue_stext = XDirPinValue_stext;
        data.handles.ZDirPinValue_stext = ZDirPinValue_stext;
        data.handles.SpectrumType_stext = SpectrumType_stext;
        data.handles.LastScan_stext = LastScan_stext;
        data.handles.SpectrumDelay_stext = SpectrumDelay_stext;
        data.handles.StartPositionText_stext = StartPositionText_stext;
        data.handles.StartPositionValue_stext = StartPositionValue_stext;
        data.handles.DriverDelay_stext = DriverDelay_stext;
        data.handles.XSteps_stext = XSteps_stext;
        data.handles.ZSteps_stext = ZSteps_stext;
        data.handles.XDirection_stext = XDirection_stext;
        data.handles.ZDirection_stext = ZDirection_stext;
        data.handles.xSpectraCount_stext = xSpectraCount_stext;
        data.handles.zScanCount_stext = zScanCount_stext;
        data.handles.CurrentPosition_stext = CurrentPosition_stext;
        data.handles.TotalMeasurementsValue_stext = TotalMeasurementsValue_stext;
        data.handles.TotalMeasurementsText_stext = TotalMeasurementsText_stext;
        data.handles.XJog_stext = XJog_stext;
        data.handles.ZJog_stext = ZJog_stext;
        data.handles.JogDirection_stext = JogDirection_stext;
        data.handles.JogStep_stext = JogStep_stext;
        
        %--- edit text
        data.handles.XSteps_etext = XSteps_etext;
        data.handles.ZSteps_etext = ZSteps_etext;
        data.handles.xSpectraCount_etext = xSpectraCount_etext;
        data.handles.zScanCount_etext = zScanCount_etext;
        data.handles.SpectrumDelay_etext = SpectrumDelay_etext;
        data.handles.DriverDelay_etext = DriverDelay_etext;
        
        data.handles.XJogSteps_etext = XJogSteps_etext;
        data.handles.XJogSteps_etext = ZJogSteps_etext;
        data.handles.XJogSteps_etext = XJogDirection_etext;
        data.handles.XJogSteps_etext = ZJogDirection_etext;
            
        %--- checkbox handles
        data.handles.XJog_checkbox = XJog_checkbox;
        data.handles.ZJog_checkbox = ZJog_checkbox;
        
        %--- button handles
        data.handles.XScan_button = XScan_button;
        data.handles.ZScan_button = ZScan_button;
        data.handles.FullScan_button = FullScan_button;
        data.handles.RepeatScan_button = RepeatScan_button;
        data.handles.MotorParametersSave_button = MotorParametersSave_button;
        data.handles.TakeSpectrum_button = TakeSpectrum_button;
        data.handles.DelaysSave_button = DelaysSave_button;
        data.handles.GetPosition_button = GetPosition_button;
        data.handles.Jog_button = Jog_button;
        
        data.handles.XScanUp_button = XScanUp_button;
        data.handles.XScanDown_button = XScanDown_button;
        data.handles.ZScanRight_button = ZScanRight_button;
        data.handles.ZScanLeft_button = ZScanLeft_button;
        
        %--- menu handles
        data.handles.ExitProgram = ExitProgram;
        data.handles.StartArduino = StartArduino;
        data.handles.StartInductionSensor = StartInductionSensor;
        
        data.handles.Test_menu = Test_menu;
        data.handles.Test2_menu = Test2_menu;
        
        fn = CrazyLaserFunctions(data);
        
        fn.UpdateDisplay();
    end

    function MenuCallback(srv, evnt)
        fn.MenuCallback(srv,evnt);
    end

    function EditCallback(srv, evnt)
        fn.EditCallback(srv, evnt)
    end

    function CheckboxCallback(srv, evnt)
        fn.CheckboxCallback(srv, evnt)
    end

    function ButtonCallback(srv, evnt)
        fn.ButtonCallback(srv, evnt)
    end

    function MF_DeleteFn(srv, evnt)
        fn.MF_DeleteFn(srv, evnt)
    end
end

