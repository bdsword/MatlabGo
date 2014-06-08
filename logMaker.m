function chessLog = logMaker( chessPositions )
    global chessBoard;
    chessLog = [];
    for i=1:size(chessPositions)
        disp(chessBoard(chessPositions(i,1),chessPositions(i,2)));
        chessLog = [chessLog;[chessPositions(i,1),chessPositions(i,2),chessBoard(chessPositions(i,1),chessPositions(i,2))]];
    end
end

