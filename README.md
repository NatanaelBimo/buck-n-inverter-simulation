# Buck and Inverter Simulation

This repository contains 2 SPICE simulations to understand power electronic products better. It provides design parameters and uses LTSpice and Qspice. 

## Buck Converter
![image](https://github.com/user-attachments/assets/ccd4bdf9-6d18-4d1f-a220-feff088e7489)
This part will simulate the buck converter using LTSpice. The design parameters are given as follows.
|   Symbol   |   Parameter   | Value |   Unit   |
|------------|---------------|-------|----------|
|     $$V_{IN}$$     |  Nominal Input Voltage |   24  |   $$V$$  |
|  $$\Delta V_{IN}$$ |  Input Voltage Ripple  |   1   |   %      |
|   $$V_{IN(max)}$$  | Maximum Input Voltage  |   30  |   $$V$$  |
|   $$V_{IN(min)}$$  |  Minimum Input Voltage |   12  |   $$V$$  |
|     $$P_{OUT}$$    |      Output Power      |   25  |   $$W$$  |
|     $$V_{OUT}$$    |     Output Voltage     |   5   |   $$V$$  |
| $$\Delta V_{OUT}$$ |  Output Voltage Ripple |   <0.5  |   %  |
|  $$I_{OUT(max)}$$  | Maximum Output Current |    5    |   $$A$$  |
|      $$f_{S}$$     |   Switching Frequency  |   20  |   $$kHz$$  |

### Inductor Calculation

$$  V_{IN} - V_{SW} - V_{OUT} = L \times \frac{\Delta I}{t_{ON}} $$

Let's assume the voltage across the switch when it is ON  $V_{SW} \approx 2.75 V$ and the forward drop across the catch diode $V_D \approx 0.7 V$ for a schottky diode. The conduction time $t_{ON}$ calculated as follows.

$$ t_{ON} = \frac{V_{OUT} + V_{D}}{(V_{IN} - V_{SW} + V_{D})f_S} = \frac{5 + 0.7}{(24 -2.75+ 0.7)20k}=13 \mu s$$

such that the duty cycle $D = t_{ON} \times f_S = 26 \\%$

Since, for loop stability reasons, we should not use any output capacitor of less than 100 $m\Omega$, and since we do not wish to use an LC post filter, our $\Delta I$ must be:

  $$ \Delta I = \frac{V_{OUT} \times \Delta V_{OUT}}{R_{Cap}} = \frac{5 \times 0.5 \\%}{100m}=250mA$$

Therefore, the inductor value is

$$  L = \frac{(V_{IN} - V_{SW} - V_{OUT})t_{ON}}{\Delta I}  =  \frac{(24 - 0.7 - 5)13 \mu }{250m} \approx 0.85mH$$

### Rectifier Diode Selection

It is recommended to use schottky diodes for better efficiency. The forward current rating needed is equal to the maximum output current calculated as follows.

$$I_F=I_{OUT(max)}\times (1-D)=3.7A$$

### Input Capacitor Selection

Estimate the required effective capacitance that will meet the ripple requirement. The worst case occurs at maximum duty cycle, which is less than 50%.

$$C_{IN}\geq \frac{D(1-D)I_{OUT}}{\Delta V_{IN} \times f_S}\geq 1mF$$

### Output Capacitor Selection

The best practice is to use low-ESR capacitors to minimize the ripple on the output voltage. Ceramic capacitors are a good choice if the dielectric material is X5R or better.

$$C_{OUT(min)}=\frac{\Delta I}{8\times f_S \times \Delta V_{OUT}}=62.5\mu F$$
