function RamanPlot(A, ele)
% This script plots a Raman spectrum/spectra object A
% with elevation of one from another.

    color = 'krbc';
    grid on
    grid minor
    hold on
    for i = 1: size(A, 3)
        plot(A(:, 1, i), A(:, 2, i) + (i - 1) * ele, color(mod(i - 1, 4) + 1));
    end
    hold off
end