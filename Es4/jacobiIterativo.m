function [x, K, r_norm] = jacobiIterativo(A, b, x0, epsilon, N_max)
    % Metodo di Jacobi - Versione Iterativa
    % Input:
    % A: matrice del sistema lineare Ax = b
    % b: vettore dei termini noti
    % x0: vettore di innesco (stima iniziale di x)
    % epsilon: soglia di precisione
    % N_max: numero massimo di iterazioni consentite
    
    % Output:
    % x: vettore approssimato x^(K) dopo K iterazioni o x^(N_max)
    % K: numero di iterazioni effettivamente eseguite
    % r_norm: norma ||r^(K)||_2 del residuo alla fine del processo
    
    % Separazione di D, L e U dalla matrice A
    D = diag(diag(A));           % Matrice diagonale
    %L = tril(A, -1);             % Parte triangolare inferiore CANCELLARE
    %U = triu(A, 1);              % Parte triangolare superiore CANCELLARE
    
    % Pre-calcolo della matrice iterativa M = D^(-1) * (L + U)
    %D_inv = inv(D);              % Inversa della diagonale
    %M = -D_inv * (L + U);        % Matrice di iterazione
    
    % Pre-calcolo del termine costante c = D^(-1) * b
    %c = D_inv * b;
    
    % Inizializza il vettore soluzione con la stima iniziale
    x = x0;
    
    % Itera il metodo di Jacobi
    for K = 1:N_max

        % Calcola il residuo r^(K-1) = b - A * x^(K-1)
        r = b - A * x;

        % Aggiornamento vettoriale: x^(K) = x^(K-1) + D^(-1) * r^(K-1)       
        x_new = 
        
        % Calcola la norma del residuo ||r^(K)||_2
        r_norm = norm(r, 2);
        
        % Condizione di arresto: ||r^(K)||_2 <= epsilon * ||b||_2
        if r_norm <= epsilon * norm(b, 2)
            x = x_new;
            return;  % Arresta l'algoritmo e restituisce il risultato
        end
        
        % Aggiorna la soluzione corrente x^(K)
        x = x_new;
    end
    
    % Se si raggiunge N_max iterazioni senza soddisfare il criterio, si restituisce
    % x^(N_max), il relativo indice N_max e la norma del residuo ||r^(N_max)||_2
end
