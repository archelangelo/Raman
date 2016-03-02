function hdl = RamanPlot(A, Yf, ele, showpk, p, w)
% This script plots a Raman spectrum/spectra object A
% with elevation of one from another.

    if ~exist('showpk', 'var')
        showpk = false;
    end
    color = 'krb';
    grid on
    grid minor
    hold on
    bs = 0;
    for i = 1: size(A, 3)
        plot(A(:, 1, i), A(:, 2, i) + bs, color(mod(i - 1, 3) +1));
        if (showpk)
            plot(Yf(:, 1, i), Yf(:, 2, i) + bs, 'm');
            text(2900, bs + 0.4 * ele,...
                sprintf('FWHM = %0.3f\n@%0.3f', w(i), p(i)),...
                'FontSize', 18);
        end
        bs = bs + ele;
    end
    set(gca, 'FontSize', 18);
    axis([1200, 3400, -Inf, Inf]);
    xlabel('Raman Shift (cm^{-1})');
    ylabel('Intensity (a.u.)');
    hold off
end