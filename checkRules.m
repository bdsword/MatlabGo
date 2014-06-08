function result = checkRules( x, y, color )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    global chessBoard;
    direction = [1,0;0,1;-1,0;0,-1];
    result = true;
    %---Rule 1-----
    %Test if the position is empty
    if chessBoard(x,y)~=0
        result=false;
        return;
    end
    %--------------
    %---Rule 2-----
    global chessBoardSize;
    walkedChess = zeros(chessBoardSize,chessBoardSize);
    
    liberty=0;
    chessBoard(x,y)=color; %assume that chess has been put on the chess board.
    countLiberty(x,y);
    if liberty==0%the chess that user wanna set has no liberty
        takenChess = takeChess(x,y);
        if isempty(takenChess)
            result=false;
            chessBoard(x,y)=0;
            return;
        end
    end
    chessBoard(x,y)=0;
    function countLiberty( nowX, nowY)
        if nowX>19 || nowY>19 || nowX<1 || nowY<1 || walkedChess(nowX,nowY)~=0
            return;
        end
        walkedChess(nowX,nowY)=1;
        if chessBoard(nowX,nowY)==0
            liberty = liberty+1;
            return;
        end
        if chessBoard(nowX,nowY)==color
            for j=1:4
                countLiberty(nowX+direction(j,1),nowY+direction(j,2));
            end
        end
    end
    %--------------
    %---Rule 3----
    %Check if the a ko exist
    global koLogger;
    
    chessBoard(x,y)=color;
    takenChess = takeChess(x,y);
    chessBoard(x,y)=0;
    if ~isempty(koLogger) && koLogger(1)==x && koLogger(2)==y && koLogger(3)==color
        result=false;
        return;
    elseif size(takenChess,1)==1%The takenChess is calculated from last rule
        koLogger = [takenChess,chessBoard(takenChess(1,1),takenChess(1,2))];
    else
        koLogger = [];
    end
    %-------------
end

