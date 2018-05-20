function salida = multibanda(a,f,M,win_type) 
%% Argumentos
%   a: amplitudes en cada banda. Tendrá tamaño D. Se asumen ordenadas.
%   f: frecuencias de corte. Su tamaño es D-1. Se asumen ordenadas segun a.
%   M: orden del filtro.
%   win: tipo de ventana.

n = 0:M;
ws = 2*pi*f;
hd = 0;


hd = a(1)*sinc(ws(1)/pi*(n-M/2))*ws(1)/pi;
for i=2:length(ws) %Suma como si fueran size(f) pasabandas
    hd = hd + a(i)*(sinc(ws(i)/pi*(n-M/2))*ws(i)/pi - sinc(ws(i-1)/pi*(n-M/2))*ws(i-1)/pi);
end
hd = hd + a(end)*(sinc(pi/pi*(n-M/2))*pi/pi -  sinc(ws(end)/pi*(n-M/2))*ws(end)/pi);

win = window(win_type, M+1)';      % ventana rectangular
h = hd.*win;   % respuesta impulsiva del filtro ventaneado

salida = h;
