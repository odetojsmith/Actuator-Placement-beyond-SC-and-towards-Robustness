# Actuator-Placement-beyond-SC-and-towards-Robustness

This project is for the paper "Actuator Placement for Structural Controllability beyond Strong Connectivity and towards Robustness", co-authored by Baiwei Guo, Orcun Karaca, Sepide Azhdari, Maryam Kamgarpour, Giancarlo Ferrari-Trecate. 

To run the codes, one needs to add the network analysis tool box, which can be downloaded at https://aeolianine.github.io/octave-networks-toolbox/. The folder of this toolbox should be placed in the same directory as "main.m" and renamed as "NetworkAnalysisTool".Notice that this network toolbox is originally developed in Octave, thus, not all commands work in Matlab. If the compiler reports an error regarding "printf", please comment that line out in the toolbox.

The graph shown in Fig. 3 in the paper is encoded in "adj_not_sc_big.mat". The m-file "main.m" is the main code to realize initial set selection, forward greedy algorithm and long-horizon forward greedy algorithm. The selected actuators and the corresponding costs are recorded. 

In the final result, "objep_S0" records the objective function with epsilon derived by FG based on the initial set S_0. "objep_lh" is that derived by LHFG while "objep_sh" with a shorter horizon.


Feel free to contact me for any queries via email.

Baiwei Guo, Automatic Control Laboratory, EPFL

E-mail: baiwei.guo@epfl.ch

