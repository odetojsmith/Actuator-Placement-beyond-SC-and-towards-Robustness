load adj_not_sc.mat
adj_small = [0 0 0 0 0;1 0 1 0 0 ; 0 1 0 1 0; 0 0 0 0 1; 0 0 0 0 0]';
adj_big = blkdiag(adj_small,adj);
G_big = digraph(adj_big);
p = plot(G_big);
bins = conncomp (G_big);
p.MarkerSize = 12;
p.NodeCData = bins;
adj = adj_big;
G = digraph(adj);
bins = conncomp(G);
save("adj_not_sc_big.mat", "adj");
save("adj_bins.mat", "bins");
