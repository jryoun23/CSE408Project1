% Joseph Young, jryoun23, 1210653766

% function to create a newVocabulary from multiple text files under folders


function voc = buildVoc(folder, voc)
newVoc = cell(0,1);
megaLine = '';
nextToken = 'palceholder';
disp(folder)
stopword = {'ourselves', 'hers', 'between', 'yourself', 'but', 'again', 'there', ...
    'about', 'once', 'during', 'out', 'very', 'having', 'with', 'they', 'own', ...
    'an', 'be', 'some', 'for', 'do', 'its', 'yours', 'such', 'into', ...
    'of', 'most', 'itself', 'other', 'off', 'is', 's', 'am', 'or', ...
    'who', 'as', 'from', 'him', 'each', 'the', 'themselves', 'until', ...
    'below', 'are', 'we', 'these', 'your', 'his', 'through', 'don', 'nor', ...
    'me', 'were', 'her', 'more', 'himself', 'this', 'down', 'should', 'our', ...
    'their', 'while', 'above', 'both', 'up', 'to', 'ours', 'had', 'she', 'all', ...
    'no', 'when', 'at', 'any', 'before', 'them', 'same', 'and', 'been', 'have', ...
    'in', 'will', 'on', 'does', 'yourselves', 'then', 'that', 'because', ...
    'what', 'over', 'why', 'so', 'can', 'did', 'not', 'now', 'under', 'he', ...
    'you', 'herself', 'has', 'just', 'where', 'too', 'only', 'myself', ...
    'which', 'those', 'i', 'after', 'few', 'whom', 't', 'being', 'if', ...
    'theirs', 'my', 'against', 'a', 'by', 'doing', 'it', 'how', ...
    'further', 'was', 'here', 'than', ''}; % define English stop words, from NLTK



files = dir(fullfile(folder,'*.txt'));
disp(files)
for file = files'
    [fid, msg] = fopen(fullfile(folder,file.name), 'rt');
    error(msg);
    disp(fid);
    line = fgets(fid); % Get the first line from the file.
    
    lineCell = cell(0,1); %This is where im gonna store the lines
    
    while line ~= -1 %this is where the shit hits the fan am i right ladies. everything that happens in here happens to every file in the folder.
       
        %initializes the currLine for the while loop
        currLine = line;    
   
        while currLine ~= -1                  %no more lines
            %This is where the line formatting will take place
            currLine = lower(currLine);
            currLine = erase(currLine, ',');
            currLine = erase(currLine, '?');
            currLine = erase(currLine, '!');
            currLine = erase(currLine, '&');
            currLine = erase(currLine, '*');
            currLine = erase(currLine, ';');
            currLine = erase(currLine, ':');
            currLine =  strrep(currLine, '-',' ');
            currLine =  strrep(currLine, '_',' ');
            currLine = erase(currLine, '.');
            currLine = erase(currLine, '(');
            currLine = erase(currLine, ')');
            currLine = strrep(currLine, '’','');
            currLine = strrep(currLine, '''','');
            currLine = strrep(currLine, '"','');
            %end line formatting
            
            %removing stopwords
                %adding a space at the fromt so i can remove the first word
                %if it is a stopword
            currLine = append(" ", currLine);
            for i = stopword
            	delim = " " + i + " ";
            	currLine = strrep(currLine,delim," ");
            end
            %stopwords for the line have been removed
            
            %Break apart the line and put it into a token array
            tokenArray = cell(0,1);
            [nextToken,currLine] = strtok(currLine);
            while nextToken ~= ""           
                
   
%                 if nextToken == ""                          
%                     break;
%                 end
                tokenArray{end+1, 1} = nextToken;
                [nextToken,currLine] = strtok(currLine);
            end 
            %currLine broken into individual words and in tokenArray (cell)
            %I assume we want to keep ALL words including repeats for
            %weighting purposes?           
            newVoc = [newVoc ; tokenArray];
    
            lineCell{end+1,1} = currLine;      
            currLine = fgetl(fid);              
        end
        line = -1;
    end    
    fclose(fid);
end
if isempty(voc)
    voc = newVoc;
elseif ~isempty(voc)
    voc = [voc ; newVoc];
end     
%%returning the sorted unique array so we can run it against the others
strVoc = string(voc);
strVoc = unique(strVoc);
strVoc = cellstr(strVoc);
voc = strVoc;
% strVoc = unique(voc);
end
