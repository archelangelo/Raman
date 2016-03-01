function RamanPlot(A, ele, showpk, p, h, bs, hfmx, l, r)
% This script plots a Raman spectrum/spectra object A
% with elevation of one from another.

    if ~exist('showpk', 'var')
        showpk = false;
    end
    color = 'krbc';
    grid on
    grid minor
    hold on
    for i = 1: size(A, 3)
        plot(A(:, 1, i), A(:, 2, i) + (i - 1) * ele,...
            color(mod(i - 1, 4) +1));
        if (showpk)
            plot([l(i), p(i), r(i)],[hfmx(i), bs(i)+h(i),...
                hfmx(i)]+(i-1)*ele, 'k+');
            refline(0, bs(i)+(i-1)*ele);
        end
    end
    hold off
end