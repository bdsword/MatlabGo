function updateChessBoard(chessPaintBoard)
    global chessBoard;
    global chessRadius;
    global history;
    cla(chessPaintBoard);
    oldGca=gca;
    set(gcf,'CurrentAxes',chessPaintBoard);
    for i=1:19
        for j=1:19
            if chessBoard(i,j)==1
                circle(i,j,chessRadius,[0,0,0],[0,0,0],'-',.5);
            elseif chessBoard(i,j)==2
                circle(i,j,chessRadius,[1,1,1],[0,0,0],'-',.5);
            end
            if size(history,2)~=0 && history{end}(1,1)==i && history{end}(1,2)==j
                circle(i,j,chessRadius,'none',[.1,.6,.2],'-',2);
            end
        end
    end
    set(gcf,'CurrentAxes',oldGca);
    function circleHandle = circle(x,y,r,color,edgeColor,lineStyle,lineWidth)
        global blocksWidth;
        global origin;
        xDraw = origin(1)+blocksWidth(1)*(x-1);
        yDraw = origin(2)+blocksWidth(2)*(y-1);
        circleHandle=rectangle('Curvature',[1 1], ...
          'Position',[xDraw-r/2 yDraw-r/2 r r], ...
          'FaceColor',color,'EdgeColor',edgeColor,'LineStyle',lineStyle,'LineWidth',lineWidth);
    end
end