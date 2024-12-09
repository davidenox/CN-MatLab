function p_t = interpolaRuffiniHornerMatrixEs1(x, y, t)
    % Input:
    % x: vettore dei punti x0, x1, ..., xn (devono essere distinti)
    % y: vettore dei valori corrispondenti y0, y1, ..., yn
    % t: vettore dei punti t1, t2, ..., tm dove si vuole valutare il polinomio interpolante
    
    % Output:
    % p_t: vettore contenente le valutazioni del polinomio interpolante nei punti t
    
    % Calcola la matrice delle differenze divise
    diff_matrix = differenze_divise(x, y);
    
    % Estrai i coefficienti dalla diagonale principale della matrice
    coeff = diag(diff_matrix);
    
    % Valuta il polinomio nei punti t usando lo schema di Horner
    p_t = horner_eval(coeff, x, t);
end

function diff_matrix = differenze_divise(x, y)
    % Calcola la matrice delle differenze divise
    n = length(x);
    diff_matrix = zeros(n, n);  % Inizializza la matrice delle differenze divise
    
    % Copia il vettore y nella prima colonna
    diff_matrix(:, 1) = y(:);
    
    % Costruisce la tabella delle differenze divise
    for j = 2:n
        for i = j:n
            diff_matrix(i, j) = (diff_matrix(i, j-1) - diff_matrix(i-1, j-1)) / (x(i) - x(i-j+1));
        end
    end
end

function p_t = horner_eval(coeff, x, t)
    % Valuta il polinomio usando lo schema di Horner
    n = length(coeff);
    m = length(t);
    p_t = zeros(1, m);
    
    for k = 1:m
        % Inizializza il polinomio con il termine di grado più alto
        p = coeff(n);
        
        % Applica lo schema di Horner
        for i = n-1:-1:1
            p = p * (t(k) - x(i)) + coeff(i);
        end
        
        % Salva il risultato della valutazione nel punto t(k)
        p_t(k) = p;
    end
end
