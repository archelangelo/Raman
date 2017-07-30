function [A, C] = PackageWrapper(filename, background, ele, showpk, findpk)
% This function takes in a Raman file and extract the
% spectrum automatically and uses the RamanPackage to
% analyse it.

    if ~exist('showpk', 'var')
        showpk = false;
    end
    if ~exist('findpk', 'var')
        findpk = true;
    end
    X = importdata(filename);
    B = importdata(background);
    if isnan(X(1, 1))
        if isnan(X(1, 2))
            A = zeros(size(X, 2) - 2, 2);
            for i = 2:size(X, 1)
                A(:, :, i - 1) = [X(1, 3:end); X(i, 3:end)]';
            end
        else
            A = zeros(size(X, 2) - 1, 2);
            for i = 2:size(X, 1)
                A(:, :, i - 1) = [X(1, 2:end); X(i, 2:end)]';
            end
        end
    else
        A = X;
    end
    C = RamanPackage(B, ele, A, showpk, findpk);
    mask_S1 = B(:, 1) > 1460 & B(:, 1) < 1660;
    mask_S2 = B(:, 1) > 1660 & B(:, 1) < 1960;
    s12ratio_back = trapz(B(mask_S1, 1), B(mask_S1, 2), 1) / ...
        trapz(B(mask_S2, 1), B(mask_S2, 2), 1);
    s12ratio = trapz(A(mask_S1, 1), A(mask_S1, 2:end), 1) ./ ...
        trapz(A(mask_S2, 1), A(mask_S2, 2:end), 1);
    gs2ratio = s12ratio - s12ratio_back;
    disp('G/S_1 Ratio:');
    disp(gs2ratio);
end