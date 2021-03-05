% load recording
load('Recording_noise.mat');
SampleRate=8000;
sound(Recording_noise,SampleRate);

% plot Time Domain Diagram of Original Signal
figure;
time=(0:length(Recording_noise)-1)/SampleRate;
plot(time, Recording_noise);
title("Time Domain Diagram of Original Signal")

% STFT
figure;
wlen=512;
hop=wlen/2;
h=hamming(wlen,'periodic');
nfft = max(256, 2^(ceil(log2(length(h)))));
[s, f, t] = spectrogram(Recording_noise,h,wlen-hop,nfft,SampleRate);
%imagesc(t, f, 20*log10((abs(s))));
imagesc(t, f, abs(s));
xlabel('Samples');
ylabel('Freqency');
title("Spectrogram of Original Signal")
colorbar;

% thresholding
s_denoised = s;
[r,c] = size(s);
for i = 1:r
    for k = 1:c
        if abs(s(i,k)) < 0.9
           s_denoised(i,k) = 0; 
        end
    end
end

% plot Spectrogram of Signal after thresholding
figure;
imagesc(t, f, abs(s_denoised));
xlabel('Samples');
ylabel('Freqency');
title("Spectrogram of Signal after thresholding")
colorbar;

% ISTFT of original signal
pause(5)
figure;
[x_istft, t_istft] = istft(s, h, h, hop, nfft, SampleRate);
plot(t_istft,x_istft);
title("Time Domain Diagram of Reconstructed Signal")
sound(x_istft,SampleRate);


% ISTFT of denoised signal
pause(5)
figure;
[x_istft_denoised, t_istft_denoised] = istft(s_denoised, h, h, hop, nfft, SampleRate);
plot(t_istft_denoised,x_istft_denoised);
title("Time Domain Diagram of Denoised Signal");
sound(x_istft_denoised,SampleRate);
