function [filenames, tokens] = nameMatch(pattern, varargin)
%Finding the filenames that matches the pattern string and returns the
%tokens if findToken is true
%   nameMatch(pattern, [findTokens, path])
    % Parse input args
    defaultPath = './';
    defaultFindTokens = false;
    p = inputParser;
    addRequired(p, 'pattern', @(x) ischar(x) || isstring(x));
    addOptional(p, 'findTokens', defaultFindTokens, @islogical);
    addOptional(p, 'path', defaultPath, @(x) ischar(x) || isstring(x));
    parse(p, pattern, varargin{:});
    pattern = p.Results.pattern;
    findTokens = p.Results.findTokens;
    path = p.Results.path;
    
    files = dir(path);
    filenames = string({files.name});
    filenames = strjoin(filenames, '\n');
    filenames = regexp(filenames, pattern, 'match', 'lineanchors')';
    clear files
    % Find tokens if findToken is true
    if findTokens
        tokens = regexp(filenames, pattern, 'tokens', 'once');
        tokens = strsplit(char(strjoin(string(tokens), ' ')));
    else
        tokens = {};
    end

end

