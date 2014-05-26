function takenChess = takeChess( x, y, color )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    global chessBoard;
    global chessBoardSize;
    direction = {[1,0],[0,1],[-1,0],[0,-1]};
    nowTakenChess = {};
    walkedChess = zeros(chessBoardSize,chessBoardSize);
    function takeChessRecursive( nowX, nowY )
        for i=1:4
            nextX = nowX+direction(i,1);
            nextY = nowY+direction(i,2);
            if walkedChess(nextX,nextY)==color
                nowTakenChess{end+1}=[nextX,nextY];
                takeChessRecursive(nextX,nextY);
            end
        end
    end

end

