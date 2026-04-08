import 'package:zebra_emdk_plugin/generated/scanner.dart';

/// Custom bridge model combining [ScannerInfo] and [BarcodeManagerConnectionState]
/// into a single typed result for the [BarcodeManager] connection listener event.
///
/// This model is not part of the EMDK SDK; it is a convenience wrapper used to
/// deliver both the scanner details and its new connection state together over
/// the Flutter platform channel.
class ConnectionChange {
  /// Information about the scanner whose connection state changed.
  final ScannerInfo? scannerInfo;

  /// The new connection state of the scanner.
  final BarcodeManagerConnectionState? connectionState;

  const ConnectionChange({
    this.scannerInfo,
    this.connectionState,
  });

  /// Creates a [ConnectionChange] from a [Map] received via the platform channel.
  factory ConnectionChange.fromMap(Map<String, dynamic> map) {
    return ConnectionChange(
      scannerInfo: map['scannerInfo'] != null
          ? ScannerInfo.fromMap(Map<String, dynamic>.from(map['scannerInfo']))
          : null,
      connectionState: map['connectionState'] != null
          ? BarcodeManagerConnectionState.fromValue(
              map['connectionState'] as String)
          : null,
    );
  }

  /// Converts this [ConnectionChange] to a [Map] suitable for sending over the platform channel.
  Map<String, dynamic> toMap() {
    return {
      'scannerInfo': scannerInfo?.toMap(),
      'connectionState': connectionState?.value,
    };
  }
}
