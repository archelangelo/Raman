function [d4, sqd, shft, d3] = BackSub(X, Y, st, nd, shft, plt)
% Subtraction of background
%   This function fits the background to the data first and then subtracts
%   it from the data
% st and nd reference number 1700 to 2100
% If shft input is NaN, it will automatically find the best shift from -5
% to 5

    if isnan(shft)
        sqdmin = inf;
        for i = -5:5
            [~, sqd, ~] = BackSub(X, Y, st, nd, i, false);
            if sqd < sqdmin
                sqdmin  = sqd;
                shft = i;
            end
        end
        [d4, sqd, ~] = BackSub(X, Y, st, nd, shft, plt);
    else
        d0 = X(:, 1);
        d1 = X(:, 2);
        if size(X, 1) ~= size(Y, 1) || X(1, 1) ~= Y(1, 1)
            Y = adaptedback(Y, X);
        end
        d2 = Y(:, 2);
        i = 1;
        while i < size(d0, 1) && d0(i) < st
            i = i + 1;
        end
        l = i;
        while i < size(d0, 1) && d0(i) < nd
            i = i + 1;
        end
        m = i;

        if shft > 0
            d2 = [nan(shft, 1); d2(1: end - shft)];
        elseif shft < 0
            d2 = [d2(1 - shft: end); nan(-shft, 1)];
            l = l + shft;
            m = m + shft;
        end
        x = d1(l: m);
        y = d2(l: m);
        A = [sum(y.^2), sum(y); sum(y), size(y, 1)];
        B = [x'*y; sum(x)];
        sol = A\B;
        d3 = d2 .* sol(1) + sol(2);
        d4 = d1 - d3;
        diff = x - (y .* sol(1) + sol(2));
        sqd = diff' * diff;
        if plt
            plot(d0, d1, 'b');
            hold;
            plot(d0, d3, 'r');
            plot(d0, d4, 'k');
        end
    end

end

