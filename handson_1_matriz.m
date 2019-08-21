clear all;clc;close all;
dPasso = 5;                          % Resolu��o do grid
dDim = 200;                          % Dimens�o do grid
nl = (dDim-2*dPasso)/dPasso + 1;     % N�mero de pontos de medi��o
%% C�digo sem La�o
t2 = tic;                            % Abre um contador de tempo identificado por t2
% Matriz com posi��o de cada ponto do grid (posi��o relativa ao canto inferior direito)
[px,py] = meshgrid(dPasso:dPasso:dDim-dPasso, dPasso:dPasso:dDim-dPasso);
% Matrizes com posi��o de cada ponto do grid relativa a cada BS
pbs0SF = px + j*py - ( dDim/2 + 0.8*dDim*j);
pbs1SF = px + j*py - ( dDim/2 + 0.2*dDim*j);
pbs2SF = px + j*py - ( 0.8*dDim + 0.5*dDim*j);
% C�lculo da pot�ncia recebida em cada roteador
pl0SF = 10*log10(1./(abs(pbs0SF).^4)/1e-3);
pl1SF = 10*log10(1./(abs(pbs1SF).^4)/1e-3);
pl2SF = 10*log10(1./(abs(pbs2SF).^4)/1e-3);
% C�lculo da melhor pot�ncia e cada ponto do grid
plfSF = max(pl0SF,pl1SF);
plfSF = max(plfSF,pl2SF);
tempoSemFor = toc(t2); % fecha contador de tempo e guarda tempo na vari�vel tempoComFor
disp(['Tempo sem La�o FOR = ' num2str(tempoSemFor)]); % Mostra tempo de execu�ao do c�digo
%% Gr�ficos para c�digo com e sem la�os for
% Plota as posi�oes dos pontos do grid para os dois roteadores
subplot(1,3,1); plot(pbs0SF,'k.');title('Roteador 0 sem La�o');
subplot(1,3,2); plot(pbs1SF,'k.');title('Roteador 1 sem La�o');
subplot(1,3,3); plot(pbs2SF,'k.');title('Roteador 2 sem La�o');

figure;
% Plota a mapa de cores relativo a pot�ncia para os dois roteadores separadamente
subplot(1,3,1); pcolor(pl0SF);title('Roteador 0 sem La�o');
subplot(1,3,2); pcolor(pl1SF);title('Roteador 1 sem La�o');
subplot(1,3,3); pcolor(pl2SF);title('Roteador 2 sem La�o');

figure;
% Plota a mapa de cores relativo a melhor pot�ncia em cada ponto do grid (melhor entre os dois roteadores)
pcolor(plfSF);title(['Sistema sem La�o - tempo ' num2str(tempoSemFor)]);