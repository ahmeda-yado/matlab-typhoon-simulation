function make_ido
    for ido = 0:15:90
        kaku = asin((90 - ido)/90);
        r = cos(kaku);
        x = -r:0.01:r;
        y = x.*0;    
        z = y + ((90 - ido)/90);
        for i = 1:length(x)
            y(i) = sqrt(r^2 - x(i)^2);
        end    
        x = [x flip(x)];  % flip(x):xの要素の順序を反転する
        y = [y -flip(y)];
        z = [z z];
        
        p = plot3(x*100, y*100, z*100, 'Color', [0.8 0.8 0.8]);
        if z(1) == 0
            p.Color = 'red';
            p.LineWidth = 1;
            continue;
        end
        plot3(x*100, y*100, -z*100, ':k', 'LineWidth', 0.1);
    end
end