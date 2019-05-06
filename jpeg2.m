function jpeg2()
    clc;
    clear all;
    [test_images, test_labels] = mnist_parse('t10k-images-idx3-ubyte',...
        't10k-labels-idx1-ubyte');
    
    num_img = 1000; % number of images to be compressed
    height = 28;
    width = 28;
    quality = getQuality(40);
%     jpeg_compressed_imgs = zeros(height, width, num_img);
    for i = 1:num_img
        sample = test_images(3:height-2,3:width-2,i) -128;
        output = compress(sample, quality); 
%        imwrite(output,'jpegout.jpeg');
        horizontal_pad = zeros(width-4,2);
        vertical_pad = zeros(2,height);
        new_img = [vertical_pad; horizontal_pad output horizontal_pad; vertical_pad];
        new_img = double(new_img)/255;
        jpeg_compressed_imgs(:,:,i) = new_img;
    end    
    
    sub_test_labels = test_labels(1:num_img);
    save('compr.mat','jpeg_compressed_imgs', 'sub_test_labels');
    %----------------------------------------------------------
    %Display of Results
    %----------------------------------------------------------
    % figure(1);imshow(I1);title('original image');
    % figure(2);imshow(K);title('restored image from dct');
end

function quality = getQuality(quality)

    %----------------------------------------------------------
    % Quality Matrix Formulation
    %----------------------------------------------------------
    Q50 = [ 16 11 10 16 24 40 51 61;
         12 12 14 19 26 58 60 55;
         14 13 16 24 40 57 69 56;
         14 17 22 29 51 87 80 62; 
         18 22 37 56 68 109 103 77;
         24 35 55 64 81 104 113 92;
         49 64 78 87 103 121 120 101;
         72 92 95 98 112 100 103 99];

     if quality > 50
         quality = uint8(round(Q50.*(ones(8)*((100-quality)/50))));
     elseif quality < 50
         quality = uint8(round(Q50.*(ones(8)*(50/quality))));
     elseif quality == 50
         quality = Q50;
     end

end

function out = compress(input, quality)
 
    I = input;
    [row, coln]= size(I);
    I= double(I);
    %----------------------------------------------------------
    % Formulation of forward DCT Matrix and inverse DCT matrix
    %----------------------------------------------
    DCT_matrix8 = dct(eye(8));
    iDCT_matrix8 = DCT_matrix8';   %inv(DCT_matrix8);

    %----------------------------------------------------------
    % Jpeg Compression
    %----------------------------------------------------------
    dct_restored = zeros(row,coln);
    quality = double(quality);
    %----------------------------------------------------------
    % Jpeg Encoding
    %----------------------------------------------------------
    %----------------------------------------------------------
    % Forward Discret Cosine Transform
    %----------------------------------------------------------

    for i1=[1:8:row]
        for i2=[1:8:coln]
            zBLOCK=I(i1:i1+7,i2:i2+7);
            win1=DCT_matrix8*zBLOCK*iDCT_matrix8;
            dct_domain(i1:i1+7,i2:i2+7)=win1;
        end
    end
    %-----------------------------------------------------------
    % Quantization of the DCT coefficients
    %-----------------------------------------------------------
    for i1=[1:8:row]
        for i2=[1:8:coln]
            win1 = dct_domain(i1:i1+7,i2:i2+7);
            win2=round(win1./quality);
            dct_quantized(i1:i1+7,i2:i2+7)=win2;
        end
    end

    %-----------------------------------------------------------
    % Jpeg Decoding 
    %-----------------------------------------------------------
    % Dequantization of DCT Coefficients
    %-----------------------------------------------------------
    for i1=[1:8:row]
        for i2=[1:8:coln]
            win2 = dct_quantized(i1:i1+7,i2:i2+7);
            win3 = win2.*quality;
            dct_dequantized(i1:i1+7,i2:i2+7) = win3;
        end
    end
    %-----------------------------------------------------------
    % Inverse DISCRETE COSINE TRANSFORM
    %-----------------------------------------------------------
    for i1=[1:8:row]
        for i2=[1:8:coln]
            win3 = dct_dequantized(i1:i1+7,i2:i2+7);
            win4=iDCT_matrix8*win3*DCT_matrix8;
            dct_restored(i1:i1+7,i2:i2+7)=win4;
        end
    end
    I2=dct_restored;



    % ---------------------------------------------------------
    % Conversion of Image Matrix to Intensity image
    %----------------------------------------------------------


    out=mat2gray(I2);
end

