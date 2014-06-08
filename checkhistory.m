function varargout = checkhistory(varargin)
    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
                       'gui_Singleton',  gui_Singleton, ...
                       'gui_OpeningFcn', @checkhistory_OpeningFcn, ...
                       'gui_OutputFcn',  @checkhistory_OutputFcn, ...
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

function checkhistory_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;

init

set(gcf,'CurrentAxes',handles.axes1);
imageData = imread('ChessBoard.jpg');
imageHandle = image(imageData);
hold on;
set(gca,'xtick',[],'ytick',[]);
axis square;
set(gcf,'CurrentAxes',handles.chessPaintBoard);
set(handles.chessPaintBoard,'xtick',[],'ytick',[]);
set(handles.chessPaintBoard,'color','none');
axis square;

% bg image
pic_bg = imread('gamebg.png');
image(pic_bg,'parent',handles.axes_gmbg)
set(handles.axes_gmbg,'xtick',[],'ytick',[]);

%--- four image button and set button----
picBack = imread('back.png');
backImhandles = image(picBack,'parent',handles.axesBack);
set(handles.axesBack,'xtick',[],'ytick',[]);
set(backImhandles, 'ButtonDownFcn', @back_ClickFcn);

picNext = imread('next.png');
nextImhandles = image(picNext,'parent',handles.axesNext);
set(handles.axesNext,'xtick',[],'ytick',[]);
set(nextImhandles, 'ButtonDownFcn', @next_ClickFcn);
%------------------

handles.chessBoard = imageHandle;
guidata(hObject, handles);

if nargin<=3
    warndlg('The sgf content is not correct.');
    startpage
    close(handles.figure1);
end
global history;
history = varargin{1};
logPointer %init the logPointer

function varargout = checkhistory_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


function back_ClickFcn(hObject, eventdata)
    handles = guidata(hObject);
    global logPointer;
    if logPointer>0
        logPointer=logPointer-1;
        updateToLogPointer(handles.chessPaintBoard);
    end
    
function next_ClickFcn(hObject, eventdata)
    handles = guidata(hObject);
    global logPointer;
    global history;
    if logPointer<size(history,2)
        logPointer=logPointer+1;
        updateToLogPointer(handles.chessPaintBoard);
    end

%======================================


% --- Executes on mouse press over axes background.
function chessPaintBoard_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to chessPaintBoard (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
