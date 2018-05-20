start
minM = 0;
for M=10:90
    
    Diseno_multibanda_LS
    if minM == 0
        min = sum(diff_h_modulo(1:ceil(nfft*0.45)));
        minM = M;
    else
        if min > sum(diff_h_modulo(1:ceil(nfft*0.45)))
            min = sum(diff_h_modulo(1:ceil(nfft*0.45)));
            minM = M
        end
    end
end