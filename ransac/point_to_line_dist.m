function distance = point_to_line_dist(pt, v1, v2)
    % This function calculates the distance from a point (pt) to a line
    % between v1 and v2. pt, v1, and v2 are all a 1x2 array [x,y].
    % Reference: https://www.mathworks.com/matlabcentral/answers/95608-is-there-a-function-in-matlab-that-calculates-the-shortest-distance-from-a-point-to-a-line
    pt = [pt, 0];
    v1 = [v1, 0];
    v2 = [v2, 0];
    a = v1 - v2;
    b = pt - v2;
    distance = sqrt(sum(cross(a,b,2).^2,2)) ./ sqrt(sum(a.^2,2));
end