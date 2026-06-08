function chiri_timer(point, c_list, r, v, m, kankaku)
    for i = 1:length(c_list)
        if ~isvalid(c_list(i))
            continue
        end
        tx = get(point, 'XData');  % pointのx座標
        ty = get(point, 'YData');  % pointのy座標 
        tz = get(point, 'ZData');
        cv = get(c_list(i), 'Vertices');  % 頂点座標の合計を頂点数で割ったら重心が求まりそう
        tzahyou = [tx(1) ty(1) tz(1)]*r/(r - 200/r*20/2);  % 台風の地上の中心の座標のつもり
        czahyou = [mean(cv(:, 1)) mean(cv(:, 2)) mean(cv(:, 3))];  % 塵の重心のつもり

        % 距離を求める(大圏距離)
        % 台風と塵の内積
        tcnai = dot(tzahyou/norm(tzahyou), czahyou/norm(czahyou));  
        tckodo = acos(tcnai);  % 弧度
        taikenkyori = abs(r*tckodo);  % 大圏距離=r*弧度
        taikenkyori = taikenkyori*6357/r;  % スケールの補正

        % 気圧傾度力 距離に反比例し気圧差に比例する
        F1muki = (tzahyou - czahyou);  
        F1 = F1muki/norm(F1muki);  % 気圧傾度力の方向
        % 気圧差の設定
        if taikenkyori > 1000  % 1000km
            dp = 0.16*taikenkyori;
        else  
            dp = 5*sqrt(taikenkyori);
        end
        if dp > 200  % 気圧差の上限
            dp = 200;
        end
        % 気圧傾度力の計算
        F1_size = dp*100/1.2/(taikenkyori*10^3);  % 1km=10^3m, 1hPa=100Pa
        F1 = F1_size*F1;
        % if i == 1
        %     disp('気圧差，大圏距離，気圧傾度力')
        %     disp(dp)
        %     disp(taikenkyori)
            % disp(norm(F1))
        % end
  
        % 初速度
        if v{i}.value == [0 0 0]
            v{i}.val_update(F1/norm(F1)/norm(tzahyou - czahyou)*10)
        end

        % コリオリの力
        omega = 7.292*10^(-5);  % 自転の角速度
        phi = (90*czahyou(3)/r)*pi/180;  % 緯度[rad]
        f = 2*omega*sin(phi);  % コリオリパラメータ
        F2 = m*v{i}.value*f;  % コリオリの力の公式(でも向きはまだ違う)
        % このF2はvに平行なのでvに垂直にしたい
        housen = cross(100*v{i}.value, czahyou);  % 塵とvがある平面の法線ベクトル
        F2 = housen/norm(housen)*norm(F2);  % コリオリの力(向き調整後)
        % 合力
        % if i == 1
        %     disp('aaa')
        %     disp(norm(F1))
        %     disp(norm(F2))
        % end
        F = F1 + F2;
        % 加速度
        % 関数がkankaku秒ごとに呼び出されるのと実際のbai倍速なので調整
        bai = 10^4*4;
        a = F/m*kankaku*bai;  

        % 塵の移動は速度の計算より一段階遅らせる そうじゃないと
        % そうじゃないと塵の現在地と塵の持つ速度が一段階ずれる
        % するとコリオリの力が一段階前の塵に働く向きになってしまう
        v2 = v{i}.value;
        
        % 速度の更新
        v{i}.val_add(a);

        % 上限速度
        % 歳代風速50m/sとする
        jogen = 50;
        if norm(v{i}.value) > jogen
            v{i}.val_update(v{i}.value/norm(v{i}.value)*jogen)
        end

        % vに従って塵を動かす(地表を回転させる)
        % 向きはvの向き、回転角の大きさはvに比例させる
        chiri_move(c_list(i), czahyou, v2, cv, kankaku)     
    end
end