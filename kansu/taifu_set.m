function taifu_set(taifu)
    tx = get(taifu, 'Xdata');
    ty = get(taifu, 'Ydata');
    tz = get(taifu, 'Zdata');
    set(taifu, 'XData', tx./100*20, 'YData', ty./100*20, 'ZData', tz./100*20)
    n = [-1 -1 0];
    n = n./norm(n);
    theta = -pi/2*80/90;
    c = cos(theta);
    s = sin(theta);
    % n軸回転行列
    nkaiten = [n(1)^2*(1-c)+c n(1)*n(2)*(1-c)-n(3)*s n(1)*n(3)*(1-c)+n(2)*s;
               n(1)*n(2)*(1-c)+n(3)*s n(2)^2*(1-c)+c n(2)*n(3)*(1-c)-n(1)*s;
               n(1)*n(3)*(1-c)-n(2)*s n(2)*n(3)*(1-c)+n(1)*s n(3)^2*(1-c)+c];
    newxyz = nkaiten*[tx;ty;tz]./5;
    set(taifu, 'XData', newxyz(1, :), 'YData', newxyz(2, :), 'ZData', newxyz(3, :))
end