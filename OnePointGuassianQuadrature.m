% ONE POINT GUASSIAN QUADRATURE
%
% This script computes a definite integral by using the One-Point
% Guassian Quadrature. It determines how long it world take to
% compute analytically and numerically the integral of the
% following function. The results are plotted.
%
% f(x) = ax^2 + bx + c   [d,e]
%
% Written by Alexander Manzano
% March 20, 2019
% 
% Video Explanation: https://youtu.be/OImY1Mqo3z0
%

clc, close all;

% define the function f(x)
a = 10;
b = 2;
c = 3;
d = 0;
e = 2;
f = @(x) a*x.^2 + b*x + c;

% demonstrate how error correlates to domain size
stepSize   = 0.1;
steps      = d:stepSize:e;
exactSols  = zeros(length(steps)-1,1);
approxSols = zeros(length(steps)-1,1);

% calculate exact solutions
tic;
for i = 1:length(steps)-1
    
    syms x
    exactSols(i) = double(int(f,x,d,steps(i+1)));
    
end
exactSolsTime = toc;

% calculate approximate solutions
tic;
for i = 1:length(steps)-1

    approxSols(i) = (steps(i+1) - d) * f((d+steps(i+1))/2);
    
end
approxSolsTime = toc;

% calculate error from approximation
errors = abs(exactSols-approxSols);

% plot results
xValues = d:stepSize:e-stepSize;
plot(xValues, exactSols, 'LineWidth',2);
hold on
plot(xValues, approxSols, 'LineWidth',2);
plot(xValues, errors, 'LineWidth',2);
xlim([d,e-stepSize]);
xlabel('Domain Size of Integrand');
ylabel('Solutions');
legend('Exact Solution', 'Approximate Solution',...
       'Error', 'Location', 'best');
hold off

% print time results in console
fprintf(['It took %1.4f seconds to calculate %1.0f definite' , ...
         ' integrals analytically.\n'], exactSolsTime, length(steps)-1);

fprintf(['It took %1.4f seconds to calculate the same %1.0f' , ...
         ' definite integrals using the One Point Guassian'  , ... 
         ' Quadrature.\n'], approxSolsTime, length(steps)-1);


