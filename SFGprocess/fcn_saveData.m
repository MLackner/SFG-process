function fcn_saveData(handles)
% Saves all the processed data to seperate csv files

%% Open and read temporary *.mat file
% Get name of temporary data file
fileName = handles.options.fileNamePrData;
% Load *.mat file
matFile = load(fileName);
% Get variable names from matfile
varNames = fieldnames(matFile);

%% Open dialog where to put files
pathName = uigetdir('','Select where to put processed data');

%% Set the suffix to the processed file
suffix = '';

%% Save every data set
for i=1:length(varNames)
    %% Determine original file Name
    fileNameOriginal = eval(['matFile.',varNames{i},'.name'])
    fileNameNew = [fileNameOriginal,suffix]
    
    % Make file path
    filePath = [pathName,'\',fileNameNew,'.csv']
    
    %% Get values
    wavelength = eval(['matFile.',varNames{i},'.wavelength']);
    wavenumber = eval(['matFile.',varNames{i},'.wavenumber']);
    signal = eval(['matFile.',varNames{i},'.signal']);
    stepSize = eval(['matFile.',varNames{i},'.stepSize']);
    shotsPerAvg = eval(['matFile.',varNames{i},'.shotsPerAvg']);
    
    % put them in matrix
    M(:,1) = wavelength;
    M(:,2) = wavenumber;
    M(:,3) = signal;
    
    %% Define Metadata
    meta = ['Shots per average: ', num2str(shotsPerAvg),'\n',...
        'StepSize: ', num2str(stepSize),'\n',...
        'Processing date: ', datestr(datetime),'\n'];
    
    %% Define Header
    header = cell(1,3);
    header{1} = 'Wavelength';
    header{2} = 'Wavenumber';
    header{3} = 'Signal';
    
    %% Write
    fcn_csvwrite(filePath,M,header,meta)
end

end