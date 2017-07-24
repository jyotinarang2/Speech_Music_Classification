function feature_spectral_mfcc = computeSpectralMfcc(X, fs)
iNumCoeffs = 13;
%iNumOfBlocks    = ceil (length(X)/iBlockLength);
feature_spectral_mfcc = zeros(iNumCoeffs,size(X,2));
H = ToolMfccFb(size(X,1),fs);
T = GenerateDctMatrix(size(H,1),iNumCoeffs);
for k=1:size(X,2)
    % compute the mel spectrum
    X_Mel       = log10(H * X(:,k)+1e-20);

    % calculate the mfccs
    feature_spectral_mfcc(:,k)  = T * X_Mel;
    
    
end
end