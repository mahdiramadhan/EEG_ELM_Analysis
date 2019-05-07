%% fungsi ini merupakan gabungan dari banyak filter

function[A,B,D,T,G,DAR,DTABR,RPR]=mahdi2(mySignal,Fs)
[baris,kolom]=size (mySignal);
waveletFunction = 'db4'; 
for j=1:kolom
    if Fs==512
        [C,L] = wavedec(mySignal(:,j),7,waveletFunction);
        Gamma = wrcoef('d',C,L,waveletFunction,4); 
        Beta = wrcoef('d',C,L,waveletFunction,5);  
        Alpha = wrcoef('d',C,L,waveletFunction,6);  
        Theta = wrcoef('d',C,L,waveletFunction,7);  
        Delta = wrcoef('a',C,L,waveletFunction,7); 
    else
        [C,L] = wavedec(mySignal(:,j),6,waveletFunction);
        Gamma = wrcoef('d',C,L,waveletFunction,3);  
        Beta = wrcoef('d',C,L,waveletFunction,4);  
        Alpha = wrcoef('d',C,L,waveletFunction,5);  
        Theta = wrcoef('d',C,L,waveletFunction,6);  
        Delta = wrcoef('a',C,L,waveletFunction,6);  
    end
    
    PowerDelta(:,j) = abs(sum(Delta.^2));
    PowerTheta(:,j) = abs(sum(Theta.^2));
    PowerAlpha(:,j) = abs(sum(Alpha.^2));
    PowerBeta(:,j) = abs(sum(Beta.^2));
    PowerGamma(:,j) = abs(sum(Gamma.^2));
    total(:,j)= PowerDelta(:,j)+PowerTheta(:,j)+PowerAlpha(:,j)+PowerBeta(:,j);
    totalgamma(:,j)= PowerDelta(:,j)+PowerTheta(:,j)+PowerAlpha(:,j)+PowerBeta(:,j)+PowerGamma(:,j);
    RPRd(:,j)=PowerDelta(:,j)/total(:,j);
    RPRt(:,j)=PowerTheta(:,j)/total(:,j);
    RPRa(:,j)=PowerAlpha(:,j)/total(:,j);
    RPRb(:,j)=PowerBeta(:,j)/total(:,j);
    RPRg(:,j)=PowerGamma(:,j)/totalgamma(:,j);
    DAR(:,j)=RPRd(:,j)/RPRa(:,j);
    DTABR(:,j)=(RPRd(:,j)+RPRt(:,j))/(RPRa(:,j)+RPRb(:,j));
    A(:,j) = Alpha;
    B(:,j) = Beta;
    D(:,j) = Delta;
    G(:,j) = Gamma;
    T(:,j) = Theta;
end
%% RPR dengan gamma
RPR =[RPRd; RPRt; RPRa; RPRb; RPRg];
