%% Clear and add path 
clc; clear; close all; 
addpath('functions'); 

%% Defining simulation parameters 
V0      = -60;          % initial Vm 

T       = 30;           % ms, max simulation time
dt      = 1e-2;         % ms, time step 

t_inp   = [5, 25];      % time to turn on input
I_amp   = 0.1;          % uA/cm^2

file_name = 'demo-1'; 

%% Defining global constants 
% note: could also save these constants in a struct in a MAT file then load
% them in at the beginning of simulaton script in practice 
global C;
global E_Na E_K E_L; 
global gbar_Na gbar_K gbar_L;

C       = 0.01;         % uF/cm^2
E_Na    = 55.17;        % mV
E_K     = -72.14;       % mV
E_L     = -49.42;       % mV

gbar_Na = 1.2;          % mS/cm^2
gbar_K  = 0.36;         % mS/cm^2
gbar_L  = 0.003;        % mS/cm^2

%% Set up state monitors 
t       = 0:dt:T;
nsteps  = length(t); 

monitors    = struct();
monitors.t  = t; 

states_to_monitor = {'V', 'm', 'h', 'n', 'I_Na', 'I_K', 'I_L', 'I', 'total_I'};
for i = 1:length(states_to_monitor)
    monitors.(states_to_monitor{i}) = zeros(nsteps,1); 
end

%% Set up initial conditions and save to monitor
V       = V0; 
m       = alpha_m(V) / (alpha_m(V) + beta_m(V));
h       = alpha_h(V) / (alpha_h(V) + beta_h(V));
n       = alpha_n(V) / (alpha_n(V) + beta_n(V));

monitors.V(1) = V;
monitors.m(1) = m;
monitors.h(1) = h;
monitors.n(1) = n;

%% Simulation loop 
for i = 2:nsteps
    
    % Input current 
    I = 0; 
    if t(i) >= t_inp(1) && t(i) <= t_inp(2)
        I = I_amp; 
    end
    
    % Calculate derivatives
    [dV_dt, dm_dt, dh_dt, dn_dt, I_Na, I_K, I_L, total_I] = dsys_hh(V,m,h,n,I);
    
    % Update step
    V = V + dV_dt * dt;
    m = m + dm_dt * dt;
    h = h + dh_dt * dt;
    n = n + dn_dt * dt;
    
    % Save to monitor 
    monitors.V(i)		= V;
    monitors.m(i)		= m;
    monitors.h(i)		= h;
    monitors.n(i)		= n;
    
    monitors.I_Na(i)    = I_Na;
    monitors.I_K(i)		= I_K;
    monitors.I_L(i)		= I_L;
    monitors.I(i)		= I;
    monitors.total_I(i)	= total_I;
    
end

%% Save data as MAT
% in practice should also save simulation parameters and other necessary
% meta-data to reproduce simulation
save(fullfile('data', file_name), 'monitors'); 

%% Visualize

figure; 
config_graphic_settings(gcf); 
subplot(5,1,1:2); hold on; 
plot(monitors.t, monitors.V, '-k');
ylabel('membrane potential V_m (mV)');

yyaxis right; 
plot(monitors.t, monitors.I, 'color', [0.7,0.7,0.7]); 
ylim(sort([-0.2*I_amp, 5*I_amp]));
set(gca, 'ycolor',  [0.7,0.7,0.7]);

ylabel('input current I (\muA/cm^2)');
title('HH model'); 

legend('Vm', 'I');
subplot(5,1,3:4); hold on; 
plot(monitors.t, monitors.m);
plot(monitors.t, monitors.h);
plot(monitors.t, monitors.n);
legend('m','h','n');
ylabel('(in)activation variables'); 

subplot(515); hold on; 
plot(monitors.t, monitors.I_Na);
plot(monitors.t, monitors.I_K);
plot(monitors.t, monitors.I_L);
plot(monitors.t, monitors.total_I);
legend('I_{Na}', 'I_K', 'I_L', 'total I'); 
ylabel('currents (\muA/cm^2)');
xlabel('time (ms)');

linkaxes(findall(gcf, 'type', 'axes'), 'x'); % link x axis 

%% Save figure as PNG
print(gcf, fullfile('figures', file_name), '-dpng', '-r200');
close;
