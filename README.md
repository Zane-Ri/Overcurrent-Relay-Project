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

- The **relay** is the *brain*  
- The **breaker** is the *muscle*

---

## 3. Why does high current mean a fault?

Under normal conditions, current is limited by the line impedance:

- Normal condition:  
  \[
  I_{\text{normal}} = \frac{V}{Z_{\text{line}}}
  \]

When a fault occurs, the impedance suddenly becomes very small:

- Fault condition:  
  \[
  I_{\text{fault}} = \frac{V}{Z_{\text{source}} + Z_{\text{line}} + Z_{\text{fault}}}
  \]

When \( Z_{\text{fault}} \) is extremely small, the current becomes huge. This is what the relay detects.

---

## 4. Types of faults (simplified)

Faults are unintentional connections, such as:

- **3-phase fault** → all phases shorted together (largest current)  
- **Line-to-line fault** → two wires touch  
- **Line-to-ground fault** → one wire touches the ground (most common)

---

## 5a. What an overcurrent relay actually does (simple)

The relay looks at the measured current and checks:

1. **Is the current extremely high?**  
   - If **yes** → trip immediately (for severe faults)
2. **Is the current just above normal?**  
   - If **yes** → wait a short amount of time  
     - Higher current → shorter wait  
     - Lower current → longer wait  

This is called **inverse-time behavior**.

---

## 5b. Mathematical explanation

*(To be filled in with the detailed math of the relay curve if needed.)*

---

## 6. What is a CT (Current Transformer)?

Power lines can carry thousands of amps. You cannot measure that directly, so the current is passed through a **Current Transformer (CT)**, which scales it down.

- Example: **300 A** on the line becomes **5 A** on the relay.
- The relay uses the CT output to make decisions.

Example CT ratio:

- **300:5** →  
  \[
  I_{\text{relay}} = I_{\text{line}} \times \frac{5}{300}
  \]

---

## 7. Time-Current Curve (TCC)

A **TCC curve** shows how long the relay waits before tripping, depending on the current level.

- Big fault → **very fast** trip  
- Small fault → **slower** trip  
- Normal load → **don’t trip at all**

This project will generate **TCC curves**.

---

## 8a. What you will simulate (plain English)

We will simulate a **small utility feeder**, which is:

> The part of the power distribution system that carries electricity from a substation out to neighborhoods, businesses, etc.

Think of a feeder as a **“main branch”** of the local distribution grid.

Parameters we will use:

- **Voltage level**: 13.8 kV source  
  - Other common US values: 4.16 kV, 12.47 kV, 24.9 kV, 34.5 kV
- **Physical length**: 1–5 miles typically  
  - We will use **2 miles**
- **Per-mile impedance (overhead)**:  
  - Use \( 0.3 + j0.8 \ \Omega/\text{mile} \)  
  - Total impedance for 2 miles:  
    \[
    Z_{\text{total}} = 0.6 + j1.6 \ \Omega
    \]
- **Load current**:  
  - Typically **100–400 A**  
  - We will choose **200 A**
- **Fault current**:  
  - Based on earlier calculations  
  - Expected **3–5 kA**

You will simulate:

- A few different **fault types**  
- The current that flows when each fault happens  
- How the relay responds based on the current  
- **When** the relay would trip  
- A **plot** showing trip time vs. current

---

## 8b. What will be simulated (mathematical)

*(To be filled in with detailed equations and models used in the simulation.)*

---

## 9. Why this matters

Overcurrent relays are the **simplest and most common** protection devices in the power grid.

They:

- Clear faults quickly  
- Prevent equipment damage  
- Help maintain reliability and safety of the electrical system
