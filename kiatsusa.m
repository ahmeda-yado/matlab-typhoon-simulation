clear; close all;
% 等圧線も引きたい
dx = 0:2500;
dp = zeros(1, length(dx));
for i = 1:length(dx)
    if dx(i) > 1000  % 1000km
        dp(i) = 0.16*dx(i);
        if dp(i) > 200
            dp(i) = 200;
        end
    else  
        dp(i) = 5*sqrt(dx(i));
        % dp(i) = .1*sqrt(dx(i));
    end
end

figure
plot(dx, dp)
axis equal
% axis tight
xlim([0 2500])
ylim([0 300])
xlabel('距離[km]');
ylabel('気圧差[hPa]');
title('気圧勾配')
xticks([50 200 500 1000 2000]);  % x軸に表示する目盛りの位置を指定
% xticklabels({'0', '2', '5', '7', '10'});  % 目盛りラベルを設定

hold on

% dpが4の倍数になるまたは4の倍数を跨ぐたびに縦線を引く
% for i = 2:length(dp)
% for i = 2:1250
%     if mod(dp(i), 4) == 0 || (mod(dp(i - 1), 4) ~= 0 && mod(dp(i), 4) == 0)
%         plot([dx(i) dx(i)], ylim, 'Color', [1 0 1]);
%         % plot([dx(i) dx(i)], [200 300], 'Color', [1 0 1]);
%     elseif floor(dp(i)/4) > floor(dp(i - 1)/4)
%         plot([dx(i) dx(i)], ylim, 'Color', [1 0 1]);
%         % plot([dx(i) dx(i)], [200 300], 'Color', [1 0 1]);
%     end
% end

