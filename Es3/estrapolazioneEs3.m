function p0 = estrapolazioneEs3(f, a, b, n_vect)
    % Input:
    % f: funzione da integrare
    % a: estremo sinistro dell'intervallo
    % b: estremo destro dell'intervallo
    % n_vect: vettore dei valori di n0, n1, ..., nm
    
    % Output:
    % p0: valore estrapolato p(0)
    
    addpath('/home/davidenox/projects/CN-MatLab/Es1/');
    addpath('/home/davidenox/projects/CN-MatLab/Es2/');

    % Prealloca i vettori per h^2 e In
    m = length(n_vect);
    h_squared = zeros(1, m);
    In_values = zeros(1, m);

    % Calcola h^2 e In per ogni n in n_vect
    for i = 1:m
        n = n_vect(i);
        h = (b - a) / n;  % Passo di discretizzazione
        h_squared(i) = h^2;
        In_values(i) = formulaTrapeziEs2(f, a, b, n);
    end
    
    % Interpola i valori (h^2, In) usando le differenze divise
    % La funzione interpola_ruffini_horner accetta vettori di x (qui h^2) e y (qui In_values)
    % t=0 perché vogliamo estrapolare p(0)
    p0 = interpolaRuffiniHornerEs1(h_squared, In_values, 0);

end