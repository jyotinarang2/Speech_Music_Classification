%------------------------------------------------------------------------------------------%
%@brief:function to compute spectral rollOff
%@param(X) : spectrogram of the input signal
%@retval spectral_rolloff_feature_vector(in Hz)
%------------------------------------------------------------------------------------------%

function spectral_rolloff_feature_vector = computeSpectralRollOff(X , fs, kappa)
% iNumOfBlocks    = ceil (length(X)/iBlockLength);
% spectral_rolloff_feature_vector = zeros(iNumOfBlocks,3);
% for k=1:iNumOfBlocks
%     start_sample = (k-1)*iBlockLength+1;
%     end_sample = min(start_sample+iBlockLength-1,length(X));
%     sumFrequency = sum(X(start_sample:end_sample));
%     index = find(cumsum(X(start_sample:end_sample)) >= kappa*sumFrequency,1);
%     spectral_rolloff_feature_vector(k,1) = index; %Coversion to Hz has not been done yet
%     spectral_rolloff_feature_vector(k,2) = start_sample;
% end
spectral_rolloff_feature_vector = zeros(1,size(X,2));
%compute rolloff
afSum   = sum(X,1);
for (n = 1:size(X,2))
    spectral_rolloff_feature_vector(n)  = find(cumsum(X(:,n)) >= kappa*afSum(n), 1); 
end
end