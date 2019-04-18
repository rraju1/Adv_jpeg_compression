function [ dct,thresholded,jpeg,error,numzeros ] = jpeg_encode( image, threshold )
%jpeg_stephen using DCTII to approximate JPEG compression
%   inputs:
%       image is the image to be compressed (multiple of 8 size)
%       threshold is the threshold for changing to zeros
%   outputs:
%       dct is the image broken into chunks and DCT transformed
%       thresholded is the DCT with small values set to zero
%       jpeg is the reconstructed image
%       error is the difference between the original and compressed images
%       numzeros is the number of zeros in the thresholded DCT

%% 
% a) Break image into 8x8 blocks
% b) Take DCT2 of each block
[M,N]=size(image);

for i=0:(M/8)-1
    for j=0:(N/8)-1
        index1 = (1+8*i):(8*(i+1));
        index2 = (1+(8*j)):(8*(j+1));
        excerpt = image(index1, index2); 
        DCTblocks(index1,index2) = dct2(excerpt);
    end
end
dct=DCTblocks;

% set all values less than threshold to zero
maxim = max(DCTblocks(:));
threshold = threshold*maxim;
DCTblocks(abs(DCTblocks) < threshold) = 0;
thresholded = DCTblocks;

% count zeros
numzeros=0;
for i=1:M,
    for j=1:N,
        if DCTblocks(j,i) == 0,
            numzeros = numzeros+1;
        end
    end
end

% recover image
jpeg=zeros(M/8-1,N/8-1);
for i=0:(M/8)-1
    for j=0:(N/8)-1
        index1 = (1+8*i):(8*(i+1));
        index2 = (1+(8*j)):(8*(j+1));
        excerpt = DCTblocks(index1, index2); 
        jpeg(index1,index2) = idct2(excerpt);
    end
end

% scale to 256 values between 0 and 1
jpeg=round(abs(jpeg)/max(jpeg(:))*255)/255;

% find error
error_num = (jpeg-image).^2;
error_denom = (image).^2;
error = sum(error_num(:))/sum(error_denom(:));

end

