clc; clear; close all;

%SYSTEM PARAMETERS
V_LL = 13.8e3;
V_phase = V_LL / sqrt(3);
Zs = 0.2 + 1j*0.4;
Zl = 0.6 + 1j*1.6;
Ztot = Zs + Zl;

%fault currents on the primary side
I_3phi = abs(V_phase / Ztot);
I_LL   = 0.866 * I_3phi;
I_SLG  = 0.6   * I_3phi;

%  CT and Relay Settings
CT_ratio = 300/5;
Ip_sec    = 4.5;   % time-overcurrent pickup (secondary)
Iinst_sec = 55;    % instantaneous pickup (secondary)
TMS       = 0.1;

% Faults on current transformer secondary
I_3phi_sec = I_3phi / CT_ratio;
I_LL_sec   = I_LL   / CT_ratio;
I_SLG_sec  = I_SLG  / CT_ratio;

%IEC Standard inverse curve
I_sec   = logspace(log10(Ip_sec*1.01), log10(200), 600);
M       = I_sec / Ip_sec;
t_curve = TMS .* (0.14 ./ (M.^0.02 - 1));

%relay trip times
% 3phase fault: assume always instantaneous
t_3phi = 0;

% LL and SLG use inverse-time formula when between Ip and Iinst
t_LL  = relay_trip_scalar(I_LL_sec,  Ip_sec, Iinst_sec, TMS);
t_SLG = relay_trip_scalar(I_SLG_sec, Ip_sec, Iinst_sec, TMS);

%display the results table for the 3 faults
faults = {'3-Phase Fault'; 'Line-Line Fault'; 'SLG Fault'};
Ivals  = [I_3phi_sec; I_LL_sec; I_SLG_sec];
tvals  = [t_3phi;     t_LL;     t_SLG];
Results = table(faults, Ivals, tvals, ...
    'VariableNames', {'FaultType','RelaySecCurrent_A','TripTime_s'})
disp('TripTime = 0 means instantaneous operation');

%plot ---------------------------
figure;

% Plot IEC inverse time curve
h_curve = loglog(I_sec, t_curve, 'b', 'LineWidth', 2);
hold on; grid on;
xlabel('Relay Secondary Current (A)');
ylabel('Trip Time (s)');
title('TCC Curve for Overcurrent Relay');

% Get Y limits after initial plot
yl = ylim;

% Shade Instantaneous Trip Region (to the right of Iinst)
x_shade = logspace(log10(Iinst_sec), log10(200), 200);
y_shade = ones(size(x_shade)) * yl(2);   
h_shade = area(x_shade, y_shade);
set(h_shade, 'FaceColor', [1 0.8 0.8], ...   % light red
             'EdgeColor', 'none', ...
             'FaceAlpha', 0.45);
uistack(h_shade, 'bottom'); % push shading behind all curves

%fault vertical line indicators
h_3phi = xline(I_3phi_sec, '--k', 'LineWidth', 2);
h_LL   = xline(I_LL_sec,   '--b', 'LineWidth', 2);
h_SLG  = xline(I_SLG_sec,  '--r', 'LineWidth', 2);

% Instantaneous pickup line
h_inst = xline(Iinst_sec, '-.m', 'LineWidth', 2);

%legend
legend([h_curve, h_3phi, h_LL, h_SLG, h_inst, h_shade], ...
    {'IEC Std Inverse Curve', ...
     '3\phi Fault', ...
     'LL Fault', ...
     'SLG Fault', ...
     'Instantaneous Pickup', ...
     'Instantaneous Trip Region'}, ...
     'Location','southwest');


function t = relay_trip_scalar(I, Ip_sec, Iinst_sec, TMS)   % returns trip time for a single current I (secondary amps)
    if I < Ip_sec
        t = inf; % below pickup relay does not operate
    elseif I >= Iinst_sec
        t = 0; %above instantaneous pickup instantaneous trip
    else
        denom = (I/Ip_sec)^0.02 - 1;
        if abs(denom) < 1e-6
            denom = sign(denom) * 1e-6;
        end
        t = TMS * (0.14 / denom);
    end
end
