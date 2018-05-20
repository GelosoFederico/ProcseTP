%% inicio del tp
close all;
clear all;

hEA = load ('SEA.mat');
h = hEA.h;
nfft = 1024;
TH = fft(h,nfft);
w = (0:nfft/2-1)/nfft*pi*2;

inverseTH = 1./TH;
absTH = abs(inverseTH);


%% Leer audio y pasar por el filtro dado del tp. Con esto se pueden escuchar
%[p4,fs] = audioread('pista_4.wav');
%salida = conv(p4,h);

%% Gráficos
%{
% Respuesta impulsiva
figure
n = 1:length(h);
stem(n, h, 'markerfacecolor','b')
xlabel('\Tiempo discreto')
ylabel('h[n]')
title('Respuesta impulsiva del filtro')
grid on

% Respuesta en frecuencia
figure
absTH = abs(inverseTH);
plot(22050*w/pi,absTH(1:length(w)),'linewidth',2); 
title(['Filtro ','.'])
ylabel('|H(e^{j\omega}|')
xlabel('f');
grid on

figure
absTH = abs(inverseTH);
plot(w/pi,absTH(1:length(w)),'linewidth',2); 
title(['Filtro ','.'])
ylabel('|H(e^{j\omega}|')
xlabel('\omega/\pi');
grid on

figure
% retardos de fase
plot(w/pi, grpdelay(h,1,nfft/2) ,'LineWidth',2)
xlabel('\omega/\pi');
ylabel('Retardo [muestras]')
grid on

figure
% Diagrama de polos y ceros de la transferencia H(z)
b = h;  % coeficientes del numerador de H(z)
a = 1;  % coeficientes del denominador de H(z)
zplane(b,a,'z');
title('Polos y ceros de H(z)')
%}