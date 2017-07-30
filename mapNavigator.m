% Map navigator
% Where you use arrow buttons to navigate through the mapped points

function mapNavigator( map, k, data, coord, dx, lx, ly, n, ymax )

figure('KeyPressFcn', ...
    {@moveRamanPoint, k, data, coord, dx, lx, ly, n, ymax});
subplot(2, 1, 1)
imagesc([coord(1, 2) coord(lx, 2)], [coord(1, 1) coord(end, 1)], map)
colormap jet
axis equal
axis([-inf inf -inf inf])
hold on
plot(coord(1, 2), coord(1, 1), 'w+', 'MarkerSize', 5, 'LineWidth', 1)

idx = 1;
subplot(2, 1, 2)
plot(k, data(idx, :))
xlim([1200 3400])
ylim([-5 ymax])

end


% Key press callback function

function moveRamanPoint( src, evtdata, ...
    k, data, coord, dx, lx, ly, n, ymax )

    ax = src.Children;
    lines = ax(2).Children;
    xp = lines(1).XData;
    yp = lines(1).YData;

    switch evtdata.Key
        case 'leftarrow'
            if xp > coord(1, 2)
                xp = xp - dx;
            end
        case 'rightarrow'
            if xp < coord(end, 2)
                xp = xp + dx;
            end
        case 'uparrow'
            if yp > coord(1, 1)
                yp = yp - dx;
            end
        case 'downarrow'
            if yp < coord(end, 1)
                yp = yp + dx;
            end
    end
    
    idx = (yp-coord(1, 1))/dx*lx + (xp-coord(1, 2))/dx + 1;
    plot(ax(1), k, data(idx, :))
    xlim([1200 3400])
    ylim([-5 ymax])
    % Plot the coordinate on the map
    lines(1).XData = xp;
    lines(1).YData = yp;

end

