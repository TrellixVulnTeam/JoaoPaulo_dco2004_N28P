close all; clear all; clc;
%% Par�metros
T=0.002;                                                % Taxa de amostragem (500kHz)
Tf=1;                                                   % Tempo final em segundos
t=0:T:Tf-T;                                             % Defini��o do eixo do tempo      
fm1=3;                                                  % Frequ�ncia senoide 1      
fm2=1;                                                  % Frequ�ncia senoide 2
m_t=sin(2*pi*fm2*t)-sin(2*pi*fm1*t);                    % Sinal mensagem m(t)
ts=0.02;                                                % Nova taxa de amostragem (para cima e para baixo)
N_samp=round(ts/T);                                     % N�mero de elementos 
% T/ts deve ser, preferencialmente, inteiro.

%% Amostragem 
s_out=downsample(m_t,N_samp);                           % Coleta 1 amostra a cada N_samp amostras do sinal  
s_out=upsample(s_out,N_samp);                           % Retorna vetor amostrado com o n�mero inicial de elementos

%% Espectro do sinal de entrada
lfft=length(m_t);                                       % Comprimento da fft
M_f=fftshift(fft(m_t,lfft)/lfft);                       % Sinal m_t na frequ�ncia 
S_out=fftshift(fft(s_out,lfft)/lfft);                   % Sinal s_out na frequ�ncia
Fs=1/T;
freq=-Fs/2:Fs/lfft:Fs/2-Fs/lfft;

%% Salva todas as vari�veis da �rea de trabalho (caso necess�rio, descomentar as linhas abaixo)
filename = 'Amostragem.mat';
save(filename);

%% Plotting
% Plot do sinal no tempo
fig = figure;
subplot(2,2,[1 2]);
plot(t,s_out);
hold on;
plot(t,m_t);
title('Sinal Original e Sinal Amostrado');
xlabel('Tempo [s]');
ylabel('Amplitude');

% Plot do sinal na frequ�ncia
subplot(2,2,3);
plot(freq,abs(M_f));
title('M(f)');
axis([-50 50 0 0.56]);
subplot(2,2,4);
plot(freq,abs(S_out));
title('M(f) do sinal amostrado');
axis([-120 120 0 0.06]);

fig.PaperUnits = 'inches';
fig.PaperPosition = [0 0 9 3];