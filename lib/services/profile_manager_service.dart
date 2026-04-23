import 'package:zebra_emdk_plugin/services/platform_service_base.dart';
import 'package:zebra_emdk_plugin/zebra_emdk_plugin.dart';

class ProfileManagerService extends PlatformServiceBase {
  OemInfoService? _oemInfoService;

  // Package-private constructor accessed by EmdkManagerService
  ProfileManagerService() : super(methodPrefix: 'profileManager') {
    initEventChannel('profile_manager_event_channel');
  }

  OemInfoService getOemInfoService() {
    // In a fully featured SDK this would instanciate a distinct object per scanner.
    // For this implementation, we return our singleton wrapper that communicates
    // with the native side's actively selected scanner.
    _oemInfoService ??= OemInfoService.internal();
    return _oemInfoService!;
  }

  /// Initialize the Profile Manager natively.
  Future<bool?> initialize() async => await invokeMethod<bool>("initialize");

  Future<bool?> dispose() async {
    _oemInfoService = null;

    return await invokeMethod<bool>("dispose");
  } 

  /// Processes an MX XML profile string.
  /// [profileName] - the name of the profile (e.g. "MyProfile").
  /// [xmlData] - the full MX XML string containing characteristics and parms.
  /// Returns a Map containing 'statusCode', 'extendedStatusCode' and 'statusString'.
  void processProfileAsync(String profileName, String xmlData) {
    invokeMethod("processProfile", { "profileName": profileName, "xmlData": xmlData });
  }

  Stream<ProfileResultData?> get onData {
    return typedEvent<ProfileResultData>('onData', factory: (map) => ProfileResultData.fromMap(map));
  }
}
