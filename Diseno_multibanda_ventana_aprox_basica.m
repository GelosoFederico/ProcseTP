%% Diseño por ventaneo con un multibanda
start

% Ws son 0.01953 0.06452 0.1016 0.1452 0.1719 0.2227 0.4375 0.4805 0.707 0.9512
Wc = [0.042*pi 0.1234*pi 0.1973*pi 0.459*pi 0.8291*pi]; %Salen de promediar los omegas de a 2. Seria mejor poner los omegas
Amplitudes = [2.297 0.285 3.8 0.5705 1.270 4.01]; %Salen de ver el gráfico de la inversa de H. También hay que retocarlos
min_DW = 0.1;                                     %Salen del mínimo deltaW para las bandas de transición
M = ceil( 4*pi/min_DW );                         %Usamos la ventana de Hann porque es la primera que llega al delta minimo tras corregir (0.0043/0.57)


h_disenado = multibanda(Amplitudes,Wc./(2*pi),M,@hann);

nfft = 1024;
H_disenado = fft(h_disenado, nfft); 
H_disenado = H_disenado(1:nfft/2); 

absTH = absTH(1:nfft/2);
diff_h_modulo = abs(abs(H_disenado) - absTH);


sist_total = conv(h_disenado,h);

plot_diseno %corre el script para hacer los gráficos
%% Gráficos
%{
n = 0:M;
nfft = 1024;
H_disenado = fft(h_disenado, nfft); 
H_disenado = H_disenado(1:nfft/2); 

figure
% Respuesta en frecuencia
plot(w/pi,abs(H_disenado),'linewidth',2); 
title(['Filtros inversa (rojo) y diseñado (azul)','.'])
ylabel('|H(e^{j\omega}|')
xlabel('\omega/\pi');
grid on
hold on
plot(w/pi,absTH(1:length(w)),'r','linewidth',2); 
hold off

figure
% retardos de fase
plot(w/pi, grpdelay(h_disenado,1,nfft/2) ,'LineWidth',2)
xlabel('\omega/\pi');
ylabel('Retardo del h diseñado [muestras]')
grid on

n = 1:length(h);
nfft = 1024;
H_total = fft(sist_total, nfft);
H_total = H_total(1:nfft/2); 

figure
% Respuesta en frecuencia del filtro total
plot(w/pi,db(abs(H_total)),'linewidth',2); 
title(['Filtro final en dB','.'])
ylabel('|H(e^{j\omega}|')
xlabel('\omega/\pi');
grid on

figure
% retardos de fase
plot(w/pi, grpdelay(sist_total,1,nfft/2) ,'LineWidth',2)
xlabel('\omega/\pi');
ylabel('Retardo del sistema total [muestras]')
grid on

figure
% Diferencia entre el diseñado y la inversa
plot(w/pi,diff_h_modulo,'linewidth',2); 
str1 = ['Diferencia entre Hs. El max es =  ' num2str(max(diff_h_modulo)) '. La suma es ' num2str(sum(abs(diff_h_modulo))) '.'];
str2 = ['La suma hasta 0,9 \pi es ',num2str(sum(diff_h_modulo(1:ceil(nfft*0.45))))]; % 0.45pi es cuando la frecuencia es 20k, que es a lo que lelga el oido
title({str1;str2})
ylabel('|H_d(e^{j\omega}| - |H(e^{j\omega}|')
xlabel('\omega/\pi');
grid on
%}