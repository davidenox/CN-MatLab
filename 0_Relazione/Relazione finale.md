```table-of-contents
title: 
style: nestedList # TOC style (nestedList|nestedOrderedList|inlineFirstLevel)
minLevel: 0 # Include headings from the specified level
maxLevel: 0 # Include headings up to the specified level
includeLinks: true # Make headings clickable
debugInConsole: false # Print debug info in Obsidian console
```
# Esercizi

## Esercizio 1

Il primo esercizio chiede di scrivere in MATLAB una function che calcoli l'algoritmo di **Ruffini-Horner** per la valutazione del polinomio d'interpolazione in un punto:

***Esercizio d’implementazione dell’algoritmo di valutazione del polinomio d’interpolazione in più punti.***
### Codice 

```matlab
function p_t = interpola_ruffini_horner(x, y, t)
    % Input:
    % x: vettore dei punti x0, x1, ..., xn (devono essere distinti)
    % y: vettore dei valori corrispondenti y0, y1, ..., yn
    % t: vettore dei punti t1, t2, ..., tm dove si vuole valutare il polinomio interpolante
    
    % Output:
    % p_t: vettore contenente le valutazioni del polinomio interpolante nei punti t
    
    % Calcola i coefficienti del polinomio usando le differenze divise
    coeff = differenze_divise(x, y);
    
    % Valuta il polinomio nei punti t usando lo schema di Horner
    p_t = horner_eval(coeff, x, t);
end

function coeff = differenze_divise(x, y)
    % Calcola i coefficienti delle differenze divise
    n = length(x);
    coeff = y;  % Copia il vettore y
    
    % Costruisce la tabella delle differenze divise
    for j = 2:n
        for i = n:-1:j
            coeff(i) = (coeff(i) - coeff(i-1)) / (x(i) - x(i-j+1));
        end
    end
end

function p_t = horner_eval(coeff, x, t)
    % Valuta il polinomio usando lo schema di Horner
    n = length(coeff);
    m = length(t);
    p_t = zeros(1, m);
    
    for k = 1:m
        % Inizializza il polinomio con il termine di grado più alto
        p = coeff(n);
        
        % Applica lo schema di Horner
        for i = n-1:-1:1
            p = p * (t(k) - x(i)) + coeff(i);
        end
        
        % Salva il risultato della valutazione nel punto t(k)
        p_t(k) = p;
    end
end
```

### Spiegazione

1) **Funzione principale (`interpola_ruffini_horner`)**:
    - Prende in input i vettori `x` (ascisse), `y` (ordinate) e `t` (punti in cui valutare il polinomio).
    - Prima usa la funzione `differenze_divise` per calcolare i coefficienti del polinomio interpolante nella forma di Newton.
    - Poi usa la funzione `horner_eval` per valutare il polinomio nei punti desiderati applicando lo schema di Horner.
2) **Calcolo delle differenze divise (`differenze_divise`)**:
    - Costruisce la tabella delle differenze divise e restituisce i coefficienti del polinomio interpolante.
    - L'algoritmo funziona partendo dai valori `y` e iterando per costruire le differenze successive.
3) **Valutazione con lo schema di Horner (`horner_eval`)**:
    - Prende i coefficienti del polinomio e valuta il polinomio in ciascun punto di `t` usando lo schema di Horner.
    - Questo schema permette di valutare il polinomio in modo molto efficiente, riducendo il numero di operazioni necessarie.

## Esercizio 2

Il secondo esercizio chiede di scrivere una function MATLAB per implementare la **formula dei trapezi** di una data funzione presa in input:

***Esercizio d’implementazione della formula dei trapezi***
### Codice 

```matlab
function In = formula_trapezi(f, a, b, n)
    % Input:
    % f: funzione da integrare (definita su [a,b])
    % a: estremo sinistro dell'intervallo
    % b: estremo destro dell'intervallo
    % n: numero di sottointervalli (n >= 1)
    
    % Output:
    % In: approssimazione dell'integrale di f(x) su [a, b] usando la formula dei trapezi

    % Larghezza di ciascun sottointervallo
    h = (b - a) / n;
    
    % Calcolo della somma dei valori intermedi
    somma = 0;
    for i = 1:n-1
        xi = a + i*h;
        somma = somma + f(xi);
    end
    
    % Formula dei trapezi
    In = h*((f(a)+f(b))/2+somma)
end
```

### Spiegazione

Funzione **`formula_trapezi`**:
- Prende in input la funzione da integrare `f`, gli estremi dell'intervallo `[a, b]`, e il numero di sottointervalli `n`.
- Calcola la larghezza di ciascun sottointervallo come $h=\frac{b-a}{n}$
- Usa la **formula dei trapezi** per calcolare un'approssimazione dell'integrale: $$I_n=h\left[\frac{f(a)+f(b)}{2}+\sum\limits_{j=1}^{n-1}f(x_j)\right]$$
- Restituisce l'approssimazione $I_n$​ della funzione $f(x)$ passata in input usando la formula dei trapezi.
## Esercizio 3

Il terzo esercizio chiede di scrivere una function MATLAB per implementare il **metodo di estrapolazione** di una data funzione presa in input. Chiede inoltre di usare le function MATLAB usate per risolvere gli esercizi 1 e 2

***Esercizio d’implementazione del metodo di estrapolazione***
### Codice 

```matlab
function p0 = estrapol(f, a, b, n_vect)
    % Input:
    % f: funzione da integrare
    % a: estremo sinistro dell'intervallo
    % b: estremo destro dell'intervallo
    % n_vect: vettore dei valori di n0, n1, ..., nm

    % Output:
    % p0: valore estrapolato p(0)

    % Prealloca i vettori per h^2 e In
    m = length(n_vect);
    h_squared = zeros(1, m);
    In_values = zeros(1, m);

    % Calcola h^2 e In per ogni n in n_vect
    for i = 1:m
        n = n_vect(i);
        h = (b - a) / n;  % Passo di discretizzazione
        h_squared(i) = h^2;
        In_values(i) = formula_trapezi(f, a, b, n);
    end

    % Interpola i valori (h^2, In) usando le differenze divise
    % La funzione interpola_ruffini_horner accetta vettori di x (qui h^2) e y (qui In_values)
    % t=0 perché vogliamo estrapolare p(0)
    p0 = interpola_ruffini_horner(h_squared, In_values, 0);

	% Se viene specificato il numero di cifre, usa vpa per ottenere precisione       if nargin > 4 
		p0 = vpa(p0, cifre); % Calcola p0 con precisione specificata 
	end
end
```

### Spiegazione

1. **Input**:
    - `f`: la funzione da integrare.
    - `a` e `b`: gli estremi dell'intervallo su cui si calcola l'integrale.
    - `n_vect`: un vettore di valori $n_0,n_1,\dots,n_m$ usati per il calcolo degli integrali.
2. **Output**:
    - `p0`: il valore estrapolato $p(0)$, dove $p(x)$ è il polinomio interpolante ottenuto dai valori di $h^2$ e $I_n$.
3. **Calcolo di $h^2$ e $I_n$​**:
    - Per ogni $n_i$​ nel vettore `n_vect`, il programma calcola il passo $h$ e il corrispondente integrale approssimato $I_n$​ utilizzando la formula dei trapezi fornita nell'Esercizio 2.
4. **Interpolazione**:
    - I valori $h^2$ e $I_n$​ vengono usati per ottenere il polinomio interpolante con la funzione di interpolazione `interpola_ruffini_horner`, che è la soluzione all'Esercizio 1.11.
5. **Estrapolazione**:
    - Il programma valuta il polinomio interpolante nel punto $t=0$ per ottenere $p(0)$.

#### Uso delle altre funzioni

- `interpola_ruffini_horner`, `differenze_divise` e `horner_eval` provengono dall'Esercizio 1.1.
- `formula_trapezi` viene dall'Esercizio 1.2 per approssimare gli integrali usando la formula dei trapezi.
- `vpa(p0, cifre)` viene usato per approssimare correttamente il risultato con il numero di cifre passate in input. Questa è una funzione del Toolbox **Symbolic Math Toolbox** 
## Esercizio 4

L'esercizio chiede di creare una function MATLAB per implementare il **metodo di Jacobi**.

***Esercizio d’implementazione del metodo di Jacobi***
### Codice 

```
function [x, K, r_norm] = jacobi_method(A, b, x0, epsilon, N_max)
    % Input:
    % A: matrice del sistema lineare Ax = b
    % b: vettore dei termini noti
    % x0: vettore di innesco (stima iniziale di x)
    % epsilon: soglia di precisione
    % N_max: numero massimo di iterazioni consentite

    % Output:
    % x: vettore approssimato x^(K) dopo K iterazioni o x^(N_max)
    % K: numero di iterazioni effettivamente eseguite
    % r_norm: norma ||r^(K)||_2 del residuo alla fine del processo

    % Numero di variabili (dimensione del sistema)
    n = length(b);

    % Inizializza la variabile per il vettore x^(K) (soluzione corrente)
    x = x0;

    % Itera il metodo di Jacobi
    for K = 1:N_max
        % Prealloca il vettore x^(K+1)
        x_new = zeros(n, 1);

        % Calcola ogni componente di x^(K+1)
        for i = 1:n
            % Somma degli elementi a sinistra di x^(K)
            sum1 = A(i, 1:i-1) * x(1:i-1);
            % Somma degli elementi a destra di x^(K)
            sum2 = A(i, i+1:n) * x(i+1:n);
            % Formula del metodo di Jacobi
            x_new(i) = (b(i) - sum1 - sum2) / A(i, i);
        end

        % Calcola il residuo r^(K) = b - A * x^(K)
        r = b - A * x_new;

        % Calcola la norma del residuo ||r^(K)||_2
        r_norm = norm(r, 2);

        % Condizione di arresto: se ||r^(K)||_2 <= epsilon * ||b||_2
        if r_norm <= epsilon * norm(b, 2)
            x = x_new;
            return;  % Arresta l'algoritmo e restituisce il risultato
        end

        % Aggiorna la soluzione corrente x^(K) con x^(K+1)
        x = x_new;
    end

    % Se si raggiunge N_max iterazioni senza soddisfare il criterio, si restituisce
    % x^(N_max), il relativo indice N_max e la norma del residuo ||r^(N_max)||_2
end
```

### Spiegazione 

1. **Input:**
    - `A`: La matrice del sistema lineare.
    - `b`: Il vettore dei termini noti.
    - `x0`: Il vettore di innesco (cioè la stima iniziale di $x$).
    - `epsilon`: La soglia di precisione per il residuo.
    - `N_max`: Il numero massimo di iterazioni consentite.
2. **Output:**
    - `x`: Il vettore soluzione $x^{(K)}$, dove $K$ è il numero di iterazioni.
    - `K`: Il numero di iterazioni effettivamente eseguite.
    - `r_norm`: La norma $||r^{(K)}||_2$​ del residuo $r^{(K)}=b-A\cdot x^{(K)}$.
3. **Procedura:**
    - Il metodo di Jacobi viene applicato iterativamente fino a quando il residuo $||r^{(K)}||_2$​ diventa minore o uguale a $\epsilon\cdot ||b||_{2}$​, oppure si raggiunge il numero massimo di iterazioni $N_{\text{max}}$.
    - Se nessuna delle iterazioni soddisfa la condizione di arresto, il programma restituisce $x^{(N_{\text{max}})}$.

## Esercizio 5

L'esercizio cheide di creare una function MATLAB per implementare il **metodo di Gauss-Sidel**.

Esercizio d’implementazione del metodo di Gauss-Seidel
### Codice 


```matlab
function [x, K, r_norm] = metodo_gauss_seidel(A, b, x0, epsilon, N_max)
    % Input:
    % A: matrice del sistema lineare Ax = b
    % b: vettore dei termini noti
    % x0: vettore di innesco (stima iniziale di x)
    % epsilon: soglia di precisione
    % N_max: numero massimo di iterazioni consentite

    % Output:
    % x: vettore approssimato x^(K) dopo K iterazioni o x^(N_max)
    % K: numero di iterazioni effettivamente eseguite
    % r_norm: norma ||r^(K)||_2 del residuo alla fine del processo

    % Numero di variabili (dimensione del sistema)
    n = length(b);

    % Inizializza la soluzione corrente con il vettore di innesco x0
    x = x0;

    % Itera il metodo di Gauss-Seidel
    for K = 1:N_max
        % Memorizza la soluzione precedente x^(K-1)
        x_old = x;

        % Calcola ogni componente di x^(K)
        for i = 1:n
            % Somma degli elementi a sinistra di x^(K)
            sum1 = A(i, 1:i-1) * x(1:i-1);
            % Somma degli elementi a destra di x^(K-1)
            sum2 = A(i, i+1:n) * x_old(i+1:n);
            % Formula del metodo di Gauss-Seidel
            x(i) = (b(i) - sum1 - sum2) / A(i, i);
        end

        % Calcola il residuo r^(K) = b - A * x^(K)
        r = b - A * x;

        % Calcola la norma del residuo ||r^(K)||_2
        r_norm = norm(r, 2);

        % Condizione di arresto: se ||r^(K)||_2 <= epsilon * ||b||_2
        if r_norm <= epsilon * norm(b, 2)
            return;  % Arresta l'algoritmo e restituisce il risultato
        end
    end

    % Se si raggiunge N_max iterazioni senza soddisfare il criterio, si restituisce
    % x^(N_max), il relativo indice N_max e la norma del residuo ||r^(N_max)||_2
end
```

### Spiegazione 

1. **Input:**
    - `A`: La matrice del sistema lineare.
    - `b`: Il vettore dei termini noti.
    - `x0`: Il vettore di innesco (cioè la stima iniziale di $x$).
    - `epsilon`: La soglia di precisione per il residuo.
    - `N_max`: Il numero massimo di iterazioni consentite.
2. **Output:**
    - `x`: Il vettore soluzione $x^{(K)}$, dove $K$ è il numero di iterazioni.
    - `K`: Il numero di iterazioni effettivamente eseguite.
    - `r_norm`: La norma $||r^{(K)}||_2$​ del residuo $r^{(K)}=b-A\cdot x^{(K)}$.
3. **Procedura:**
    - Il metodo di Gauss-Seidel iterativo aggiorna ogni componente del vettore $x^{(K)}$ tenendo conto dei valori già aggiornati di $x_i$​, a differenza del metodo di Jacobi, dove si usano solo i valori dell'iterazione precedente.
	- L'arresto del processo avviene quando la norma del residuo $||r^{(K)}||_2$​ è inferiore o uguale a $\epsilon\cdot ||b||_{2}$​ oppure si raggiunge il numero massimo di iterazioni $N_{\text{max}}$​.

## Esercizio 6

L'esercizio 6 chiede di creare una function MATLAB che implementi il **metodo della  bisezione**, ovvero il metodo che permette di trovare il punto $\xi$ di una funzione $f(x)$ definita su intervallo $[a,b]$ tale che $f(\xi)=0$

Sia $f:[a,b]\rightarrow\mathbb{R}$ una funzione continua su $[a,b]$ tale che $f(a)$ e $f(b)$ hanno segno opposto $:f(a)f(b)\lt 0$. Un teorema dell'analisi matematica ( teorema degli zeri ) garantisce che la funzione $f(x)$ ha almeno uno zero nell'intervallo $(a,b)$, cioè esiste un punto $\zeta\in(a,b)$ tale che $f(\zeta)=0$; 
Figura 1.1
![[Pasted image 20241111102714.png|center|400]]
	Una funzione continua $f:[a,b]\rightarrow\mathbb R$ tale che $f(a)f(b)<0$ possiede almeno uno zero $\zeta\in(a,b)$.
Supponiamo che $f(x)$ abbia un unico zero $\zeta$ in $(a,b)$. Un metodo per determinare un'approssimazione $\xi$ di $\zeta$ è il metodo di bisezione: fissata una soglia di precisione $\varepsilon>0$, il metodo costruisce la successione di intervalli $$[\alpha_k,\beta_k],\space\space\space\space\space\space\space\space k=0,1,2,\dots$$ in cui $[\alpha_0,\beta_0]=[a,b]$ e, per $k\le1$,$$[\alpha_k,\beta_k]=\begin{cases}
[\alpha_{k-1},\frac{\alpha_{k-1}+\beta_{k-1}}{2}],se\ \zeta\in[\alpha_{k-1},.\frac{\alpha_{k-1}+\beta_{k-1}}{2}]\ cioè\ f(\alpha_{k-1})f(\frac{\alpha_{k-1}+\beta_{k-1}}{2})\le 0, \\
[\frac{\alpha_{k-1}+\beta_{k-1}}{2},\beta_{k-1}],\ altrimenti.
\end{cases}$$
La successione di intervalli così costruita gode delle seguenti proprietà:
- $\zeta\in[\alpha_k ,\beta_k ]$ per tutti i $k \ge 0$;
- ogni intervallo è metà del precedente e dunque la lunghezza di $[\alpha_k , \beta_k ]$ è $\beta_k − \alpha_k =\frac{b−a}{2^k}$ per ogni $k \ge 0$.
Il metodo si arresta al primo indice $K$ tale che $\beta_K − \alpha_K \le\varepsilon$ e restituisce come risultato il punto medio $\xi$ dell’intervallo $[\alpha_K , \beta_K ]$ dato da $\xi=\frac{\alpha_K+\beta_k}{2}$. In questo modo, siccome $\zeta\in[\alpha_K , \beta_K ]$, si ha $|\xi − \zeta| ≤ \frac{\varepsilon}{2}$.
Osserviamo che l’indice di arresto K è il più piccolo intero ≥ 0 tale che $$\beta_k-\alpha_k\le\varepsilon\iff\frac{b-a}{2^K}\le\varepsilon\iff 2^K\ge\frac{b-a}{\varepsilon}\iff K\ge\log_2(\frac{b-a}{\varepsilon}),$$
cioè $K=\lceil\log_2(\frac{b-a}{\varepsilon})\rceil$.

Scrivere un programma Matlab che implementa il metodo di bisezione. Il programma deve:
- prendere in input gli estremi $a, b$ di un intervallo, una funzione continua $f:[a, b]\rightarrow\mathbb R$, con $f(a)f(b) < 0$ e con un unico zero $\zeta\in(a, b)$, e un $\varepsilon > 0$;
- restituire in output l’approssimazione $\xi$ di $\zeta$ ottenuta con il metodo di bisezione sopra descritto, l’indice di arresto $K$ del metodo, e il valore $f(\xi)$ (che sarà all’incirca pari a $0 = f (\zeta)$).

### Codice


```matlab
function [xi, K, fx] = bisezione(a, b, f, epsilon)
    % Verifica che f(a) e f(b) abbiano segno opposto
    if f(a) * f(b) > 0
        error('f(a) e f(b) devono avere segni opposti');
    end

    % Inizializzazione degli estremi dell'intervallo e contatore delle iterazioni
    alpha_k = a;
    beta_k = b;
    K = 0;

    % Ripeti finché la lunghezza dell'intervallo è maggiore della precisione richiesta
    while (beta_k - alpha_k) / 2 > epsilon
        % Calcola il punto medio dell'intervallo
        xi = (alpha_k + beta_k) / 2;

        % Aggiorna gli estremi dell'intervallo in base al segno di f(xi)
        if f(alpha_k) * f(xi) <= 0
            beta_k = xi;
        else
            alpha_k = xi;
        end

        % Incrementa il contatore delle iterazioni
        K = K + 1;
    end

    % Calcola l'approssimazione finale di xi come punto medio dell'ultimo intervallo
    xi = (alpha_k + beta_k) / 2;
    fx = f(xi); % Calcola il valore di f in xi
end
```

### Spiegazione

- **Verifica dei segni**: la funzione controlla che $f(a)$ e $f(b)$ abbiano segno opposto, come richiesto dal teorema degli zeri.
- **Inizializzazione**: definisce $\alpha_k = a$ e $\beta_k = b$ e imposta il contatore $K=0$
- **Iterazione del metodo di bisezione**: continua a suddividere l'intervallo finché la metà della sua lunghezza è maggiore di $\varepsilon$. Ad ogni iterazione:
    - Calcola il punto medio $\xi$.
    - Aggiorna gli estremi in base al segno di $f(\xi)$ rispetto a $f(\alpha_k)$.
    - Incrementa $K$.
- **Output finale**: restituisce l'approssimazione $\xi$, l'indice $K$, e $f(\xi)$.
# Problemi

## Problema 1

Il problema 1 dice questo 

![[problema 1.png|center|500]]
### Codice

```matlab
% Definisci i nodi di interpolazione e i valori corrispondenti di sqrt(x)
x_nodes = [0, 1/64, 4/64, 9/64, 16/64, 25/64, 36/64, 49/64, 1];
y_nodes = sqrt(x_nodes);

% Definisci i punti zeta_i dove valutare il polinomio interpolante
zeta = (0:20) / 20;

% Calcola il polinomio interpolante nei punti zeta usando interpolaRuffiniHornerEs1
p_zeta = interpola_ruffini_horner(x_nodes, y_nodes, zeta);

% Calcola la funzione sqrt nei punti zeta
sqrt_zeta = sqrt(zeta);

% Calcola il vettore delle differenze p(zeta) - sqrt(zeta)
diff_vector = p_zeta - sqrt_zeta;

% Visualizza il vettore delle differenze
disp('Vettore delle differenze p(zeta_i) - sqrt(zeta_i):');
disp(diff_vector.');

% Traccia il grafico di sqrt(x) e p(x) sull'intervallo [0, 1]
x_plot = linspace(0, 1, 100);  % Punti per il grafico
p_x_plot = interpola_ruffini_horner(x_nodes, y_nodes, x_plot);
sqrt_x_plot = sqrt(x_plot);

figure;
plot(x_plot, sqrt_x_plot, 'b-', 'LineWidth', 1.5); hold on;
plot(x_plot, p_x_plot, 'r--', 'LineWidth', 1.5);
legend('sqrt(x)', 'p(x)', 'Location', 'best');
xlabel('x');
ylabel('y');
title('Grafico di sqrt(x) e del polinomio interpolante p(x)');
hold off;
```
### Spiegazione
## Problema 2

Il secondo problema dice questo 
![[problema 2.png|center|500]]
### Codice

```matlab
% Script per risolvere il problema 2.2 con il metodo di Ruffini-Horner
% Definizione della funzione f(x) = e^x
f = @(x) exp(x);

% Intervallo di integrazione [0, 1]
a = 0;
b = 1;

% Valore esatto dell'integrale
I_exact = exp(1) - 1;

% Precisioni richieste
epsilons = [1e-1, 1e-2, 1e-3, 1e-4, 1e-5, 1e-6, 1e-7, 1e-8, 1e-9, 1e-10];

% Inizializza le variabili per la tabella dei risultati
results = []; % tabella dei risultati

fprintf("Punto (a)\n");

% Passo (a) e (b): Trova n(epsilon) per ogni epsilon e costruisci la tabella
for eps = epsilons
    n = 1;
    In = formula_trapezi(f, a, b, n);
    error = abs(I_exact - In);

    % Incrementa n finché l'errore non è inferiore a epsilon
    while error > eps
        n = n + 1;
        In = formula_trapezi(f, a, b, n);
        error = abs(I_exact - In);

        % Debug: stampa ogni volta che In viene aggiornato
        %fprintf('Calcolo per eps = %.1e: n = %d, In = %.10f, error = %.10e\n', eps, n, In, error);
    end

    % Salva i risultati in una tabella
    results = [results; eps, n, In, I_exact, error];
    % Stampa i risultati per questo epsilon
    fprintf('%.1e\t %d\t %.10f\t %.10f\t %.10e\n', eps, n, In, I_exact, error);
end

% Visualizza la tabella dei risultati
fprintf("Punto (b)\n");
disp('Tabella dei risultati:');
disp(array2table(results, 'VariableNames', {'Epsilon', 'n', 'In', 'I_exact', 'Error'}));

% Passo (c): Calcolo di I_2, I_4, I_8, I_16 e confronto con I_exact
fprintf("Punto (c)\n");
n_values = [2, 4, 8, 16];
In_values = zeros(size(n_values));
for i = 1:length(n_values)
    n = n_values(i);
    In_values(i) = formula_trapezi(f, a, b, n);
    fprintf('I_%d = %.10f (Errore = %.10e)\n', n, In_values(i), abs(I_exact - In_values(i)));
end

% Passo (d): Calcolo del polinomio interpolante usando il metodo di Ruffini-Horner
% Usa i valori h^2 come nodi e gli I_n calcolati come valori corrispondenti
fprintf("Punto (d)\n");
h_values = 1 ./ n_values;
t = 0;  % Punto in cui vogliamo valutare il polinomio interpolante
p0 = interpola_ruffini_horner(h_values.^2,In_values, t);

fprintf('\nPolinomio interpolante p(0) = %.10f\n', p0);
fprintf('Errore tra p(0) e I_exact = %.10e\n', abs(I_exact - p0));
```
### Spiegazione
## Problema 3
## Problema 4
## Problema 5
## Problema 6

# Appendice dei programmi

