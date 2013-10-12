% -----------------------------------------
% HV Partitioning Algorithm
% -----------------------------------------
%
% @author		Chris Atkin-Granville
% @link			http://chrisatk.in
% @email		v2t04@students.keele.ac.uk
%
% @file			hv_partition.m
% @version		1.0
% @date			26th January 2012
%
% Copyright (C) 2012 Chris Atkin-Granville.
% All rights reserved.
% -----------------------------------------

clc
clear
clear all
warning on all

% --------------------------------
% Configuration
% --------------------------------
global DRAW_FIGURE ID THRESHOLD leaves
DRAW_FIGURE = true;
IMAGE_NAME = 'lenna.tif';
ID = 1;
leaves = {};
THRESHOLD = 0.01;
% --------------------------------

% Load the image
disp('Loading image...')
img_info = imfinfo(IMAGE_NAME);
img = imread(IMAGE_NAME);

if DRAW_FIGURE
    figure, imshow(img);
end

fprintf('Segmenting %s...\n', IMAGE_NAME)
fprintf('Drawing figure: %g\n', DRAW_FIGURE)

% Segment the image...
tree = Range(img, [1, img_info.Width], [1, img_info.Height], 0);
tree.segment();

disp('Finished segmenting')
disp('Getting leaves...')

% Domain-range mapping
% First, we get the leaf nodes
%tree.get_leaves();

fprintf('Found %g leaves\n', length(leaves))
disp('Comparing domain-ranges')
fprintf('Using a threshold of %3.2d\n', THRESHOLD)

% Map the leaf nodes to the...leaf nodes
%tree.map_leaves(leaves);

disp('Done comparing domain-ranges');

%matlabpool close
disp('Finished!')