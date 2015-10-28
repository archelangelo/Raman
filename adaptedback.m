function rt = adaptedback(back, data)
% Adapt the background's x coord according to the data

rt = data;
sb = size(back);
sb = sb(1);
sd = size(data);
sd = sd(1);
j = 1;
for i = 1:sd
    while (j + 1 < sb) && (back(j+1,1) < data(i,1))
        j = j + 1;
    end
    if (back(j+1,1) < data(i,1))
        break;
    end
    x1 = back(j,1);
    y1 = back(j,2);
    x2 = back(j+1,1);
    y2 = back(j+1,2);
    x = data(i,1);
    rt(i,2) = (x-x1)*(y1-y2)/(x1-x2)+y1;
end
end
    
        