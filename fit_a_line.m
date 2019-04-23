function [m, b] = fit_a_line(v1, v2)
% v1 and v2 are two points [x1, y1] and [x2, y2]
m = (v1(2)-v2(2))/(v1(1)-v2(1));
b = v1(2) - m*v1(1);