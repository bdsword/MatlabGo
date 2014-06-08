function writeHistoryToFileClg()
    global history;
      
    [filename, pathname] = uiputfile('*.clg', 'Save chess log as...');
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
    for i=1:size(history,2)
        for j=1:size(history{i},1)
            fprintf(fileID,'%d %d %d\n',history{i}(j,1),history{i}(j,2),history{i}(j,3));
        end
    end
    fclose(fileID);
end

