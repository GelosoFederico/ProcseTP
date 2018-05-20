%% Diseño por ventaneo con un multibanda
start %corre el script que carga las cosas

%% Parámetros más modificables
% Ws son 0.01953 0.06452 0.1016 0.1452 10.1719 0.2227 0.4375 0.4805 0.707 0.9512
Wc = [0.042*pi 0.1284*pi 0.194*pi 0.459*pi 0.8291*pi];  %Salen de promediar los omegas de a 2, pero hay que ir retocándolos para que funcione bien
Amplitudes = [2.297 0.285 3.8 0.5705 1.270 4.01];       %Salen de ver el gráfico de la inversa de H. También hay que retocarlos
min_DW = 0.1;                                           %Salen del mínimo deltaW para las bandas de transición
M = ceil( 8*pi/min_DW );                                %Usamos la ventana de Hann porque es la primera que llega al delta minimo tras corregir (0.0043/0.57)

%% Diseña
h_disenado = multibanda(Amplitudes,Wc./(2*pi),M,@hann);

%% Transformada y error
nfft = 1024;            %Este número va a ser la definición de la fft. Usamos 1024 para todos
H_disenado = fft(h_disenado, nfft); 
H_disenado = H_disenado(1:nfft/2); %Como es real usamos solo la mitad (es simetrico)

absTH = absTH(1:nfft/2);
diff_h_modulo = abs(abs(H_disenado) - absTH);


sist_total = conv(h_disenado,h); %Creo el sistema total que es la convolución del h del lugar con el diseñado

plot_diseno %corre el script para hacer los gráficos