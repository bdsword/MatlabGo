function result = undo()
% This function is bad, need to improve.
    global history;
    tmp = history;
    history = {};
    
    if( size(tmp,1)==0 )
        result = false;
        return ;
    end
    
    for i=1:size(tmp,2)-1
        history{end+1} = tmp{i};
    end
    clearChessBoard();
    
    global chessBoard;
    for i=1:size(history,2)
        x=history{i}(1,1);
        y=history{i}(1,2);
        curPlayer=history{i}(1,3);
        setChess([x,y],curPlayer);
        takenChess = takeChess(x,y);
        if ~isempty(takenChess)
            unsetChess(takenChess);
        end
    end
    setCurrentPlayer(tmp{end}(1,3));
    result = true;
end