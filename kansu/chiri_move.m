function chiri_move(chiri, czahyou, v, cv, kankaku)
    % vを回転運動に変換する
    % 回転軸n
    % nは回転する平面に垂直なベクトルでなければならない
    n = cross(czahyou, v);
    n = n./norm(n);

    % 現実の地球では、v[m/s] = v*2*pi/(4*10^4*10^3)[rad/s]
    % この関数はkankaku秒ごとに呼び出されるのでkankaku倍
    % 実験をbai倍の速度で行う
    bai = 10^4*4;
    dt2 = norm(v)*2*pi/(4*10^4*10^3)*kankaku*bai;
    c = cos(dt2);
    s = sin(dt2);
    % n軸回転行列
    nkaiten = [n(1)^2*(1-c)+c n(1)*n(2)*(1-c)-n(3)*s n(1)*n(3)*(1-c)+n(2)*s;
               n(1)*n(2)*(1-c)+n(3)*s n(2)^2*(1-c)+c n(2)*n(3)*(1-c)-n(1)*s;
               n(1)*n(3)*(1-c)-n(2)*s n(2)*n(3)*(1-c)+n(1)*s n(3)^2*(1-c)+c];
    cv = (nkaiten*(cv'))';
    set(chiri, 'Vertices', cv);
end