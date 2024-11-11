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

![[Pasted image 20241111124227.png|center|700]]

### Soluzione

**Punto (a)**

Con $\xi_i=\frac{i-1}{20}$, il vettore colonna $p(\xi_1)-\sqrt{\xi_1},\dots,p(\xi_{21})-\sqrt{\xi_{21}}$ è $$\begin{align}
&p(\xi_1)-\sqrt{\xi_1}:0
\\&p(\xi_2)-\sqrt{\xi_2}:0.009373456935820
\\&p(\xi_3)-\sqrt{\xi_3}:-0.016624898598359
\\&p(\xi_4)-\sqrt{\xi_4}:0.006265159516694
\\&p(\xi_5)-\sqrt{\xi_5}: 0.026059100541982
\\&p(\xi_6)-\sqrt{\xi_6}: 0.000000000000000
 \\&p(\xi_7)-\sqrt{\xi_7}: -0.046798842893448
 \\&p(\xi_8)-\sqrt{\xi_8}: -0.052843679514480
\\&p(\xi_9)-\sqrt{\xi_9}:   0.019043791981465
\\&p(\xi_{10})-\sqrt{\xi_{10}}:   0.136657922266046
\\&p(\xi_{11})-\sqrt{\xi_{11}}:   0.195969221000572
\\&p(\xi_{12})-\sqrt{\xi_{12}}:   0.070222900207986
\\&p(\xi_{13})-\sqrt{\xi_{13}}:  -0.298665479678417
\\&p(\xi_{14})-\sqrt{\xi_{14}}:  -0.793827451939188
\\&p(\xi_{15})-\sqrt{\xi_{15}}:  -1.047857448417138
\\&p(\xi_{16})-\sqrt{\xi_{16}}:  -0.461689802877381
\\&p(\xi_{17})-\sqrt{\xi_{17}}:   1.600121563949965
\\&p(\xi_{18})-\sqrt{\xi_{18}}:   5.337600132745608
\\&p(\xi_{19})-\sqrt{\xi_{19}}:   9.648720381277402
\\&p(\xi_{20})-\sqrt{\xi_{20}}:  10.731478361986454
\\&p(\xi_{21})-\sqrt{\xi_{21}}:  -0.000000000000004\end{align}$$
Osservando i valori numerici, si può notare che:
- **L'errore non è costante:** La differenza $p(\xi_i) - \sqrt{\xi_i}$ assume sia valori positivi che negativi, indicando che il polinomio a volte sovrastima e a volte sottostima la funzione radice quadrata.
- **L'errore varia in modo significativo a seconda del punto:** In alcuni punti l'errore è molto piccolo (quasi nullo), mentre in altri è molto grande.

**Punto (b)**

Il grafico delle funzioni $\sqrt{x}$ e $p(x)$ è il seguente

![[grafico_es1.jpg|center|500]]
### Codice

```matlab title:Problema2.1
% Definisci i nodi di interpolazione e i valori corrispondenti di sqrt(x)
x_nodes = [0, 1/64, 4/64, 9/64, 16/64, 25/64, 36/64, 49/64, 1];
y_nodes = sqrt(x_nodes);

% Definisci i punti zeta_i dove valutare il polinomio interpolante
i = 1:21;
zeta = (i-1) / 20;

% Calcola il polinomio interpolante nei punti zeta usando Interpola_Ruffini_Horner
p_zeta = interpola_ruffini_horner(x_nodes, y_nodes, zeta);

% Calcola la funzione sqrt nei punti zeta
sqrt_zeta = sqrt(zeta);

% Calcola il vettore delle differenze p(zeta) - sqrt(zeta)
diff_vector = p_zeta - sqrt_zeta;

% Visualizza il vettore delle differenze
disp('Vettore delle differenze p(zeta_i) - sqrt(zeta_i}:');
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
## Problema 2

![[Pasted image 20241111124424.png|center|700]]

### Soluzione

**Punto (a)**

Per il teorema sull'errore o resto della formula dei trapezi, abbiamo che $$\left|\int_0^1e^xdx-I_n\right|=\left|-\frac{f^{''}(\eta)(b-a)}{12}\cdot h^2\right|$$
Per determinare un $n=n(\varepsilon)$ tale che $\left|I-I_n\right|\leq\varepsilon$ procediamo in questo modo

Abbiamo che 

$$\left|\int_0^1e^xdx-I_n\right|=\left|-\frac{f^{''}(\eta)\cdot 1}{12n^2}\right|=\frac{f^{''}(\eta)}{12n^2},\eta\in[0,1]$$
Calcoliamo $f^{''}(x)$ : 
$$f^{'}(x)=f^{''}=f(x)=e^x$$
per ogni $x\in[0,1]$ si ha che:
$$\left|f^{''}(x)\right|=\left|e^x\right|=e^x\leq e=2.71828$$
Quindi, possiamo scrivere $$\left|\int_0^1e^xdx-I_n\right|\leq\frac{2.71828}{12n^2}$$
E infine $$\frac{2.71828}{12n^2}\leq\varepsilon\iff n\geq\sqrt{\frac{2.71828}{12\varepsilon}}=n(\varepsilon)$$
**Punto (b)**

Tabella

| $\varepsilon$ | $n$   | $I_n$            | $I$              | Errore               |
| ------------- | ----- | ---------------- | ---------------- | -------------------- |
| 1.0e-1        | 2     | 1.75393109246483 | 1.71828182845905 | 3.56492640057802e-2  |
| 1.0e-2        | 4     | 1.72722190455752 | 1.71828182845905 | 8.94007609847147e-3  |
| 1.0e-3        | 12    | 1.71927608944639 | 1.71828182845905 | 9.94260987340567e-4  |
| 1.0e-4        | 38    | 1.71838098946991 | 1.71828182845905 | 9.91610108698193e-5  |
| 1.0e-5        | 120   | 1.71829177220812 | 1.71828182845905 | 9.94374907281603e-6  |
| 1.0e-6        | 379   | 1.71828282532022 | 1.71828182845905 | 9.96861172719576e-7  |
| 1.0e-7        | 1197  | 1.71828192839571 | 1.71828182845905 | 9.99366627230103e-8  |
| 1.0e-8        | 3785  | 1.71828183845402 | 1.71828182845905 | 9.99497018483453e-9  |
| 1.0e-9        | 11967 | 1.71828182945891 | 1.71828182845905 | 9.99865967798996e-10 |
| 1.0e-10       | 37839 | 1.71828182855904 | 1.71828182845905 | 9.99984539618026e-11 |
**Punto (c)**

Le approssimazioni di $I$ ottenute con la formula dei trapezi sono le seguenti :

$I_2 = 1.75393109246482525876$ (Errore = $3.5649264006e-02$)
$I_4 = 1.72722190455751656302$ (Errore = $8.9400760985e-03$)
$I_8 = 1.72051859216430180766$ (Errore = $2.2367637053e-03$)
$I_16 = 1.71884112857999449275$ (Errore = $5.5930012095e-04$)

Valore esatto di $I$ è : $1.718281828459045$

**Punto (d)**

Il valore di $p(0) = 1.718281828460389$
Confronto con il valore esatto di $I$ = $1.343813949006289e-12$ (ovvero $1.344\cdot10^{-12}$)
### Codice

```matlab title:"Problema 2.2"
% Definizione della funzione
f = @(x) exp(x);

% Valore esatto dell'integrale
I_exact = 1.718281828459045;

% --- Punto (b) ---
% Tolleranze epsilon da verificare
epsilons = [1e-1, 1e-2, 1e-3, 1e-4, 1e-5, 1e-6, 1e-7, 1e-8, 1e-9, 1e-10];

% Inizializzazione tabella
results = [];

for epsilon = epsilons
    n = 1;
    In = formula_trapezi(f, 0, 1, n);
    error = abs(I_exact - In);

    % Incrementa n fino a soddisfare la condizione di errore
    while error > epsilon
        n = n + 1;
        In = formula_trapezi(f, 0, 1, n);
        error = abs(I_exact - In);
    end

    % Aggiungi i risultati per questo epsilon
    results = [results; epsilon, n, In, I_exact, error];
end

% --- Formattazione e visualizzazione dei risultati ---
% Cambia formato per Epsilon in esponenziale
format("shortE");
epsilon_col = results(:,1);

% Cambia formato per I_n e I_exact in formato long
format("long");
In_col = results(:,3);
I_exact_col = results(:,4);

% Cambia formato per il resto dei valori in compatto
format("compact");
n_col = results(:,2);
error_col = results(:,5);

% Mostra la tabella formattata
disp('Tabella dei risultati per il punto (b):');
disp(table(epsilon_col, n_col, In_col, I_exact_col, error_col, ...
    'VariableNames', {'Epsilon', 'n', 'In', 'I_exact', 'Error'}));

% --- Punto (c) ---
n_values = [2, 4, 8, 16];
I_values = zeros(size(n_values));

for i = 1:length(n_values)
    I_values(i) = formula_trapezi(f, 0, 1, n_values(i));
end

% Visualizza i risultati per il punto (c) con formato long per I_values
disp('Risultati per il punto (c):');
format("long");
for i = 1:length(n_values)
    fprintf('I_%d = %.20f (Errore = %.10e)\n', n_values(i), I_values(i), abs(I_exact - I_values(i)));
end
disp('Valore esatto I:');
disp(I_exact);

% --- Punto (d) ---
% Passi di discretizzazione
h_values = [1/2, 1/4, 1/8, 1/16];
h_squared = h_values.^2;

% Calcola il polinomio interpolante usando le funzioni fornite
p0 = interpola_ruffini_horner(h_squared, I_values, 0);

% Visualizza il risultato dell'interpolazione per il punto (d) in formato long
disp('Risultato per il punto (d):');
disp(['p(0) = ', num2str(p0, '%.15f')]);
disp(['Confronto con il valore esatto I: ', num2str(I_exact, '%.15f')]);
disp(abs(p0-I_exact));
% Reset del formato al default per successive esecuzioni
format("default");
```

## Problema 3
## Problema 4
## Problema 5
## Problema 6

# Appendice dei programmi