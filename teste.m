

close all;clc;clear all;
% Parâmetros
peSim = 64;                                        % Período do símbolo (amostras/símbolo)
nsCL = 4;                                          % Número de símbolos o cosseno levantado se espalhará (ISI)
roff = 0.25;                                       % Fator de decaimento do cosseno levantado
nSimbs = 400;                                      % Número de símbolos transmitidos 
vtSim = 2*randi([0 1], 1, nSimbs)-1;               % Símbolos
dup = upsample(vtSim,peSim);                       % Símbolos (sobreamostragem)
hrc = rcosfir(roff, nsCL, peSim,1,'normal');
length(hrc)
find(hrc==min(hrc))
4*peSim*2+1
a=2*nsCL*peSim;
t = -a:nsCL/2:a
length(t)==length(hrc)

plot(hrc)
