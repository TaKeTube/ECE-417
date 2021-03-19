figure(1)
load MRI_dataset;
for i=1:32
    imshow(MRI_dataset(:,:,i));
end
% figure(2)
load noise_img;
% imshow(noise_img);

%% svd
A = [1 -0.8 0.5;0 1 2;1 0 0.3;2 2.5 0];
[U,S,V] = svd(A);
disp("U:");disp(U);
disp("S:");disp(S);
disp("V:");disp(V);

%% Eigne image & value
% vectorize image and form data matrix
X_biased = [];
for i=1:32
   image_vec = reshape(MRI_dataset(:,:,i),1,[]);
   X_biased = [X_biased;image_vec];
end

% get average image
avg_image = mean(X_biased, 1);

% get data centered with origin
X = bsxfun(@minus, X_biased, avg_image);

% get the shape of data matrix
[N, d] = size(X);

% do svd
[U,S,V] = svd(X,'econ');

% set figure
figure(2);
set(gcf,'position',[100,100,1400,600]);

% get singular values
singular_values = diag(S);

% get eigen images
eigen_images = [];
for i=1:N
    img_min = min(V(:,i));
    img_max = max(V(:,i));
    eigen_image = reshape(V(:,i),64,[]);
    eigen_images(:,:,i) = eigen_image;
    subplot(4,8,i);
    imshow(eigen_image);
    title([singular_values(i)])
    caxis([img_min,img_max]);
end
sgtitle('eigen images');

%% eigen filter
figure(3);
imshow(noise_img);
title('noise image');
[U,S,V] = svd(noise_img,'econ');
k = 27;
reconstruct_image = zeros(size(noise_img));
sigma = diag(S);
for i=1:k
    reconstruct_image = reconstruct_image + U(:,i)*V(:,i)'*sigma(i);
end
figure(4);
imshow(reconstruct_image);
title('denoised image');