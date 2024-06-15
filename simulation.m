% Define system matrices
A = [-1 2; -3 -4];
B = [1 0; 0 1];
C = [1 0; 0 1];
D = [0 0; 0 0];

% Define initial conditions and time span
x0 = [1; 1];
tspan = 0:0.05:10; % Time vector with 0.05 time step

% Define input function
u = @(t) [sin(t); cos(t)];

% Define the state-space system as a function
dxdt = @(t, x) A * x + B * u(t);

% Solve the system using ode45 with specified time vector
[t, x] = ode45(dxdt, tspan, x0);

% Calculate the output y(t)
y = zeros(length(t), 2);
for i = 1:length(t)
    y(i, :) = (C * x(i, :)' + D * u(t(i)))';
end

% Calculate the input u(t) for saving and plotting
u_values = zeros(length(t), 2);
for i = 1:length(t)
    u_values(i, :) = u(t(i))';
end

% Save time and input to a text file with specified format
input_file = fopen('time_and_input.txt', 'w');
for i = 1:length(t)
    fprintf(input_file, '%.3f %.3f %.3f\n', t(i), u_values(i, 1), u_values(i, 2));
end
fclose(input_file);

% Save time and output to a text file with specified format
output_file = fopen('time_and_output.txt', 'w');
for i = 1:length(t)
    fprintf(output_file, '%.3f %.3f %.3f\n', t(i), y(i, 1), y(i, 2));
end
fclose(output_file);

% Plot the input variables
figure;
subplot(2, 1, 1);
plot(t, u_values(:, 1));
xlabel('Time (s)');
ylabel('u1');
title('Input Variable u1');

subplot(2, 1, 2);
plot(t, u_values(:, 2));
xlabel('Time (s)');
ylabel('u2');
title('Input Variable u2');

% Plot the output variables
figure;
subplot(2, 1, 1);
plot(t, y(:, 1));
xlabel('Time (s)');
ylabel('y1');
title('Output Variable y1');

subplot(2, 1, 2);
plot(t, y(:, 2));
xlabel('Time (s)');
ylabel('y2');
title('Output Variable y2');
