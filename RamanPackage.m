function X = RamanPackage(B, ele, A)
% A packege calculation for Raman spectra.
% It takes in the Background B, the elevated distance for plotting ele
% and various numbers of spectra and the coresponding color.
% example: 
% [C1, C2] = RamanPackage(B, 50, A1, A2, 'k', 'r');

    n = size(A, 3);
    X = zeros(size(A));
    fprintf('Input %d spectra\n', n);
    for k = 1:n
        C = BackSub(A(:, :, k), B, 1700, 2100, nan, false);
        X(:, :, k) = [A(:, 1, k), C];
        [p, h, w] = PeakAnalyse(X(:, :, k), 2570, 2875);
        fprintf('Spectrum %d\n', k);
        fprintf('\tPeak at %.3f\n\tHeight: %.3f\n\tFWHM: %.3f\n', p, h, w);
    end
    RamanPlot(X, ele);
end
    