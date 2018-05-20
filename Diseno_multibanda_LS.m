%% Diseño por cuadrados mínimos
start %corre el script que carga las cosas

%% Parámetros más modificables
%f = [0 0.01952 0.06452 0.1016 0.1452 0.1719 0.2227 0.4375 0.4805 0.707 0.8105 0.9512]; %Frecuencias a las que indico valores
f = [0 0.0152 0.0644 0.0803 0.1462 0.1726 0.2197 0.4325 0.4808 0.7067 0.8105 0.9575];

A = [2.297 2.321 0.3026 0.2951 3.84 3.827 0.575 0.595 1.26 1.33 1.845 4.014]; %Amplitudes para cada frecuencia de las que estan arriba
min_DW = 0.1;
%deltas = [0.036*A(1) 0.001*A(3) 0.177*A(5) 0.0048*A(7) 0.06*A(9) 0.1*A(11)];  %Son los deltas multiplicados por la amplitud en las bandas, ya que hay que escalarlos
deltas = [0.036 0.001 0.177 0.0048 0.06 0.1];
%M = round((-10*log10(min(deltas))-13)/(2.324 * min_DW)); %Este es el orden de la ventana de kaiser, que sirve como punto de inicio, después hay que retocar
M = 72; %Este parece el mejor por ahora 
inv_deltas = 1./deltas; %Acá quedan los pesos para cada parte del filtro

% respuesta impulsiva del filtro
h_disenado = firls(M, f, A, inv_deltas);

nfft = 1024;
H_disenado = fft(h_disenado, nfft); 
H_disenado = H_disenado(1:nfft/2); 

absTH = absTH(1:nfft/2);
diff_h_modulo = abs(abs(H_disenado) - absTH);


sist_total = conv(h_disenado,h);

plot_diseno