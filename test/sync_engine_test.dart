// Automated tests for OfflineSyncEngine
// Author: Eng. MHD. Shadi AL-Hasan <mhd.shadi.alhasan@gmail.com>

import 'package:flutter_offline_sync_engine/sync_engine.dart';
import 'package:test/test.dart';

void main() {
  group('OfflineSyncEngine Tests', () {
    late OfflineSyncEngine engine;

    setUp(() {
      engine = OfflineSyncEngine();
    });

    test('Initial queue should be empty and pending count zero', () {
      expect(engine.pendingCount, equals(0));
    });

    test('Enqueueing operation while offline stores it in queue', () {
      engine.setConnectivity(false);
      final op = SyncOperation(
        id: 'tx_001',
        endpoint: '/api/v1/orders',
        method: 'POST',
        payload: {'amount': 1500, 'item': 'Enterprise License'},
      );
      engine.enqueue(op);

      expect(engine.pendingCount, equals(1));
      expect(op.status, equals(SyncStatus.pending));
    });

    test('Setting connectivity to online processes pending queue', () async {
      engine.setConnectivity(false);
      final op1 = SyncOperation(
        id: 'tx_101',
        endpoint: '/api/v1/invoices',
        method: 'POST',
        payload: {'id': 1},
      );
      final op2 = SyncOperation(
        id: 'tx_102',
        endpoint: '/api/v1/invoices',
        method: 'POST',
        payload: {'id': 2},
      );
      engine.enqueue(op1);
      engine.enqueue(op2);
      expect(engine.pendingCount, equals(2));

      // Turn online
      engine.setConnectivity(true);
      await engine.processQueue();

      expect(engine.pendingCount, equals(0));
    });
  });
}
