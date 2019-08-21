% limpa vari�veis, a tela e fecha todos os gr�ficos existentes
clear all;clc;close all; 
dPasso = 5;                             % Resolu��o do grid
dDim = 200;                             % Dimens�o do grid
nl = (dDim-2*dPasso)/dPasso + 1;        % N�mero de pontos de medi��o
%% C�digo com la�o FOR
t1 = tic;                               % Abre um contador de tempo identificado por t1
% Matriz com posi��o de cada ponto do grid (posi��o relativa ao canto inferior direito)
for il = 1:nl 
    for ic = 1:nl
        px(il,ic) = dPasso + (ic-1)*dPasso;
        py(ic,il) = px(il,ic);
    end
end
% Matrizes de posi��o e pot�ncia recebida
for il = 1:nl
    for ic = 1:nl
        % Matrizes com posi��o de cada ponto do grid relativa a cada roteador
        pbs0(il,ic) = px(il,ic) + j*py(il,ic) - ( dDim/2 + 0.8*dDim*j); % Roteador 0
        pbs1(il,ic) = px(il,ic) + j*py(il,ic) - ( dDim/2 + 0.2*dDim*j); % Roteador 1
        pbs2(il,ic) = px(il,ic) + j*py(il,ic) - (dDim*0.8 + 0.5*dDim*j); % Roteador2
        % C�lculo da pot�ncia recebida em cada ponto do grid, recebida de cada roteador
        pl0(il,ic) = 10*log10(1/abs(pbs0(il,ic))^4/1e-3); % Roteador 0
        pl1(il,ic) = 10*log10(1/abs(pbs1(il,ic))^4/1e-3); % Roteador 1
        pl2(il,ic) = 10*log10(1/abs(pbs2(il,ic))^4/1e-3); % Roteador 2
        % c�lculo da melhor pot�ncia em cada ponto do grid
        plf(il,ic) = max(pl0(il,ic), pl1(il,ic));
        plf(il,ic) = max(plf(il,ic), pl2(il,ic));
    end
end
tempoComFor = toc(t1); % Fecha contador de tempo e guarda tempo na vari�vel tempoComFor
disp(['Tempo com La�o FOR = ' num2str(tempoComFor)]);   % Mostra tempo de execu�ao do c�digo
%% Gr�ficos para c�digo com la�o for
% Plota as posi�oes dos pontos do grid para os dois roteadores
subplot(1,3,1); plot(pbs0,'k.'); title('Roteador 0 com La�o');
subplot(1,3,2); plot(pbs1,'k.'); title('Roteador 1 com La�o');
subplot(1,3,3); plot(pbs2,'k.'); title('Roteador 2 com La�o');
figure;
% Plota a mapa de cores relativo a pot�ncia para os dois roteadores separadamente
subplot(1,3,1); pcolor(pl0); title('Roteador 0 com La�o');
subplot(1,3,2); pcolor(pl1); title('Roteador 1 com La�o');
subplot(1,3,3); pcolor(pl2); title('Roteador 2 com La�o');
figure;
% Plota a mapa de cores realtivo a melhor pot�ncia em cada ponto do grid (melhor entre os dois roteadores)
pcolor(plf);title(['Sistema com La�o - tempo ' num2str(tempoComFor)]);