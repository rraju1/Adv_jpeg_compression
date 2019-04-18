clear all;
close all;


threshold = 0.1;
num_img = 100; % number of images to be compressed
height = 28;
width = 28;

% Read in data from MNIST binary
[test_images, test_labels] = mnist_parse('./data/MNIST/raw/t10k-images-idx3-ubyte', './data/MNIST/raw/t10k-labels-idx1-ubyte');

jpeg_compressed_imgs = zeros(height, width, num_img);
for i=1:num_img
    sample = test_images(3:height-2,3:width-2,i);
    [dct,thresholded, jpeg,error,numzeros] = jpeg_encode(sample, threshold);

    horizontal_pad = zeros(width-4,2);
    vertical_pad = zeros(2,height);
    new_img = [vertical_pad; horizontal_pad jpeg horizontal_pad; vertical_pad];
    new_img = double(new_img)/255;
    jpeg_compressed_imgs(:,:,i) = new_img;
end
sub_test_labels = test_labels(1:num_img);
save('compr.mat','jpeg_compressed_imgs', 'sub_test_labels');