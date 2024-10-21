% Script principale
f = @(x) x.*exp(x);  % Uso corretto di .* per moltiplicazione elemento per elemento
a = 0;
b = 2;
n_vect = [12, 24, 30];  % Vettore con i numeri di sottointervalli

p0 = estrapolazioneEs3(f, a, b, n_vect);  % Chiamata alla funzione di estrapolazione
disp(p0);  % Stampa il risultato