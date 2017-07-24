%----------------------------------------
%Compue the Rms of the audio signal y %
%@Param(x) - The input audio vector
%@Param(fs) - Sampling rate of the input audio signal %
%@retval - rms vector and segment vector containing rms value , block number
%@retval - final time domain vector post rms thresholding which will be
%used later for computation of specteal and harmonic features
%----------------------------------------
function [rms_feature_vector, segment_start] = computeRmsFeature(x, iBlockLength, iHopLength, fs)

%Compute the number of blocks
iNumOfBlocks    = ceil (length(x)/iHopLength);

%Allocate memory for computation
rms_feature_vector = zeros(iNumOfBlocks,1);

%Allocate memory for storing the start segment
segment_start = zeros(iNumOfBlocks,1);

epsilon = 1e-5; %-100dB

for k=1:iNumOfBlocks
    start_sample = (k-1)*iHopLength+1;
    end_sample = min(start_sample+iBlockLength-1,length(x));
    rms_feature_vector(k) = rms(x(start_sample:end_sample));
    segment_start(k) = start_sample; 

end
%convert to DB
rms_feature_vector(rms_feature_vector < epsilon)    = epsilon;
rms_feature_vector                    = 20*log10(rms_feature_vector);
end