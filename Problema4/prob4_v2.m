addpath('/home/davidenox/projects/CN-MatLab/Es4/');

% Dati del problema
A = [5, 1, 2; -1, 7, 1; 0, 1, -3];
b = [13; 16; -7];

% Punto (a): Soluzione esatta del sistema
x_exact = A \ b; % Soluzione esatta
disp('Soluzione esatta:');
disp(x_exact);

% Punto (b): Metodo di Jacobi per le prime 10 iterazioni
x0 = [0; 0; 0]; % Vettore iniziale
N_iter = 10; % Numero di iterazioni
n = length(b);
X_iterations = zeros(n, N_iter+2); % Matrice per conservare le iterazioni
X_iterations(:, 1) = x0; % Inizializzazione con x^(0)

for k = 1:N_iter
    x_new = zeros(n, 1);
    for i = 1:n
        sum1 = A(i, 1:i-1) * X_iterations(1:i-1, k);
        sum2 = A(i, i+1:n) * X_iterations(i+1:n, k);
        x_new(i) = (b(i) - sum1 - sum2) / A(i, i);
    end
    X_iterations(:, k+1) = x_new;
end
X_iterations(:, end) = x_exact; % Aggiunta della soluzione esatta come ultima colonna

disp('Iterazioni del metodo di Jacobi (prime 10 cifre con precisione a 7 decimali):');
for k = 1:N_iter+1
    fprintf('Iterazione %2d: [%10.7f, %10.7f, %10.7f]\n', k-1, ...
        X_iterations(1, k), X_iterations(2, k), X_iterations(3, k));
end

% Punto (c): Metodo di Jacobi con variazione della precisione
epsilons = 10.^(-1:-1:-10); % Precisioni {10^-1, ..., 10^-10}
N_max = 1000; % Numero massimo di iterazioni
results = []; % Per conservare i risultati

for epsilon = epsilons
    [x_approx, K, r_norm] = jacobiIterativo(A, b, x0, epsilon, N_max);
    error_norm = norm(x_exact - x_approx, inf); % Norma dell'errore infinito
    results = [results; struct('epsilon', epsilon, 'K', K, 'x_approx', x_approx', ...
                               'error_norm', error_norm)];
end

% Stampa dei risultati in formato tabella
disp('Tabella dei risultati per le varie precisioni:');
disp('Epsilon | Iterazioni K | x_epsilon                            | Norma errore ||x - x_approx||_inf');
for i = 1:length(results)
    r = results(i);
    fprintf('%.1e|%3d|[%10.7f, %10.7f, %10.7f]|%e\n', ...
            r.epsilon, r.K, r.x_approx(1), r.x_approx(2), r.x_approx(3), r.error_norm);
end
