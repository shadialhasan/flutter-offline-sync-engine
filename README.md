# 🔄 flutter-offline-sync-engine

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Flutter](https://img.shields.io/badge/Flutter-3.x%20Ready-blue.svg)](https://flutter.dev)
[![Architecture: Offline-First](https://img.shields.io/badge/Pattern-Offline--First-brightgreen.svg)](https://github.com/MobileConduit)
[![CI Pipeline](https://github.com/MobileConduit/flutter-offline-sync-engine/actions/workflows/ci.yml/badge.svg)](https://github.com/MobileConduit/flutter-offline-sync-engine/actions)

A robust offline-first synchronization engine for Flutter applications. Guarantees mutation delivery across patchy mobile connectivity by queuing write actions locally and synchronizing seamlessly with enterprise backends upon reconnection.

## 🏗️ Synchronization Lifecycle

```mermaid
stateDiagram-v2
    [*] --> Idle
    Idle --> Queued: User Action (Offline)
    Queued --> LocalStorage: Persist Transaction
    LocalStorage --> NetworkCheck: Connectivity Change
    NetworkCheck --> Syncing: Online Detected
    NetworkCheck --> Queued: Still Offline
    Syncing --> ServerAck: 200 OK
    Syncing --> ExponentialBackoff: 5xx / Network Drop
    ExponentialBackoff --> Syncing: Retry Timer
    ServerAck --> Idle: Queue Drained
```

## 🚀 Usage

```dart
final engine = OfflineSyncEngine();

// Enqueue write operation while offline
engine.enqueue(SyncOperation(
  id: 'tx_998',
  endpoint: '/api/v1/orders',
  method: 'POST',
  payload: {'order_id': 1234, 'total': 850.0},
));

// Reconnection trigger
engine.setConnectivity(true);
```

---

## 👤 Author & Maintainer

**Eng. MHD. Shadi AL-Hasan**  
- **Role:** Executive CTO & Enterprise Solutions Architect  
- **Email:** [mhd.shadi.alhasan@gmail.com](mailto:mhd.shadi.alhasan@gmail.com)  
- **Phone / WhatsApp:** [+963934005922](tel:+963934005922)  
- **Location:** Damascus, Syria  
- **GitHub:** [MobileConduit](https://github.com/MobileConduit)  

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.  
Copyright (c) 2026 **MHD. Shadi AL-Hasan**. All rights reserved.
