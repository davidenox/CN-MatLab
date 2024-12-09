addpath ('/home/davidenox/projects/CN-MatLab/Es4/');

% Parametri del problema
n_values = [5, 10, 20];
epsilon = 1e-7;
N_max = 500;

% Funzione per generare la matrice An e il vettore bn
generate_system = @(n) deal(...
    3*eye(n) - tril(toeplitz((1/2).^(0:n-1)), -1) - triu(toeplitz((1/2).^(0:n-1)), 1), ...
    ones(n, 1));

% Risultati tabellati
fprintf(' n | Metodo | Iterazioni | x_J | x_G |Errore infinito ||x - x_approx||_inf\n');
fprintf('------------------------------------------------------------\n');

for n = n_values
    % Genera sistema
    [A, b] = generate_system(n);
    
    % Soluzione esatta
    x_exact = A \ b;
    %disp(x_exact);


    % Jacobi
    [x_J, K_J, ~] = jacobi_method(A, b, zeros(n, 1), epsilon, N_max);
    error_J = norm(x_exact - x_J, inf);
    
    % Gauss-Seidel
    [x_G, K_G, ~] = metodo_gauss_seidel(A, b, zeros(n, 1), epsilon, N_max);
    error_G = norm(x_exact - x_G, inf);
    
    % Stampa risultati
    fprintf('%2d | Jacobi      | %3d        | %3d |     %e\n', n, K_J,x_J, error_J);
    fprintf('%2d | Gauss-Seidel| %3d        | %3d |    %e\n', n, K_G,x_G, error_G);
end