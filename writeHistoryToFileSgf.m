function writeHistoryToFileSgf()
    global history;
      
    [filename, pathname] = uiputfile('*.sgf', 'Save chess log as...');
    if isequal(filename,0) ||isequal(filename,0)
       disp('User selected Cancel');
       return;
    end
    fullFilePath = fullfile(pathname, filename);
    fileID = fopen(fullFilePath, 'w+');
    if fileID<0
        errordlg('There seem to be some errors when openning file.','Openfile Error!');
        return;
    end
    fprintf(fileID,'(;GM[1]\nFF[4]\nSZ[19]');
    for i=1:size(history,2)
        for j=1:size(history{i},1)
            if history{i}(j,3)==1
                chessColor = 'B';
            else
                chessColor = 'W';
            end
            fprintf(fileID,';%c[%c%c]',chessColor,'a'+history{i}(j,1)-1,'a'+history{i}(j,2)-1);
        end
    end
    fprintf(fileID,')');
    fclose(fileID);
end

