function varargout = game(varargin)
% GAME MATLAB code for game.fig
%      GAME, by itself, creates a new GAME or raises the existing
%      singleton*.
%
%      H = GAME returns the handle to a new GAME or the handle to
%      the existing singleton*.
%
%      GAME('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GAME.M with the given input arguments.
%
%      GAME('Property','Value',...) creates a new GAME or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before game_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to game_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help game

% Last Modified by GUIDE v2.5 30-May-2014 14:27:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @game_OpeningFcn, ...
                   'gui_OutputFcn',  @game_OutputFcn, ...
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


% --- Executes just before game is made visible.
function game_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to game (see VARARGIN)

% Choose default command line output for game
handles.output = hObject;

init

imageData = imread('ChessBoard.jpg');
imageHandle = image(imageData);
hold on;
axis square;
set(gca,'xtick',[],'ytick',[]);
set(imageHandle, 'ButtonDownFcn', @chessBoard_ClickFcn);

% Update handles structure
handles.chessBoard = imageHandle;
guidata(hObject, handles);

% UIWAIT makes game wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = game_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function chessBoard_ClickFcn(hObject, eventdata)
% ------For test coordinate------
% [x,y,button] = ginput(1);
% x
% y
% button
% --------test code end----------
% This function wouldn't be trigger when user click on a chess which
% plotted on the board.
% -------------------
handles = guidata(hObject);
cursorPoint = get(handles.axes1, 'CurrentPoint');
curX = cursorPoint(1,1);
curY = cursorPoint(1,2);
[x,y] = coordinateConvert(curX,curY);
if x>0 && y>0
    curPlayer = getCurrentPlayer();
    if setChess([x,y],curPlayer)==false
        msgbox('This position is not allowed to set chess!','modal');
        return;
    end
    writeToHistory([x,y,curPlayer,1]);
    takenChess = takeChess(x,y);
    if ~isempty(takenChess)
        chessLog = logMaker(takenChess, 2);
        writeToHistory(chessLog);
        unsetChess(takenChess);
    end
    updateChessBoard();
    nextTurn();
end


% --- Executes on button press in undoButton.
function undoButton_Callback(hObject, eventdata, handles)
    % writeHistoryToFile();