function [m, b] = fit_a_hyperplane(v)

% v is matrix of all vectors used to compute the hyperplane: [v1 v2 .. vk]
[a,b] = size(v);
% find points parallel to hyperplane
diff_vec = zeros(a,b-1);
for ii = 2:b
    diff_vec(:,ii-1) = v(:,1) - v(:,ii);
end
% cross product of parallel lines = line normal to hyperplane
stnd_w = cross(diff_vec(:,1), diff_vec(:,2));
% plug in to equation to get intercept
p1 = v(:,1);
stnd_int = stnd_w(1)*p1(1) + stnd_w(2)*p1(2) + stnd_w(3)*p1(3);
% divide by the standard form coefficient to get "point slope" form
stnd_w = stnd_w/stnd_w(end);
b = stnd_int/stnd_w(end);
m = stnd_w(1:end-1);

b = v1(2) - m*v1(1);