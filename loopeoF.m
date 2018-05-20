start
f = [0 0.01952 0.06452 0.1016 0.1452 0.1719 0.2227 0.4375 0.4805 0.707 0.8105 0.9512]; %Frecuencias a las que indico valores
%Diseno_multibanda_ventana
%min = sum(diff_h_modulo(1:ceil(nfft*0.45)));
%minW1 = 0.0001*pi;
for indice=2:length(f)
    if(indice == 1)
        f_start = 0.0001;
    else
        f_start = f(indice-1)+0.0001;
    end
    if(indice == length(f))
        f_end = 0.9999;
    else
        f_end = f(indice+1)*0.9;
    end
    for f_i=f_start:0.00001:f_end
        f(indice) = f_i;
        Diseno_multibanda_LS
        error_hasta_20K = sum(diff_h_modulo(1:ceil(nfft*0.45)));
        if f_i == f_start
            min = error_hasta_20K;
            minf = f_i;
        end
            
        if min > error_hasta_20K
            min = error_hasta_20K;
            minf = f_i;
        end
    end
    f(indice) = minf
end