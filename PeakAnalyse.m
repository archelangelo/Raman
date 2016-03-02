function [p, w, Y] = PeakAnalyse(A, st, ed)
% This script analyses the peak in Raman spectrum between st and ed.
% Suggested st and ed for 2D peak are 2570 to 2875
% It returns the location of the peak and its height and FWHM
    % Determine the starting and ending points
    k = 1;
    while k < size(A, 1) && A(k, 1) < st
        k = k + 1;
    end
    l = k;
    while k < size(A, 1) && A(k, 1) < ed
        k = k + 1;
    end
    r = k;
    
    A = A(l:r, :);
    Y = A(:, 1);
    [Y(:, 2), Params] = lorentzfit(A(:, 1), A(:, 2),...
    [4443, 2700, 313, 0]);
    p = Params(2);
    w = 2 * sqrt(Params(3));
end