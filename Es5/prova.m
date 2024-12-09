% Codice di run
A = [2, 1; 2, -2];  % Matrice del sistema
b = [3; 0];         % Vettore dei termini noti
x0 = [0; 0];       % Stima iniziale
epsilon = 1e-5;    % Soglia di precisione
N_max = 6;         % Numero massimo di iterazioni

[x, K, r_norm] = gauss_seidelIterativo(A, b, x0, epsilon, N_max);  % Chiamata alla funzione
disp('Soluzione x:'); disp(x);        % Visualizza la soluzione
disp(['Numero di iterazioni K: ', num2str(K)]);  % Visualizza il numero di iterazioni
disp(['Norma del residuo: ', num2str(r_norm)]);    % Visualizza la norma del residuo