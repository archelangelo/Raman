% Map navigator
% Where you use arrow buttons to navigate through the mapped points

function lineNavigator( line, k, data, coord, dx, ymax )

    figure('KeyPressFcn', ...
        {@moveRamanPoint, k, data, coord, dx, ymax});
    subplot(2, 1, 1)
    plot(coord, line, 'o-')
    xlim([coord(1), coord(end)])
    hold on
    plot([coord(1) coord(1)], get(gca, 'ylim'), 'r-', 'LineWidth', 1.5)

    idx = 1;
    subplot(2, 1, 2)
    plot(k, data(idx, :))
    xlim([1200 3400])
    ylim([-5 ymax])

end


% Key press callback function

function moveRamanPoint( src, evtdata, ...
    k, data, coord, dx, ymax )

    ax = src.Children;
    lines = ax(2).Children;
    xp = lines(1).XData;
    idx = round((xp(1)-coord(1))/dx + 1);
    n = size(coord, 1);

    switch evtdata.Key
        case 'leftarrow'
            if idx > 1
                idx = idx - 1;
            end
        case 'rightarrow'
            if idx < n
                idx =idx + 1;
            end
    end
    
    
    plot(ax(1), k, data(idx, :))
    xlim([1200 3400])
    ylim([-5 ymax])
    % Plot the coordinate on the map
    lines(1).XData = [coord(idx), coord(idx)];

end

