function chiri_timer_stop(t, t2)
    R = get(t, 'Running');
    if isequal(R ,'on')  % tが動いてる
        disp('phase ended')
        start(t2)
    else  % tが動いてない=プロ倉ムンの終了
        disp('terminated')  
        delete(timerfindall);
    end
end