function varargout = startpage(varargin)
% STARTPAGE MATLAB code for startpage.fig
%      STARTPAGE, by itself, creates a new STARTPAGE or raises the existing
%      singleton*.
%
%      H = STARTPAGE returns the handle to a new STARTPAGE or the handle to
%      the existing singleton*.
%
%      STARTPAGE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STARTPAGE.M with the given input arguments.
%
%      STARTPAGE('Property','Value',...) creates a new STARTPAGE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before startpage_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to startpage_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help startpage

% Last Modified by GUIDE v2.5 09-Jun-2014 02:40:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @startpage_OpeningFcn, ...
                   'gui_OutputFcn',  @startpage_OutputFcn, ...
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


% --- Executes just before startpage is made visible.
function startpage_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to startpage (see VARARGIN)

% Choose default command line output for startpage
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
% UIWAIT makes startpage wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% bg image
pic_bg = imread('gamebg.png');
image(pic_bg,'parent',handles.axes_bg)
set(handles.axes_bg,'xtick',[],'ytick',[]);
 


%--- four image button and set button----
pic_start = imread('button_start.png');
start_imhandles = image(pic_start,'parent',handles.axes_start);
set(handles.axes_start,'xtick',[],'ytick',[]);
set(start_imhandles, 'ButtonDownFcn', @start_ClickFcn);

pic_con = imread('button_con.png');
con_imhandles = image(pic_con,'parent',handles.axes_con);
set(handles.axes_con,'xtick',[],'ytick',[]);
set(con_imhandles, 'ButtonDownFcn', @con_ClickFcn);

pic_grade = imread('button_grade.png');
grade_imhandles = image(pic_grade,'parent',handles.axes_grade);
set(handles.axes_grade,'xtick',[],'ytick',[]);
set(grade_imhandles, 'ButtonDownFcn', @grade_ClickFcn);

pic_log = imread('button_history.png');
log_imhandles = image(pic_log,'parent',handles.axes_log);
set(handles.axes_log,'xtick',[],'ytick',[]);
set(log_imhandles, 'ButtonDownFcn', @log_ClickFcn);

pic_quit = imread('button_quit.png');
quit_imhandles = image(pic_quit,'parent',handles.axes_quit);
set(handles.axes_quit,'xtick',[],'ytick',[]);
set(quit_imhandles, 'ButtonDownFcn', @quit_ClickFcn);
%------------------

% --- Outputs from this function are returned to the command line.
function varargout = startpage_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%==========click function of four image button=================
function start_ClickFcn(hObject, eventdata)

handles = guidata(hObject);
delete(handles.axes_start)
delete(handles.axes_con)
delete(handles.axes_grade)
delete(handles.axes_log)
delete(handles.axes_quit)
%-------choose play mode-------
axesm1_h = axes('Units','pixels','Position',[40 150 150 180])
% pic_m1 = imread('two player.png');
% m1_imh = image(pic_m1,'parent',axesm1_h)
% set(axesm1_h,'xtick',[],'ytick',[]);
% set(m1_imh, 'ButtonDownFcn', @m1_ClickFcn);

uniquebgcolor=[0 0 0]; % <- select a color that does not exist in your image!!!
pic_m1 = imread('two player.png','BackgroundColor',uniquebgcolor);
mask = bsxfun(@eq,pic_m1,reshape(uniquebgcolor,1,1,3));
m1_imh = image(pic_m1,'parent',axesm1_h,'alphadata',1-double(all(mask,3)));
set(axesm1_h,'xtick',[],'ytick',[]);
set(m1_imh, 'ButtonDownFcn', @m1_ClickFcn);

axesm2_h = axes('Units','pixels','Position',[225 150 150 180])
pic_m2 = imread('computer.png');
m2_imh = image(pic_m2,'parent',axesm2_h)
set(axesm2_h,'xtick',[],'ytick',[]);
set(m2_imh, 'ButtonDownFcn', @m2_ClickFcn);

axesm3_h = axes('Units','pixels','Position',[410 150 150 180])
pic_m3 = imread('practice.png');
m3_imh = image(pic_m3,'parent',axesm3_h)
set(axesm3_h,'xtick',[],'ytick',[]);
set(m3_imh, 'ButtonDownFcn', @m3_ClickFcn);
%-------------------------------

function con_ClickFcn(hObject, eventdata)

handles = guidata(hObject);
[FileName,PathName] = uigetfile('*.sgf','Select the GO chess file');
if isequal(FileName,0)
    return;
end
filePath = strcat(PathName,FileName);
history = readSgf(filePath);
game(history);
close(handles.figure1);


function grade_ClickFcn(hObject, eventdata)

handles = guidata(hObject);
%imshow('002.jpg','parent',handles.axes_log)
delete(handles.axes_start)
delete(handles.axes_con)
delete(handles.axes_grade)
delete(handles.axes_log)
delete(handles.axes_quit)

function log_ClickFcn(hObject, eventdata)

handles = guidata(hObject);
[FileName,PathName] = uigetfile('*.sgf','Select the GO chess file');
if isequal(FileName,0)
   return;
end
filePath = strcat(PathName,FileName);
history = readSgf(filePath);
checkhistory(history);
close(handles.figure1);


function quit_ClickFcn(hObject, eventdata)

handles = guidata(hObject);
close(handles.figure1)

%==================================================

%=======click start to choose mode=====
function m1_ClickFcn(hObject, eventdata)

handles = guidata(hObject);
% select player vs player mode
game
close(handles.figure1)

function m2_ClickFcn(hObject, eventdata)

handles = guidata(hObject);
% select player vs com. mode
game
close(handles.figure1)

function m3_ClickFcn(hObject, eventdata)

handles = guidata(hObject);
% select practice mode
game
close(handles.figure1)
%======================================
