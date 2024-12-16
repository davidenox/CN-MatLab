function risultato = interpolaRuffiniHornerMatrix2Es1(x, y, t)
    % x: nodi (ascisse)
    % y: valori (ordinate)
    % t: punto in cui valutare il polinomio interpolante
    
    n = length(x); % Numero di nodi
    diff_matrix = zeros(n, n); % Inizializza la matrice delle differenze divise
    diff_matrix(:, 1) = y(:); % La prima colonna è data dai valori delle ordinate
    
    % Calcolo della tabella delle differenze divise (triangolare superiore)
    for j = 2:n
        for i = 1:(n-j+1)
            diff_matrix(i, j) = (diff_matrix(i+1, j-1) - diff_matrix(i, j-1)) / (x(i+j-1) - x(i));
        end
    end
    
    % Visualizzazione della matrice delle differenze divise nella forma triangolare
    fprintf('Matrice delle differenze divise:\n');
    for i = 1:n
        for j = 1:n
            if j >= i
                fprintf('%10.4f ', diff_matrix(i, j));
            else
                fprintf('%10s ', ''); % Spazi vuoti per formattare la triangolare
            end
        end
        fprintf('\n');
    end
    
    % Valutazione del polinomio interpolante usando Horner
    coeff = diff_matrix(1, :); % I coefficienti sono nella prima riga della matrice
    risultato = coeff(n);
    for k = (n-1):-1:1
        risultato = coeff(k) + (t - x(k)) * risultato;
    end
    
    % Mostra il risultato interpolato
    fprintf('Risultato interpolato:\n');
    disp(risultato);
end
