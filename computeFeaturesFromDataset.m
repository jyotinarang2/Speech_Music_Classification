function [features,classification_label] = computeFeaturesFromDataset(speechMusicData,iBlockLength, iHopLength)
music_files = speechMusicData.music_files;
speech_files = speechMusicData.speech_files;
basePath = 'C:\Users\jyoti\Desktop\speechmusic data\music_speech\music_speech';
slashType = '\';
music_folder = 'music_wav';
speech_folder = 'speech_wav';
features = [];
%Read the music files
classification_label = [];
for k=1:length(music_files)
    file = [basePath slashType music_folder slashType music_files(k).name];
    [y,Fs]=audioread(char(file));
    disp('Reading audio file..');
    disp(music_files(k).name);
    y = y/max(y);
    [rms_feature_vector, segment_start] = computeRmsFeature(y, iBlockLength, iHopLength, Fs);
    afWindow = hann(iBlockLength,'periodic');
    [X,f,t]     = spectrogram(  [y; zeros(iBlockLength,1)],...
                                    afWindow,...
                                    iBlockLength-iHopLength,...
                                    iBlockLength,...
                                    Fs);
    X = abs(X)*2/iBlockLength;
    spectral_mfcc = [];
    spectral_mfcc = computeSpectralMfcc(X, Fs);
    spectral_rolloff_feature_vector = computeSpectralRollOff(X, Fs, 0.85);
    spectral_rolloff_feature_vector = spectral_rolloff_feature_vector';
    [zero_crossings,t] = computeTimeZeroCrossing(y, iBlockLength, iHopLength, Fs);
    zero_crossings = zero_crossings';
    spectral_spread = computeFeatureSpectralSpread(X, Fs);
    spectral_spread = spectral_spread';
    spectral_slope = computeFeatureSpectralSlope(X, Fs);
    spectral_slope = spectral_slope';
    music_vector = [rms_feature_vector spectral_slope zero_crossings spectral_mfcc(2,:)' spectral_rolloff_feature_vector ...
        spectral_mfcc(4,:)' spectral_mfcc(13,:)' spectral_mfcc(11,:)' spectral_mfcc(1,:)' spectral_mfcc(12,:)' spectral_spread];
    classification_label = [classification_label;ones(length(rms_feature_vector),1)];
    features = [features;music_vector];
end
for k=1:length(speech_files)
    file = [basePath slashType speech_folder slashType speech_files(k).name];
    [y,Fs]=audioread(char(file));
    disp('Reading audio file..');
    disp(speech_files(k).name);
    y = y/max(y);
    [rms_feature_vector, segment_start] = computeRmsFeature(y, iBlockLength, iHopLength, Fs);
    afWindow = hann(iBlockLength,'periodic');
    [X,f,t]     = spectrogram(  [y; zeros(iBlockLength,1)],...
                                    afWindow,...
                                    iBlockLength-iHopLength,...
                                    iBlockLength,...
                                    Fs);
    X = abs(X)*2/iBlockLength;
    spectral_mfcc = [];
    spectral_mfcc = computeSpectralMfcc(X, Fs);
    spectral_rolloff_feature_vector = computeSpectralRollOff(X, Fs, 0.85);
    spectral_rolloff_feature_vector = spectral_rolloff_feature_vector';
    [zero_crossings,t] = computeTimeZeroCrossing(y, iBlockLength, iHopLength, Fs);
    zero_crossings = zero_crossings';
    spectral_spread = computeFeatureSpectralSpread(X, Fs);
    spectral_spread = spectral_spread';
    spectral_slope = computeFeatureSpectralSlope(X, Fs);
    spectral_slope = spectral_slope';
    speech_vector = [rms_feature_vector spectral_slope zero_crossings spectral_mfcc(2,:)' spectral_rolloff_feature_vector ...
        spectral_mfcc(4,:)' spectral_mfcc(13,:)' spectral_mfcc(11,:)' spectral_mfcc(1,:)' spectral_mfcc(12,:)' spectral_spread];
    features = [features;speech_vector];
    classification_label = [classification_label;zeros(length(rms_feature_vector),1)];
end
end