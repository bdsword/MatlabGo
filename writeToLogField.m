function writeToLogField(logFieldHandle)
    global history;
    log = '';
    set(logFieldHandle,'string','');
    for i=1:size(history,2)
        chessColor='';
        if history{i}(1,3)==1
            chessColor = 'B';
        else
            chessColor = 'W';
        end
        log=[log,sprintf('%s (%s,%c)\n',chessColor,num2str(history{i}(1,1)),history{i}(1,2)+'a'-1)];
    end
    set(logFieldHandle,'string',log);
end

