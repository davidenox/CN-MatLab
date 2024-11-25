addpath('/home/davidenox/projects/CN-MatLab/Es6/');

clc;
clear;
close all;

% Caso 1: f(x) = x^3 + 3x - 1 - exp(-x^2), [a, b] = [0, 1]
disp('Caso 1: f(x) = x^3 + 3x - 1 - exp(-x^2), [a, b] = [0, 1]');
a1 = 0; b1 = 1;
f1 = @(x) x.^3 + 3.*x - 1 - exp(-x.^2);

% Punto (a): Verifica f(a)f(b) < 0
fa1 = f1(a1);
fb1 = f1(b1);
if fa1 * fb1 < 0
    disp('Verifica (a): f(a)f(b) < 0 soddisfatta per il Caso 1.');
else
    error('Verifica (a) fallita per il Caso 1.');
end

% Punto (b): Grafico
figure;
x1 = linspace(a1, b1, 1000);
plot(x1, f1(x1), 'b-', 'LineWidth', 2);
grid on;
xlabel('x');
ylabel('f(x)');
title('Grafico di f(x) = x^3 + 3x - 1 - exp(-x^2)');
line([a1 b1], [0 0], 'Color', 'k', 'LineStyle', '--'); % Asse x
disp('Grafico tracciato per il Caso 1.');

% Punto (c): Dimostrazione analitica (commentata)
% f'(x) = 3x^2 + 3 + 2x * exp(-x^2) > 0 per ogni x in [0, 1]
% f(x) è crescente e cambia segno -> unico zero nell'intervallo.

% Punto (d): Metodo di bisezione e tabella dei risultati
disp('Costruzione tabella per il Caso 1...');
epsilon_values = 10.^(-1:-1:-10);
results1 = zeros(length(epsilon_values), 4);

for i = 1:length(epsilon_values)
    epsilon = epsilon_values(i);
    [xi, K, fx] = bisezione(a1, b1, f1, epsilon);
    results1(i, :) = [epsilon, xi, K, fx];
end

% Mostra la tabella dei risultati
disp('Tabella dei risultati - Caso 1:');
disp('epsilon        xi_eps         K_eps        f(xi_eps)');
disp(results1);

% Caso 2: f(x) = cos(x) - x, [a, b] = [0, pi]
disp('Caso 2: f(x) = cos(x) - x, [a, b] = [0, pi]');
a2 = 0; b2 = pi;
f2 = @(x) cos(x) - x;

% Punto (a): Verifica f(a)f(b) < 0
fa2 = f2(a2);
fb2 = f2(b2);
if fa2 * fb2 < 0
    disp('Verifica (a): f(a)f(b) < 0 soddisfatta per il Caso 2.');
else
    error('Verifica (a) fallita per il Caso 2.');
end

% Punto (b): Grafico
figure;
x2 = linspace(a2, b2, 1000);
plot(x2, f2(x2), 'r-', 'LineWidth', 2);
grid on;
xlabel('x');
ylabel('f(x)');
title('Grafico di f(x) = cos(x) - x');
line([a2 b2], [0 0], 'Color', 'k', 'LineStyle', '--'); % Asse x
disp('Grafico tracciato per il Caso 2.');

% Punto (c): Dimostrazione analitica (commentata)
% f'(x) = -sin(x) - 1 < 0 per ogni x in [0, pi]
% f(x) è decrescente e cambia segno -> unico zero nell'intervallo.

% Punto (d): Metodo di bisezione e tabella dei risultati
disp('Costruzione tabella per il Caso 2...');
results2 = zeros(length(epsilon_values), 3);

for i = 1:length(epsilon_values)
    epsilon = epsilon_values(i);
    [xi, K, fx] = bisezione(a2, b2, f2, epsilon);
    results2(i, :) = [xi, K, fx];
end

% Mostra la tabella dei risultati
disp('Tabella dei risultati - Caso 2:');
disp('epsilon        xi_eps         K_eps        f(xi_eps)');
disp(results2);

% Funzione Metodo di Bisezione
function [xi, K, fx] = bisezione(a, b, f, epsilon)
    K = 0; % Iterazioni
    while (b - a) / 2 > epsilon
        xi = (a + b) / 2;
        if f(xi) == 0
            break; % Trovato zero esatto
        elseif f(a) * f(xi) < 0
            b = xi;
        else
            a = xi;
        end
        K = K + 1;
    end
    xi = (a + b) / 2; % Approssimazione finale
    fx = f(xi); % Valore della funzione in xi
end