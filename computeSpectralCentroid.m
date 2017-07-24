%-----------------------------------------------------%
%@brief :compute Spectral Centroid
%@param(X) : the frequency spectrum of the input signal
%------------------------------------------------------
function feature_spectral_centroid = computeSpectralCentroid(X, fs)
% iNumOfBlocks    = ceil (length(X)/iBlockLength);
% feature_spectral_centroid = zeros(iNumOfBlocks,3);
% for k=1:iNumOfBlocks
%     start_sample = (k-1)*iBlockLength+1;
%     end_sample = min(start_sample+iBlockLength-1,length(X));
%     M = X(start_sample:end_sample);
%     block_centroid = ([0:size(M)-1]*M)/sum(M);
%     feature_spectral_centroid(k,1) = block_centroid;
%     feature_spectral_centroid(k,2) = start_sample;
% end
feature_spectral_centroid = ([0:size(X,1)-1]*X)./sum(X,1);
% avoid NaN for silence frames
feature_spectral_centroid (sum(X,1) == 0) = 0;
        
end