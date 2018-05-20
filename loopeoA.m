start
Amplitudes = [2.297 0.285 3.8 0.5705 1.270 4.01];       %Salen de ver el gráfico de la inversa de H. También hay que retocarlos
%Diseno_multibanda_ventana
%min = sum(diff_h_modulo(1:ceil(nfft*0.45)));
%minW1 = 0.0001*pi;

for indice=1:length(Amplitudes)
    A_start = Amplitudes(indice)/2;
    A_end = Amplitudes(indice)*2;
    for A_i=A_start:0.001:A_end
        Amplitudes(indice) = A_i;
        Diseno_multibanda_ventana
        error_hasta_20K = sum(diff_h_modulo(1:ceil(nfft*0.45)));
        if A_i == A_start
            min = error_hasta_20K;
            minA = A_i;
        end
            
        if min > error_hasta_20K
            min = error_hasta_20K;
            minA = A_i;
        end
    end
    Amplitudes(indice) = minA
end