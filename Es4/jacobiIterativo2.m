function [x, iter, norm_r] = jacobiIterativo2(A, b, x0, tol, Nmax)
% Metodo iterativo di Jacobi utilizzando il metodo (4.11) e Osservazione 4.6
%
% Input:
%   A        - Matrice quadrata dei coefficienti (n x n)
%   b        - Vettore dei termini noti (n x 1)
%   x0       - Vettore di innesco iniziale (n x 1)
%   tol      - Soglia di precisione
%   Nmax     - Numero massimo di iterazioni consentite
%
% Output:
%   x             - Soluzione approssimata
%   iter          - Numero di iterazioni effettuate
%   norm_r_final  - Norma finale del residuo ||r||_2


% Estrae la matrice diagonale D
    D = diag(diag(A));

% Calcolo del residuo iniziale r^(0)
    x = x0;                       % Vettore soluzione iniziale
    r = b - A * x;                % Residuo iniziale
    norm_r = norm(r, 2);          % Norma L2 del residuo
    iter = 0;                     % Contatore iterazioni

% Iterazioni del metodo di Jacobi
    while norm_r > tol && iter < Nmax
    % Risolve il sistema D z^(k) = r^(k) per ottenere z^(k)
        z = r ./ diag(D);   % Equivalente a z = D \ r    

    % Aggiorna la soluzione x^(k+1) = x^(k) + z^(k)
        x = x + z;
    
    % Calcola il nuovo residuo r^(k+1) = b - A x^(k+1)
        r = b - A * x;
        norm_r = norm(r, 2);
    
    % Incrementa il contatore delle iterazioni
        iter = iter + 1;
    end

end