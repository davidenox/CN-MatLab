function p0 = extrapolation_method(a, b, f, n_vect)
    % Input:
    % a, b - estremi dell'intervallo
    % f - funzione definita su [a, b]
    % n_vect - vettore [n0, n1, ..., nm] con n0, n1, ..., nm ≥ 1 tutti distinti
    
    m = length(n_vect);
    h = zeros(1, m); % Passi di discretizzazione
    I = zeros(1, m); % Valori delle formule dei trapezi
    
    % Calcolo delle formule dei trapezi per ogni n in n_vect
    for i = 1:m
        h(i) = (b - a) / n_vect(i); % Passo di discretizzazione
        I(i) = trapezoidal_rule(a, b, f, n_vect(i)); % Approssimazione dell'integrale
    end
    
    % Interpolazione dei dati (h^2, I) con differenze divise e Horner
    h_squared = h.^2;
    p = interpola_ruffini_horner(h_squared, I, 0); % Calcola il polinomio e valuta p(0)
    
    p0 = p; % Valore estrapolato p(0)
end

function I = trapezoidal_rule(a, b, f, n)
    % Applica la regola dei trapezi per approssimare l'integrale di f su [a, b] con n intervalli
    x = linspace(a, b, n+1); % n+1 punti
    y = f(x); % Valori della funzione nei punti
    h = (b - a) / n;
    I = (h / 2) * (y(1) + 2 * sum(y(2:end-1)) + y(end)); % Formula dei trapezi
end
