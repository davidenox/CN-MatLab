% Definizione degli epsilon
epsilon_values = 10.^(-1:-1:-10); % {10^-1, 10^-2, ..., 10^-10}

% Funzione da integrare
f = @(x) exp(x); 

% Intervallo di integrazione
a = 0; 
b = 1;

% Valore esatto dell'integrale
I_exact = exp(1) - 1;

% Preallocazione per risultati
n_values = zeros(size(epsilon_values));
I_n_values = zeros(size(epsilon_values));
errors = zeros(size(epsilon_values));

% Calcolo di n e I_n
for i = 1:length(epsilon_values)
    epsilon = epsilon_values(i);
    
    % Calcolo di n (formula di stima dell'errore)
    n = ceil(sqrt(exp(1) / (12 * epsilon)));
    n_values(i) = n;
    
    % Calcolo di I_n usando la formula dei trapezi
    I_n = formulaTrapeziEs2(f, a, b, n);
    error = abs(I_exact - I_n);
    I_n_values(i) = I_n;
    errors(i) = error;
end

% Visualizzazione dei risultati
disp('Epsilon      n         I_n            Error');
disp([epsilon_values(:), n_values(:), I_n_values(:), errors(:)]);
