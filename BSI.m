function[bsi_std,bsi_ave,bsi]=BSI(psd_data,npsd_epoch,n_epoch) 
%======= calculate each BSI for all electrodes ========%

[~,N]=size(psd_data); 
N=N/2; 
M = npsd_epoch; 
bsi=zeros(n_epoch,N); 
for i=1:n_epoch 
    for k=1:N 
        for j=1:M
            num=psd_data((i-1)*M+j,k)- psd_data((i-1)*M+j,k+N); 
            denum=psd_data((i-1)*M+j,k)+ psd_data((i-1)*M+j,k+N); 
            bsi(i,k)=bsi(i,k)+ norm((num/denum)); 
        end
        bsi(i,k)=bsi(i,k)./M; 
    end
end

%======= calculate BSI average for all electrodes ========% 
 %bsi_ave=zeros(1,k); 
for k=1:N 
    bsi_ave(k)=sum(bsi(:,k))/n_epoch; 
    stdeviation=std(bsi);
end
bsi_std=[bsi_ave;stdeviation];
