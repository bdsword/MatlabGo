function [ x,y ] = coordinateConvert( xGUI, yGUI )
%COORDINATECONVERT Summary of this function goes here
%   Detailed explanation goes here
    global origin;
    global dismiss
    global blocksWidth;
    %99.7058,84.5599
    %925.1590,943.3341
    %45.8585,47.7096
    
    closestX = origin(1);
    closestXIndex = 0;
    for i=0:18
        if abs( xGUI-(closestX+blocksWidth(1)*i) )<dismiss
            closestXIndex = i+1; 
            break;
        end
    end
    closestY = origin(2);
    closestYIndex = 0;
    for i=0:18
        if abs( yGUI-(closestY+blocksWidth(2)*i) )<dismiss
            closestYIndex = i+1;
            break;
        end
    end
    x=closestXIndex;
    y=closestYIndex;
    return;
end

