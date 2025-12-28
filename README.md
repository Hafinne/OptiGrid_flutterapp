
# ⚡ OptiGrid: Decentralized Virtual Power Plant (VPP)

> **CECECO Clean Energy Hackathon 2026 Submission**
> *Theme: Data for Policy, Planning & Implementation*

OptiGrid is a mobile-first ecosystem designed to stabilize national energy grids while empowering citizens to monetize their energy savings. It transforms smartphones into **Edge Logic Nodes**, creating a hardware-free Virtual Power Plant.

## 📱 Key Features

### 1. Thermodynamic Digital Twin 🏠
Uses **Linear Algebra** matrices to simulate home heat loss ($Q = U \cdot A \cdot \Delta T$) in real-time, visualizing the cost of every degree change.

### 2. VPP Command Node ⚠️
Functions as a decentralized grid stabilizer. Using **Finite State Machine (FSM)** logic, the app responds to "Grid Critical" signals by automatically optimizing energy consumption, effectively shedding load without blackouts.

### 3. Eco-Invest Hub 💰
A novel "Behavior-to-Investment" model where energy savings are converted into digital **Eco-Credits**, allowing users to micro-invest in regional renewable energy projects (Solar/Wind).

## 🛠️ Tech Stack
* **Framework:** Flutter (Dart)
* **Architecture:** MVC Pattern
* **Math Engine:** Custom Linear Algebra Heat Loss Calculator
* **Logic Engine:** Finite State Machine (FSM) for Grid Response

## 🚀 How to Run
1. Clone the repo
2. `flutter pub get`
3. `flutter run`

---
*Built by [Senin Adın/Kullanıcı Adın] for a cleaner future.*
