addpath('/home/davidenox/projects/CN-MatLab/Es1/');
addpath('/home/davidenox/projects/CN-MatLab/Es2/');
addpath('/home/davidenox/projects/CN-MatLab/Es3/');


% Punto (a): Calcolo dell'integrale esatto

syms x;
f_sym = x^2 * exp(-x); % Funzione simbolica
I_exact = double(int(f_sym, 0, 1)); % Calcolo simbolico del valore esatto
fprintf('Punto (a):\n');
fprintf('Valore esatto dell\integrale I = %.10f\n\n', I_exact);

% Definizione della funzione come funzione anonima
f = @(x) x.^2 .* exp(-x);

% Punto (b): Calcolo di I_5, I_10, I_20, I_40

I_5 = formulaTrapeziEs2(f, 0, 1, 5);
I_10 = formulaTrapeziEs2(f, 0, 1, 10);
I_20 = formulaTrapeziEs2(f, 0, 1, 20);
I_40 = formulaTrapeziEs2(f, 0, 1, 40);

fprintf('Punto (b):\n');
fprintf('I_5  = %.10f\n', I_5);
fprintf('I_10 = %.10f\n', I_10);
fprintf('I_20 = %.10f\n', I_20);
fprintf('I_40 = %.10f\n\n', I_40);

% Punto (c): Interpolazione di p(0)

% Passi h e h^2
h = [1/5, 1/10, 1/20, 1/40]; % Passi di discretizzazione
h2 = h.^2; % h^2 per interpolazione
I_values = [I_5, I_10, I_20, I_40]; % Valori I_5, I_10, I_20, I_40

% Calcolo del polinomio interpolante tramite interpolaRuffiniHornerEs1
p_coeff = interpolaRuffiniHornerEs1(h2, I_values); % Coefficienti del polinomio
p_0 = p_coeff(end); % Valore di p(0), cioè il termine noto
fprintf('Punto (c):\n');
fprintf('Valore interpolato p(0) = %.10f\n\n', p_0);

% Punto (d): Tabella dei risultati

% Errori calcolati
error_5 = abs(I_5 - I_exact);
error_10 = abs(I_10 - I_exact);
error_20 = abs(I_20 - I_exact);
error_40 = abs(I_40 - I_exact);
error_p0 = abs(p_0 - I_exact);

fprintf('Punto (d): Tabella dei risultati\n');
fprintf('n         I_n          |I_n - I_exact|\n');
fprintf('%-9d %.10f %.10f\n', 5, I_5, error_5);
fprintf('%-9d %.10f %.10f\n', 10, I_10, error_10);
fprintf('%-9d %.10f %.10f\n', 20, I_20, error_20);
fprintf('%-9d %.10f %.10f\n', 40, I_40, error_40);
fprintf('p(0)      %.10f %.10f\n\n', p_0, error_p0);

% Punto (e): Calcolo di n per |I_n - I_exact| <= epsilon

epsilon = error_p0; % Tolleranza (uguale a |p(0) - I_exact|)

n = 1; % Partenza da n=1
while true
    I_n = formulaTrapeziEs2(f, 0, 1, n); % Calcolo di I_n
    if abs(I_n - I_exact) <= epsilon % Controllo dell'errore
        break;
    end
    n = n + 1; % Incremento di n
end

fprintf('Punto (e):\n');
fprintf('Valore di n trovato: %d\n', n);
fprintf('I_n       = %.10f\n', I_n);
fprintf('Errore    = %.10f\n', abs(I_n - I_exact));
fprintf('|I_n - I_exact| <= epsilon (%.10f)\n', epsilon);
