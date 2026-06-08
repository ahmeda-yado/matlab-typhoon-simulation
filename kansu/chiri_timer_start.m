function chiri_timer_start(taifu, kosu, f, v, c_list, r, sokudo)
    % ここでやること：c_listの初期化、c_listの更新、sokudoの初期化
    % pause(3)
    trashcan = [];
    tcount = 0;
    if length(c_list.lis) >= 30
        tcount = tcount + 1;
        while(1) 
            if isvalid(c_list.lis(tcount))           
                trashcan = [trashcan c_list.lis(tcount)];  % この方がバグらん気がする 
                disp('deleted')
            end
            if length(trashcan) == kosu  % tcount = 10なら11から塵がある
                break;
            end
            tcount = tcount + 1;
        end
    end

    for i = 1:length(trashcan)
        delete(trashcan(i))
    end

    % % 再構成
    % c_list.lis_recon();

    for i = 1:kosu
        p = patch('Faces', f, 'Vertices', v, 'FaceColor', [.8 .8 .8], ...
            'EdgeColor', 'none', 'FaceAlpha', 0);
        ransu = rand(1);
        if ransu(1) < .08
            set(p, 'FaceColor', [1 0 1])
        end
        chiri_dist(taifu, p, r);
        c_list.lis_add(p)
    end
    
    % for i = tcount + 21:tcount + 30
    %     sokudo{i}.val_update([0 0 0])
    % end
end