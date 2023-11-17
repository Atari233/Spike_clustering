load('indy_20161005_06.mat');
%Dataloader
Spikes = [];

for i = 1:length(wf(:,1))
    for j = 2:5
        s = size(cell2mat(wf(i,j)));
        Spikes = [Spikes; cell2mat(wf(i,j)) j*ones(s(1),1)];
    end
end

coeff = pca(Spikes(:,1:64));

figure(1);
Spikes_pca = Spikes(:,1:64) * coeff(:, 1:2);


title('PCA Reduced Data');
plot(Spikes_pca(:,1),Spikes_pca(:,2), 'o');
xlabel('Principal Component 1');
ylabel('Principal Component 2');
hold on;
title('PCA of Spike Waveforms');

%%
%进行K均值聚类
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

%%
%分类结果评估
%根据聚类中心判断idx与unit编号的对应关系为：1-1,2-4,3-3,4-2
% id2 = find(idx==2);
% id4 = find(idx==4);
% idx(id2)=4*ones(length(idx(id2)),1);
% idx(id4)=2*ones(length(idx(id4)),1);
% 
% Error = Spikes(:,65)-idx;
% length(find(Error == 0))
