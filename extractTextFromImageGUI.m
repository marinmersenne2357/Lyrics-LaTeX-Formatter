function textExtractionGUI()
    % Create the main figure
    fig = figure('Name', 'Text Extraction from Image', 'Position', [100, 100, 600, 420]);

    % Create UI components
    uicontrol('Style', 'pushbutton', 'String', 'Upload Image', 'Position', [20, 380, 100, 30], 'Callback', @uploadImage);
    uicontrol('Style', 'text', 'String', 'Selected Image:', 'Position', [130, 385, 100, 20]);
    imagePathText = uicontrol('Style', 'text', 'String', '', 'Position', [20, 350, 560, 30], 'HorizontalAlignment', 'left');
    
    uicontrol('Style', 'text', 'String', 'Language:', 'Position', [20, 315, 60, 20]);
    languageDropdown = uicontrol('Style', 'popupmenu', 'String', getAllLanguages(), 'Position', [90, 315, 100, 25]);
    
    extractButton = uicontrol('Style', 'pushbutton', 'String', 'Extract Text', 'Position', [200, 310, 100, 30], 'Callback', @extractText);
    
    % Add confidence toggle
    confidenceToggle = uicontrol('Style', 'checkbox', 'String', 'Show Confidences', 'Position', [310, 315, 120, 20]);
    
    % Add Confidence Graph button
    confidenceGraphButton = uicontrol('Style', 'pushbutton', 'String', 'Confidence Graph', 'Position', [440, 310, 120, 30], 'Callback', @showConfidenceGraph);
    
    outputText = uicontrol('Style', 'edit', 'Position', [20, 20, 560, 280], 'Max', 2, 'HorizontalAlignment', 'left', 'Enable', 'on');

    % Store UI components in figure's UserData
    userData = struct('imagePathText', imagePathText, 'languageDropdown', languageDropdown, 'outputText', outputText, 'imagePath', '', 'confidenceToggle', confidenceToggle, 'confidences', []);
    set(fig, 'UserData', userData);

    function uploadImage(~, ~)
        [filename, pathname] = uigetfile({'*.png;*.jpg;*.jpeg', 'Image Files (*.png, *.jpg, *.jpeg)'});
        if filename ~= 0
            fullPath = fullfile(pathname, filename);
            userData.imagePath = fullPath;
            set(imagePathText, 'String', fullPath);
            set(fig, 'UserData', userData);
        end
    end

    function extractText(~, ~)
        userData = get(fig, 'UserData');
        imagePath = userData.imagePath;
        if isempty(imagePath)
            set(outputText, 'String', 'Please upload an image first.');
            return;
        end

        languages = get(languageDropdown, 'String');
        selectedLanguage = languages{get(languageDropdown, 'Value')};
        showConfidences = get(confidenceToggle, 'Value');

        try
            I = imread(imagePath);
            ocrResults = ocr(I, 'Language', selectedLanguage);
            
            % Extract the text and confidences
            extractedText = ocrResults.Text;
            confidences = ocrResults.CharacterConfidences;

            % Store confidences in userData
            userData.confidences = confidences;
            set(fig, 'UserData', userData);

            % Remove any empty lines and join the text
            lines = strsplit(extractedText, '\n');
            nonEmptyLines = lines(~cellfun('isempty', lines));
            
            if showConfidences
                % Format text with confidences
                formattedText = '';
                charIndex = 1;
                for i = 1:length(nonEmptyLines)
                    line = nonEmptyLines{i};
                    for j = 1:length(line)
                        formattedText = [formattedText, line(j)];
                        if ~isnan(confidences(charIndex))
                            formattedText = [formattedText, sprintf('(%.2f)', confidences(charIndex)*100)];
                        end
                        charIndex = charIndex + 1;
                    end
                    formattedText = [formattedText, '\n'];
                    charIndex = charIndex + 1; % Skip newline character
                end
            else
                formattedText = strjoin(nonEmptyLines, '\n');
            end

            set(outputText, 'String', formattedText);
        catch e
            set(outputText, 'String', sprintf('Error: %s', e.message));
        end
    end

    function showConfidenceGraph(~, ~)
        userData = get(fig, 'UserData');
        confidences = userData.confidences;
        
        if isempty(confidences)
            msgbox('Please extract text first.', 'No Confidence Data', 'warn');
            return;
        end
        
        % Plot confidence scores
        figure;
        bar(confidences * 100);
        xlabel('Characters');
        ylabel('Confidence Scores');
        title('Character Confidence Scores from OCR');
        ylim([0 100]);
        grid on;
    end
end

function languages = getAllLanguages()
    languages = {
        'english', 'japanese', 'afrikaans', 'albanian', 'ancientgreek', 'arabic', 'azerbaijani', 'basque', 'belarusian', 'bengali', ...
        'bulgarian', 'catalan', 'cherokee', 'chinesesimplified', 'chinesetraditional', 'croatian', 'czech', ...
        'danish', 'dutch', 'english', 'esperanto', 'esperantoalternative', 'estonian', 'finnish', 'frankish', ...
        'french', 'galician', 'german', 'greek', 'hebrew', 'hindi', 'hungarian', 'icelandic', 'indonesian', ...
        'italian', 'italianold', 'japanese', 'kannada', 'korean', 'latvian', 'lithuanian', 'macedonian', ...
        'malay', 'malayalam', 'maltese', 'mathequation', 'middleenglish', 'middlefrench', 'norwegian', ...
        'polish', 'portuguese', 'romanian', 'russian', 'serbianlatin', 'slovakian', 'slovenian', 'spanish', ...
        'spanishold', 'swahili', 'swedish', 'tagalog', 'tamil', 'telugu', 'thai', 'turkish', 'ukrainian'
    };
end