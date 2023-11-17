waveform1 = cell2mat(wf(2,2));
s1 = size(cell2mat(wf(2,2)));
waveform2 = cell2mat(wf(2,3));
s2 = size(cell2mat(wf(2,3)));
waveform3 = cell2mat(wf(2,4));
s3 = size(cell2mat(wf(2,4)));
waveform4 = cell2mat(wf(2,5));
s4 = size(cell2mat(wf(2,5)));
waveform = [waveform1 ones(s1(1),1);waveform2 2*ones(s2(1),1);waveform3 3*ones(s3(1),1);waveform4 4*ones(s4(1),1)];

coeff = pca(waveform(:,1:64));

% waveform1_pca = waveform1 * coeff(:, 1:2);
% waveform2_pca = waveform2 * coeff(:, 1:2);
% waveform3_pca = waveform3 * coeff(:, 1:2);
% waveform4_pca = waveform4 * coeff(:, 1:2);
% 
% plot(waveform1_pca(:,1),waveform1_pca(:,2), 'o');
% hold on
% plot(waveform2_pca(:,1),waveform2_pca(:,2), 'o');
% hold on
% plot(waveform3_pca(:,1),waveform3_pca(:,2), 'o');
% hold on
% plot(waveform4_pca(:,1),waveform4_pca(:,2), 'o');
% hold on
% xlabel('Principal Component 1');
% ylabel('Principal Component 2');

%%
%根据聚类中心得出的序号对应关系idx-unit为：4-1
Spikes_pca = waveform(:,1:64) * coeff(:, 1:2);
K = 4;
[idx, centers] = kmeans(Spikes_pca, K);
Spikes_pca1 = Spikes_pca(:,1);
Spikes_pca2 = Spikes_pca(:,2);
figure(2);
for q = 1:K
    unit_x = Spikes_pca1(find(idx==q));
    unit_y = Spikes_pca2(find(idx==q));
    plot(unit_x, unit_y, 'o');
    hold on;
end
xlabel('Principal Component 1');
ylabel('Principal Component 2');
title('Spikes-PCA-Kmeans');

id1 = find(idx==1);
id4 = find(idx==4);
id2 = find(idx==2);
id3 = find(idx==3);
idx(id1)=2*ones(length(idx(id1)),1);
idx(id2)=1*ones(length(idx(id2)),1);
idx(id3)=4*ones(length(idx(id3)),1);
idx(id4)=3*ones(length(idx(id4)),1);
% 
Error = waveform(:,65)-idx;
R = (length(waveform(:,1))-length(find(Error == 0)))/length(waveform(:,1));




