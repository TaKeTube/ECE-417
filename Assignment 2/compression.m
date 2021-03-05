clear all;

%load image
load img.mat;
% imshow(img);
% title('original image');

% initialize compression ratio and decomposition level
ratios = [0.5 0.2 0.1 0.15 0.12 0.11 0.1 0.05 0.03 0.02 0.01];
level = 5;

%% D4 wavelet
%apply wavelet transform to the image using D4 wavelet.
[c_db4,s_db4]=wavedec2(img,level,'db4');
[H1_db4,V1_db4,D1_db4] = detcoef2('all',c_db4,s_db4,1);
A1_db4 = appcoef2(c_db4,s_db4,'db4',1);

%initilize cells of reconstructed imgs and the compression ratios
re_img_db4 = {};
compression_ratio_db4 = {};
all_pixel_num = length(c_db4);

%compression
re_img_db4(end+1) = {img};
compression_ratio_db4(end+1) = {1};
for i = ratios
    c_db4_compressed = c_db4;
    c_db4_abs_sorted = sort(abs(c_db4(:)));
    min_num = round(all_pixel_num*(1-i));
    c_db4_compressed(find(abs(c_db4_compressed)<=c_db4_abs_sorted(min_num),min_num)) = 0;
    re_img_db4(end+1) = {waverec2(c_db4_compressed,s_db4,'db4')};
    compression_ratio_db4(end+1) = {i};
end

%display
figure(2);
set(gcf,'position',[150,150,1400,600]);
subplot_width = length(compression_ratio_db4);
for i = 1:subplot_width
    subplot(2, subplot_width/2, i);
    imshow(cell2mat(re_img_db4(i)),[]);
    title(['compression ratio' compression_ratio_db4(i)]);
end
sgtitle('D4 wavelet');

%% Haar wavelet
%apply wavelet transform to the image using Haar wavelet.
[c_haar,s_haar]=wavedec2(img,level,'haar');
[H1_haar,V1_haar,D1_haar] = detcoef2('all',c_haar,s_haar,1);
A1_haar = appcoef2(c_haar,s_haar,'haar',1);

%initilize cells of reconstructed imgs and the compression ratios
re_img_haar = {};
compression_ratio_haar = {};
all_pixel_num = length(c_haar);

%compression
re_img_haar(end+1) = {img};
compression_ratio_haar(end+1) = {1};
for i = ratios
    c_haar_compressed = c_haar;
    c_haar_abs_sorted = sort(abs(c_haar(:)));
    min_num = round(all_pixel_num*(1-i));
    c_haar_compressed(find(abs(c_haar_compressed)<=c_haar_abs_sorted(min_num),min_num)) = 0;
    re_img_haar(end+1) = {waverec2(c_haar_compressed,s_haar,'haar')};
    compression_ratio_haar(end+1) = {i};
end

%display
figure(3);
set(gcf,'position',[100,100,1400,600]);
subplot_width = length(compression_ratio_haar);
for i = 1:subplot_width
    subplot(2, subplot_width/2, i);
    imshow(cell2mat(re_img_haar(i)),[]);
    title(['compression ratio' compression_ratio_haar(i)]);
end
sgtitle('Haar wavelet');

%% FFT
% apply FFT to the image
c_fft = fft2(img);

%initilize cells of reconstructed imgs and the compression ratios
re_img_fft = {};
compression_ratio_fft = {};
[r c] = size(c_fft);
all_pixel_num = r*c;

%compression
re_img_fft(end+1) = {img};
compression_ratio_fft(end+1) = {1};
for i = ratios
    c_fft_compressed = c_fft;
    c_fft_abs_sorted = sort(abs(c_fft(:)));
    min_num = round(all_pixel_num*(1-i));
    c_fft_compressed(find(abs(c_fft_compressed)<=c_fft_abs_sorted(min_num),min_num)) = 0;
    re_img_fft(end+1) = {real(ifft2(c_fft_compressed))};
    compression_ratio_fft(end+1) = {i};
end

%display
figure(4);
set(gcf,'position',[50,50,1400,600]);
subplot_width = length(compression_ratio_fft);
for i = 1:subplot_width
    subplot(2, subplot_width/2, i);
    imshow(cell2mat(re_img_fft(i)),[]);
    title(['compression ratio' compression_ratio_fft(i)]);
end
sgtitle('FFT');

%% Find the compression ratio which maintains a good visual quality

figure(5);
set(gcf,'position',[0,0,1100,1100]);

% display original image
subplot(2,2,1);
imshow(img);
title('Original Image');

% figure out the best compression ratio for D4
db4_best_ratio = 0.15;
c_db4_visual = c_db4;
c_db4_visual_sorted = sort(abs(c_db4(:)));
all_pixel_num = length(c_db4);
min_num = round(all_pixel_num*(1-db4_best_ratio));
c_db4_visual(find(abs(c_db4_visual)<=c_db4_visual_sorted(min_num),min_num)) = 0;
re_img_db4_visual = waverec2(c_db4_visual,s_db4,'db4');
subplot(2,2,2);
imshow(re_img_db4_visual,[]);
title(['D4 best compression ratio ' num2str(db4_best_ratio)]);

% figure out the best compression ratio for Haar
haar_best_ratio = 0.20;
c_haar_visual = c_haar;
c_haar_visual_sorted = sort(abs(c_haar(:)));
all_pixel_num = length(c_haar);
min_num = round(all_pixel_num*(1-haar_best_ratio));
c_haar_visual(find(abs(c_haar_visual)<=c_haar_visual_sorted(min_num),min_num)) = 0;
re_img_haar_visual = waverec2(c_haar_visual,s_haar,'haar');
subplot(2,2,3);
imshow(re_img_haar_visual,[]);
title(['Haar best compression ratio ' num2str(haar_best_ratio)]);

% figure out the best compression ratio for FFT
fft_best_ratio = 0.25;
c_fft_visual = c_fft;
c_fft_visual_sorted = sort(abs(c_fft(:)));
[r c] = size(c_fft);
all_pixel_num = r*c;
min_num = round(all_pixel_num*(1-fft_best_ratio));
c_fft_visual(find(abs(c_fft_visual)<=c_fft_visual_sorted(min_num),min_num)) = 0;
re_img_fft_visual = real(ifft2(c_fft_visual));
subplot(2,2,4);
imshow(re_img_fft_visual,[]);
title(['FFT best ratio ', num2str(fft_best_ratio)]);