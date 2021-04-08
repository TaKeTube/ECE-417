load Signals_Q6;
%show signals:
plot(Signals_Q6(1,:));
hold on;
plot(Signals_Q6(2,:));
plot(Signals_Q6(3,:));
plot(Signals_Q6(4,:));
plot(Signals_Q6(5,:));
plot(Signals_Q6(6,:));

mixdata = Signals_Q6.';

% plot mixed signal
figure
for i = 1:6
    subplot(2,3,mod(i,3)+floor(i/3)*3);
    plot(mixdata(:,i));
    title(['Mix ',num2str(i)])
end

% whitening
mixdata = prewhiten(mixdata);
% get number of linearly independent measurements
whiten_size = size(mixdata);
q = whiten_size(2);
disp(['#linearly independent measurements:',num2str(q)]);
% do ICA
Mdl = rica(mixdata,q,'NonGaussianityIndicator',-ones(q,1));
unmixed = transform(Mdl,mixdata);

% plot unmixed signals
figure
for i = 1:q
    subplot(2,3,i);
    plot(unmixed(:,i))
    title(['Unmix ',num2str(i)])
end