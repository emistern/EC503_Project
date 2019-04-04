function [x,y]=make_noisy_data6(m,b)
    % Generates all noisy data within a threshold of noise_magnitude*slope above or below a line
    % Completely randomizes the end samples (e.g. maybe a sensor is going bad)
    randomize_n_samples=50;
    noise_magnitude=100;
    x=linspace(0,1000,2000).';
    y=m.*x+b;
    for i=1:size(x,1)
        noisei=randi([-abs(m*noise_magnitude),abs(m*noise_magnitude)]);
        y(i)=(noisei)+y(i);
    end
    y(end-randomize_n_samples+1:end) = max(y)*(1+rand(randomize_n_samples, 1)) - max(y);
    scatter(x,y)
end