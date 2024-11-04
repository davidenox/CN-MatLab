% Aggiungi i percorsi delle cartelle Es1 e Es2
addpath('/home/davidenox/projects/CN-MatLab/Es1/');
addpath('/home/davidenox/projects/CN-MatLab/Es2/');

% Definisci i parametri dell'integrale e la funzione
f = @(x) exp(x);  % Funzione f(x) = e^x
a = 0;
b = 1;
I_exact = exp(1) - 1;  % Valore esatto dell'integrale

% Valori di epsilon richiesti
epsilon_values = 10.^(-1:-1:-10);

% Inizializza la tabella dei risultati
results = zeros(length(epsilon_values), 4);

% Parte (a) e (b)
for k = 1:length(epsilon_values)
    epsilon = epsilon_values(k);
    n = 1;
    error = inf;
    
    % Trova il minimo n tale che l'errore sia <= epsilon
    while error > epsilon
        In = formulaTrapeziEs2(f, a, b, n);
        error = abs(I_exact - In);
        if error > epsilon
            n = n + 1;
        end
    end
    
    % Salva i risultati nella tabella
    results(k, :) = [n, In, I_exact, error];
end

% Visualizza la tabella dei risultati
disp('Epsilon    n(epsilon)    I_n          I_exact      |I - I_n|');
disp(results);

% Parte (c): Calcola le approssimazioni con n = 2, 4, 8, 16
n_values = [2, 4, 8, 16];
I_values = zeros(1, length(n_values));

for i = 1:length(n_values)
    I_values(i) = formulaTrapeziEs2(f, a, b, n_values(i));
end

% Visualizza i risultati per n = 2, 4, 8, 16
disp('n        I_n         I_exact      |I - I_n|');
for i = 1:length(n_values)
    fprintf('%d    %.10f    %.10f    %.10f\n', n_values(i), I_values(i), I_exact, abs(I_exact - I_values(i)));
end

% Parte (d): Interpolazione dei valori I_2, I_4, I_8, I_16
h_values = [1/2, 1/4, 1/8, 1/16];
h_squared = h_values.^2;
p0 = interpolaRuffiniHornerEs1(h_squared, I_values, 0);

% Visualizza il confronto
disp('h^2       I_n');
disp([h_squared', I_values']);
fprintf('Valore interpolato p(0): %.10f\n', p0);
fprintf('Valore esatto I: %.10f\n', I_exact);

