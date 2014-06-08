function history = readSgf( filePath )
    fileID = fopen(filePath,'r');
    history = {};
    if fileID<0
        msgbox('Open sgf file error.');
        return;
    end
    while ~feof(fileID)
        inC = fscanf(fileID,'%c',1);
        if (strcmp(inC,';')==true)&&(feof(fileID)==0)
            inC = fscanf(fileID,'%c',1);
            if strcmp(inC,'B')
                fscanf(fileID,'%c',1);
                x=fscanf(fileID,'%c',1)-'a'+1;
                y=fscanf(fileID,'%c',1)-'a'+1;
                history{end+1}=[x,y,1];
                fscanf(fileID,'%c',1);
            elseif strcmp(inC,'W')
                fscanf(fileID,'%c',1);
                x=fscanf(fileID,'%c',1)-'a'+1;
                y=fscanf(fileID,'%c',1)-'a'+1;
                history{end+1}=[x,y,2];
                fscanf(fileID,'%c',1);
            end
        end
    end
    fclose(fileID);
end

