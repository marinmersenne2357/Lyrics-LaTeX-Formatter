function result = extractTextFromImage(varargin)
    % Check if help is requested
    if any(strcmpi(varargin, 'HELP'))
        result = getHelpText();
        return;
    end

    imagePath = varargin{1};
    outputOption = varargin{2};
    language = varargin{3};
    
    % Check if the image file exists
    if ~isfile(imagePath)
        result = 'Error: Image file not found.';
        return;
    end

    % Read the image
    try
        I = imread(imagePath);
    catch
        result = 'Error: Unable to read the image file.';
        return;
    end

    % BW = imbinarize(I);
    % figure
    % imshowpair(I,BW,"montage")
    
    % Perform OCR
    ocrResults = ocr(I, 'Model', language);

    % Extract the recognized text, confidences, and bounding boxes
    extractedText = ocrResults.Text;
    confidences = ocrResults.CharacterConfidences;
    % boundingBoxes = ocrResults.CharacterBoundingBoxes;
    % Plot confidence scores
    figure;
    bar(confidences*100);
    xlabel('Characters');
    ylabel('Confidence Scores');
    title('Character Confidence Scores from OCR');
    ylim([0 100]);
    grid on;

    formattedText = '';
    for i = 1:length(extractedText)
        if ~isempty(extractedText(i))
            formattedText = sprintf('%s%s', formattedText, extractedText(i));
        end
    end
    
    % Process based on the outputOption
    if strcmpi(outputOption, 'STRING')
        result = formattedText;
    elseif endsWith(outputOption, '.txt', 'IgnoreCase', true)
        try
            % Write the extracted text to a file
            fileID = fopen(outputOption, 'w');
            fprintf(fileID, '%s', formattedText);
            fclose(fileID);
            result = sprintf('Text extracted and saved to %s', outputOption);
        catch
            result = 'Error: Unable to save the text to the specified file.';
        end
    else
        result = 'Error: Invalid output option. Use "STRING" or a valid .txt file path.';
    end
end


function helpText = getHelpText()
    helpText = sprintf(['extractTextFromImage - Extract text from image using OCR\n\n', ...
        'Syntax: result = extractTextFromImage(imagePath, outputOption, language)\n\n', ...
        'Inputs:\n', ...
        '  imagePath    - String, path to input image file\n', ...
        '  outputOption - String, "STRING" for text output,\n', ...
        '                 "*.txt" to save to file, or "HELP"\n', ...
        '  language     - String, e.g., "Japanese", "English", etc.\n\n', ...
        'Outputs:\n', ...
        '  result       - Extracted text with confidence scores, success/error message, or help text\n']);
end