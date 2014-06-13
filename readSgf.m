function history = readSgf( filePath )
    fileID = fopen(filePath,'r');
    history = {};
    if fileID<0
        msgbox('Open sgf file error.');
        return;
    end
    while ~feof(fileID)
        inC = fscanf(fileID,'%c',1);
        if strcmp(inC,';')==true
            nodeName = readToLeftQuart(fileID);
            nodeContent=readToRightQuart(fileID);
            chessColor=0;
            if strcmp(nodeName,'B')
                chessColor=1;
            elseif strcmp(nodeName,'W')
                chessColor=2;
            end
            if chessColor~=0
                if isempty(nodeContent)
                    continue; 
                end
                history{end+1}=[nodeContent(1)-'a'+1,nodeContent(2)-'a'+1,chessColor];
            end
        end
    end
    fclose(fileID);
    function nodeTag = readToLeftQuart(fileID)
        nodeTag = '';
        while true
            inCC = fscanf(fileID,'%c',1);
            if strcmp(inCC,'[')==true
                break;
            end
            nodeTag = [nodeTag,inCC];
        end
    end
    function content = readToRightQuart(fileID)
        content = '';
        while true
            inCC = fscanf(fileID,'%c',1);
            if strcmp(inCC,']')==true
                break;
            end
            content = [content,inCC];
        end
    end
end

