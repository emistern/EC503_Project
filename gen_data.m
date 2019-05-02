function [x, y] = gen_data(nb_features, noise, nb_samples, shuffled)
% Generate Synthetic Dataset

x_unshuf = repmat(linspace(1, 100, nb_samples), nb_features,1)';
y_unshuf = zeros(nb_samples, 1);


for a_feature = 1:nb_features
    y_unshuf = y_unshuf + x_unshuf(:,a_feature) * randi([-5 5]);
end

if noise == 1
    number_outliers = randi(1, ceil(nb_samples/3));
    for an_outlier = 1:number_outliers
        bad_sample = randi([1 nb_samples]);
        y_unshuf(bad_sample) = y_unshuf(bad_sample) + randi([-10 10])*rand(1,1);
    end
end


if shuffled == 1
    data_unshuffled = [x_unshuf' y_unshuf];

    shuffled = data_unshuffled(randperm(size(data_unshuffled,1)),:);

    x = shuffled(:,1:nb_features);
    y = shuffled(:,nb_features+1);
else
    x = x_unshuf;
    y = y_unshuf;
end
