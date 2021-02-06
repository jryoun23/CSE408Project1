%Joseph Young jryoun23 1210653766

% function to create a vocabulary from multiple text files under folders

function feat_vec = cse408_bow(filepath, voc)
intVector = zeros(size(voc));

docVoc = cell(0,1);
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

[fid, msg] = fopen(filepath, 'rt');
error(msg);
line = fgets(fid); % Get the first line from
 % the file.
feat_vec = zeros(size(voc)); %Initialize the feature vector'

while line ~= -1
    
    %welp first things first we gotta reformat them. Copy Pasta time
     line = line;    
                    %no more lines
            %This is where the line formatting will take place
             line = lower(line);
            line = strrep(line, '$',' ' );
            line = strrep(line, '\',' ' );
            line = strrep(line, '/',' ' );
            line = strrep(line, ',',' ' );
            line = strrep(line, '?', ' ');
            line = strrep(line, '!', ' ');
            line = strrep(line, '&', ' ');
            line = strrep(line, '*', ' ');
            line = strrep(line, ';', ' ');
            line = strrep(line, ':', ' ');
            line =  strrep(line, '-',' ');
            line =  strrep(line, '_',' ');
            line = strrep(line, '.', ' ');
            line = strrep(line, '(', ' ');
            line = strrep(line, ')', ' ');
            line = strrep(line, '’',' ');
            line = strrep(line, '''',' ');
            line = strrep(line, '"',' ');
            %end line formatting
            
            %removing stopwords
                %adding a space at the fromt so i can remove the first word
                %if it is a stopword
            line = append(" ", line);
            for i = stopword
            	delim = " " + i + " ";
            	line = strrep(line,delim," ");
            end
            %stopwords for the line have been removed
            
            %Break apart the line and put it into a token array
            tokenArray = cell(0,1);
            [nextToken,line] = strtok(line);
            while nextToken ~= ""            
                tokenArray{end+1, 1} = nextToken;
                [nextToken,line] = strtok(line);
            end 
            %adds the newest line to the existing array
            docVoc = [docVoc ; tokenArray];     
            line = fgetl(fid);    
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
   
    
end
%this is where we count against voc to get the counted vector;
%just gonna use an int array
docVoc = docVoc';
searchVoc = string(voc)';
for i = 1:size(docVoc')
    find1 = string(docVoc{i});
    for k = i:size(searchVoc')
        find2 = searchVoc(k);
        if(contains(find2,find1)) %we're gonna count strings and substrings so that we can give words that are alike higher weight
            feat_vec(k) = feat_vec(k) +1;
        end
    end
            
end
feat_vec = feat_vec';
fclose(fid);
end
