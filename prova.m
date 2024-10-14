function p_t = interpola_ruffini_horner(x, y, t)
    % Input:
    % x: vettore dei punti x0, x1, ..., xn (devono essere distinti)
    % y: vettore dei valori corrispondenti y0, y1, ..., yn
    % t: vettore dei punti t1, t2, ..., tm dove si vuole valutare il polinomio interpolante
    
    % Output:
    % p_t: vettore contenente le valutazioni del polinomio interpolante nei punti t
    
    % Calcola i coefficienti del polinomio usando le differenze divise
    coeff = differenze_divise(x, y);
    
    % Valuta il polinomio nei punti t usando lo schema di Horner
    p_t = horner_eval(coeff, x, t);
end

function coeff = differenze_divise(x, y)
    % Calcola i coefficienti delle differenze divise
    n = length(x);
    coeff = y;  % Copia il vettore y
    
    % Costruisce la tabella delle differenze divise
    for j = 2:n
        for i = n:-1:j
            coeff(i) = (coeff(i) - coeff(i-1)) / (x(i) - x(i-j+1));
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

    function In = formula_trapezi(f, a, b, n)
        % Input:
        % f: funzione da integrare (definita su [a,b])
        % a: estremo sinistro dell'intervallo
        % b: estremo destro dell'intervallo
        % n: numero di sottointervalli (n >= 1)
        
        % Output:
        % In: approssimazione dell'integrale di f(x) su [a, b] usando la formula dei trapezi
    
        % Larghezza di ciascun sottointervallo
        h = (b - a) / n;
        
        % Calcolo della somma dei valori intermedi
        somma = 0;
        for i = 1:n-1
            xi = a + i*h;
            somma = somma + f(xi);
        end
        
        % Formula dei trapezi
        %In = (h/2) * (f(a) + 2 * somma + f(b));
        In = h*((f(a)+f(b))/2+somma)
    end
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

% DA FINIRE

