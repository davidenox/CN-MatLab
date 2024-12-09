function [x, K, r_norm] = gauss_seidelIterativo(A, b, x0, epsilon, N_max)
    % Metodo di Gauss-Seidel - versione Iterativa
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
    
    % Separazione della matrice A in E (triangolare inferiore) e U (triangolare superiore)
    E = tril(A);               % Parte triangolare inferiore (inclusa diagonale)
    U = triu(A, 1);            % Parte triangolare superiore (esclusa diagonale)
    
    % Pre-calcolo della matrice iterativa G = E^(-1) * U
    G = -E \ U;                % G = -inv(E) * U (calcolo efficace tramite backslash operator)
    
    % Pre-calcolo del termine costante c = E^(-1) * b
    c = E \ b;                 % c = inv(E) * b
    
    % Inizializza la soluzione corrente con il vettore di innesco x0
    x = x0;
    
    % Itera il metodo di Gauss-Seidel
    for K = 1:N_max
        % Aggiornamento vettoriale: x^(k+1) = G * x^(k) + c
        x_new = G * x + c;
        
        % Calcola il residuo r^(K) = b - A * x^(K)
        r = b - A * x_new;
        
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
