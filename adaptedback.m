function rt = adaptedback(back, data)
% Adapt the background's x coord according to the data

rt = data;
rt(:, 2) = interp1(back(:, 1), back(:, 2), data(:, 1));

end
    
        