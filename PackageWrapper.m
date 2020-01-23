function [A, C, gs2ratio] = PackageWrapper(filename, background, ele, showpk, findpk)
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
    
    %% Determining the dimension of data
    if isnan(X(1, 1))
        if isnan(X(1, 2))
            A = zeros(size(X, 2) - 2, 2, size(X, 1)-1);
            for i = 2:size(X, 1)
                A(:, :, i - 1) = [X(1, 3:end); X(i, 3:end)]';
            end
        else
            A = zeros(size(X, 2) - 1, 2, size(X, 1)-1);
            for i = 2:size(X, 1)
                A(:, :, i - 1) = [X(1, 2:end); X(i, 2:end)]';
            end
        end
    else
        A = X;
    end
    
    %%
    B(:, 2) = B(:, 2) - min(B(:, 2));
    A(:, 2, :) = A(:, 2, :) - ...
        repmat(min(A(:, 2, :), [], 1), size(A, 1), 1, 1);
    C = RamanPackage(B, ele, A, showpk, findpk);
    % Calculate S1/S2 ratio of background
    mask_S1 = B(:, 1) > 1460 & B(:, 1) < 1660;
    mask_S2 = B(:, 1) > 1660 & B(:, 1) < 1960;
    s12ratio_back = trapz(B(mask_S1, 1), B(mask_S1, 2), 1) / ...
        trapz(B(mask_S2, 1), B(mask_S2, 2), 1);
    % Calculate S1/S2 ratio of specimen
    mask_S1 = A(:, 1) > 1460 & A(:, 1) < 1660;
    mask_S2 = A(:, 1) > 1660 & A(:, 1) < 1960;
    s12ratio = trapz(A(mask_S1, 1, 1), A(mask_S1, 2, :), 1) ./ ...
        trapz(A(mask_S2, 1, 1), A(mask_S2, 2, :), 1);
    s12ratio = reshape(s12ratio, 1, size(A, 3));
    gs2ratio = s12ratio - repmat(s12ratio_back, 1, size(s12ratio, 2));
    disp('G/S_2 ratio:');
    disp(gs2ratio);
end