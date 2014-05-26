function nextTurn( )
%NEXTTURN Summary of this function goes here
%   Detailed explanation goes here
    global curPlayer;
    global maxPlayers;
    curPlayer = mod(curPlayer,maxPlayers);
    curPlayer = curPlayer+1;
    return;
end

