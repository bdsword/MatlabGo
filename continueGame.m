function continueGame( chessLog, chessPaintBoard )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    global history;
    history = chessLog{1};
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
    setCurrentPlayer(history{end}(1,3));
    if size(history,2)~=0
        setLastStepChess([history{end}(1,1),history{end}(1,2)]);
    end
    updateChessBoard(chessPaintBoard);
end

