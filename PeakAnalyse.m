function [p, w, Y] = PeakAnalyse(A, st, ed)
% This script analyses the peak in Raman spectrum between st and ed.
% Suggested st and ed for 2D peak are 2570 to 2875
% It returns the location of the peak and its height and FWHM
    % Determine the starting and ending points

    mask = A(:, 1) >= st & A(:, 1) <= ed;
    
    A = A(mask, :);
    Y = A(:, 1);
    [Y(:, 2), Params] = lorentzfit(A(:, 1), A(:, 2),...
    [4443, 2700, 313, 0]);
    p = Params(2);
    w = 2 * sqrt(Params(3));
end