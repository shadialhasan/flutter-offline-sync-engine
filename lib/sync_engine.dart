/**
 * Offline Sync Engine for Flutter Applications
 * Author: Eng. MHD. Shadi AL-Hasan <mhd.shadi.alhasan@gmail.com>
 * Phone: +963934005922
 * Copyright (c) 2026 MHD. Shadi AL-Hasan
 */

enum SyncStatus { pending, inProgress, synced, failed }

class SyncOperation {
  final String id;
  final String endpoint;
  final String method;
  final Map<String, dynamic> payload;
  SyncStatus status;
  final DateTime createdAt;

  SyncOperation({
    required this.id,
    required this.endpoint,
    required this.method,
    required this.payload,
    this.status = SyncStatus.pending,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();
}

class OfflineSyncEngine {
  final List<SyncOperation> _queue = [];
  bool _isOnline = false;

  void setConnectivity(bool isOnline) {
    _isOnline = isOnline;
    if (_isOnline) {
      processQueue();
    }
  }

  void enqueue(SyncOperation op) {
    _queue.add(op);
    if (_isOnline) {
      processQueue();
    }
  }

  Future<void> processQueue() async {
    final pendingOps = _queue.where((op) => op.status == SyncStatus.pending).toList();
    for (final op in pendingOps) {
      op.status = SyncStatus.inProgress;
      // In real implementation: invoke Dio / HTTP client
      op.status = SyncStatus.synced;
    }
    _queue.removeWhere((op) => op.status == SyncStatus.synced);
  }

  int get pendingCount => _queue.length;
}
