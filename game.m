function varargout = game(varargin)
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

function game_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;

init

set(gcf,'CurrentAxes',handles.axes1);
imageData = imread('ChessBoard.jpg');
imageHandle = image(imageData);
hold on;
set(gca,'xtick',[],'ytick',[]);
axis square;
set(gcf,'CurrentAxes',handles.chessPaintBoard);
set(gca,'xtick',[],'ytick',[]);
set(gca,'color','none');
axis square;

handles.chessBoard = imageHandle;
guidata(hObject, handles);



function varargout = game_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


function undoButton_Callback(hObject, eventdata, handles)
    % writeHistoryToFile();
    if undo()~=false
        updateChessBoard();
    end
    
function chessPaintBoard_ButtonDownFcn(hObject, eventdata, handles)
    cursorPoint = get(handles.chessPaintBoard, 'CurrentPoint');
    curX = cursorPoint(1,1);
    curY = cursorPoint(1,2);
    [x,y] = coordinateConvert(curX,curY);
    if x>0 && y>0
        curPlayer = getCurrentPlayer();
        if setChess([x,y],curPlayer)==false
            msgbox('This position is not allowed to set chess!','modal');
            return;
        end
        writeToHistory([x,y,curPlayer]);
        takenChess = takeChess(x,y);
        if ~isempty(takenChess)
            unsetChess(takenChess);
        end
        updateChessBoard();
        nextTurn();
    end

function writeHistoryButton_Callback(hObject, eventdata, handles)
    writeHistoryToFileSgf();
