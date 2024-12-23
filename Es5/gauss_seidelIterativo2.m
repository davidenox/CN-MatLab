function [x, iter, norm_r] = gauss_seidelIterativo2(A, b, x0, tol, maxIter)
% Metodo di Gauss-Seidel usando l'Osservazione 4.6
% Input:
%   A       : Matrice dei coefficienti (NxN)
%   b       : Vettore dei termini noti (Nx1)
%   x0      : Vettore iniziale (Nx1)
%   tol     : Tolleranza per arrestare il metodo
%   maxIter : Numero massimo di iterazioni
% Output:
%   x       : Soluzione approssimata
%   res     : Vettore dei residui r^(k) ad ogni iterazione
%   iter    : Numero di iterazioni effettuate

% Inizializzazione
    n = length(b);              % Dimensione del sistema
    x = x0;                     % Vettore soluzione iniziale
    iter = 0;                   % Contatore iterazioni

% Precondizionatore M = E (matrice triangolare inferiore di A)
    E = tril(A);                % Estrae la parte triangolare inferiore di A

% Controllo iniziale: verifica se x0 è già soluzione
    r = b - A*x;                % Calcolo del residuo iniziale r^(0)
    norm_r = norm(r,2);

% Iterazioni del metodo
    while iter < maxIter && norm_r > tol
    % Risolvi M * z^(k) = r^(k) per z^(k)
        z = E \ r;              % Sistema triangolare inferiore (Osservazione 4.6)
    
    % Aggiorna x^(k+1)
        x = x + z;              % x^(k+1) = x^(k) + M^{-1} * r^(k)
    
    % Calcola il nuovo residuo r^(k+1)
        r = b - A*x;            % r^(k+1)
        norm_r = norm(r, 2);
        iter = iter+1;
    end

end