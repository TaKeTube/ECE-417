% torus parameter
R = 10;
r = 2;
% half length of sides of the sampling box
a = r;
b = R + r;
% sampling time
N = 100000;

% sampling in the box
accept_N = 0;
for i = 1:N
    x = unifrnd(-b, b);
    y = unifrnd(-b, b);
    z = unifrnd(-a, a);
    if (sqrt(x^2+y^2)-R)^2+z^2-r^2 < 0
        accept_N = accept_N + 1;
    end
end

% calculate vol of torus using both analytical and smapling methods
V_analy = 4 * pi^2 * r * R;
V_sample = accept_N/N * (2*b)^2 * 2*a;

% display the result
disp(['Analytical solution of vol is ', num2str(V_analy)]);
disp(['Sampling solution of vol is ', num2str(V_sample)]);