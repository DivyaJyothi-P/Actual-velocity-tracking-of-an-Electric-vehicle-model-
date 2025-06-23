# Actual velocity tracking of an Electric Vehicle Model Using PID Controller in Simulink
This repository contains a complete simulink model of an **Electric Vehicle (EV)** system designed for **real time velocity tracking**  using a **PID controller**.The model tracks a standard drive cycle and evaluates key EV performance metrices such as Battery state of charge (SOC),motor behaviour and energy demand 
## Project Overview 
The Project integrates both **Controller** and **Plant models** to simulate a closed loop electric vehicle system.Tuning of PID parameters is done to ensure that the vehicle's actual speed closely follows the reference speed from a drive cycle. 
## Objectives
-Design a **PID-based control System** for velocity tracking in an EV model.
-Simulate and analyze EV performance using standard drive cycles (e.g,FTP,USO6,Highway,SCO3).
-Tune 'Kp','Ki', and 'Kd' values for optimal controller performance.
-Plot and evaluate system behaviors 
Such as:
-Battery SOC vs time 
-Vehicle mph vs Driver mph
-Motor plots vs Vehicle Speed
-Battery plots vs Vehicle Speed
## Components Modeled
-**Controller Subsystem** (PID controller for velocity tracking)
-**Plant Model**,including:
-Vehicle demand energy calculation
-Drive line model
-Battery model
-Motor model
-Break model
## Simulation outputs
-Battery SOC vs time 
-Vehicle mph vs Driver mph
-Motor plots vs Vehicle Speed
-Battery plots vs Vehicle Speed
These outputs help validate system performance and demonstrate how well the vehicle tracks the reference velocity under varying road condition
## Tools
-MATLAB R2025a
-Simulink
-FTP,USO6,SCO3,Highway drive cycle data 
## File Details
|'PART_5_COMBINED_CITY.slx'| simulink model using FTP drive cycle
|'PART_5_CITY.m'|MATLAB script for  FTP drive cycle
|'PART_5_COMBINED_HWY.slx'| simulink model using Highway drive cycle
|'PART_5_HWY.m'|MATLAB script for  Highway drive cycle
|'PART_5_COMBINED_SCO3_MODEL.slx'|simulink model using SCO3 drive cycle
|'PART_5_SCO3.m'|MATLAB script for SCO3 drive cycle
|'PART_5_US06.slx'|simulink model using USO6 drive cycle
|'PART_5_US06_MODEL.m'|MATLAB script for SCO3 drive cycle
|'CITY.xlsx'|FTP drive cycle data
|'HEFET_DATA.xlsx'|Highway drive cycle data
|'sco3.xlsx'|SCO3 drive cycle data
|'US06.xlsx'|USO6 drive cycle data
|'Presentation.pptx'|Description and results



