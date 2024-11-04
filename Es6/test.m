% Definizione dei parametri
a = 1;              % Estremo sinistro dell'intervallo
b = 2;              % Estremo destro dell'intervallo
f = @(x) x.^3 - 6*x + 4; % Funzione continua con cambio di segno su [1, 2]%
%f = @(x) x.^2 - 2;
epsilon = 1e-4;     % Precisione richiesta

% Chiamata alla funzione di bisezione
[xi, K, fx] = bisezione(a, b, f, epsilon);

% Output dei risultati
fprintf('Approssimazione dello zero: xi = %.5f\n', xi);
fprintf('Numero di iterazioni: K = %d\n', K);
fprintf('Valore di f(xi): f(xi) = %.5e\n', fx);

% Creazione del vettore x per i punti dell'intervallo [a, b]
x = linspace(a, b, 100); % 100 punti equispaziati tra a e b

% Calcolo dei valori di f(x) per ciascun x
y = f(x);

% Tracciamento del grafico della funzione
plot(x, y, 'b-', 'LineWidth', 2); % Linea blu con larghezza 2
hold on;

% Disegno degli assi cartesiani
plot([a, b], [0, 0], 'k--'); % Asse x come linea tratteggiata nera
y_min = min(y); % Minimo valore di y per il range dell'asse y
y_max = max(y); % Massimo valore di y per il range dell'asse y
plot([0, 0], [y_min, y_max], 'k--'); % Asse y come linea tratteggiata nera

% Etichette e titolo
xlabel('x');
ylabel('f(x)');
title('Grafico della funzione f(x) = x^3 - 6x+4 con assi cartesiani');
grid on;

% Limiti degli assi per includere l'origine (se non è inclusa automaticamente)
xlim([a, b]);
ylim([y_min, y_max]);

hold off;