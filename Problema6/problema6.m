addpath('/home/davidenox/projects/CN-MatLab/Es6/');

% Funzioni e intervalli definiti dal problema
f1 = @(x) x.^3 + 3*x - 1 - exp(-x.^2); % Prima funzione
a1 = 0; b1 = 1; % Intervallo [a, b] per f1

f2 = @(x) cos(x) - x; % Seconda funzione
a2 = 0; b2 = pi; % Intervallo [a, b] per f2

% Lista di epsilon
epsilons = [1e-1, 1e-2, 1e-3, 1e-4, 1e-5, 1e-6, 1e-7, 1e-8, 1e-9, 1e-10];

% Risoluzione per il primo caso
solve_case(f1, a1, b1, epsilons, 'f1(x) = x^3 + 3x - 1 - e^{-x^2}');

% Risoluzione per il secondo caso
solve_case(f2, a2, b2, epsilons, 'f2(x) = cos(x) - x');

% Funzione per risolvere ogni caso
function solve_case(f, a, b, epsilons, case_name)
    fprintf('\nSoluzione per %s:\n', case_name);
    
    % (a) Verifica che f(a)*f(b) < 0
    fa = f(a);
    fb = f(b);
    fprintf('(a) f(a)*f(b) = %.3f (segno opposto: %s)\n', fa * fb, ...
        string(fa * fb < 0));
    if fa * fb >= 0
        error('f(a) e f(b) devono avere segni opposti');
    end
    
    % (b) Tracciamento del grafico
    fprintf('(b) Tracciamento del grafico di f(x) su [%f, %f]\n', a, b);
    fplot(f, [a b]);
    hold on;
    grid on;
    plot(a, f(a), 'ro', 'DisplayName', 'f(a)');
    plot(b, f(b), 'bo', 'DisplayName', 'f(b)');
    xlabel('x'); ylabel('f(x)');
    title(['Grafico di f(x) - Caso ', case_name]);
    legend show;

    % (c) Dimostrazione analitica: fatta in modo separato (se necessario)

    % (d) Tabella dei risultati per vari epsilon
    fprintf('(d) Calcolo del metodo di bisezione per diverse tolleranze epsilon:\n');
    fprintf('epsilon       xi               K       f(xi)\n');
    fprintf('-------------------------------------------------\n');
    for epsilon = epsilons
        [xi, K, fx] = bisezione(a, b, f, epsilon);
        fprintf('%e   %.15f   %d   %.15e\n', epsilon, xi, K, fx);
    end
end

