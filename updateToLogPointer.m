function updateToLogPointer( chessPaintBoard )
    global logPointer;
    global history;
    clearChessBoard();
    for i=1:logPointer
        x=history{i}(1,1);
        y=history{i}(1,2);
        curPlayer=history{i}(1,3);
        setChess([x,y],curPlayer);
        takenChess = takeChess(x,y);
        if ~isempty(takenChess)
            unsetChess(takenChess);
        end
    end
    setCurrentPlayer(history{end}(1,3));
    if logPointer>0
        setLastStepChess([history{logPointer}(1,1),history{logPointer}(1,2)]);
    else
        setLastStepChess([0,0]);
    end
    updateChessBoard(chessPaintBoard);
end

