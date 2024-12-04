function [xi, K, fx] = bisezione(a, b, f, epsilon)
    % Verifica che f(a) e f(b) abbiano segno opposto
    if f(a) * f(b) > 0
        error('f(a) e f(b) devono avere segni opposti');
    end

    % Inizializzazione degli estremi dell'intervallo e contatore delle iterazioni
    alpha_k = a;
    beta_k = b;
    K = 0;

    % Ripeti finché la lunghezza dell'intervallo è maggiore della precisione richiesta
    while (beta_k - alpha_k) > epsilon
        % Calcola il punto medio dell'intervallo
        xi = (alpha_k + beta_k) / 2;
        
        % Aggiorna gli estremi dell'intervallo in base al segno di f(xi)
        if f(alpha_k) * f(xi) <= 0
            beta_k = xi;
        else
            alpha_k = xi;
        end

        % Incrementa il contatore delle iterazioni
        K = K + 1;
    end

    % Calcola l'approssimazione finale di xi come punto medio dell'ultimo intervallo
    xi = (alpha_k + beta_k) / 2;
    fx = f(xi); % Calcola il valore di f in xi (dovrebbe essere vicino a zero)
end