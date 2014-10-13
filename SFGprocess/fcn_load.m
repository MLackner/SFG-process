%function fcn_load()
% Returns path to selected file or folder

%% Get files
% Open dialog
[fileName,pathName,filterIndex] = uigetfile('*.itx','Select files',...
    'MultiSelect','on') % Returns fileName as cell array (if multiple)
% Convert string to array
if iscell(fileName)==false
    fileName = cellstr(fileName)
end
% Make Filepaths
filePath = cell(1,length(fileName));
for i=1:length(fileName)
    filePath{i} = [pathName,fileName{i}]
end

% Init waitbar
progress = 0;
[pathstr,name,ext] = fileparts(fileName{1});
waitBar = waitbar(progress,['Importing ',name]);
for i=1:length(filePath)
    %% Initialize variables.
    [pathstr,name,ext] = fileparts(fileName{i});
    delimiter = '\t';
    startRow = 4;
    
    %% Read columns of data as strings:
    % For more information, see the TEXTSCAN documentation.
    formatSpec = '%s%s%s%s%s%s%s%s%[^\n\r]';
    
    %% Open the text file.
    fileID = fopen(filePath{i},'r');
    
    %% Read columns of data according to format string.
    % This call is based on the structure of the file used to generate this
    % code. If an error occurs for a different file, try regenerating the code
    % from the Import Tool.
    dataArray = textscan(fileID, formatSpec,...
        'Delimiter', delimiter,...
        'HeaderLines' ,startRow-1,...
        'CommentStyle',{'WAVES','\D'},...
        'ReturnOnError', false);
    
    %% Close the text file.
    fclose(fileID);
    
    %% Convert the contents of columns containing numeric strings to numbers.
    % Replace non-numeric strings with NaN.
    raw = repmat({''},length(dataArray{1}),length(dataArray)-1);
    for col=1:length(dataArray)-1
        raw(1:length(dataArray{col}),col) = dataArray{col};
    end
    numericData = NaN(size(dataArray{1},1),size(dataArray,2));
    
%     for col=[1,2,3,4,5,6,7]
    % Init counter
    k = 0;
    for col=[1,5]
        % Converts strings in the input cell array to numbers. Replaced non-numeric
        % strings with NaN.
        rawData = dataArray{col};
        for row=1:size(rawData, 1);
            % Create a regular expression to detect and remove non-numeric prefixes and
            % suffixes.
            regexstr = '(?<prefix>.*?)(?<numbers>([-]*(\d+[\,]*)+[\.]{0,1}\d*[eEdD]{0,1}[-+]*\d*[i]{0,1})|([-]*(\d+[\,]*)*[\.]{1,1}\d+[eEdD]{0,1}[-+]*\d*[i]{0,1}))(?<suffix>.*)';
            try
                result = regexp(rawData{row}, regexstr, 'names');
                numbers = result.numbers;
                
                % Detected commas in non-thousand locations.
                invalidThousandsSeparator = false;
                if any(numbers==',');
                    thousandsRegExp = '^\d+?(\,\d{3})*\.{0,1}\d*$';
                    if isempty(regexp(thousandsRegExp, ',', 'once'));
                        numbers = NaN;
                        invalidThousandsSeparator = true;
                    end
                end
                % Convert numeric strings to numbers.
                if ~invalidThousandsSeparator;
                    numbers = textscan(strrep(numbers, ',', ''), '%f');
                    numericData(row, col) = numbers{1};
                    raw{row, col} = numbers{1};
                end
            catch me
            end
        end
        % Update waitbar
        k = k+1;
        progress = k/2/length(filePath) + (i-1)/length(filePath);
        waitbar(progress);
    end
    
    
    %% Split data into numeric and cell columns.
%     rawNumericColumns = raw(:, [1,2,3,4,5,6,7]);
    rawNumericColumns = raw(:, [1,5]);
%     rawCellColumns = raw(:, 8);
    
    
    %% Exclude rows with non-numeric cells
    I = ~all(cellfun(@(x) (isnumeric(x) || islogical(x)) && ~isnan(x),rawNumericColumns),2); % Find rows with non-numeric cells
    rawNumericColumns(I,:) = [];
%     rawCellColumns(I,:) = [];
    
    %% Allocate imported array to column variable names
    WLOPG = cell2mat(rawNumericColumns(:, 1));
%     SigDet1 = cell2mat(rawNumericColumns(:, 2));
%     SigDet2 = cell2mat(rawNumericColumns(:, 3));
%     SigDet3 = cell2mat(rawNumericColumns(:, 4));
    SigOsc1 = cell2mat(rawNumericColumns(:, 2));
%     SigOsc2 = cell2mat(rawNumericColumns(:, 6));
%     SigOsc3 = cell2mat(rawNumericColumns(:, 7));
    
    %% Write data in structure
    % Make valid name
    varName = matlab.lang.makeValidName(name);
    % Write
    eval([varName,'.name = name']);
    eval([varName,'.wavelength = WLOPG']);
    eval([varName,'.signal = SigOsc1']);
end

% Close waitbar
close(waitBar)


%end
