function p_t = interpolaRuffiniHornerMatrix2Es1(x, y, t)
    % Input:
    % x: vettore dei nodi x0, x1, ..., xn
    % y: vettore dei valori corrispondenti y0, y1, ..., yn
    % t: punto o vettore dei punti in cui si vuole valutare il polinomio interpolante
    
    % Output:
    % p_t: valutazione del polinomio interpolante nei punti t
    
    % Calcola la matrice delle differenze divise
    diff_matrix = differenze_divise(x, y);
    
    % Estrai i coefficienti dalla prima riga della matrice
    coeff = diff_matrix(1, :);
    
    % Valuta il polinomio interpolante nei punti t usando lo schema di Horner
    p_t = horner_eval(coeff, x, t);
end

function diff_matrix = differenze_divise(x, y)
    n = length(x);  % Numero di nodi
    diff_matrix = zeros(n, n);  % Inizializza la matrice delle differenze divise
    
    % Inserisci i valori di y nella diagonale inferiore
    for i = 1:n
        diff_matrix(i, 1) = y(i);
    end
    
    % Calcola le differenze divise
    for j = 2:n
        for i = j:n
            % Formula corretta per le differenze divise
            diff_matrix(i, j) = (diff_matrix(i, j - 1) - diff_matrix(i - 1, j - 1)) / (x(i) - x(i - j + 1));
        end
    end
    disp('Matrice delle differenze divise:');
    disp(diff_matrix);
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


