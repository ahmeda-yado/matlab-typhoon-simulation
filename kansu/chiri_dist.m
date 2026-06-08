function chiri_dist(taifu, obj, r)
% 例えば台風からどのくらい離れているかは内積で一意に表せるはず
% 地球の直径は四万キロ 一万キロ離れた地点同士の内積は必ずpi/2になるはず
% 千キロだとpi/20
% 台風と同じ地点に塵を生成した上でランダムな回転軸を作成しpi/20回転させる
% 結局pi/8にした(最大二千五百キロ)
    tx = get(taifu, 'XData');  
    ty = get(taifu, 'YData');  
    tz = get(taifu, 'ZData');
    tzahyou = [tx(1) ty(1) tz(1)]*r/(r - 200/r*20/2);  % 台風の地上の中心の座標のつもり

    % 塵の座標を一旦台風の座標に移す
    cv = get(obj, 'Vertices');
    cv(:, 1) = cv(:, 1) + tzahyou(1);
    cv(:, 2) = cv(:, 2) + tzahyou(2);
    cv(:, 3) = cv(:, 3) + tzahyou(3);

    a = 1;
    b = -1;
    n = a + (b - a).*rand(1, 3);  % (b, a)の乱数
    n = n./norm(n);  % 回転軸
    dt = pi/8;
    c = cos(dt);
    s = sin(dt);
    % n軸回転行列
    nkaiten = [n(1)^2*(1-c)+c n(1)*n(2)*(1-c)-n(3)*s n(1)*n(3)*(1-c)+n(2)*s;
               n(1)*n(2)*(1-c)+n(3)*s n(2)^2*(1-c)+c n(2)*n(3)*(1-c)-n(1)*s;
               n(1)*n(3)*(1-c)-n(2)*s n(2)*n(3)*(1-c)+n(1)*s n(3)^2*(1-c)+c];
    cv = (nkaiten*(cv'))';
    set(obj, 'Vertices', cv, 'FaceAlpha', 1);
end