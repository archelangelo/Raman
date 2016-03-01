function [p, h, w, bs, hfmx, l, r] = PeakAnalyse(A, st, ed)
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
    [m, i] = max(A(:, 2));
    p = A(i, 1);
    bs = (mean(A(1:20, 2)) + mean(A(end-24:end))) / 2;
    hfmx = (m + bs) / 2;
    h = m - bs;
    
    % Looking for FWHM
    k = 1;
    while k < size(A, 1) && A(k, 2) < hfmx
        k = k + 1;
    end
    l = LinearFind(A(k-1:k, 1), A(k-1:k, 2), hfmx);
    k = size(A, 1);
    while k > 1 && A(k, 2) < hfmx
        k = k - 1;
    end
    r = (A(k, 1) + A(k + 1, 1)) / 2;
    r = LinearFind(A(k:k+1, 1), A(k:k+1, 2), hfmx);
    w = r - l;
end