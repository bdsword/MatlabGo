function undo()
% This function is bad, need to improve.
    global history;
    tmp = history;
    history = {};
    
    if( size(tmp{end},1)==0 )
        return ;
    end
    
    for i=1:size(tmp,2)-1
        history{end+1} = tmp{i};
    end
    
    for j=1:size(tmp{end},1)
        if( tmp{end}(j,4)==2 )
            setChess([tmp{end}(j,1),tmp{end}(j,2)],tmp{end}(j,3));
        else
            unsetChess([tmp{end}(j,1),tmp{end}(j,2)]);
        end
    end
end