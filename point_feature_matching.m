% Load first image
image1 = (imread('cameraman.tif')) ;
if size(image1, 3) == 3
    image1 = rgb2gray(image1);
else
    image1 = image1;
end
figure; imshow(image1);
title('Image 1');
saveas(gcf, '../image_examples/image1.png');

% Use a transform of the first image as our second image.
image2 = imresize(image1,0.7); 
image2 = imrotate(image2,31);
figure; imshow(image2);
title('Image 2');
saveas(gcf, '../image_examples/image2.png');

% Find features in each image
image1Features = detectSURFFeatures(image1);
image2Features = detectSURFFeatures(image2);

[image1Features, image1Points] = extractFeatures(image1, image1Features);
[image2Features, image2Points] = extractFeatures(image2, image2Features);

% Get the indices of the matching pairs of features. Columns correspond to
% images, with a row per matching set of features. Matches based on least
% pairwise distance between features.
matchIdx = matchFeatures(image1Features, image2Features);

% Display all matched features (includes outliers)
matchedImage1Points = image1Points(matchIdx(:, 1), :);
matchedImage2Points = image2Points(matchIdx(:, 2), :);

figure;
showMatchedFeatures(image1, image2, matchedImage1Points, matchedImage2Points, 'montage');
title('Matched Points, Including Outliers');
saveas(gcf, '../image_examples/all_matches.png');

% estimateGeometricTransform uses MSAC internally
% To do it with our own regression, see slide 13 on:
%  https://www.cis.rit.edu/class/simg782/lectures/lecture_02/lec782_05_02.pdf

% P the homogeneous coordinate representation of image 1
% Rows correspond to matched feature points. Columns are [x; y; 1]
P = [matchedImage1Points.Location ones(matchedImage1Points.Count, 1)];
% Q the homogeneous coordinate representation of image 2
Q = [matchedImage2Points.Location ones(matchedImage2Points.Count, 1)];

outputView = imref2d(size(image1));

% Map image2 to image1 coordinates using OLS
olsxform = Q\P;
olsxform(:,3)=[0;0;1];
olsaffine2d = affine2d(olsxform);
olsIr = imwarp(image2, olsaffine2d, 'OutputView', outputView);
figure; imshow(olsIr);
title('OLS mapping of image2 to image1');
saveas(gcf, '../image_examples/ols_mapping.png');

% Map image2 to image1 coordinates using Theil-Sen
[m,b,breakdown] = theil_sen_fit(Q(:,1:2), P(:,1:2), 100);
tsxform = [[m; b] [0;0;1]];
tsaffine2d = affine2d(tsxform);
tsIr = imwarp(image2, tsaffine2d, 'OutputView', outputView);
figure; imshow(tsIr);
title('Theil-Sen mapping of image2 to image1');
saveas(gcf, '../image_examples/ts_mapping.png');

% Map image2 to image1 coordinates using MSAC
[xform, inlierImage2Points, inlierImage1Points] = estimateGeometricTransform(matchedImage2Points, matchedImage1Points, 'affine');
msacIr = imwarp(image2, xform, 'OutputView', outputView);
figure; imshow(msacIr);
title('MSAC mapping of image2 to image1');
saveas(gcf, '../image_examples/msac_mapping.png');

figure;
showMatchedFeatures(image1, image2, inlierImage1Points, inlierImage2Points, 'montage');
title('Matched Points, Inliers Only');
saveas(gcf, '../image_examples/msac_inliers.png');