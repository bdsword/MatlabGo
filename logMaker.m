function chessLog = logMaker( chessPositions, chessStatus )
    chessLog = [];
    for i=1:size(chessPositions)
        chessLog = [chessLog;[chessPositions(i,1),chessPositions(i,2),chessStatus]];
    end
end

