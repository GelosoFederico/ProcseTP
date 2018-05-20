%% Dise�o por ventaneo con un multibanda
start %corre el script que carga las cosas

%% Par�metros m�s modificables
% Ws son 0.01953 0.06452 0.1016 0.1452 10.1719 0.2227 0.4375 0.4805 0.707 0.9512
Wc = [0.0365*pi 0.133*pi 0.1872*pi 0.459*pi 0.78*pi 0.86*pi];  %Salen de promediar los omegas de a 2, pero hay que ir retoc�ndolos para que funcione bien
Amplitudes = [2.3045 0.2855 3.790 0.5713 1.3110 2.250 2.7];  %Salen de ver el gr�fico de la inversa de H. Tambi�n hay que retocarlos
min_DW = 0.1*pi;                                           %Salen del m�nimo deltaW para las bandas de transici�n
%M = ceil( 8*pi/min_DW );                                %Usamos la ventana de Hann porque es la primera que llega al delta minimo tras corregir (0.0043/0.57)
M=142;
%% Dise�a
h_disenado = multibanda(Amplitudes,Wc./(2*pi),M,@hamming);

%% Transformada y error
nfft = 1024;            %Este n�mero va a ser la definici�n de la fft. Usamos 1024 para todos
H_disenado = fft(h_disenado, nfft); 
H_disenado = H_disenado(1:nfft/2); %Como es real usamos solo la mitad (es simetrico)

absTH = absTH(1:nfft/2);
diff_h_modulo = abs(abs(H_disenado) - absTH);


sist_total = conv(h_disenado,h); %Creo el sistema total que es la convoluci�n del h del lugar con el dise�ado

plot_diseno %corre el script para hacer los gr�ficos