 %Input variables
%Vehicle_1
%Kerb_weight(lb)%Payload(lb)=4750;%(lb)****
%total_weight=Kerb_Weight+Payload;
%total_weight_lb=4750;
HEFET_DATA=readtable('HEFET_DATA.xlsx');
HEFET_time=HEFET_DATA{:,1};%sec
HEFET_velocity=HEFET_DATA{:,2};%mph
%to export data to simulink
velocity=[HEFET_time,HEFET_velocity];
stop_time=HEFET_time;
total_weight_lb_to_kg=4750*0.4536;
total_weight=2154.6;%mass in kg
Gravitational_force= 9.81;%(m/s^2)
Air_density=1.225;%(kg/m3)
Frontal_Area=1.8;%(m^2)
Drag_coefficient=0.2;
grade_angle=15;%(deg)
Gear_Ratio_g =7;
wheel_radius_cal=0.217;%m
Coefficient_of_rolling_resistance=0.012;
MDL_brakesystem_friction=0.45;
MDL_brakesystem_regenerative_friction=0.55;
MDL_Brakingsystem_maximum_brakeforce=10000;%N
MDL_motormodel_maxtorque_out=500;
MDL_motormodel_max_power_out=100000;
MDL_motormodel_Kc=0.045257;
MotorModel_kw=5.0664*10^-5 ;
MotorModel_ki=0.016667;
MotorModel_C=628.3;
energy_capacity=12.6;
initial_soc=0.95;
Driveline_model_spinloss=6;
out=sim('PART_5_COMBINED_HWY');
t=out.time;
actual_velocity=out.actual_velocity;
SOC_percentage=out.soc;
Battery_power_W=out.Battery_power;
Motor_torque_Nm=out.Motor_torque;
Motor_power_loss=out.motor_power_loss;
Motor_power_output=out.Motor_power_output_W;
APP=out.App;
BPP=out.Bpp;

%plotting
figure(1)
subplot(2,2,1)
plot(t,SOC_percentage);
xlabel('Time(s)')
ylabel('SOC_percentage(%)')
legend('Time(s) vs SOC_percentage(%)')
grid on
subplot(2,2,2)
plot(actual_velocity,Battery_power_W);
xlabel('actual_velocity(mph)')
ylabel('Battery_power_W')
legend('actual_velocity(mph) vs Battery_power_W')
grid on
sorted_Motor_torque_Nm=sort(Motor_torque_Nm);
subplot(2,2,3)
plot(actual_velocity,sorted_Motor_torque_Nm);%&&&&&&&&&&&&&&
xlabel('actual_velocity(mph)')
ylabel('sorted_Motor_torque_Nm')
legend('actual_velocity(mph) vs sorted_Motor_torque_Nm')
grid on
subplot(2,2,4)
plot(actual_velocity,Motor_torque_Nm);
xlabel('actual_velocity(mph)')
ylabel('Motor_torque_Nm')
legend('actual_velocity(mph) vs Motor_torque_Nm')
grid on
figure(2)
plot(t,actual_velocity,HEFET_time,HEFET_velocity);
xlabel('time')
ylabel('velocity_mph')
legend('DRIVECYCLE VELOCITY VS ACTUAL VELOCITY')
grid on

figure(3)
subplot(2,2,1)
plot(t,Motor_power_loss)
xlabel('time')
ylabel('motor_power_loss')
legend('time vs Motor_power_loss')
grid on
subplot(2,2,2)
plot(t,Motor_power_output)
xlabel('time')
ylabel('motor_power_out')
legend('time vs Motor_power_output')
grid on
subplot(2,2,3)
plot(t,APP)
xlabel('time')
ylabel('App')
legend('time vs APP')
grid on
subplot(2,2,4)
plot(t,BPP)
xlabel('time')
ylabel('Bpp')
legend('time vs BPP')
grid on

 %Assuming 'actual_velocity' is the output signal stored from the Simulink VDE model and 't' is the corresponding time vector.
%% Make sure  and t are available
if ~exist('actual_velocity','var')||~exist('t','var')
    error('Output_signal_y_and_time_vector_t_are_required');
 end
% Reference Input Value (Drive cycle velocity)
   ref_value = HEFET_velocity; 

% Find Overshoot (OS)
%interpolate the actual velocity to size actual velocity  
actual_velocity_resampled=interp1(t,actual_velocity,HEFET_time);
%to find the max value of actual velocity and the position where it occur
[peak_value,index_of_peak_value]=max(actual_velocity_resampled);
%time at which max velocity occure
t_max=HEFET_time(index_of_peak_value);
%ref value curresponds to peak max value of actual velocity
 ref_Vmax=ref_value (index_of_peak_value);
overshoot=((peak_value-ref_Vmax))/(ref_Vmax)*100;

 % Find Undershoot (US) - minimum value after the initial response
[v_actual_min,index_of_vmin]=min(actual_velocity_resampled);
 t_min=HEFET_time(index_of_vmin);
 ref_Vmin=ref_value(index_of_vmin);
 undershoot = (v_actual_min-ref_Vmin)/ref_Vmin*100;

 % Find Settling Time (Ts) - time when the signal stays within 2% of the final value
tolerance = 0.02 * ref_value;
settling_index = find(abs(actual_velocity_resampled - ref_value) > tolerance);
settling_time = t(end) - t(settling_index(end));
 
%Find Rise Time (Tr) - time taken for the signal to rise from 10% to 90% of its final value
rise_time_start_index = find(actual_velocity_resampled>= 0.1 * ref_value, 1);
rise_time_end_index = find(actual_velocity_resampled >= 0.9 * ref_value, 1);
rise_time = t(rise_time_end_index) - t(rise_time_start_index);

% Find Peak Time (Tp) - time when the peak occurs
[~, peak_time_index] = max(actual_velocity_resampled);
peak_time = t(peak_time_index);

% Find Steady-State Error (Ess) - difference between the final value and the reference
steady_state_error = abs(ref_value(end)-actual_velocity_resampled(end));

 % Display Results
fprintf('Overshoot (OS): %.2f%%\n', overshoot);
fprintf('Undershoot (US): %.2f%%\n', undershoot);
fprintf('Settling Time (Ts): %.2f seconds\n', settling_time);
fprintf('Rise Time (Tr): %.2f seconds\n', rise_time);
fprintf('Peak Time (Tp): %.2f seconds\n', peak_time);
fprintf('Steady-State Error (Ess): %.4f\n', steady_state_error);
