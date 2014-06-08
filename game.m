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
        resetEndChecker();
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


% --- Executes on button press in passButton.
function passButton_Callback(hObject, eventdata, handles)
    global tmpLogName;
    pass();
    if isGameFinished()
        msgbox('Both player pass in succession. The game is finished.','modal');
        writeSgfForGnuGo();
        if strcmp(computer('arch'),'glnxa64') %linux
            system(sprintf('./gnugo-linux/gnugo --score aftermath -l %s > score',tmpLogName));
        elseif strcmp(computer('arch'),'win32') || strcmp(computer('arch'),'win64') %windows
            system(sprintf('gnugo-windows\\gnugo.exe --score aftermath -l %s > score',tmpLogName));
        end
        fileID = fopen('score','r');
        if fileID<0
            disp('The score file generated by gnugo not found.');
        end
        tline = fgets(fileID);
        wordParts = strsplit(tline);
        % White wins by 100.5 points
        winKomi = str2double(wordParts(4));
        msgbox(sprintf('%s wins by %f points.',tline(1),winKomi));
        fclose(fileID);
        delete(tmpLogName);
    end
    