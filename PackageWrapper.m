function [A, C] = PackageWrapper(filename, background, ele)
% This function takes in a Raman file and extract the
% spectrum automatically and uses the RamanPackage to
% analyse it.

    X = importdata(filename);
    B = importdata(background);
    if isnan(X(1, 1))
        A = zeros(size(X, 2) - 1, 2);
        for i = 2:size(X, 1)
            A(:, :, i - 1) = [X(1, 2:end); X(i, 2:end)]';
        end
    else
        A = X;
    end
    C = RamanPackage(B, ele, A);
end