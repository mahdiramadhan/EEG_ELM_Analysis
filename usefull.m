%% Project Muhammad Mahdi Ramadhan 1506725571
% project ini membagi setiap pengolahan data dalam dua detik

clc
addpath(genpath(pwd))
%% diaktifkan hanya untuk analisis satu sinyal
% [namafile path]=uigetfile('*.edf','masukkan file edf sinyal otak',pwd);
% file =[path namafile];
% [hdr,record] = edfread(file);

%% analisis satu folder
EEGdir = uigetdir(pwd,'masukkan folder yang terdapat file edf');
EEGnames = dir([EEGdir '\*.edf']);
EEGbos = {EEGnames.name};


for b=1:length(EEGbos)
    cd(EEGdir);
    disp(['EEG: ' num2str(EEGnames(b).name)])
    [hdr,record] = edfread([EEGdir '\' EEGnames(b).name]);
tic
hdr.label %untuk lihat chanel 
Fs=hdr.samples(1,1); %untuk lihat frekuensi sampling
detik = 2*Fs;
duration = hdr.records;
jumlahdata = duration*Fs;
a=mod(jumlahdata,detik);
if a ~=0
    jumlahdata=jumlahdata-a;
end
kelompok = jumlahdata/detik;
%menggunakan konsep Common Average Ratio untuk menghilangkan interferensi
%sinyal dari satu elektroda dengan elektroda yang lain
 mySignal=zeros(detik,18,kelompok);
if strcmp(hdr.label{1},'FP1Ref')
    for j = 1:kelompok
    FP1{j} = record(1,(j-1)*detik+1:j*detik)';
    F3{j}= record(2,(j-1)*detik+1:j*detik)';
    C3{j}= record(3,(j-1)*detik+1:j*detik)';
    P3{j}= record(4,(j-1)*detik+1:j*detik)';
    O1{j}= record(5,(j-1)*detik+1:j*detik)';
    F7{j}= record(6,(j-1)*detik+1:j*detik)';
    T3{j}= record(7,(j-1)*detik+1:j*detik)';
    T5{j}= record(8,(j-1)*detik+1:j*detik)';
    FP2{j}= record(11,(j-1)*detik+1:j*detik)';
    F4{j}= record(12,(j-1)*detik+1:j*detik)';
    C4{j}= record(13,(j-1)*detik+1:j*detik)';
    P4{j}= record(14,(j-1)*detik+1:j*detik)';
    O2{j}= record(15,(j-1)*detik+1:j*detik)';
    F8{j}= record(16,(j-1)*detik+1:j*detik)';
    T4{j}= record(17,(j-1)*detik+1:j*detik)';
    T6{j}= record(18,(j-1)*detik+1:j*detik)';
    FZ{j}= record(21,(j-1)*detik+1:j*detik)';
    CZ{j}= record(22,(j-1)*detik+1:j*detik)';
    PZ{j}= record(23,(j-1)*detik+1:j*detik)';
    OZ{j}= record(24,(j-1)*detik+1:j*detik)';
    FPZ{j}= record(25,(j-1)*detik+1:j*detik)';
    T1{j}= record(29,(j-1)*detik+1:j*detik)';
    T2{j}= record(30,(j-1)*detik+1:j*detik)';
    
    end
    % Spektrum 
     %mySignal(:,:,j)=[FP1{j} F3{j} C3{j} P3{j} O1{j} F7{j} T3{j} T5{j} FP2{j} F4{j} C4{j} P4{j} O2{j} F8{j} T4{j} T6{j} FZ{j} CZ{j} PZ{j} OZ{j} FPZ{j} T1{j} T2{j}];
     mySignal(:,:,j)=[FP1{j} C3{j} F3{j} F7{j} O1{j} P3{j} T1{j} T3{j} T5{j} FP2{j} C4{j} F4{j} F8{j} O2{j} P4{j} T2{j} T4{j} T6{j}];

else
   
      for j = 1:kelompok
            FP1{j}= record(10,(j-1)*detik+1:j*detik)';
            F3{j}= record(5,(j-1)*detik+1:j*detik)';
            C3{j}= record(2,(j-1)*detik+1:j*detik)';
            P3{j}= record(15,(j-1)*detik+1:j*detik)';
            O1{j}= record(13,(j-1)*detik+1:j*detik)';
            F7{j}= record(7,(j-1)*detik+1:j*detik)';
            T3{j}= record(18,(j-1)*detik+1:j*detik)';
            T5{j}= record(20,(j-1)*detik+1:j*detik)';
            FP2{j}= record(11,(j-1)*detik+1:j*detik)';
            F4{j}= record(6,(j-1)*detik+1:j*detik)';
            C4{j}= record(3,(j-1)*detik+1:j*detik)';
            P4{j}= record(16,(j-1)*detik+1:j*detik)';
            O2{j}= record(14,(j-1)*detik+1:j*detik)';
            F8{j}= record(8,(j-1)*detik+1:j*detik)';
            T4{j}= record(19,(j-1)*detik+1:j*detik)';
            T6{j}= record(21,(j-1)*detik+1:j*detik)';
            FZ{j}= record(9,(j-1)*detik+1:j*detik)';
            CZ{j}= record(4,(j-1)*detik+1:j*detik)';
            PZ{j}= record(17,(j-1)*detik+1:j*detik)';
            OZ{j}= record(28,(j-1)*detik+1:j*detik)';
            FPZ{j}= record(12,(j-1)*detik+1:j*detik)';
            T1{j}= record(26,(j-1)*detik+1:j*detik)'; 
            T2{j}= record(27,(j-1)*detik+1:j*detik)';

       %mySignal(:,:,j)=[FP1{j} F3{j} C3{j} P3{j} O1{j} F7{j} T3{j} T5{j} FP2{j} F4{j} C4{j} P4{j} O2{j} F8{j} T4{j} T6{j} FZ{j} CZ{j} PZ{j} OZ{j} FPZ{j} T1{j} T2{j}];
        mySignal(:,:,j)=[FP1{j} C3{j} F3{j} F7{j} O1{j} P3{j} T1{j} T3{j} T5{j} FP2{j} C4{j} F4{j} F8{j} O2{j} P4{j} T2{j} T4{j} T6{j}];
      end
end     
    

for j=1:kelompok
    RPR = 0;Delta = 0;Alpha = 0;Beta = 0;Theta = 0;DTABR=0;DAR=0;Gamma=0
    psd_data=0;k=0;npsd_epoch=0;n_epoch=0;
    F=mySignal(:,:,j);
     [Alpha,Beta,Delta,Theta,Gamma,DAR,DTABR,RPR]=mahdi2(F,Fs);     
     sprintf('memulai melakukan kalkulai PSD %i',j)
    [psd_data,k,npsd_epoch,n_epoch]=psd(F,Fs,1,25,512);
    sprintf('memulai melakukan kalkulai BSI %i',j)
    [bsi_std,bsi_ave,bsi]=BSI(psd_data,npsd_epoch,n_epoch);
      sprintf('iterasi ke %i',j)
      total_RPR(:,:,j) = RPR;
      total_delta(:,:,j) = Delta;
      total_alfa(:,:,j) = Alpha;
      total_beta(:,:,j) = Beta;
      total_Theta(:,:,j) = Theta;
      total_Gamma(:,:,j) = Gamma;
      total_DTABR(:,:,j)=DTABR;
      total_DAR(:,:,j)=DAR;
      total_psd_data(:,:,j)=psd_data;
      total_k(:,:,j)=k;
      total_npsd_epoch(:,:,j)=npsd_epoch;
      total_n_epoch(:,:,j)=n_epoch;
      total_bsi_std(:,:,j)=bsi_std;
      total_bsi_ave(:,:,j)=bsi_ave;
      total_bsi(:,:,j)=bsi;
end
 clear('RPR' ,'Alpha', 'Beta' ,'Theta','DTABR','DAR',...
     'Gamma','psd_data','k','npsd_epoch','n_epoch','bsi_std','bsi','bsi_ave','F')
 waktukalkulasi=toc;
 save(sprintf('%s.mat',EEGnames(b).name(1:length(EEGnames(b).name)-4)));
 clearvars -except EEGdir EEGnames EEGbos b
end
%% Modified by Muhammad Mahdi Ramadhan