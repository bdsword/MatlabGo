function takenChess = takeChess( x, y )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    global chessBoard;
    global chessBoardSize;
    direction = [1,0;0,1;-1,0;0,-1];
    takenChess = [];
    walkedChess = zeros(chessBoardSize,chessBoardSize);
    attackColor = chessBoard(x,y);
    
    for i=1:4
        liberty = 0;
        dirTakenChess = [];
        takeChessRecursive(x+direction(i,1),y+direction(i,2));
        if liberty==0
            takenChess = [takenChess;dirTakenChess];
        end
    end
    function takeChessRecursive( nowX, nowY)
        if nowX>19 || nowY>19 || nowX<1 || nowY<1
            return;
        end
        if chessBoard(nowX,nowY)==0
            liberty = liberty+1;
            return;
        end
        if walkedChess(nowX,nowY)~=1 && ...
                chessBoard(nowX,nowY)~=attackColor
            walkedChess(nowX,nowY)=1;
            dirTakenChess=[dirTakenChess;[nowX,nowY]];
            for j=1:4
                takeChessRecursive(nowX+direction(j,1),nowY+direction(j,2));
            end
        end
    end

end

