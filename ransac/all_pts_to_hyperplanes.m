function [dists] = all_pts_to_hyperplanes(rest_of_data, v1, v2, v3)
% Return vector of distances to estimated line
% rest_of_data is remaining x and y training data that weren't used to
% calcuate m and b
% v is matrix of points used to calculate new weights and intercept
% v1 is first point used to calculate m and b
% v2 is second point used to calculate m and b
% v3 is third point used to calculate ma and 
% dists output vector of distances
%pts = [rest_of_data zeros(length(rest_of_data),1)];
%v1 = [repmat(v1,size(pts,1),1) zeros(length(pts),1)];
%v2 = [repmat(v2,size(pts,1),1) zeros(length(pts),1)];
%a = v1 - v2;
%b = pts - v2;
dists = zeros(length(rest_of_data),1);
norm_vec = cross(v1,v2);
norm_unit_vec = norm_vec/norm(norm_vec);
for ii = 1:length(rest_of_data)
    cur_sample = rest_of_data(ii,:)';
    dists(ii) = abs(dot(cur_sample-v3,norm_unit_vec));
end

end

