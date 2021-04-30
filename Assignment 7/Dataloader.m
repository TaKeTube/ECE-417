clear;
hold on;
load Mixed.mat;
title('training data');
histogram(Mixed);

Mixed_size = size(Mixed);
N = Mixed_size(1);

k = 2;
% train
GMModel = fitgmdist(Mixed,k);

disp(['sigma_1: ', num2str(GMModel.Sigma(:,:,1)), '  sigma_2: ', num2str(GMModel.Sigma(:,:,2))]);
disp(['miu_1: ', num2str(GMModel.mu(1)), '  miu_2: ', num2str(GMModel.mu(2))]);
disp(['pi_1: ', num2str(GMModel.ComponentProportion(1)), '  pi_2: ', num2str(GMModel.ComponentProportion(2))]);

% plot the histogram
Sample_Mixed = random(GMModel, N);
figure();
hold on;
title('smaple from the model');
histogram(Sample_Mixed);
