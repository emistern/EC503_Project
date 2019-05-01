% Generate the Theil-Sen visualization used in the presentation.

% Use X values that illustrate that constant sampling isn't necessary
x = [1;4;6;8;10];

% Add some noise to illustrate that it doesn't need perfect inliers
y = x * 2 + 3 + 4 * rand(size(x, 1),1);

% Add a single outlier
y(2) = 3 * y(2);


figure;
hold on;
ylim([0 max(y)]);
xlim([0 max(x)])
scatter(x, y);
all_pairs = nchoosek(1:size(x, 1), 2);

delta_y = y(all_pairs(:,2))-y(all_pairs(:,1));
delta_x = x(all_pairs(:,2))-x(all_pairs(:,1));
slopes = delta_y ./ delta_x;
[~, median_idx] = min(abs(slopes - median(slopes)));
intercepts = y(all_pairs(:,1)) - (slopes .* x(all_pairs(:,1)));

pmed = plot(x(all_pairs(median_idx,:)).', y(all_pairs(median_idx,:)).', 'r', 'LineWidth', 2);
prest = plot(x(all_pairs([1:median_idx-1 median_idx+1:end],:)).', y(all_pairs([1:median_idx-1 median_idx+1:end],:)).', 'k--');
% text(mean(x(all_pairs), 2), mean(y(all_pairs), 2), [repmat('m=', size(slopes, 1), 1) num2str(slopes)]);
rl = refline(slopes(median_idx), intercepts(median_idx));
rl.Color = 'r';
rl.LineWidth = 2;
text(mean(x(all_pairs(median_idx,:)))+0.5, mean(y(all_pairs(median_idx,:)))-0.5, ...
    ['y = ', num2str(slopes(median_idx)), ' * x + ', num2str(intercepts(median_idx))]);
legend([pmed(1); prest(1)], ['Median slope'; 'Other slopes'], 'Location', 'southeast');
title('Theil-Sen Representative Slope');
xlabel('x (arbitrary units)');
ylabel('y (arbitrary units)');
