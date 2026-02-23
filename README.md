# Adaptive AI-Based Network Anomaly Detection (Flow CSV Generator)

This project captures live network traffic using **Npcap + PcapPlusPlus**, aggregates packets into bi-directional flows, and generates a CSV file containing flow-level features for Machine Learning (XGBoost).

This repository currently focuses on the **Flow Feature Extraction + CSV Generation** stage.

# 🔧 What This Program Does

1. Lists available network adapters
2. Captures live packets using Npcap
3. Groups packets into bi-directional flows:
   - (SrcIP, DstIP, SrcPort, DstPort, Protocol)
4. Computes flow-level features such as:
   - Duration
   - Packet counts
   - Byte counts
   - Forward/Backward split
   - Packets per second
   - Bytes per second
   - Inter-arrival time (IAT)
5. Writes results into a CSV file

This CSV is used as input for XGBoost-based anomaly detection.

---

# 🚀 Quick Start (Run-Only for Team Members)

## 1️⃣ Install Npcap

Download and install **Npcap**.

During installation:
- ✅ Enable **WinPcap API-compatible Mode**

Restart if required.

---

## 2️⃣ Open Terminal as Administrator

Packet capture requires elevated privileges.

- Start Menu → type `cmd`
- Right-click → **Run as Administrator**

---

## 3️⃣ Navigate to Project Folder
cd D:\MinorProject\adaptive_ml\feature_extract

---

## 4️⃣ List Network Interfaces
.\bin\main.exe --seconds 1

This will show available adapters.

Choose:
- Wi-Fi adapter (if on Wi-Fi)
- Ethernet adapter (if on cable)

Avoid:
- WAN Miniport
- Loopback
- Virtual adapters

---

## 5️⃣ Capture Traffic

Example:
.\bin\main.exe --iface 4 --seconds 60 --label 0

Where:
- `--iface 4` → Adapter index
- `--seconds 60` → Capture duration
- `--label 0` → Normal traffic (0 = normal, 1 = anomaly)

While capturing:
- Open websites
- OR run: `ping google.com -t`

---

# 📁 Saving CSV Files

After running, the program generates:
flows.csv

Rename it to avoid overwriting:

Each team member should save their own file:
- `flows_aman.csv`
- `flows_friend1.csv`
- `flows_friend2.csv`

---

# 🧠 Merging CSV Files (For ML Training)

Use the merge script:
python scripts/merge_csv.py

This will generate:
data/flows_all.csv

This file is used for training the XGBoost model.

---

# 🛠 Build Instructions (Maintainer Only)

Only needed if modifying source code.

## Requirements

- Visual Studio Build Tools (MSVC)
- CMake
- Npcap SDK
- PcapPlusPlus source built in Release mode

## Build Command

Run:
build.bat

Output:
bin/main.exe

---

# ⚠ Common Issues & Fixes

### Packets captured = 0
- Run terminal as Administrator
- Select correct adapter index
- Generate traffic during capture

### main.exe not running
Use:
.\bin\main.exe

PowerShell requires `.\` to run from current directory.

---
