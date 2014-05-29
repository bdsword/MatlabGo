function result = unsetChess( chessPositions )
    global chessBoard;
    global chessHandles;
    result=false;
    for i=1:size(chessPositions)
        if chessBoard(chessPositions(i,1),chessPositions(i,2))~=0
            chessBoard(chessPositions(i,1),chessPositions(i,2))=0;
            delete(chessHandles(chessPositions(i,1),chessPositions(i,2)));
            chessHandles(chessPositions(i,1),chessPositions(i,2))=0;
            result=true;
        end
    end
end

