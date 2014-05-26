function result = setChess( x, y, color )
    global chessBoard;
    if checkRules(x,y,color)==true
        chessBoard(x,y)=color;
        result=true;
        return;
    end
end

