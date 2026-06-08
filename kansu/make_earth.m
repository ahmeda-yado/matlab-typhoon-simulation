function p02 = make_earth(stl_path, stlfile, r)
    TR = stlread(sprintf('%s%s', stl_path, stlfile));
    model.Vertices = TR.Points;
    model.Faces    = TR.ConnectivityList;
    
    p02 = patch(model, 'FaceColor', [0 1 1], 'Facecolor', 'interp', ...
        'FaceAlpha' ,0.6);
    p02.EdgeColor = 'none';
    % facecolor flat がないと動かない
    % facecolor interp にすると頂点毎に色がつく 面の色は頂点の色で補完する
    % CData:面の色 今回は使わない
    % FaceVertexCData:頂点の色 こっちを使う
    p02v = get(p02, 'vertices');
    p02fvcd = zeros(length(p02v), 3);
    for i = 1:length(p02v)
        if sqrt(p02v(i, 1)^2 + p02v(i, 2)^2 + p02v(i, 3)^2) > 1.04
            p02fvcd(i, :) = [0 1 0];  % 陸
            if p02v(i, 3) < -0.93  % 南極
                p02fvcd(i, :) = [0.9 0.9 0.9];
            end
        else 
            p02fvcd(i, :) = [0 .5 1];  % 海
        end
    end
    theta = pi/4;
    zkaiten = [cos(theta) -sin(theta) 0;
               sin(theta) cos(theta)  0;
               0          0           1];
    p02v = (zkaiten*(p02v'))';
    set(p02, 'FaceVertexCData', p02fvcd, 'vertices', p02v*r)
end