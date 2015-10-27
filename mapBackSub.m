function C = mapBackSub(raw, B)
% 2D map back ground subtraction
% input raw is the data imported directly from 2Dmapping file using
% importdata().

raw = raw';
C = raw(1: 2, :);
A = raw(3: end, :);
B = adaptedback(B, A(:, 1: 2));
for i = 2: size(A, 2)
    A(:, i) = BackSub([A(:, 1), A(:, i)], B, 1700, 2100, 0, false);
end
C = [C; A];
C = C';
end