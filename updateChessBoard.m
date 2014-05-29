function updateChessBoard()
    global chessBoard;
    global chessRadius;
    global chessHandles;
    for i=1:19
        for j=1:19
            if chessBoard(i,j)==1&&chessHandles(i,j)==0
                chessHandles(i,j)=circle(i,j,chessRadius,[0,0,0]);
            elseif chessBoard(i,j)==2&&chessHandles(i,j)==0
                chessHandles(i,j)=circle(i,j,chessRadius,[1,1,1]);
            end
        end
    end
    function circleHandle = circle(x,y,r,color)
        global blocksWidth;
        global origin;
        xDraw = origin(1)+blocksWidth(1)*(x-1);
        yDraw = origin(2)+blocksWidth(2)*(y-1);
        circleHandle=rectangle('Curvature',[1 1], ...
          'Position',[xDraw-r/2 yDraw-r/2 r r], ...
          'FaceColor',color);
    end
end