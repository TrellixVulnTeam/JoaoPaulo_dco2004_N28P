N = 1e6;                            %numero de simbolos BPSK
EbN0dB = -5:2:20;                   %valores de EbN0  simular
% Transmissor
d = rand(N,1)>0.5;                  %dados binarios
x = 2*d -1;                         %simbolos BPSK: 0 representa -1 e 1 representa 1

%% Inicializacao de vetores de BER simulada e teorica
BER_rayleigh_simulada = zeros(length(EbN0dB));
BER_awgn_simulada = zeros(length(EbN0dB));

%
%%loop EbN0
for i=1:length(EbN0dB)
    %canal
    %ruido AWGN complexo com media 0 e variancia 1
    noise = 1/sqrt(2)*(randn(N,1)+j*randn(N,1));
    n = noise*10^(-EbN0dB(i)/20);
    %Desvainecimento rayleigh normalizado
    h = 1/sqrt(2)*(randn(N,1)+j*randn(N,1));
    %sinal recebido para canal somente AWGN
    y_awgn = x + n;
    %sinal recebido para desvainecimento rayleigh
    y_rayleigh = h.*x + n;
    %Equalizador
    y_rayleigh_cap=y_rayleigh./h;
    % Receptor para o canal somente AWGN
    r_awgn = real(y_awgn) > 0; 
    % Receptor para o canal rayleigh
    r_rayleigh = real(y_rayleigh_cap)>0;
    %Contador de erro para o caso com Rayleigh e AWGN
    BER_rayleigh_simulada(i) = sum(xor(d,r_rayleigh));
    % Contador de erro para o caso com somente AW
    BER_awgn_simulada(i) = sum(xor(d,r_awgn));
end
%calculo de BER para rayleigh
BER_rayleigh_simulada = BER_rayleigh_simulada/N;
%calculo de BER para awgn
BER_awgn_simulada = BER_awgn_simulada/N;
% Pe Te�rica
EbN0=10.^(EbN0dB/10);            % Eb/N0 em escala linear
% Implementa��o direta da equa��o de Pe para o canal Rayleigh+AWGN
BER_rayleigh_teorica = 0.5.*(1-sqrt(EbN0).*sqrt((1./(1+EbN0)))); 
% Implementa��o direta da equa��o de Pe para o canal somente AWGN
BER_awgn_teorica = qfunc(sqrt(2*EbN0));

%% graficos
figure
hold on
semilogy(EbN0dB(find(BER_rayleigh_simulada>0)),BER_rayleigh_simulada(find(BER_rayleigh_simulada>0)),'go')
semilogy(EbN0dB(find(BER_awgn_simulada>0)),BER_awgn_simulada(find(BER_awgn_simulada>0)),'ro')
semilogy(EbN0dB,BER_rayleigh_teorica,'k-')
semilogy(EbN0dB,BER_awgn_teorica,'b--')
