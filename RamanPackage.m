function X = RamanPackage(B, ele, A, showpk, findpk)
% A packege calculation for Raman spectra.
% It takes in the Background B, the elevated distance for plotting ele
% and various numbers of spectra and the coresponding color.
% example: 
% [C1, C2] = RamanPackage(B, 50, A1, A2, 'k', 'r');

    if ~exist('showpk', 'var')
        showpk = false;
    end
    if ~exist('findpk', 'var')
        findpk = true;
    end
    n = size(A, 3);
    X = zeros(size(A));
    p = zeros(1, n);
    w = zeros(1, n);
    fprintf('Input %d spectra\n', n);
    for k = 1:n
        [C, ~, shft] = BackSub(A(:, :, k), B, 1700, 2100, nan, false);
        X(:, :, k) = [A(:, 1, k), C];
        if (findpk)
            [p(k), w(k), Y(:, :, k)] = PeakAnalyse(X(:, :, k), 2500, 2900);
            fprintf('Spectrum %d\n\tBackground Shifted:%d\n', k, shft);
            fprintf('\tPeak at %.3f\n\tFWHM: %.3f\n', p(k), w(k));
        end
    end
    RamanPlot(X, Y, ele, showpk, p, w);
end
    