j = 1;
load Combinations.mat
r = randi([1 N],1,10000);
N = 490314;
K = 10000;
ep = 1e-9;              % Epsilon
T = 1;                  % Integration termination time
Div = 1000;
smEnergy = zeros(1,20);
EnergyInd = zeros(1,20);
EnergyDegree = zeros(1,20);

load adjDegree.mat
run EnergyOfRandomNetwork.m
smEnergy = lowEnergy;
EnergyInd(j) = lowEnergyInd;
EnergyDegree(j) = lowEnergyDegree;
j = j+1;

load adjG2.mat
run EnergyOfRandomNetwork.m
smEnergy(j) = lowEnergy;
EnergyInd(j) = lowEnergyInd;
EnergyDegree(j) = lowEnergyDegree;
j = j+1;

load adjG2.mat
run EnergyOfRandomNetwork.m
smEnergy(j) = lowEnergy;
EnergyInd(j) = lowEnergyInd;
EnergyDegree(j) = lowEnergyDegree;
j = j+1;

load adjG3.mat
run EnergyOfRandomNetwork.m
smEnergy(j) = lowEnergy;
EnergyInd(j) = lowEnergyInd;
EnergyDegree(j) = lowEnergyDegree;
j = j+1;

load adjG4.mat
run EnergyOfRandomNetwork.m
smEnergy(j) = lowEnergy;
EnergyInd(j) = lowEnergyInd;
EnergyDegree(j) = lowEnergyDegree;
j = j+1;

load adjG5.mat
run EnergyOfRandomNetwork.m
smEnergy(j) = lowEnergy;
EnergyInd(j) = lowEnergyInd;
EnergyDegree(j) = lowEnergyDegree;
j = j+1;

load adjG6.mat
run EnergyOfRandomNetwork.m
smEnergy(j) = lowEnergy;
EnergyInd(j) = lowEnergyInd;
EnergyDegree(j) = lowEnergyDegree;
j = j+1;

load adjG7.mat
run EnergyOfRandomNetwork.m
smEnergy(j) = lowEnergy;
EnergyInd(j) = lowEnergyInd;
EnergyDegree(j) = lowEnergyDegree;
j = j+1;

load adjG8.mat
run EnergyOfRandomNetwork.m
smEnergy(j) = lowEnergy;
EnergyInd(j) = lowEnergyInd;
EnergyDegree(j) = lowEnergyDegree;
j = j+1;

load adjG9.mat
run EnergyOfRandomNetwork.m
smEnergy(j) = lowEnergy;
EnergyInd(j) = lowEnergyInd;
EnergyDegree(j) = lowEnergyDegree;
j = j+1;

load adjG10.mat
run EnergyOfRandomNetwork.m
smEnergy(j) = lowEnergy;
EnergyInd(j) = lowEnergyInd;
EnergyDegree(j) = lowEnergyDegree;
j = j+1;

load adjG11.mat
run EnergyOfRandomNetwork.m
smEnergy(j) = lowEnergy;
EnergyInd(j) = lowEnergyInd;
EnergyDegree(j) = lowEnergyDegree;
j = j+1;

load adjG12.mat
run EnergyOfRandomNetwork.m
smEnergy(j) = lowEnergy;
EnergyInd(j) = lowEnergyInd;
EnergyDegree(j) = lowEnergyDegree;
j = j+1;

load adjG13.mat
run EnergyOfRandomNetwork.m
smEnergy(j) = lowEnergy;
EnergyInd(j) = lowEnergyInd;
EnergyDegree(j) = lowEnergyDegree;
j = j+1;

load adjG14.mat
run EnergyOfRandomNetwork.m
smEnergy(j) = lowEnergy;
EnergyInd(j) = lowEnergyInd;
EnergyDegree(j) = lowEnergyDegree;
j = j+1;

load adjG15.mat
run EnergyOfRandomNetwork.m
smEnergy(j) = lowEnergy;
EnergyInd(j) = lowEnergyInd;
EnergyDegree(j) = lowEnergyDegree;
j = j+1;

load adjG16.mat
run EnergyOfRandomNetwork.m
smEnergy(j) = lowEnergy;
EnergyInd(j) = lowEnergyInd;
EnergyDegree(j) = lowEnergyDegree;
j = j+1;

load adjG17.mat
run EnergyOfRandomNetwork.m
smEnergy(j) = lowEnergy;
EnergyInd(j) = lowEnergyInd;
EnergyDegree(j) = lowEnergyDegree;
j = j+1;

load adjG18.mat
run EnergyOfRandomNetwork.m
smEnergy(j) = lowEnergy;
EnergyInd(j) = lowEnergyInd;
EnergyDegree(j) = lowEnergyDegree;
j = j+1;

load adjG19.mat
run EnergyOfRandomNetwork.m
smEnergy(j) = lowEnergy;
EnergyInd(j) = lowEnergyInd;
EnergyDegree(j) = lowEnergyDegree;
j = j+1;

load adjG20.mat
run EnergyOfRandomNetwork.m
smEnergy(j) = lowEnergy;
EnergyInd(j) = lowEnergyInd;
EnergyDegree(j) = lowEnergyDegree;
j = j+1;



