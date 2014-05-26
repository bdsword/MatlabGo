function updateChessBoard()
    global chessBoard;
    global chessRadius;
    for i=1:19
        for j=1:19
            if chessBoard(i,j)==1
                circle(i,j,chessRadius,[0 0 0]);
            elseif chessBoard(i,j)==2
                circle(i,j,chessRadius,[1 1 1]);
            end
        end
    end
    
    function circle(x,y,r,color)
        global blocksWidth;
        global origin;
        xDraw = origin(1)+blocksWidth(1)*(x-1);
        yDraw = origin(2)+blocksWidth(2)*(y-1);
        ang=0:0.01:2*pi; 
        xp=r*cos(ang);
        yp=r*sin(ang);
        plot(xDraw+xp,yDraw+yp,'Color',color);
        fill(xDraw+xp,yDraw+yp,color);
    end
end