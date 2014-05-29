function result = setChess( chessPositions, color )
    global chessBoard;
    result=false;
    for i=1:size(chessPositions)
        if checkRules(chessPositions(i,1),chessPositions(i,2),color)==true
            chessBoard(chessPositions(i,1),chessPositions(i,2))=color;
            result=true;
        end
    end
end