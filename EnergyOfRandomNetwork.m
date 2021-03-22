% n = 50
% M_cobo = nchoosek(1:(n-i),numberofPick);

ener = zeros(1,K)
for i = 1 : K
    ener(i) = obj2(T,Div,adjG, M_cobo(r(i),:), ep);
    if i == 1
        lowEnergy = ener(i);
    end
    if ener(i) < lowEnergy
        lowEnergy = ener(i);
        lowEnergyInd = i; 
    end
end
lowEnergyDegree = sum(sum(adjG(M_cobo(r(lowEnergyInd),:),:)));