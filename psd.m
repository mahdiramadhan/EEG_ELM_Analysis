function[psd_data,k,npsd_epoch,n_epoch]=psd(raw_data,fs,length_epoch,max_psdfreq,nfft)
%% jika bingung, set aja length_epoch =20;max_psdfreq =25;nfft=1024

pxx=pwelch(raw_data(1:length_epoch*fs),[],[],nfft,2*max_psdfreq); %fungsi dari matlab
npsd_epoch = length(pxx); %number of FFT coefficient per epoch 
clear pxx; %delete pxx 
[M,N]= size(raw_data); %dimension of data matrix 
            %M = number of data per electrode 
            %N = number of electrodes 
n_epoch = floor(M/(length_epoch*fs)); %number of bsi or number of epoch 
psd_data = zeros(n_epoch*npsd_epoch,N); %create zero matrix for psd data

% estimate power spectral density per epoch 
j_step = length_epoch*fs; 
j_max = n_epoch * j_step; 
for i = 1:N 
    k=1; 
    for j = 1:j_step:j_max 
        pxx=pwelch(raw_data(j:j+j_step-1,i),[],[],nfft,2*max_psdfreq); 
        psd_data(k:k+npsd_epoch-1,i)=pxx; 
        k = k + npsd_epoch; 
    end
end