function zenshin(taifu, dt)
    tx = get(taifu, 'Xdata');
    ty = get(taifu, 'Ydata');
    tz = get(taifu, 'Zdata');
    n = [-1 -1 0];
    n = n./norm(n);
    c = cos(dt);
    s = sin(dt);
    % n軸回転行列
    nkaiten = [n(1)^2*(1-c)+c n(1)*n(2)*(1-c)-n(3)*s n(1)*n(3)*(1-c)+n(2)*s;
               n(1)*n(2)*(1-c)+n(3)*s n(2)^2*(1-c)+c n(2)*n(3)*(1-c)-n(1)*s;
               n(1)*n(3)*(1-c)-n(2)*s n(2)*n(3)*(1-c)+n(1)*s n(3)^2*(1-c)+c];
    newxyz = nkaiten*[tx;ty;tz];
    set(taifu, 'XData', newxyz(1, :), 'YData', newxyz(2, :), 'ZData', newxyz(3, :))
    drawnow;
    view([tx(1) ty(1) tz(1)])
end
