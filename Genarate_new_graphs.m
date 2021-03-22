close all
source_num = 4;
sequence_1 = [1 3 3 1 1 1 3 3 2 3 2 2 1];
sequence_2 = [1 3 1 2 1 3 1];
adj_1 = randomGraphFromDegreeSequence(sequence_1);
adj_2 = randomGraphFromDegreeSequence(sequence_2);
adj = blkdiag(adj_1,adj_2);
adj = [adj;zeros(1,size(adj,2))];
adj = [adj zeros(size(adj,1),1)];
adj(length(sequence_1),end) = 1;
adj(length(sequence_2)+length(sequence_1),end) = 1;
figure(1)
G_1 = graph(adj_1);
p = plot(G_1,'layout','force');
figure(2)
G_2 = graph(adj_2);
p = plot(G_2,'layout','force');
figure(3)
% G_3 = graph(adj);
% p = plot(G_3,'LineWidth',4);
save("adj_not_sc.mat", "adj");

max_num = source_num+1;
while max_num >source_num 
    adj =randomDirectedGraph(20, 0.11) ;
    figure(4)
    G = digraph(adj);
    p = plot (G);
    bins = conncomp (G);
    max_num = max(bins);
    p.MarkerSize = 7;
    p.NodeCData = bins;
end
colormap (hsv (4))
save("adj_not_sc.mat", "adj");
save("adj_bins.mat", "bins");