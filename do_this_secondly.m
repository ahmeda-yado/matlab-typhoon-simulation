clear; close all;
% 地球を生成
fig = figure;
r = 100;  % 半径
earth_path = 'sonota/';
make_earth(earth_path, 'earth01.stl', r);
axis equal
xlim([-1.5, 1.5].*r*3)
ylim([-1.5, 1.5].*r*3)
zlim([-1.5, 1.5].*r*3)
xlabel('x')
ylabel('y')
zlabel('z')
grid on
view(3)

% 緯線を書く
hold on
make_ido;

% 視点の設定
v = [1.5 -1.5 .5];
view(v)
camzoom(6)
% pause(10)
camzoom(2)

% 塵の設定
% x>0, y<0, z>0 の領域に塵を生み出す
% とりあえず全ての塵を同時に動かすことを想定している為、塵の数は少なめ
rng('shuffle');
chiri_path = 'sonota/';
f = readmatrix(sprintf('%s/%s', chiri_path, 'chiri_f.txt'));
v = readmatrix(sprintf('%s/%s', chiri_path, 'chiri_v.txt'));
% v = v.*5*r/100;  % 塵の大きさ
v = v.*5*r/100/2;  % 塵の大きさ
kosu = 10;  % 塵の個数
% kosu = 1;  % 塵の個数 重い時用
cmass = 1;  % 塵の質量
c_list = YourHandleClass(zeros(30));  % 塵のリスト

% 台風の生成
a = 150;
bairitsu = 1/2;
taifu = t_seisei(a, 10*r/100, bairitsu, 0, 400, 0);  % 500にすると竜巻の根元が地表に来る
taifu_set(taifu)  % 台風の初期位置を定める

% タイマー：台風を動かす
t_period = .1;
% t_period = 0.5;
dt = pi/2^11;
t = timer('ExecutionMode', 'fixedDelay', 'Period', t_period);
t.TimerFcn = @(~, ~) zenshin(taifu, dt);
t.StopFcn = @(~, ~) delete(findall(0, 'Type', 'figure'));
% t.StartDelay = 1;
start(t);  % timerスタート

% 速度の初期設定
sokudo = cell(1, kosu*30);
for i = 1:length(sokudo)
    sokudo{i} = YourHandleClass([0 0 0]);  % sokudo(i).value = [0 0 0]
end

% タイマー：塵を台風に近づける 全ての塵に対してchiri_mawasuを実行する必要がある
t2_period = .06;
t2 = timer('ExecutionMode', 'fixedDelay', 'period', t2_period);
t2.StartFcn = @(~, ~) chiri_timer_start(taifu, kosu, f, v, c_list, r, sokudo);
% tic;
t2.TimerFcn = @(~, ~) chiri_timer(taifu, c_list.lis, r, sokudo, cmass, t2_period);
% toc;
t2.StopFcn = @(~, ~) chiri_timer_stop(t, t2);
% t2.StartDelay = 1;
t2.TasksToExecute = round(2/t2_period);  
start(t2);  

% 終了の処理
fig.KeyPressFcn = @(~, data) quitfile(data);
fig.DeleteFcn = @(~, ~) stop(timerfindall);