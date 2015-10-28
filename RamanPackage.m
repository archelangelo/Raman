function [varargout] = RamanPackage(B, ele, varargin)
% A packege calculation for Raman spectra.
% It takes in the Background B, the elevated distance for plotting ele
% and various numbers of spectra and the coresponding color.
% example: 
% [C1, C2] = RamanPackage(B, 50, A1, A2, 'k', 'r');

    nVargs = length(varargin) / 2;
    fprintf('Input %d spectra\n', nVargs);
    hold on;
    grid on;
    grid minor;
    for k = 1:nVargs
        C = BackSub(varargin{k}, B, 1700, 2100, 0, false);
        varargout{k} = [varargin{k}(:, 1), C];
        plot(varargin{k}(:, 1), C + ele * (k - 1), varargin{k + nVargs});
        [p, h, w] = PeakAnalyse(varargout{k}, 2570, 2875);
        fprintf('Spectrum %d\n', k);
        fprintf('\tPeak at %.3f\n\tHeight: %.3f\n\tFWHM: %.3f\n', p, h, w);
    end
end
    