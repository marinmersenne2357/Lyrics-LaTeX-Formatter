function lyricsInputGUIV2()
    % buildResults = compiler.build.standaloneApplication(lyricsInputGUIVersion2.m);
    % Create the figure window
    fig = uifigure('Name', 'Lyrics Input', 'Position', [100 100 600 400]);

    % Create input fields
    title1Label = uilabel(fig, 'Text', 'Title 1:', 'Position', [20 360 100 22]);
    title1Field = uieditfield(fig, 'text', 'Position', [130 360 450 22]);

    title2Label = uilabel(fig, 'Text', 'Title 2:', 'Position', [20 330 100 22]);
    title2Field = uieditfield(fig, 'text', 'Position', [130 330 450 22]);

    authorLabel = uilabel(fig, 'Text', 'Author:', 'Position', [20 300 100 22]);
    authorField = uieditfield(fig, 'text', 'Position', [130 300 450 22]);

    jpLabel = uilabel(fig, 'Text', 'Japanese Lyrics:', 'Position', [20 270 100 22]);
    jpField = uitextarea(fig, 'Position', [20 180 560 90]);

    rmLabel = uilabel(fig, 'Text', 'Romaji Lyrics:', 'Position', [20 150 100 22]);
    rmField = uitextarea(fig, 'Position', [20 60 560 90]);

    enLabel = uilabel(fig, 'Text', 'English Lyrics:', 'Position', [20 30 100 22]);
    enField = uitextarea(fig, 'Position', [20 -60 560 90]);

    % Create buttons
    saveTexBtn = uibutton(fig, 'Text', 'Save as .tex', 'Position', [700 200 100 22], ...
        'ButtonPushedFcn', @(btn,event) saveLyrics2Tex());
    % Create save button
    saveTxtBtn = uibutton(fig, 'Text', 'Save as .txt', 'Position', [700 100 100 22], ...
        'ButtonPushedFcn', @(btn,event) saveLyrics2Txt(title1Field, title2Field, authorField, jpField, rmField, enField));
    % Add new button for example text
    exampleBtn = uibutton(fig, 'Text', 'Show Example', 'Position', [700 0 100 22], ...
        'ButtonPushedFcn', @(btn,event) showExampleText());

    fig.WindowState = 'maximized';
end

function showExampleText()
    % Create a new figure for the example text
    exampleFig = uifigure('Name', 'Example Text', 'Position', [200 200 500 600]);
    
    % Create a text area to display the example
    exampleText = uitextarea(exampleFig, 'Position', [20 20 460 560], 'Editable', 'off');
    
    % Load and display the example text
    exampleContent = ['title1=津軽海峡冬景色\n\n' ...
        'title2=Wintery Straits of Tsugaru\n' ...
        'author=Sayuri Ishikawa 石川さゆり\n\n' ...
        'jp=上野発の夜行列車　おりた時から\n' ...
        '青森駅は雪の中\n' ...
        '北へ帰る人の群れは　誰も無口で\n' ...
        '海鳴りだけをきいている\n' ...
        '私もひとり連絡船に乗り\n' ...
        'こごえそうな鴎見つめ泣いていました\n' ...
        'ああ津軽海峡・冬景色\n\n' ...
        'ごらんあれが竜飛岬　北のはずれと\n' ...
        '見知らぬ人が指をさす\n' ...
        '息でくもる窓のガラスふいてみたけど\n' ...
        'はるかにかすみ　見えるだけ\n' ...
        'さよならあなた　私は帰ります\n' ...
        '風の音が胸をゆする　泣けとばかりに\n' ...
        'ああ津軽海峡・冬景色\n\n' ...
        'さよならあなた　私は帰ります\n' ...
        '風の音が胸をゆする　泣けとばかりに\n' ...
        'ああ津軽海峡・冬景色\n\n' ...
        'rm=ueno hatsu no yakouressha orita toki kara\n' ...
        'aomori eki wa yuki no naka\n' ...
        'kita e kaeru hito no mure wa dare mo mukuchi de\n' ...
        'uminari dake o kiiteiru\n' ...
        'watashi mo hitori renrakusen ni nori\n' ...
        'kogoe sou na kamome mitsume naiteimashita\n' ...
        'aa tsugaru kaikyou fuyugeshiki\n\n' ...
        'goran are ga tappizaki kita no hazure to\n' ...
        'mishiranu hito ga yubi o sasu\n' ...
        'iki de kumoru mado no garasu fuite mita kedo\n' ...
        'haruka ni kasumi mieru dake\n' ...
        'sayonara anata watashi wa kaerimasu\n' ...
        'kaze no oto ga mune o yusuru nake to bakari ni\n' ...
        'aa tsugaru kaikyou fuyugeshiki\n\n' ...
        'sayonara anata watashi wa kaerimasu\n' ...
        'kaze no oto ga mune o yusuru nake to bakari ni\n' ...
        'aa tsugaru kaikyou fuyugeshiki\n\n' ...
        'en=Since I stepped off the night train\n' ...
        'departing from Ueno,\n' ...
        'Aomori Station was within the snow\n' ...
        'In the crowd of people returning north,\n' ...
        'everyone is silent.\n\n' ...
        'I hear only the rumbling of the sea\n' ...
        'I, too, ride alone on a connecting ferry.\n' ...
        'I gazed at the seagulls that seemed\n' ...
        'like they would freeze and cried.\n' ...
        'Ah, the Tsugaru Strait winter scenery…\n\n' ...
        'Look, that is Cape Tappi, at the outskirts of the north.\n' ...
        'People I do not recognize point their fingers.\n' ...
        'I tried wiping the window glass\n' ...
        'that my breath clouded up,\n' ...
        'But I see only haze in the distance.\n' ...
        'Goodbye, my dear. I am going back.\n' ...
        'The sound of the wind shakes my chest,\n' ...
        'and all I can do is cry.\n' ...
        'Ah, the Tsugaru Strait winter scenery…\n\n' ...
        'Goodbye, my dear. I am going back.\n' ...
        'The sound of the wind shakes my chest,\n' ...
        'and all I can do is cry.\n' ...
        'Ah, the Tsugaru Strait winter scenery…'];
    % Interpret escape sequences and set the example text content
    interpretedContent = sprintf(strrep(exampleContent, '\n', newline));
    exampleText.Value = interpretedContent;

    exampleFig.WindowState = 'maximized';
end



function [content, defaultFileName] = createContent(title1Field, title2Field, authorField, jpField, rmField, enField)
    % Get the input values
    title1 = title1Field.Value;
    title2 = title2Field.Value;
    author = authorField.Value;
    jpLyrics = jpField.Value;
    rmLyrics = rmField.Value;
    enLyrics = enField.Value;

    % Create the content string
    content = sprintf('title1=%s\n\ntitle2=%s\nauthor=%s\n\njp=%s\nrm=%s\nen=%s', ...
        title1, title2, author, strjoin(jpLyrics, '\n'), strjoin(rmLyrics, '\n'), strjoin(enLyrics, '\n'));

  % Create default file name
    defaultFileName = sprintf('%s_%s_%s', title1, title2, author);
    % Replace any characters that might be invalid in file names
    defaultFileName = regexprep(defaultFileName, '[<>:"/\\|?*]', '_');

end


function saveLyrics2Txt(title1Field, title2Field, authorField, jpField, rmField, enField)
    [content, defaultFileName] = createContent(title1Field, title2Field, authorField, jpField, rmField, enField);

    % Open a file dialog to choose where to save the file
    [file, path] = uiputfile({'*.txt','Text Files (*.txt)'},'Save Lyrics File', append(defaultFileName, '.txt'));
    if isequal(file, 0) || isequal(path, 0)
        disp('User canceled the save operation');
    else
        % Write the content to the file
        fullPath = fullfile(path, file);
        fid = fopen(fullPath, 'w');
        fprintf(fid, '%s', content);
        fclose(fid);
        disp(['File saved successfully: ' fullPath]);
    end
end



function saveLyrics2Tex()
    % Open a file dialog to choose the input .txt file
    [inputFile, inputPath] = uigetfile({'*.txt','Text Files (*.txt)'},'Select Input Lyrics File');
    if isequal(inputFile, 0) || isequal(inputPath, 0)
        disp('User canceled the input file selection');
        return;
    end
    
    % Construct full input file path
    inputFullPath = fullfile(inputPath, inputFile);
    
    % Extract the file name without extension for default output name
    [~, defaultFileName, ~] = fileparts(inputFile);
    
    % Open a file dialog to choose where to save the output .tex file
    [outputFile, outputPath] = uiputfile({'*.tex','LaTeX Files (*.tex)'},'Save LaTeX File', [defaultFileName, '.tex']);
    if isequal(outputFile, 0) || isequal(outputPath, 0)
        disp('User canceled the output file selection');
        return;
    end
    
    % Construct full output file path
    outputFullPath = fullfile(outputPath, outputFile);
    
    % Call the text2latex function
    text2latex(inputFullPath, outputFullPath);
    
    disp(['LaTeX file saved successfully: ' outputFullPath]);
end






function text2latex(inputFile, outputFile)
    % Read the input text file
    fileID = fopen(inputFile, 'r');
    content = textscan(fileID, '%s', 'Delimiter', '\n', 'TextType', 'string');
    fclose(fileID);
    content = content{1};
    
    % Open the output LaTeX file
    outFile = fopen(outputFile, 'w');
    
    % Write LaTeX header
    fprintf(outFile, '\\documentclass{ltjarticle}\n');
    fprintf(outFile, '\\usepackage{geometry}\n');
    fprintf(outFile, '\\usepackage{paracol}\n');
    fprintf(outFile, '\\usepackage{hyperref}\n');
    fprintf(outFile, '\\geometry{a4paper, margin=1in}\n');
    
    % Extract title1, title2, author
    % Note: 'title2' is a subtitle implemented using the latex 'author'.
    title1Index = find(startsWith(content, 'title1='), 1);
    title2Index = find(startsWith(content, 'title2='), 1);
    authorIndex = find(startsWith(content, 'author='), 1);
    if ~isempty(title1Index)
        title1 = extractAfter(content(title1Index), 'title1=');
    else
        title1 = '--NO INPUT FOUND FOR [title1=]';
    end
        
    if ~isempty(title2Index)
        title2 = extractAfter(content(title2Index), 'title2=');
    else
        title2 = '--NO INPUT FOUND FOR [title2=]';
    end

    if ~isempty(authorIndex)
        author = extractAfter(content(authorIndex), 'author=');
    else
        author = '--NO INPUT FOUND FOR [author=]';
    end

    disp(['Class: ', class(title1)])


    fprintf(outFile, '\\title{%s}\n', escapeLatex(title1));
    fprintf(outFile, '\\author{%s}\n', strjoin([escapeLatex(title2), '-', escapeLatex(author)]));
    fprintf(outFile, '\\begin{document}\n');
    fprintf(outFile, '\\pagenumbering{gobble}\n');
    fprintf(outFile, '\\setlength{\\parindent}{0pt}\n');
    fprintf(outFile, '\\maketitle\n');
    fprintf(outFile, '\\setcolumnwidth{0.4\\textwidth, 0.3\\textwidth}\n');
    fprintf(outFile, '\\begin{paracol}{2}\n'); % begin 2 column layout

    for i = 1:length(content)
         line = content(i);
         if startsWith(line, 'jp=')
             jpStartIndex = i;
             content(i) = extractAfter(line, 'jp=');
         elseif startsWith(line, 'rm=')
             rmStartIndex = i;
             content(i) = extractAfter(line, 'rm=');
         elseif startsWith(line, 'en=')
             enStartIndex = i;
             content(i) = extractAfter(line, 'en=');
         end
    end
    
    jpLines = '';
    rmLines = '';
    enLines = '';
    

    % Extract jp lines
    for i = jpStartIndex:rmStartIndex-1
        jpLines = [jpLines, content(i)];
    end
    
    % Extract rm lines
    for i = rmStartIndex:enStartIndex-1
        rmLines = [rmLines, content(i)];
    end
    
    % Extract en lines
    for i = enStartIndex:length(content)
        enLines = [enLines, content(i)];
    end
    
    disp(length(jpLines));
    disp(length(rmLines));
    disp(length(enLines));

    if length(jpLines) ~= length(rmLines)
        fprintf('Warning: Japanese=%d lines vs Romaji=%d\n', length(jpLines), length(rmLines));
        return;
    end
    intraParagraphSpace = '';
    for i = 1:length(jpLines)
        % disp(strlength(jpLines(i)));
        % if the next line is not a blank paragraph space, set '\n' to
        % create the paragraph space
        if i < length(jpLines)
            if strlength(jpLines(i+1)) > 1
            intraParagraphSpace = '\n';
            end
        end
        if strlength(jpLines(i)) < 1
            if i > 1
                fprintf(outFile, '\\\\ \\\\ \n');
            end
        else
            fprintf(outFile, strcat(jpLines(i), '\n\n', rmLines(i), intraParagraphSpace, '\n'));
            intraParagraphSpace = '';
        end
        
    end

    fprintf(outFile, '\\switchcolumn');
    for i = 1:length(enLines)
        if strlength(enLines(i)) < 1
            if i > 1
                fprintf(outFile, '\\\\ \\\\ \n');
            end
        else
            fprintf(outFile, strcat('\n', enLines(i), '\n'));
        end
        % fprintf(outFile, strjoin([enLines(i), '\n']));
    end

    % End two-column layout and document
    fprintf(outFile, '\\end{paracol}\n');
    fprintf(outFile, '\\end{document}');
    
    % Close the output file
    fclose(outFile);
    
    disp('Conversion complete!');
end

function escaped = escapeLatex(str)
    % Escape special LaTeX characters
    special = {'&', '%', '$', '#', '_', '{', '}', '~', '^', '\\'};
    escaped = str;
    for i = 1:length(special)
        escaped = strrep(escaped, special{i}, ['\' special{i}]);
    end
end