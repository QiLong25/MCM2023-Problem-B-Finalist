function ret = aimfunc2(Aa, As, Ns)

area = 144.22;       % total area of subregion
tourist = 71.09;    % tourist of subregion
u = 1;            % weights of profit and wildlife
v = 1;  
w = 1;

Ap = area - Aa - As;
Dp = tourist / Ap;
Ds = Ns / (As+ Ap);

% Dw = 170.54 / (-68 * Ds + 12 * Dp) + 2.1491;          % wildlife - people, stock relationship

Dws = -0.183 * Ds ^ 2 + 5.045 * Ds -27.18;
if Dws < 0
    Dws = 0;
end

Dwp = 154.1755 / Dp - 2.2329;
if Dwp > 13
    Dwp = 13;
end

p = 888 * 1.55;            % agriculture output / unit area
q = 154.9;            % average stock price

profit = p*Aa + q*Ns;           % economic profit (aim function 1)
ret = u * profit / 2500000 + v * Dws + w * Dwp;
