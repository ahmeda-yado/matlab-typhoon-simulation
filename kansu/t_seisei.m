% 台風を生成する関数
% aは高さ、sは描画する円の間隔、bairitsuは台風の形状の倍率、後は根元の座標
% 出力をplotのみにしたい
function point = t_seisei(a, s, bairitsu, x0, y0, z0)
    h = 0:s:a;
    r = zeros(1, length(h));
    for i = 1:length(h)
        r(i) = (a^(2/3) - h(i)^(2/3))^(3/2);  % アステロイドの分枝
    end
    r = flip(r).*bairitsu;  % 台風の幅になる円の半径、r(i)がh(i)に対応する
    
    % 三次元プロットの為のベクトル
    x = [];
    z = [];
    y = [];
    for i = 1:length(h)  % 高さh(i)のとき半径r(i)の円を描く
        x1 = -r(i):0.1:r(i);  % xを-rからrまで動かす
        z1 = zeros(1, length(x1));
        for j = 1:length(x1)
            z1(j) = sqrt(r(i)^2 - x1(j)^2);  % 半円のz座標を求める
        end
        % もう一つの半円の座標を追加
        x1 = [x1 flip(x1)];
        z1 = [z1 -z1];
        % y座標（高さ）を追加
        y1 = ones(1, length(x1))*h(i);
        % 描画する為のベクトルに座標を追加
        x = [x x1];
        z = [z z1];
        y = [y y1];
    end
    
    % 台風を根元の座標に移動させる
    x = x + x0;
    z = z + z0;
    y = y + y0;
    
    point = plot3(x, z, y, '-', 'Linewidth', 0.01, 'Color', [1 1 1, 0.8]);
end
