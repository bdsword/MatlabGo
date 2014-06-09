function varargout = practice(varargin)
    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
                       'gui_Singleton',  gui_Singleton, ...
                       'gui_OpeningFcn', @practice_OpeningFcn, ...
                       'gui_OutputFcn',  @practice_OutputFcn, ...
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

function practice_OpeningFcn(hObject, eventdata, handles, varargin)
    global blackButtonPress;
    global whiteButtonPress;
    handles.output = hObject;
    init 
    blackButtonPress = false;
    whiteButtonPress= false;
    
    set(handles.figure1,'CurrentAxes',handles.axes1);
    imageData = imread('ChessBoard.jpg');
    imageHandle = image(imageData);
    hold on;
    set(gca,'xtick',[],'ytick',[]);
    axis square;
    set(gcf,'CurrentAxes',handles.chessPaintBoard);
    set(handles.chessPaintBoard,'xtick',[],'ytick',[]);
    set(handles.chessPaintBoard,'color','none');
    axis square;

    set(handles.figure1,'name','Go!Go!Matlab! - Practice Mode');
    
    % bg image
    pic_bg = imread('gamebg.png');
    image(pic_bg,'parent',handles.axes_gmbg)
    set(handles.axes_gmbg,'xtick',[],'ytick',[]);

    %--- four image button and set button----
    picBP = imread('back_page.png');
    BPImhandles = image(picBP,'parent',handles.axesBackp);
    set(handles.axesBackp,'xtick',[],'ytick',[]);
    set(BPImhandles, 'ButtonDownFcn', @backPage_ClickFcn);
    
    picBlack = imread('black.png');
    blackImhandles = image(picBlack,'parent',handles.axesBlack);
    set(handles.axesBlack,'xtick',[],'ytick',[]);
    set(blackImhandles, 'ButtonDownFcn', @black_ClickFcn);
    
    picWhite = imread('white.png');
    whiteImhandles = image(picWhite,'parent',handles.axesWhite);
    set(handles.axesWhite,'xtick',[],'ytick',[]);
    set(whiteImhandles, 'ButtonDownFcn', @white_ClickFcn);
    
    picPlay = imread('play.png');
    playImhandles = image(picPlay,'parent',handles.axesPlay);
    set(handles.axesPlay,'xtick',[],'ytick',[]);
    set(playImhandles, 'ButtonDownFcn', @play_ClickFcn);
    
    picPass = imread('pass.png');
    passImhandles = image(picPass,'parent',handles.axesPass);
    set(handles.axesPass,'xtick',[],'ytick',[]);
    set(passImhandles, 'ButtonDownFcn', @pass_ClickFcn);

    picLog = imread('Save.png');
    logImhandles = image(picLog,'parent',handles.axesLog);
    set(handles.axesLog,'xtick',[],'ytick',[]);
    set(logImhandles, 'ButtonDownFcn', @log_ClickFcn);

    picUndo = imread('regret.png');
    undoImhandles = image(picUndo,'parent',handles.axesUndo);
    set(handles.axesUndo,'xtick',[],'ytick',[]);
    set(undoImhandles, 'ButtonDownFcn', @undo_ClickFcn);
    %------------------

    handles.chessBoard = imageHandle;
    guidata(hObject, handles);

    if nargin>3
        continueGame(varargin,gca);
    end


function varargout = practice_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

    
function chessPaintBoard_ButtonDownFcn(hObject, eventdata, handles)
    cursorPoint = get(handles.chessPaintBoard, 'CurrentPoint');
    curX = cursorPoint(1,1);
    curY = cursorPoint(1,2);
    [x,y] = coordinateConvert(curX,curY);
    if x>0 && y>0
        curPlayer = getPracticeChessColor();
        if setChess([x,y],curPlayer)==false
            msgbox('This position is not allowed to set chess!','modal');
            return;
        end
        setLastStepChess([x,y]);
        resetEndChecker();
        writeToHistory([x,y,curPlayer]);
        takenChess = takeChess(x,y);
        if ~isempty(takenChess)
            unsetChess(takenChess);
        end
        updateChessBoard(handles.chessPaintBoard);
        nextTurn();
    end
    
function chessColor=getPracticeChessColor()
    global blackButtonPress;
    global whiteButtonPress;
    if blackButtonPress==true
        chessColor=1;
    elseif whiteButtonPress==true;
        chessColor=2;
    else
        chessColor=getCurrentPlayer();
    end
    setCurrentPlayer(chessColor);
    %=======practice button image=====
function backPage_ClickFcn(hObject, eventdata)
    handles = guidata(hObject);
    close(gcf)
    startpage
    
function black_ClickFcn(hObject, eventdata)
    global blackButtonPress;
    global whiteButtonPress;
    whiteButtonPress=false;
    blackButtonPress=true;
    handles = guidata(hObject);
    
    %choose black
    
function white_ClickFcn(hObject, eventdata)
    global whiteButtonPress;
    global blackButtonPress;
    whiteButtonPress=true;
    blackButtonPress=false;
    handles = guidata(hObject);
    %choose white
    
function play_ClickFcn(hObject, eventdata)
    global whiteButtonPress;
    global blackButtonPress;
    whiteButtonPress=false;
    blackButtonPress=false;

function pass_ClickFcn(hObject, eventdata)

    handles = guidata(hObject);
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

function log_ClickFcn(hObject, eventdata)
    writeHistoryToFileSgf();

function undo_ClickFcn(hObject, eventdata)
    handles = guidata(hObject);
    if undo()~=false
        updateChessBoard(handles.chessPaintBoard);
    end

%======================================
