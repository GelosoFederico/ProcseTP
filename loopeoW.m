Wc = [0.0365*pi 0.1284*pi 0.1872*pi 0.459*pi 0.8690*pi];  %Salen de promediar los omegas de a 2, pero hay que ir retocándolos para que funcione bien
%Diseno_multibanda_ventana
%min = sum(diff_h_modulo(1:ceil(nfft*0.45)));
%minW1 = 0.0001*pi;
for indice=1:length(Wc)
    if(indice == 1)
        w_start = 0.0001*pi;
    else
        w_start = Wc(indice-1);
    end
    if(indice == length(Wc))
        w_end = 0.9999*pi;
    else
        w_end = Wc(indice);
    end
    for W_i=w_start:0.0001*pi:w_end
        Wc(indice) = W_i;
        Diseno_multibanda_ventana
        error_hasta_20K = sum(diff_h_modulo(1:ceil(nfft*0.45)));
        if W_i == w_start
            min = error_hasta_20K;
            minW = W_i;
        end
            
        if min > error_hasta_20K
            min = error_hasta_20K;
            minW = W_i;
        end
    end
    Wc(indice) = minW
end