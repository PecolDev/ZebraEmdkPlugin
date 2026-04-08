// ================= FILE: emdk_manager.dart =================

/// Feature types supported by the EMDK Manager.
///
/// Used when requesting a feature manager instance from [EMDKManager].
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/EMDKManager/
enum EMDKFeatureType {
  profile('PROFILE'),
  version('VERSION'),
  barcode('BARCODE'),
  scanAndPair('SCANANDPAIR'),
  simulScan('SIMULSCAN'),
  personalShopper('PERSONALSHOPPER'),
  serialComm('SERIALCOMM'),
  notification('NOTIFICATION'),
  serialCommEx('SERIALCOMM_EX'),
  sam('SAM');

  final String value;

  const EMDKFeatureType(this.value);

  static EMDKFeatureType fromValue(String value) =>
      EMDKFeatureType.values.firstWhere((e) => e.value == value);
}

/// Status data passed to the EMDKManager StatusListener.
///
/// Describes the result of an EMDK open/close operation for a feature.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/EMDKManager/
class EMDKStatusData {
  /// The result of the EMDK status event.
  final EMDKStatusCode? result;

  /// The feature type this status relates to.
  final EMDKFeatureType? featureType;

  const EMDKStatusData({this.result, this.featureType});

  factory EMDKStatusData.fromMap(Map<String, dynamic> map) {
    return EMDKStatusData(
      result: map['result'] != null
          ? EMDKStatusCode.fromValue(map['result'] as String)
          : null,
      featureType: map['featureType'] != null
          ? EMDKFeatureType.fromValue(map['featureType'] as String)
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'result': result?.value,
      'featureType': featureType?.value,
    };
  }
}

/// Status codes returned from EMDKManager operations.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/EMDKManager/
enum EMDKStatusCode {
  success('SUCCESS'),
  failure('FAILURE'),
  unknown('UNKNOWN'),
  nullPointer('NULL_POINTER'),
  emptyProfileName('EMPTY_PROFILENAME'),
  emdkNotOpened('EMDK_NOT_OPENED'),
  checkXml('CHECK_XML'),
  previousRequestInProgress('PREVIOUS_REQUEST_IN_PROGRESS'),
  processing('PROCESSING'),
  noDataListener('NO_DATA_LISTENER'),
  featureNotReadyToUse('FEATURE_NOT_READY_TO_USE'),
  featureNotSupported('FEATURE_NOT_SUPPORTED');

  final String value;

  const EMDKStatusCode(this.value);

  static EMDKStatusCode fromValue(String value) =>
      EMDKStatusCode.values.firstWhere((e) => e.value == value);
}

// ================= FILE: emdk_results.dart =================

/// Result object returned from profile and EMDK operations.
///
/// Contains both a primary status code and an extended status code for
/// more detailed error reporting.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/EMDKResults/
class EMDKResults {
  /// Primary status code of the operation.
  final EMDKStatusCode? statusCode;

  /// Extended status code providing additional error detail.
  final EMDKExtendedStatusCode? extendedStatusCode;

  final String? statusString;

  const EMDKResults({this.statusCode, this.extendedStatusCode, this.statusString});

  factory EMDKResults.fromMap(Map<String, dynamic> map) {
    return EMDKResults(
      statusCode: map['statusCode'] != null
          ? EMDKStatusCode.fromValue(map['statusCode'] as String)
          : null,
      extendedStatusCode: map['extendedStatusCode'] != null
          ? EMDKExtendedStatusCode.fromValue(map['extendedStatusCode'] as String)
          : null,
      statusString: map['statusString'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'statusCode': statusCode?.value,
      'extendedStatusCode': extendedStatusCode?.value,
      'statusString': statusString,
    };
  }
}

/// Extended status codes for detailed EMDK result reporting.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/EMDKResults/
enum EMDKExtendedStatusCode {
  none('NONE'),
  profileNotFoundInConfig('PROFILE_NOT_FOUND_IN_CONFIG'),
  featureTypeNotFoundInConfig('FEATURE_TYPE_NOT_FOUND_IN_CONFIG'),
  featureNameNotFoundInConfig('FEATURE_NAME_NOT_FOUND_IN_CONFIG'),
  featureNameNotFoundInExtradata('FEATURE_NAME_NOT_FOUND_IN_EXTRADATA'),
  featureTypeNotFoundInExtradata('FEATURE_TYPE_NOT_FOUND_IN_EXTRADATA'),
  profileNotFoundInExtradata('PROFILE_NOT_FOUND_IN_EXTRADATA'),
  featureNotUniqueInConfig('FEATURE_NOT_UNIQUE_IN_CONFIG'),
  featureNotUniqueInExtradata('FEATURE_NOT_UNIQUE_IN_EXTRADATA'),
  dependencyComponentFailure('DEPENDACY_COMPONENT_FAILURE'),
  generalExceptionOccured('GENERAL_EXCEPTION_OCCURED'),
  namevalueMissmatchInConfig('NAMEVALUE_MISSMATCH_IN_CONFIG'),
  namevalueMismatchInExtradata('NAMEVALUE_MISMATCH_IN_EXTRADATA'),
  invalidProfileConfiguration('INVALID_PROFILE_CONFIGURATION'),
  profileNameFormatError('PROFILE_NAME_FORMAT_ERROR'),
  activitySelectionMergingNotSupported('ACTIVITY_SELECTION_MERGING_NOT_SUPPORTED'),
  invalidValue('INVALID_VALUE'),
  appNotAllowedToSubmitXml('APP_NOT_ALLOWED_TO_SUBMIT_XML');

  final String value;

  const EMDKExtendedStatusCode(this.value);

  static EMDKExtendedStatusCode fromValue(String value) =>
      EMDKExtendedStatusCode.values.firstWhere((e) => e.value == value);
}

// ================= FILE: emdk_error.dart =================

/// Represents an EMDK error with a primary code and optional sub-codes.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/EMDKError/
class EMDKError {
  /// The primary error code.
  final EMDKErrorCode? errorCode;

  /// List of sub-error codes for additional detail.
  final List<EMDKSubErrorCode>? subErrorCodes;

  const EMDKError({this.errorCode, this.subErrorCodes});

  factory EMDKError.fromMap(Map<String, dynamic> map) {
    return EMDKError(
      errorCode: map['errorCode'] != null
          ? EMDKErrorCode.fromValue(map['errorCode'] as String)
          : null,
      subErrorCodes: map['subErrorCodes'] != null
          ? List<EMDKSubErrorCode>.from(
              (map['subErrorCodes'] as List)
                  .map((e) => EMDKSubErrorCode.fromValue(e as String)),
            )
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'errorCode': errorCode?.value,
      'subErrorCodes': subErrorCodes?.map((e) => e.value).toList(),
    };
  }
}

/// Primary EMDK error codes.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/EMDKErrorCode/
enum EMDKErrorCode {
  undefined('UNDEFINED'),
  unsupportedFeature('UNSUPPORTED_FEATURE'),
  unlicensedFeature('UNLICENSED_FEATURE');

  final String value;

  const EMDKErrorCode(this.value);

  static EMDKErrorCode fromValue(String value) =>
      EMDKErrorCode.values.firstWhere((e) => e.value == value,
          orElse: () => EMDKErrorCode.undefined);
}

/// Sub-error codes for detailed EMDK error reporting.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/EMDKSubErrorCode/
enum EMDKSubErrorCode {
  undefined('UNDEFINED'),
  mdnaLicenseRequired('MDNA_LICENSE_REQUIRED');

  final String value;

  const EMDKSubErrorCode(this.value);

  static EMDKSubErrorCode fromValue(String value) =>
      EMDKSubErrorCode.values.firstWhere((e) => e.value == value,
          orElse: () => EMDKSubErrorCode.undefined);
}

// ================= FILE: version_manager.dart =================

/// Identifies the component whose version is being queried.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/VersionManager/
enum EMDKVersionType {
  emdk('EMDK'),
  mx('MX'),
  barcode('BARCODE');

  final String value;

  const EMDKVersionType(this.value);

  static EMDKVersionType fromValue(String value) =>
      EMDKVersionType.values.firstWhere((e) => e.value == value);
}

// ================= FILE: profile_manager.dart =================

/// Flags that control the action performed by processProfile.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/ProfileManager/
enum ProfileFlag {
  set('SET'),
  get('GET'),
  reset('RESET'),
  checkCompatibility('CHECK_COMPATIBILITY');

  final String value;

  const ProfileFlag(this.value);

  static ProfileFlag fromValue(String value) =>
      ProfileFlag.values.firstWhere((e) => e.value == value);
}

/// Result data returned from an asynchronous profile processing call.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/ProfileManager/
class ProfileResultData {
  /// The result of the profile operation.
  final EMDKResults? result;

  /// The name of the profile that was processed.
  final String? profileName;

  /// The profile flag that was used.
  final ProfileFlag? profileFlag;

  /// The XML string representation of the profile result.
  final String? profileString;

  const ProfileResultData({
    this.result,
    this.profileName,
    this.profileFlag,
    this.profileString,
  });

  factory ProfileResultData.fromMap(Map<String, dynamic> map) {
    return ProfileResultData(
      result: map['result'] != null
          ? EMDKResults.fromMap(Map<String, dynamic>.from(map['result']))
          : null,
      profileName: map['profileName'] as String?,
      profileFlag: map['profileFlag'] != null
          ? ProfileFlag.fromValue(map['profileFlag'] as String)
          : null,
      profileString: map['profileString'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'result': result?.toMap(),
      'profileName': profileName,
      'profileFlag': profileFlag?.value,
      'profileString': profileString,
    };
  }
}