addpath('/home/davidenox/projects/CN-MatLab/Es1/')
addpath('/home/davidenox/projects/CN-MatLab/Es2/')

% Funzione e intervallo
f = @(x) x.^2 .* exp(-x); % Definizione della funzione
a = 0; 
b = 1;

% Calcolo delle approssimazioni con la formula dei trapezi
I_5 = formulaTrapeziEs2(f, a, b, 5);
I_10 = formulaTrapeziEs2(f, a, b, 10);
I_20 = formulaTrapeziEs2(f, a, b, 20);
I_40 = formulaTrapeziEs2(f, a, b, 40);

% Calcolo del valore esatto
I_exact = 2 - 5 / exp(1); % Valore calcolato analiticamente
% Calcolo degli errori
error_5 = abs(I_5 - I_exact);
error_10 = abs(I_10 - I_exact);
error_20 = abs(I_20 - I_exact);
error_40 = abs(I_40 - I_exact);

% Stampa dei risultati a schermo
fprintf('Risultati:\n');
fprintf('I_5   = %.10f, Errore = %.10f\n', I_5, error_5);
fprintf('I_10  = %.10f, Errore = %.10f\n', I_10, error_10);
fprintf('I_20  = %.10f, Errore = %.10f\n', I_20, error_20);
fprintf('I_40  = %.10f, Errore = %.10f\n', I_40, error_40);

% Interpolazione e calcolo di p(0)
x = [0.04, 0.01, 0.0025, 0.000625]; % h^2 valori
y = [I_5, I_10, I_20, I_40];        % Approssimazioni
p_0 = interpolaRuffiniHornerEs1(x, y, 0);

% Calcolo errore di interpolazione
error_p0 = abs(p_0 - I_exact);

% Stampa dei risultati di interpolazione
fprintf('Interpolazione:\n');
fprintf('p(0)  = %.10f, Errore = %.10f\n', p_0, error_p0);
