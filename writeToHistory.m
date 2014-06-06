function writeToHistory( chessLog )
    % chessLog format:
    %    [x,y,color,status]
    %    x : the x coordinate of the status-changed chess.
    %    y : the y coordinate of the status-changed chess.
    %    status: what happened to the chess (1: was seted, 2: was unseted)
    global history;
    history{end+1} = chessLog;
end