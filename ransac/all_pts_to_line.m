function [dists] = all_pts_to_line(rest_of_data, v1, v2)
% Return vector of distances to estimated line
% rest_of_data is remaining x and y training data that weren't used to
% calcuate m and b
% v1 is first point used to calculate m and b
% v2 is second point used to calculate m and b
% dists output vector of distances
pts = [rest_of_data zeros(length(rest_of_data),1)];
v1 = [repmat(v1,size(pts,1),1) zeros(length(pts),1)];
v2 = [repmat(v2,size(pts,1),1) zeros(length(pts),1)];
a = v1 - v2;
b = pts - v2;
dists = sqrt(sum(cross(a,b,2).^2,2)) ./ sqrt(sum(a.^2,2));
end

