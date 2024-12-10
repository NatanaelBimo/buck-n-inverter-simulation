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

### Close-Loop Control

#### Error Amplifier
Set the error amplifier inverting signal gain. Using Type III Compensator.

Calculate the filter’s resonant frequency:
$$f_{LC}=\frac{1}{2\pi\sqrt{LC_{OUT}}}\approx620Hz$$

We add first zero slightly below the filter’s resonant frequency

$$C_{Z-IN}=\frac{1}{2\pi\times 0.9f_{LC}R_{div1}}=10nF$$

Loop crossover is chosen to be near $f_{xover}=2 kHz$ so, place a pole at the crossover frequency:

$$R_{Z-IN}=\frac{1}{2\pi f_{xover}C_{Z-IN}}\approx 8k3\Omega$$

Calculate the required gain of the compensator at the desired crossover frequency:

$$G_{COMP-xover}=\frac{1}{|\frac{V_{IN}}{V_{tri}}\times \frac{1}{LC_{OUT}(j2\pi f_{xover})^2+1}|}\approx 1.85$$

Set the gain of the compensator:

$$R_{Z-F}=(R_{div1}||R_{Z-IN})G_{COMP-xover}\approx 12k2\Omega$$

Place a second zero just below the filter resonance

$$C_{Z-F1}=\frac{1}{2\pi\times 0.9f_{LC}R_{Z-F}}\approx 24n7F$$

Place a second pole about a decade above the crossover frequency

$$C_{Z-F2}=\frac{1}{2\pi\times 10f_{xover}R_{Z-F}}\approx 690pF$$
<!-- 
$$Gain = -\frac{R_4}{R_3}=-\frac{10k}{10k}$$

Determine $R_1$ and $R_2$ to divide $V_{ref}$ to cancel the non-inverting gain.
$$V_{o_{dc}}=(1+\frac{R_4}{R_3})(\frac{R_2}{R_1+R_2})V_{ref}=(1+\frac{10k}{10k})(\frac{10k}{10k+10k})2.5=2.5V$$ -->

#### Triangle Wave Generator

The amplitude of $V_{tri}$ must be chosen such that it is greater than the maximum amplitude of $V_i$ (2V) to avoid 0% or 100% duty cycle in the PWM output signal. Select $V_{tri}$ to be 2.1V. The amplitude of $V_1$ = 2.5V

$R_{OFFSET}=\frac{|V_{tri}|\times R_{OFFSET-F}}{|V_1|}=8k4\Omega$ with $R_{OFFSET-F}=10k\Omega$

#### Oscillation Frequency

Set the oscillation frequency to 20kHz

$$f_S=\frac{R_{OFFSET-F}}{4\times R_{OSC}\times R_{OFFSET} \times C_{OSC}}$$
Suppose $C_{OSC}=10nF$
$$R_{OSC}=\frac{R_{OFFSET-F}}{4\times f_S\times R_{OFFSET} \times C_{OSC}}\approx 1k5\Omega$$
<!-- 
Choose $C_1$ to limit amplifier bandwidth below switching frequency.
$$f_P=\frac{1}{2\pi R_4C_1}$$

$$C_1=1nF >> f_P=16kHz$$

Select $C_2$ to filter noise from $V_{ref}$

$$f_{div}=\frac{1}{2\pi C_2\frac{R_1R_2}{R_1+R_2}}$$

$$C_2=100nF >> f_{div}=320Hz$$ -->

#### Totem-Pole Gate Driver

#### Boostraping

#### CMOS NOT Gate