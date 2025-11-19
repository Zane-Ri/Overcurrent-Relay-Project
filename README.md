
# Background for Overcurrent Relay Project

  

## 1. What is power system protection?

  

The electrical grid needs protection because sometimes faults happen — short circuits, trees touching lines, equipment failure, etc.

  

Faults cause very large currents, and these currents can:

  

- Damage equipment

- Cause fires

- Create large blackouts

  

Protection systems detect abnormal electrical conditions and disconnect the damaged part of the system.

  

---

  

## 2. What is an overcurrent relay?

  

An overcurrent relay watches the current on a line. If the current becomes too high, the relay tells a breaker to open.

  

- The relay is the brain

- The breaker is the muscle

  

---

  

## 3. Why does high current mean a fault?

  

Under normal conditions, current is limited by the line impedance:

  

- Normal condition:

    $$
    I = \frac{V}{Z_{Load}}
    $$

  

When a fault occurs, the impedance suddenly becomes very small:

  

- Fault condition:

$$
I = \frac{V}{Z_{Source}+Z_{Line}+Z_{Fault}}
$$

  

When the fault impedance is extremely small, the current becomes huge. This is what the relay detects.

  

---

  

## 4. Types of faults

  

Faults are unintentional connections, such as:

  

-  **3-phase fault** → all phases shorted together (largest current)

-  **Line-to-line fault** → two wires touch

-  **Line-to-ground fault** → one wire touches the ground (most common)

  

---

  

## 5. What an overcurrent relay actually does (simple)

  

The relay looks at the measured current and checks:

  

1.  **Is the current extremely high?**

- If yes → trip immediately (for severe faults)

2.  **Is the current just above normal?**

- If yes → wait a short amount of time

- Higher current → shorter wait

- Lower current → longer wait

  

This is called **inverse-time behavior**.


## 6. What is a CT (Current Transformer)?

  

Power lines can carry thousands of amps. You cannot measure that directly, so the current is passed through a **Current Transformer (CT)**, which scales it down.

  

- Example: 300 A on the line becomes 5 A on the relay.

- The relay uses the CT output to make decisions.

  

Example CT ratio:

  

$$300:5$$

$$
I_{\text{relay}} = I_{\text{line}} \times \frac{5}{300}
$$


  

---

  

## 7. Time-Current Curve (TCC)

  

A **TCC curve** shows how long the relay waits before tripping, depending on the current level.

  

- Big fault → very fast trip

- Small fault → slower trip

- Normal load → don’t trip at all

  

This project will consist of a MATLAB file which generates TCC curves based on given parameters. The TCC curve will be based off the **IEC Standard Inverse Time Formula**, which describes the time taken for a relay to respond:
$$t = TMS \cdot\frac{0.14}{(\frac{I}{I_{P}})^{0.02}-1}$$

  

---

  

## 8. What will be simulated

  

We will simulate a **small utility feeder**, which is the part of the power distribution system that carries electricity from a substation out to neighborhoods, businesses, etc.

  

Think of a feeder as a “main branch” of the local distribution grid.

  

Parameters we will use for the MATLAB simulation:

  

-  Voltage level: 13.8 kV

-  Physical length: 2 miles

-  Per-mile impedance (overhead): 0.3 + j0.8$\Omega$

- Total impedance for 2 miles: 0.6 + j1.6$\Omega$

- Load current: 200A



  

The following things will be simulated:

  

- The three different fault types

- The current that flows when each fault happens

- How the relay responds based on the current

- A plot showing trip time vs. current

## 9. Why this matters

  

Overcurrent relays are the simplest and most common protection devices in the power grid. They:

  

- Clear faults quickly

- Prevent equipment damage

- Help maintain reliability and safety of the electrical system
