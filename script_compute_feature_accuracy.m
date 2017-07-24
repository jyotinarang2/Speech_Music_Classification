iBlockLength = 4096;
iHopLength = 2048;
speechMusicData = processData();
[features,classification_label] = computeFeaturesFromDataset(speechMusicData,iBlockLength, iHopLength);
shuffled_index = randperm(length(classification_label));
shuffled_class = classification_label(shuffled_index,:);
shuffled_data = features(shuffled_index,:);
normalized = zscore(shuffled_data);
normalized = normalized/2;
%-t in the parameters indicates the kernel type .
% -t kernel_type : set type of kernel function (default 2)
%     0 -- linear: u'*v
%     1 -- polynomial: (gamma*u'*v + coef0)^degree
%     2 -- radial basis function: exp(-gamma*|u-v|^2)
%     3 -- sigmoid: tanh(gamma*u'*v + coef0)
%     4 -- precomputed kernel (kernel values in training_instance_matrix)
model = svmtrain(shuffled_class(1:3500),normalized(1:3500,:),'-c 1 -g 0.4 -b 1 -t 2');