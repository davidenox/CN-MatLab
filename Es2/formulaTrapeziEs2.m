function In = formulaTrapeziEs2(f, a, b, n)
        % Input:
        % f: funzione da integrare (definita su [a,b])
        % a: estremo sinistro dell'intervallo
        % b: estremo destro dell'intervallo
        % n: numero di sottointervalli (n >= 1)
        
        % Output:
        % In: approssimazione dell'integrale di f(x) su [a, b] usando la
        % formula dei trapezi di ordine n
    
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
        In = h*((f(a)+f(b))/2+somma);
    end