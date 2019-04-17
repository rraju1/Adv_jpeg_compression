clear all;
close all;


threshold = 0.1;

% Read in data from MNIST binary
[images, labels] = mnist_parse('./data/MNIST/raw/t10k-images-idx3-ubyte', './data/MNIST/raw/t10k-labels-idx1-ubyte');
[dct,thresholded, jpeg,error,numzeros] = jpeg_encode(test, threshold);
new_jpeg = jpeg;