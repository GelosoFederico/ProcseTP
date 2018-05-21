%% Diseño por cuadrados mínimos
close all;
start

f = [0 0.01952 0.06452 0.1016 0.1452 0.1719 0.2227 0.4375 0.4805 0.707 0.8105 0.9512]; %Frecuencias a las que indico valores
A = [2.297 2.321 0.3026 0.2951 3.84 3.827 0.575 0.595 1.26 1.33 1.845 4.014];
min_DW = 0.1;
deltas = [0.0156 0.0726 0.04658 0.008408 0.055 0.1];
M = round((-10*log10(min(deltas))-13)/(2.324 * min_DW));
if mod(M,2)==1
    M = M+1;
end
inv_deltas = 1./deltas;

% respuesta impulsiva del filtro
h_disenado = firls(M, f, A, inv_deltas);

nfft = 1024;
H_disenado = fft(h_disenado, nfft); 
H_disenado = H_disenado(1:nfft/2); 

absTH = absTH(1:nfft/2);
diff_h_modulo = abs(abs(H_disenado) - absTH);


sist_total = conv(h_disenado,h);
plot_diseno

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