
clear all
addpath('./NetworkAnalysisTool');


load adj_not_sc_big.mat
load adj_bins.mat
adjG = adj;


K = 8;                  % Cardinality constraints  
ep = 1e-12;              % Epsilon
T = 1;                  % Integration termination time
Div = 1000;              % Integration resolution (division of the total time)
switchM = 1;
max_bin = max(bins);
siz.T = T;
siz.Div = Div;
siz.K = K;
siz.ep = ep;

% Measure the graph 
[x_1,y_1] = size(adjG);
siz.x_1 = x_1;
adjG_topo = zeros(x_1,y_1);
if x_1 ~= y_1 
  error('Adj not square!');
end
% if isConnected(abs(adjG)) == 0
%     error(' The graph entered is not connected.');
% end

% Give the topological information for the graph.
for i = 1 : x_1
  for j = 1 : y_1
    if adjG(i,j) ~= 0
      adjG_topo(i,j) = 1;
    end
  end
end

% Determine whether the cardinality constraint is adequate.
CardEnoicon = isCardEnough(adjG_topo,K,x_1);
if CardEnoicon == 0
  error(' The allowed cardinality is too small! ');
end

% Constructing the initial bipartite graph
inputNode = [];
potSelection = [];
auxGSTadj = zeros(3 * x_1 + 2,3 * x_1 + 2);
auxGSTadj(2 : (x_1 + 1) , (2 * x_1+2):(3 * x_1 + 1)) = adjG_topo;
auxGSTadj(1 , 2 : (2 * x_1 + 1) ) = ones(1,2 * x_1);
auxGSTadj((2 * x_1 + 2) : (3 * x_1 + 1) , 3 * x_1 + 2) = ones(x_1,1);

% Constructing the strongly connected components and find those with no
% incoming edges
sc_cell = cell(1,max_bin);
sc_no_in_index = [];

for k = 1 : max_bin
    sc_kth = find(bins == k);
    sc_cell{1,k} = sc_kth;
end

for k = 1 : max_bin
    sc_kth = sc_cell{1,k};
    
    other_nodes = [];
    for sc_index = 1 : max_bin
        if sc_index ~= k
            other_nodes = [other_nodes sc_cell{1,sc_index}];
        end
    end
    in_sum = sum(adjG(sc_kth,other_nodes));

    if in_sum == 0
        sc_no_in_index = [sc_no_in_index k];
    end
end

%% Actuator Placement for Accessibility
auxGSTadj_ori = auxGSTadj;
num_no_in = length(sc_no_in_index);
S_0 = [];
for i = 1 : num_no_in
    sc_i = sc_cell{1,sc_no_in_index(i)};
    n_element_i_sc = length(sc_i);
    cost_record = [];
    for j = 1 : n_element_i_sc
        S_0_copy = [S_0 j];
        if k_expandable(inputNode, auxGSTadj, K, x_1) == 0
            cost_record = [cost_record NaN];
            continue
        end
        cost_record = [cost_record obj2(T,Div,adjG,S_0_copy,ep)];
    end
    [~,cost_min_ind] = min(cost_record);
    cost_min_ind = cost_min_ind(1);
    S_0 = [S_0 sc_i(cost_min_ind)];    
end
S_0 = s0_mani(S_0);

disp('*****************')
fprintf ('The initial set is:')
fprintf ('% g,', S_0(1,1:end-1));
fprintf ('% g. \n', S_0(1,end));

%% Actuator Placement for Dilation-Freeness
[inputNode_S0,objep_S0] = FGD(S_0,auxGSTadj,adjG,siz);
S_0 = [];
disp('*****************')
fprintf ('The set given by FG is:')
fprintf ('% g,', inputNode_S0(1:end-1));
fprintf ('% g. \n', inputNode_S0(end));
fprintf ('The resulting objective is: % d. \n',objep_S0)


tic
[inputNode,objep] = FGD(S_0,auxGSTadj,adjG,siz);
toc
warning('off','all')

%% Long-Horizon Actuator Placement (starting from empty set)
tic
auxGSTadj = auxGSTadj_ori;
inputNode_lh = [];
for i = 1 : K
    potSelection = [];
    for j = 1 : x_1
        if ismember(j,inputNode_lh) == 1
          continue
        end
        auxGSTadj_temp = in_to_adj(auxGSTadj_ori,[inputNode_lh j],x_1);
        [valf,~] = findMaxflow(auxGSTadj_temp);
        if valf < (siz.x_1 - siz.K + i) 
          continue
        else
        potSelection = [potSelection j];
        end
    end
    costs = [];
    for k = 1 : length(potSelection)
        inputNode_temp = [inputNode_lh potSelection(k)];
        [~,obj] = FGD(inputNode_temp,auxGSTadj_ori,adjG,siz);
        costs = [costs, obj];
    end
    [~,ind] = min(costs);
    new_selec = potSelection(ind);
    inputNode_lh = [inputNode_lh new_selec];
end
objep_lh = obj2(siz.T,siz.Div,adjG,inputNode_lh,siz.ep);
toc

disp('*****************')
fprintf ('\nThe set given by LHFG is:')
fprintf ('% g,', inputNode_lh(1:end-1));
fprintf ('% g. \n', inputNode_lh(end));
fprintf ('The resulting objective is: % d.\n',objep_lh)

%% LHFG with a shorter horizon
tic
auxGSTadj = auxGSTadj_ori;
inputNode_sh = [];
for i = 1 : K
    potSelection = [];
    for j = 1 : x_1
        if ismember(j,inputNode_sh) == 1
          continue
        end
        auxGSTadj_temp = in_to_adj(auxGSTadj_ori,[inputNode_lh j],x_1);
        [valf,~] = findMaxflow(auxGSTadj_temp);
        if valf < (siz.x_1 - siz.K + i) 
          continue
        else
        potSelection = [potSelection j];
        end
    end
    costs = [];
    for k = 1 : length(potSelection)
        inputNode_temp = [inputNode_sh potSelection(k)];
        [~,obj] = FGD_sh(inputNode_temp,auxGSTadj_ori,adjG,siz,3);
        costs = [costs, obj];
    end
    [~,ind] = min(costs);
    new_selec = potSelection(ind);
    inputNode_sh = [inputNode_sh new_selec];
end

objep_sh = obj2(siz.T,siz.Div,adjG,inputNode_sh,siz.ep);
toc

disp('*****************')
fprintf ('\n The set given by LHFG with horizon 3 is:')
fprintf ('% g,', inputNode_sh(1:end-1));
fprintf ('% g. \n', inputNode_sh(end));
fprintf ('The resulting objective is: % d.',objep_sh)






%%%%%%%%%%%%%%%%%% functions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function yes_or_no = k_expandable(inputNode, auxGSTadj_ori, K, x_1)
    n_input = length(inputNode);
    for i = 1 : n_input
        auxGSTadj_ori(x_1 + inputNode(i) + 1, 2 * x_1 + inputNode(i)  + 1) = 1; 
    end
    [valf,~] = findMaxflow(auxGSTadj_ori);
    if valf < (x_1 - K + n_input) 
        yes_or_no = 0;
    else
        yes_or_no = 1;
    end
end

function auxGSTadj = in_to_adj(auxGSTadj_ori,inputNode,x_1)
    n_input = length(inputNode);
    for i = 1 : n_input
        auxGSTadj_ori(x_1 + inputNode(i) + 1, 2 * x_1 + inputNode(i)  + 1) = 1; 
    end
    auxGSTadj = auxGSTadj_ori;
end

function [inputNode,objep] = FGD(S_0,auxGSTadj,adjG,siz)

    potSelection = [];
    auxGSTadj = in_to_adj(auxGSTadj,S_0,siz.x_1);
    inputNode = S_0;
    ini_num = length(S_0);

    for i = 1 : siz.K - ini_num
      for j = 1 : siz.x_1
        if ismember(j,inputNode) ~= 1
          auxGSTadj_copy = auxGSTadj;
          auxGSTadj_copy(siz.x_1 + j + 1, 2 * siz.x_1 + j + 1) = 1; 
        else
          continue
        end
        [valf,~] = findMaxflow(auxGSTadj_copy);
        if valf < (siz.x_1 - siz.K + ini_num + i) 
          continue
        else
        potSelection = [potSelection j];
        end
      end

      multiObj = [];
      for k = 1 : length(potSelection)
        valobj = obj2(siz.T,siz.Div,adjG,[inputNode potSelection(k)],siz.ep);
        multiObj = [multiObj valobj];
      end
      [~,newSelectionind] = min(multiObj);
      newSelection = potSelection(newSelectionind);
      inputNode = [inputNode newSelection];
      auxGSTadj(siz.x_1 + newSelection + 1 , 2 * siz.x_1 + newSelection + 1) = 1;
      potSelection = [];
    end

    objep = obj2(siz.T,siz.Div,adjG,inputNode,siz.ep);
    obj0 = obj2(siz.T,siz.Div,adjG,inputNode,0);
end

function [inputNode,objep] = FGD_sh(S_0,auxGSTadj,adjG,siz,h)

    potSelection = [];
    auxGSTadj = in_to_adj(auxGSTadj,S_0,siz.x_1);
    inputNode = S_0;
    ini_num = length(S_0);
    

    for i = 1 : siz.K - ini_num 
      if i > h
          continue
      end
      for j = 1 : siz.x_1
        if ismember(j,inputNode) ~= 1
          auxGSTadj_copy = auxGSTadj;
          auxGSTadj_copy(siz.x_1 + j + 1, 2 * siz.x_1 + j + 1) = 1; 
        else
          continue
        end
        [valf,~] = findMaxflow(auxGSTadj_copy);
        if valf < (siz.x_1 - siz.K + ini_num + i) 
          continue
        else
        potSelection = [potSelection j];
        end
      end

      multiObj = [];
      for k = 1 : length(potSelection)
        valobj = obj2(siz.T,siz.Div,adjG,[inputNode potSelection(k)],siz.ep);
        multiObj = [multiObj valobj];
      end
      [~,newSelectionind] = min(multiObj);
      newSelection = potSelection(newSelectionind);
      inputNode = [inputNode newSelection];
      auxGSTadj(siz.x_1 + newSelection + 1 , 2 * siz.x_1 + newSelection + 1) = 1;
      potSelection = [];
    end

    objep = obj2(siz.T,siz.Div,adjG,inputNode,siz.ep);
end

