// ================= FILE: decoder_params.dart =================

import 'package:zebra_emdk_plugin/generated/scanner_config.dart';

/// Container for all per-symbology decoder configurations.
///
/// Each field corresponds to one barcode symbology. Set the [BaseDecoder.enabled]
/// flag on each decoder to enable/disable it, and set symbology-specific options.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
class DecoderParams {
  final AustralianPostalDecoder? australianPostal;
  final AztecDecoder? aztec;
  final CanadianPostalDecoder? canadianPostal;
  final Chinese2of5Decoder? chinese2of5;
  final CodaBarDecoder? codaBar;
  final Code11Decoder? code11;
  final Code128Decoder? code128;
  final Code39Decoder? code39;
  final Code93Decoder? code93;
  final CompositeABDecoder? compositeAB;
  final CompositeCDecoder? compositeC;
  final D2of5Decoder? d2of5;
  final DataMatrixDecoder? dataMatrix;
  final DotCodeDecoder? dotCode;
  final DutchPostalDecoder? dutchPostal;
  final Ean13Decoder? ean13;
  final Ean8Decoder? ean8;
  final FinnishPostal4SDecoder? finnishPostal4S;
  final GridMatrixDecoder? gridMatrix;
  final Gs1DatabarDecoder? gs1Databar;
  final Gs1DatabarExpDecoder? gs1DatabarExp;
  final Gs1DatabarLimDecoder? gs1DatabarLim;
  final Gs1DatamatrixDecoder? gs1Datamatrix;
  final Gs1QrCodeDecoder? gs1QrCode;
  final HanXinDecoder? hanXin;
  final I2of5Decoder? i2of5;
  final JapanesePostalDecoder? japanesePostal;
  final Korean3of5Decoder? korean3of5;
  final MailMarkDecoder? mailMark;
  final Matrix2of5Decoder? matrix2of5;
  final MaxiCodeDecoder? maxiCode;
  final MicrE13BDecoder? micrE13B;
  final MicroPdfDecoder? microPDF;
  final MicroQrDecoder? microQR;
  final MsiDecoder? msi;
  final OcrADecoder? ocrA;
  final OcrBDecoder? ocrB;
  final Pdf417Decoder? pdf417;
  final QrCodeDecoder? qrCode;
  final SignatureDecoder? signature;
  final Tlc39Decoder? tlc39;
  final TriOptic39Decoder? triOptic39;
  final UkPostalDecoder? ukPostal;
  final UpcaDecoder? upca;
  final Upce0Decoder? upce0;
  final Upce1Decoder? upce1;
  final UpcEanParamsDecoder? upcEanParams;
  final Us4StateFicsDecoder? us4StateFics;
  final Us4StateDecoder? us4State;
  final UsPlanetDecoder? usPlanet;
  final UsPostNetDecoder? usPostNet;
  final UsCurrencyDecoder? usCurrency;
  final WebCodeDecoder? webCode;

  const DecoderParams({
    this.australianPostal,
    this.aztec,
    this.canadianPostal,
    this.chinese2of5,
    this.codaBar,
    this.code11,
    this.code128,
    this.code39,
    this.code93,
    this.compositeAB,
    this.compositeC,
    this.d2of5,
    this.dataMatrix,
    this.dotCode,
    this.dutchPostal,
    this.ean13,
    this.ean8,
    this.finnishPostal4S,
    this.gridMatrix,
    this.gs1Databar,
    this.gs1DatabarExp,
    this.gs1DatabarLim,
    this.gs1Datamatrix,
    this.gs1QrCode,
    this.hanXin,
    this.i2of5,
    this.japanesePostal,
    this.korean3of5,
    this.mailMark,
    this.matrix2of5,
    this.maxiCode,
    this.micrE13B,
    this.microPDF,
    this.microQR,
    this.msi,
    this.ocrA,
    this.ocrB,
    this.pdf417,
    this.qrCode,
    this.signature,
    this.tlc39,
    this.triOptic39,
    this.ukPostal,
    this.upca,
    this.upce0,
    this.upce1,
    this.upcEanParams,
    this.us4StateFics,
    this.us4State,
    this.usPlanet,
    this.usPostNet,
    this.usCurrency,
    this.webCode,
  });

  factory DecoderParams.fromMap(Map<String, dynamic> map) {
    return DecoderParams(
      australianPostal: map['australianPostal'] != null ? AustralianPostalDecoder.fromMap(Map<String, dynamic>.from(map['australianPostal'])) : null,
      aztec: map['aztec'] != null ? AztecDecoder.fromMap(Map<String, dynamic>.from(map['aztec'])) : null,
      canadianPostal: map['canadianPostal'] != null ? CanadianPostalDecoder.fromMap(Map<String, dynamic>.from(map['canadianPostal'])) : null,
      chinese2of5: map['chinese2of5'] != null ? Chinese2of5Decoder.fromMap(Map<String, dynamic>.from(map['chinese2of5'])) : null,
      codaBar: map['codaBar'] != null ? CodaBarDecoder.fromMap(Map<String, dynamic>.from(map['codaBar'])) : null,
      code11: map['code11'] != null ? Code11Decoder.fromMap(Map<String, dynamic>.from(map['code11'])) : null,
      code128: map['code128'] != null ? Code128Decoder.fromMap(Map<String, dynamic>.from(map['code128'])) : null,
      code39: map['code39'] != null ? Code39Decoder.fromMap(Map<String, dynamic>.from(map['code39'])) : null,
      code93: map['code93'] != null ? Code93Decoder.fromMap(Map<String, dynamic>.from(map['code93'])) : null,
      compositeAB: map['compositeAB'] != null ? CompositeABDecoder.fromMap(Map<String, dynamic>.from(map['compositeAB'])) : null,
      compositeC: map['compositeC'] != null ? CompositeCDecoder.fromMap(Map<String, dynamic>.from(map['compositeC'])) : null,
      d2of5: map['d2of5'] != null ? D2of5Decoder.fromMap(Map<String, dynamic>.from(map['d2of5'])) : null,
      dataMatrix: map['dataMatrix'] != null ? DataMatrixDecoder.fromMap(Map<String, dynamic>.from(map['dataMatrix'])) : null,
      dotCode: map['dotCode'] != null ? DotCodeDecoder.fromMap(Map<String, dynamic>.from(map['dotCode'])) : null,
      dutchPostal: map['dutchPostal'] != null ? DutchPostalDecoder.fromMap(Map<String, dynamic>.from(map['dutchPostal'])) : null,
      ean13: map['ean13'] != null ? Ean13Decoder.fromMap(Map<String, dynamic>.from(map['ean13'])) : null,
      ean8: map['ean8'] != null ? Ean8Decoder.fromMap(Map<String, dynamic>.from(map['ean8'])) : null,
      finnishPostal4S: map['finnishPostal4S'] != null ? FinnishPostal4SDecoder.fromMap(Map<String, dynamic>.from(map['finnishPostal4S'])) : null,
      gridMatrix: map['gridMatrix'] != null ? GridMatrixDecoder.fromMap(Map<String, dynamic>.from(map['gridMatrix'])) : null,
      gs1Databar: map['gs1Databar'] != null ? Gs1DatabarDecoder.fromMap(Map<String, dynamic>.from(map['gs1Databar'])) : null,
      gs1DatabarExp: map['gs1DatabarExp'] != null ? Gs1DatabarExpDecoder.fromMap(Map<String, dynamic>.from(map['gs1DatabarExp'])) : null,
      gs1DatabarLim: map['gs1DatabarLim'] != null ? Gs1DatabarLimDecoder.fromMap(Map<String, dynamic>.from(map['gs1DatabarLim'])) : null,
      gs1Datamatrix: map['gs1Datamatrix'] != null ? Gs1DatamatrixDecoder.fromMap(Map<String, dynamic>.from(map['gs1Datamatrix'])) : null,
      gs1QrCode: map['gs1QrCode'] != null ? Gs1QrCodeDecoder.fromMap(Map<String, dynamic>.from(map['gs1QrCode'])) : null,
      hanXin: map['hanXin'] != null ? HanXinDecoder.fromMap(Map<String, dynamic>.from(map['hanXin'])) : null,
      i2of5: map['i2of5'] != null ? I2of5Decoder.fromMap(Map<String, dynamic>.from(map['i2of5'])) : null,
      japanesePostal: map['japanesePostal'] != null ? JapanesePostalDecoder.fromMap(Map<String, dynamic>.from(map['japanesePostal'])) : null,
      korean3of5: map['korean3of5'] != null ? Korean3of5Decoder.fromMap(Map<String, dynamic>.from(map['korean3of5'])) : null,
      mailMark: map['mailMark'] != null ? MailMarkDecoder.fromMap(Map<String, dynamic>.from(map['mailMark'])) : null,
      matrix2of5: map['matrix2of5'] != null ? Matrix2of5Decoder.fromMap(Map<String, dynamic>.from(map['matrix2of5'])) : null,
      maxiCode: map['maxiCode'] != null ? MaxiCodeDecoder.fromMap(Map<String, dynamic>.from(map['maxiCode'])) : null,
      micrE13B: map['micrE13B'] != null ? MicrE13BDecoder.fromMap(Map<String, dynamic>.from(map['micrE13B'])) : null,
      microPDF: map['microPDF'] != null ? MicroPdfDecoder.fromMap(Map<String, dynamic>.from(map['microPDF'])) : null,
      microQR: map['microQR'] != null ? MicroQrDecoder.fromMap(Map<String, dynamic>.from(map['microQR'])) : null,
      msi: map['msi'] != null ? MsiDecoder.fromMap(Map<String, dynamic>.from(map['msi'])) : null,
      ocrA: map['ocrA'] != null ? OcrADecoder.fromMap(Map<String, dynamic>.from(map['ocrA'])) : null,
      ocrB: map['ocrB'] != null ? OcrBDecoder.fromMap(Map<String, dynamic>.from(map['ocrB'])) : null,
      pdf417: map['pdf417'] != null ? Pdf417Decoder.fromMap(Map<String, dynamic>.from(map['pdf417'])) : null,
      qrCode: map['qrCode'] != null ? QrCodeDecoder.fromMap(Map<String, dynamic>.from(map['qrCode'])) : null,
      signature: map['signature'] != null ? SignatureDecoder.fromMap(Map<String, dynamic>.from(map['signature'])) : null,
      tlc39: map['tlc39'] != null ? Tlc39Decoder.fromMap(Map<String, dynamic>.from(map['tlc39'])) : null,
      triOptic39: map['triOptic39'] != null ? TriOptic39Decoder.fromMap(Map<String, dynamic>.from(map['triOptic39'])) : null,
      ukPostal: map['ukPostal'] != null ? UkPostalDecoder.fromMap(Map<String, dynamic>.from(map['ukPostal'])) : null,
      upca: map['upca'] != null ? UpcaDecoder.fromMap(Map<String, dynamic>.from(map['upca'])) : null,
      upce0: map['upce0'] != null ? Upce0Decoder.fromMap(Map<String, dynamic>.from(map['upce0'])) : null,
      upce1: map['upce1'] != null ? Upce1Decoder.fromMap(Map<String, dynamic>.from(map['upce1'])) : null,
      upcEanParams: map['upcEanParams'] != null ? UpcEanParamsDecoder.fromMap(Map<String, dynamic>.from(map['upcEanParams'])) : null,
      us4StateFics: map['us4StateFics'] != null ? Us4StateFicsDecoder.fromMap(Map<String, dynamic>.from(map['us4StateFics'])) : null,
      us4State: map['us4State'] != null ? Us4StateDecoder.fromMap(Map<String, dynamic>.from(map['us4State'])) : null,
      usPlanet: map['usPlanet'] != null ? UsPlanetDecoder.fromMap(Map<String, dynamic>.from(map['usPlanet'])) : null,
      usPostNet: map['usPostNet'] != null ? UsPostNetDecoder.fromMap(Map<String, dynamic>.from(map['usPostNet'])) : null,
      usCurrency: map['usCurrency'] != null ? UsCurrencyDecoder.fromMap(Map<String, dynamic>.from(map['usCurrency'])) : null,
      webCode: map['webCode'] != null ? WebCodeDecoder.fromMap(Map<String, dynamic>.from(map['webCode'])) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'australianPostal': australianPostal?.toMap(),
      'aztec': aztec?.toMap(),
      'canadianPostal': canadianPostal?.toMap(),
      'chinese2of5': chinese2of5?.toMap(),
      'codaBar': codaBar?.toMap(),
      'code11': code11?.toMap(),
      'code128': code128?.toMap(),
      'code39': code39?.toMap(),
      'code93': code93?.toMap(),
      'compositeAB': compositeAB?.toMap(),
      'compositeC': compositeC?.toMap(),
      'd2of5': d2of5?.toMap(),
      'dataMatrix': dataMatrix?.toMap(),
      'dotCode': dotCode?.toMap(),
      'dutchPostal': dutchPostal?.toMap(),
      'ean13': ean13?.toMap(),
      'ean8': ean8?.toMap(),
      'finnishPostal4S': finnishPostal4S?.toMap(),
      'gridMatrix': gridMatrix?.toMap(),
      'gs1Databar': gs1Databar?.toMap(),
      'gs1DatabarExp': gs1DatabarExp?.toMap(),
      'gs1DatabarLim': gs1DatabarLim?.toMap(),
      'gs1Datamatrix': gs1Datamatrix?.toMap(),
      'gs1QrCode': gs1QrCode?.toMap(),
      'hanXin': hanXin?.toMap(),
      'i2of5': i2of5?.toMap(),
      'japanesePostal': japanesePostal?.toMap(),
      'korean3of5': korean3of5?.toMap(),
      'mailMark': mailMark?.toMap(),
      'matrix2of5': matrix2of5?.toMap(),
      'maxiCode': maxiCode?.toMap(),
      'micrE13B': micrE13B?.toMap(),
      'microPDF': microPDF?.toMap(),
      'microQR': microQR?.toMap(),
      'msi': msi?.toMap(),
      'ocrA': ocrA?.toMap(),
      'ocrB': ocrB?.toMap(),
      'pdf417': pdf417?.toMap(),
      'qrCode': qrCode?.toMap(),
      'signature': signature?.toMap(),
      'tlc39': tlc39?.toMap(),
      'triOptic39': triOptic39?.toMap(),
      'ukPostal': ukPostal?.toMap(),
      'upca': upca?.toMap(),
      'upce0': upce0?.toMap(),
      'upce1': upce1?.toMap(),
      'upcEanParams': upcEanParams?.toMap(),
      'us4StateFics': us4StateFics?.toMap(),
      'us4State': us4State?.toMap(),
      'usPlanet': usPlanet?.toMap(),
      'usPostNet': usPostNet?.toMap(),
      'usCurrency': usCurrency?.toMap(),
      'webCode': webCode?.toMap(),
    };
  }
}

// ---------------------------------------------------------------------------
// Base decoder
// ---------------------------------------------------------------------------

/// Base class for all decoder configurations.
///
/// Every decoder extends this and adds its own parameters.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
class BaseDecoder {
  /// Whether this symbology decoder is enabled.
  final bool? enabled;
  const BaseDecoder({this.enabled});
}

// ---------------------------------------------------------------------------
// Simple decoders (enabled only)
// ---------------------------------------------------------------------------

/// Australian Postal decoder configuration.
class AustralianPostalDecoder extends BaseDecoder {
  const AustralianPostalDecoder({super.enabled});
  factory AustralianPostalDecoder.fromMap(Map<String, dynamic> map) =>
      AustralianPostalDecoder(enabled: map['enabled'] as bool?);
  Map<String, dynamic> toMap() => {'enabled': enabled};
}

/// Aztec decoder configuration.
class AztecDecoder extends BaseDecoder {
  const AztecDecoder({super.enabled});
  factory AztecDecoder.fromMap(Map<String, dynamic> map) =>
      AztecDecoder(enabled: map['enabled'] as bool?);
  Map<String, dynamic> toMap() => {'enabled': enabled};
}

/// Canadian Postal decoder configuration.
class CanadianPostalDecoder extends BaseDecoder {
  const CanadianPostalDecoder({super.enabled});
  factory CanadianPostalDecoder.fromMap(Map<String, dynamic> map) =>
      CanadianPostalDecoder(enabled: map['enabled'] as bool?);
  Map<String, dynamic> toMap() => {'enabled': enabled};
}

/// Chinese 2 of 5 decoder configuration.
class Chinese2of5Decoder extends BaseDecoder {
  const Chinese2of5Decoder({super.enabled});
  factory Chinese2of5Decoder.fromMap(Map<String, dynamic> map) =>
      Chinese2of5Decoder(enabled: map['enabled'] as bool?);
  Map<String, dynamic> toMap() => {'enabled': enabled};
}

/// Composite C decoder configuration.
class CompositeCDecoder extends BaseDecoder {
  const CompositeCDecoder({super.enabled});
  factory CompositeCDecoder.fromMap(Map<String, dynamic> map) =>
      CompositeCDecoder(enabled: map['enabled'] as bool?);
  Map<String, dynamic> toMap() => {'enabled': enabled};
}

/// Data Matrix decoder configuration.
class DataMatrixDecoder extends BaseDecoder {
  const DataMatrixDecoder({super.enabled});
  factory DataMatrixDecoder.fromMap(Map<String, dynamic> map) =>
      DataMatrixDecoder(enabled: map['enabled'] as bool?);
  Map<String, dynamic> toMap() => {'enabled': enabled};
}

/// EAN-13 decoder configuration.
class Ean13Decoder extends BaseDecoder {
  const Ean13Decoder({super.enabled});
  factory Ean13Decoder.fromMap(Map<String, dynamic> map) =>
      Ean13Decoder(enabled: map['enabled'] as bool?);
  Map<String, dynamic> toMap() => {'enabled': enabled};
}

/// Finnish Postal 4S decoder configuration.
class FinnishPostal4SDecoder extends BaseDecoder {
  const FinnishPostal4SDecoder({super.enabled});
  factory FinnishPostal4SDecoder.fromMap(Map<String, dynamic> map) =>
      FinnishPostal4SDecoder(enabled: map['enabled'] as bool?);
  Map<String, dynamic> toMap() => {'enabled': enabled};
}

/// GS1 DataBar decoder configuration.
class Gs1DatabarDecoder extends BaseDecoder {
  const Gs1DatabarDecoder({super.enabled});
  factory Gs1DatabarDecoder.fromMap(Map<String, dynamic> map) =>
      Gs1DatabarDecoder(enabled: map['enabled'] as bool?);
  Map<String, dynamic> toMap() => {'enabled': enabled};
}

/// GS1 DataBar Expanded decoder configuration.
class Gs1DatabarExpDecoder extends BaseDecoder {
  const Gs1DatabarExpDecoder({super.enabled});
  factory Gs1DatabarExpDecoder.fromMap(Map<String, dynamic> map) =>
      Gs1DatabarExpDecoder(enabled: map['enabled'] as bool?);
  Map<String, dynamic> toMap() => {'enabled': enabled};
}

/// GS1 DataMatrix decoder configuration.
class Gs1DatamatrixDecoder extends BaseDecoder {
  const Gs1DatamatrixDecoder({super.enabled});
  factory Gs1DatamatrixDecoder.fromMap(Map<String, dynamic> map) =>
      Gs1DatamatrixDecoder(enabled: map['enabled'] as bool?);
  Map<String, dynamic> toMap() => {'enabled': enabled};
}

/// GS1 QR Code decoder configuration.
class Gs1QrCodeDecoder extends BaseDecoder {
  const Gs1QrCodeDecoder({super.enabled});
  factory Gs1QrCodeDecoder.fromMap(Map<String, dynamic> map) =>
      Gs1QrCodeDecoder(enabled: map['enabled'] as bool?);
  Map<String, dynamic> toMap() => {'enabled': enabled};
}

/// Japanese Postal decoder configuration.
class JapanesePostalDecoder extends BaseDecoder {
  const JapanesePostalDecoder({super.enabled});
  factory JapanesePostalDecoder.fromMap(Map<String, dynamic> map) =>
      JapanesePostalDecoder(enabled: map['enabled'] as bool?);
  Map<String, dynamic> toMap() => {'enabled': enabled};
}

/// Korean 3 of 5 decoder configuration.
class Korean3of5Decoder extends BaseDecoder {
  const Korean3of5Decoder({super.enabled});
  factory Korean3of5Decoder.fromMap(Map<String, dynamic> map) =>
      Korean3of5Decoder(enabled: map['enabled'] as bool?);
  Map<String, dynamic> toMap() => {'enabled': enabled};
}

/// Mail Mark decoder configuration.
class MailMarkDecoder extends BaseDecoder {
  const MailMarkDecoder({super.enabled});
  factory MailMarkDecoder.fromMap(Map<String, dynamic> map) =>
      MailMarkDecoder(enabled: map['enabled'] as bool?);
  Map<String, dynamic> toMap() => {'enabled': enabled};
}

/// MaxiCode decoder configuration.
class MaxiCodeDecoder extends BaseDecoder {
  const MaxiCodeDecoder({super.enabled});
  factory MaxiCodeDecoder.fromMap(Map<String, dynamic> map) =>
      MaxiCodeDecoder(enabled: map['enabled'] as bool?);
  Map<String, dynamic> toMap() => {'enabled': enabled};
}

/// MICR E13B decoder configuration.
class MicrE13BDecoder extends BaseDecoder {
  const MicrE13BDecoder({super.enabled});
  factory MicrE13BDecoder.fromMap(Map<String, dynamic> map) =>
      MicrE13BDecoder(enabled: map['enabled'] as bool?);
  Map<String, dynamic> toMap() => {'enabled': enabled};
}

/// Micro PDF decoder configuration.
class MicroPdfDecoder extends BaseDecoder {
  const MicroPdfDecoder({super.enabled});
  factory MicroPdfDecoder.fromMap(Map<String, dynamic> map) =>
      MicroPdfDecoder(enabled: map['enabled'] as bool?);
  Map<String, dynamic> toMap() => {'enabled': enabled};
}

/// Micro QR Code decoder configuration.
class MicroQrDecoder extends BaseDecoder {
  const MicroQrDecoder({super.enabled});
  factory MicroQrDecoder.fromMap(Map<String, dynamic> map) =>
      MicroQrDecoder(enabled: map['enabled'] as bool?);
  Map<String, dynamic> toMap() => {'enabled': enabled};
}

/// PDF417 decoder configuration.
class Pdf417Decoder extends BaseDecoder {
  const Pdf417Decoder({super.enabled});
  factory Pdf417Decoder.fromMap(Map<String, dynamic> map) =>
      Pdf417Decoder(enabled: map['enabled'] as bool?);
  Map<String, dynamic> toMap() => {'enabled': enabled};
}

/// QR Code decoder configuration.
class QrCodeDecoder extends BaseDecoder {
  const QrCodeDecoder({super.enabled});
  factory QrCodeDecoder.fromMap(Map<String, dynamic> map) =>
      QrCodeDecoder(enabled: map['enabled'] as bool?);
  Map<String, dynamic> toMap() => {'enabled': enabled};
}

/// TLC39 decoder configuration.
class Tlc39Decoder extends BaseDecoder {
  const Tlc39Decoder({super.enabled});
  factory Tlc39Decoder.fromMap(Map<String, dynamic> map) =>
      Tlc39Decoder(enabled: map['enabled'] as bool?);
  Map<String, dynamic> toMap() => {'enabled': enabled};
}

/// US 4-State decoder configuration.
class Us4StateDecoder extends BaseDecoder {
  const Us4StateDecoder({super.enabled});
  factory Us4StateDecoder.fromMap(Map<String, dynamic> map) =>
      Us4StateDecoder(enabled: map['enabled'] as bool?);
  Map<String, dynamic> toMap() => {'enabled': enabled};
}

/// US 4-State FICS decoder configuration.
class Us4StateFicsDecoder extends BaseDecoder {
  const Us4StateFicsDecoder({super.enabled});
  factory Us4StateFicsDecoder.fromMap(Map<String, dynamic> map) =>
      Us4StateFicsDecoder(enabled: map['enabled'] as bool?);
  Map<String, dynamic> toMap() => {'enabled': enabled};
}

/// US Currency decoder configuration.
class UsCurrencyDecoder extends BaseDecoder {
  const UsCurrencyDecoder({super.enabled});
  factory UsCurrencyDecoder.fromMap(Map<String, dynamic> map) =>
      UsCurrencyDecoder(enabled: map['enabled'] as bool?);
  Map<String, dynamic> toMap() => {'enabled': enabled};
}

// ---------------------------------------------------------------------------
// Decoders with extra fields
// ---------------------------------------------------------------------------

/// CodaBar decoder configuration.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
class CodaBarDecoder extends BaseDecoder {
  /// Minimum length of the barcode.
  final int? length1;

  /// Maximum length of the barcode.
  final int? length2;

  /// Whether to require two consecutive reads before reporting.
  final bool? redundancy;

  /// Whether to apply CLSI editing to the decoded data.
  final bool? clsiEditing;

  /// Whether to apply NOTIS editing to the decoded data.
  final bool? notisEditing;

  const CodaBarDecoder({
    super.enabled,
    this.length1,
    this.length2,
    this.redundancy,
    this.clsiEditing,
    this.notisEditing,
  });

  factory CodaBarDecoder.fromMap(Map<String, dynamic> map) => CodaBarDecoder(
        enabled: map['enabled'] as bool?,
        length1: map['length1'] as int?,
        length2: map['length2'] as int?,
        redundancy: map['redundancy'] as bool?,
        clsiEditing: map['clsiEditing'] as bool?,
        notisEditing: map['notisEditing'] as bool?,
      );

  Map<String, dynamic> toMap() => {
        'enabled': enabled,
        'length1': length1,
        'length2': length2,
        'redundancy': redundancy,
        'clsiEditing': clsiEditing,
        'notisEditing': notisEditing,
      };
}

/// Code 11 decoder configuration.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
class Code11Decoder extends BaseDecoder {
  final int? length1;
  final int? length2;
  final bool? redundancy;

  /// Number of check digits to verify.
  final VerifyCheckDigit? verifyCheckDigit;

  /// Whether to include the check digit in reported data.
  final bool? reportCheckDigit;

  const Code11Decoder({
    super.enabled,
    this.length1,
    this.length2,
    this.redundancy,
    this.verifyCheckDigit,
    this.reportCheckDigit,
  });

  factory Code11Decoder.fromMap(Map<String, dynamic> map) => Code11Decoder(
        enabled: map['enabled'] as bool?,
        length1: map['length1'] as int?,
        length2: map['length2'] as int?,
        redundancy: map['redundancy'] as bool?,
        verifyCheckDigit: map['verifyCheckDigit'] != null
            ? VerifyCheckDigit.fromValue(map['verifyCheckDigit'] as String)
            : null,
        reportCheckDigit: map['reportCheckDigit'] as bool?,
      );

  Map<String, dynamic> toMap() => {
        'enabled': enabled,
        'length1': length1,
        'length2': length2,
        'redundancy': redundancy,
        'verifyCheckDigit': verifyCheckDigit?.value,
        'reportCheckDigit': reportCheckDigit,
      };
}

/// Code 128 decoder configuration.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
class Code128Decoder extends BaseDecoder {
  final int? length1;
  final int? length2;
  final bool? redundancy;

  /// Whether to enable plain Code 128 decoding.
  final bool? enablePlain;

  /// Whether to enable EAN 128 (GS1-128) decoding.
  final bool? enableEan128;

  /// Whether to enable ISBT 128 decoding.
  final bool? enableIsbt128;

  /// ISBT 128 concatenation mode.
  final Isbt128ContactMode? isbt128ConcatMode;

  /// Whether to check the ISBT table for valid sequences.
  final bool? checkIsbtTable;

  /// Security level for decoding.
  final SecurityLevel? securityLevel;

  /// Whether to allow decoding with reduced quiet zone.
  final bool? reducedQuietZone;

  const Code128Decoder({
    super.enabled,
    this.length1,
    this.length2,
    this.redundancy,
    this.enablePlain,
    this.enableEan128,
    this.enableIsbt128,
    this.isbt128ConcatMode,
    this.checkIsbtTable,
    this.securityLevel,
    this.reducedQuietZone,
  });

  factory Code128Decoder.fromMap(Map<String, dynamic> map) => Code128Decoder(
        enabled: map['enabled'] as bool?,
        length1: map['length1'] as int?,
        length2: map['length2'] as int?,
        redundancy: map['redundancy'] as bool?,
        enablePlain: map['enablePlain'] as bool?,
        enableEan128: map['enableEan128'] as bool?,
        enableIsbt128: map['enableIsbt128'] as bool?,
        isbt128ConcatMode: map['isbt128ConcatMode'] != null
            ? Isbt128ContactMode.fromValue(map['isbt128ConcatMode'] as String)
            : null,
        checkIsbtTable: map['checkIsbtTable'] as bool?,
        securityLevel: map['securityLevel'] != null
            ? SecurityLevel.fromValue(map['securityLevel'] as String)
            : null,
        reducedQuietZone: map['reducedQuietZone'] as bool?,
      );

  Map<String, dynamic> toMap() => {
        'enabled': enabled,
        'length1': length1,
        'length2': length2,
        'redundancy': redundancy,
        'enablePlain': enablePlain,
        'enableEan128': enableEan128,
        'enableIsbt128': enableIsbt128,
        'isbt128ConcatMode': isbt128ConcatMode?.value,
        'checkIsbtTable': checkIsbtTable,
        'securityLevel': securityLevel?.value,
        'reducedQuietZone': reducedQuietZone,
      };
}

/// Code 39 decoder configuration.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
class Code39Decoder extends BaseDecoder {
  final int? length1;
  final int? length2;
  final bool? verifyCheckDigit;
  final bool? reportCheckDigit;

  /// Whether to enable full ASCII mode.
  final bool? fullAscii;

  final bool? redundancy;

  /// Whether to convert Code 39 to Code 32.
  final bool? convertToCode32;

  /// Whether to include the Code 32 prefix in the output.
  final bool? reportCode32Prefix;

  final SecurityLevel? securityLevel;
  final bool? reducedQuietZone;

  const Code39Decoder({
    super.enabled,
    this.length1,
    this.length2,
    this.verifyCheckDigit,
    this.reportCheckDigit,
    this.fullAscii,
    this.redundancy,
    this.convertToCode32,
    this.reportCode32Prefix,
    this.securityLevel,
    this.reducedQuietZone,
  });

  factory Code39Decoder.fromMap(Map<String, dynamic> map) => Code39Decoder(
        enabled: map['enabled'] as bool?,
        length1: map['length1'] as int?,
        length2: map['length2'] as int?,
        verifyCheckDigit: map['verifyCheckDigit'] as bool?,
        reportCheckDigit: map['reportCheckDigit'] as bool?,
        fullAscii: map['fullAscii'] as bool?,
        redundancy: map['redundancy'] as bool?,
        convertToCode32: map['convertToCode32'] as bool?,
        reportCode32Prefix: map['reportCode32Prefix'] as bool?,
        securityLevel: map['securityLevel'] != null
            ? SecurityLevel.fromValue(map['securityLevel'] as String)
            : null,
        reducedQuietZone: map['reducedQuietZone'] as bool?,
      );

  Map<String, dynamic> toMap() => {
        'enabled': enabled,
        'length1': length1,
        'length2': length2,
        'verifyCheckDigit': verifyCheckDigit,
        'reportCheckDigit': reportCheckDigit,
        'fullAscii': fullAscii,
        'redundancy': redundancy,
        'convertToCode32': convertToCode32,
        'reportCode32Prefix': reportCode32Prefix,
        'securityLevel': securityLevel?.value,
        'reducedQuietZone': reducedQuietZone,
      };
}

/// Code 93 decoder configuration.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
class Code93Decoder extends BaseDecoder {
  final int? length1;
  final int? length2;
  final bool? redundancy;

  const Code93Decoder({super.enabled, this.length1, this.length2, this.redundancy});

  factory Code93Decoder.fromMap(Map<String, dynamic> map) => Code93Decoder(
        enabled: map['enabled'] as bool?,
        length1: map['length1'] as int?,
        length2: map['length2'] as int?,
        redundancy: map['redundancy'] as bool?,
      );

  Map<String, dynamic> toMap() => {
        'enabled': enabled,
        'length1': length1,
        'length2': length2,
        'redundancy': redundancy,
      };
}

/// Composite AB decoder configuration.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
class CompositeABDecoder extends BaseDecoder {
  /// UCC/EAN link mode.
  final UccLinkMode? uccLinkMode;

  const CompositeABDecoder({super.enabled, this.uccLinkMode});

  factory CompositeABDecoder.fromMap(Map<String, dynamic> map) => CompositeABDecoder(
        enabled: map['enabled'] as bool?,
        uccLinkMode: map['uccLinkMode'] != null
            ? UccLinkMode.fromValue(map['uccLinkMode'] as String)
            : null,
      );

  Map<String, dynamic> toMap() => {'enabled': enabled, 'uccLinkMode': uccLinkMode?.value};
}

/// Discrete 2 of 5 decoder configuration.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
class D2of5Decoder extends BaseDecoder {
  final int? length1;
  final int? length2;
  final bool? redundancy;

  const D2of5Decoder({super.enabled, this.length1, this.length2, this.redundancy});

  factory D2of5Decoder.fromMap(Map<String, dynamic> map) => D2of5Decoder(
        enabled: map['enabled'] as bool?,
        length1: map['length1'] as int?,
        length2: map['length2'] as int?,
        redundancy: map['redundancy'] as bool?,
      );

  Map<String, dynamic> toMap() => {
        'enabled': enabled,
        'length1': length1,
        'length2': length2,
        'redundancy': redundancy,
      };
}

/// DotCode decoder configuration.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
class DotCodeDecoder extends BaseDecoder {
  /// Inverse DotCode mode.
  final DotCodeInverse? inverse;

  /// Mirror DotCode mode.
  final DotCodeMirror? mirror;

  const DotCodeDecoder({super.enabled, this.inverse, this.mirror});

  factory DotCodeDecoder.fromMap(Map<String, dynamic> map) => DotCodeDecoder(
        enabled: map['enabled'] as bool?,
        inverse: map['inverse'] != null
            ? DotCodeInverse.fromValue(map['inverse'] as String)
            : null,
        mirror: map['mirror'] != null
            ? DotCodeMirror.fromValue(map['mirror'] as String)
            : null,
      );

  Map<String, dynamic> toMap() => {
        'enabled': enabled,
        'inverse': inverse?.value,
        'mirror': mirror?.value,
      };
}

/// Dutch Postal decoder configuration.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
class DutchPostalDecoder extends BaseDecoder {
  /// Whether to enable Dutch Postal 3S mode.
  final bool? dutchPostal3S;

  const DutchPostalDecoder({super.enabled, this.dutchPostal3S});

  factory DutchPostalDecoder.fromMap(Map<String, dynamic> map) => DutchPostalDecoder(
        enabled: map['enabled'] as bool?,
        dutchPostal3S: map['dutchPostal3S'] as bool?,
      );

  Map<String, dynamic> toMap() => {'enabled': enabled, 'dutchPostal3S': dutchPostal3S};
}

/// EAN-8 decoder configuration.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
class Ean8Decoder extends BaseDecoder {
  /// Whether to convert EAN-8 to EAN-13 on output.
  final bool? convertToEan13;

  const Ean8Decoder({super.enabled, this.convertToEan13});

  factory Ean8Decoder.fromMap(Map<String, dynamic> map) => Ean8Decoder(
        enabled: map['enabled'] as bool?,
        convertToEan13: map['convertToEan13'] as bool?,
      );

  Map<String, dynamic> toMap() => {'enabled': enabled, 'convertToEan13': convertToEan13};
}

/// Grid Matrix decoder configuration.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
class GridMatrixDecoder extends BaseDecoder {
  final GridMatrixInverse? inverse;
  final GridMatrixMirror? mirror;

  const GridMatrixDecoder({super.enabled, this.inverse, this.mirror});

  factory GridMatrixDecoder.fromMap(Map<String, dynamic> map) => GridMatrixDecoder(
        enabled: map['enabled'] as bool?,
        inverse: map['inverse'] != null
            ? GridMatrixInverse.fromValue(map['inverse'] as String)
            : null,
        mirror: map['mirror'] != null
            ? GridMatrixMirror.fromValue(map['mirror'] as String)
            : null,
      );

  Map<String, dynamic> toMap() => {
        'enabled': enabled,
        'inverse': inverse?.value,
        'mirror': mirror?.value,
      };
}

/// GS1 DataBar Limited decoder configuration.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
class Gs1DatabarLimDecoder extends BaseDecoder {
  final GS1LimitedSecurityLevel? securityLevel;

  const Gs1DatabarLimDecoder({super.enabled, this.securityLevel});

  factory Gs1DatabarLimDecoder.fromMap(Map<String, dynamic> map) => Gs1DatabarLimDecoder(
        enabled: map['enabled'] as bool?,
        securityLevel: map['securityLevel'] != null
            ? GS1LimitedSecurityLevel.fromValue(map['securityLevel'] as String)
            : null,
      );

  Map<String, dynamic> toMap() =>
      {'enabled': enabled, 'securityLevel': securityLevel?.value};
}

/// Han Xin decoder configuration.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
class HanXinDecoder extends BaseDecoder {
  final HanXinInverse? hanXinInverse;

  const HanXinDecoder({super.enabled, this.hanXinInverse});

  factory HanXinDecoder.fromMap(Map<String, dynamic> map) => HanXinDecoder(
        enabled: map['enabled'] as bool?,
        hanXinInverse: map['hanXinInverse'] != null
            ? HanXinInverse.fromValue(map['hanXinInverse'] as String)
            : null,
      );

  Map<String, dynamic> toMap() =>
      {'enabled': enabled, 'hanXinInverse': hanXinInverse?.value};
}

/// Interleaved 2 of 5 decoder configuration.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
class I2of5Decoder extends BaseDecoder {
  final int? length1;
  final int? length2;
  final bool? redundancy;
  final CheckDigitType? verifyCheckDigit;
  final bool? reportCheckDigit;

  /// Whether to convert I 2 of 5 to EAN-13.
  final bool? convertToEan13;

  final SecurityLevel? securityLevel;
  final bool? reducedQuietZone;

  /// Whether Febraban (Brazilian banking) mode is enabled.
  final bool? febraban;

  const I2of5Decoder({
    super.enabled,
    this.length1,
    this.length2,
    this.redundancy,
    this.verifyCheckDigit,
    this.reportCheckDigit,
    this.convertToEan13,
    this.securityLevel,
    this.reducedQuietZone,
    this.febraban,
  });

  factory I2of5Decoder.fromMap(Map<String, dynamic> map) => I2of5Decoder(
        enabled: map['enabled'] as bool?,
        length1: map['length1'] as int?,
        length2: map['length2'] as int?,
        redundancy: map['redundancy'] as bool?,
        verifyCheckDigit: map['verifyCheckDigit'] != null
            ? CheckDigitType.fromValue(map['verifyCheckDigit'] as String)
            : null,
        reportCheckDigit: map['reportCheckDigit'] as bool?,
        convertToEan13: map['convertToEan13'] as bool?,
        securityLevel: map['securityLevel'] != null
            ? SecurityLevel.fromValue(map['securityLevel'] as String)
            : null,
        reducedQuietZone: map['reducedQuietZone'] as bool?,
        febraban: map['febraban'] as bool?,
      );

  Map<String, dynamic> toMap() => {
        'enabled': enabled,
        'length1': length1,
        'length2': length2,
        'redundancy': redundancy,
        'verifyCheckDigit': verifyCheckDigit?.value,
        'reportCheckDigit': reportCheckDigit,
        'convertToEan13': convertToEan13,
        'securityLevel': securityLevel?.value,
        'reducedQuietZone': reducedQuietZone,
        'febraban': febraban,
      };
}

/// Matrix 2 of 5 decoder configuration.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
class Matrix2of5Decoder extends BaseDecoder {
  final int? length1;
  final int? length2;
  final bool? redundancy;
  final bool? reportCheckDigit;
  final bool? verifyCheckDigit;

  const Matrix2of5Decoder({
    super.enabled,
    this.length1,
    this.length2,
    this.redundancy,
    this.reportCheckDigit,
    this.verifyCheckDigit,
  });

  factory Matrix2of5Decoder.fromMap(Map<String, dynamic> map) => Matrix2of5Decoder(
        enabled: map['enabled'] as bool?,
        length1: map['length1'] as int?,
        length2: map['length2'] as int?,
        redundancy: map['redundancy'] as bool?,
        reportCheckDigit: map['reportCheckDigit'] as bool?,
        verifyCheckDigit: map['verifyCheckDigit'] as bool?,
      );

  Map<String, dynamic> toMap() => {
        'enabled': enabled,
        'length1': length1,
        'length2': length2,
        'redundancy': redundancy,
        'reportCheckDigit': reportCheckDigit,
        'verifyCheckDigit': verifyCheckDigit,
      };
}

/// MSI decoder configuration.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
class MsiDecoder extends BaseDecoder {
  final int? length1;
  final int? length2;
  final bool? redundancy;

  /// Number of check digits.
  final CheckDigit? checkDigits;

  /// Check digit scheme.
  final CheckDigitScheme? checkDigitScheme;

  final bool? reportCheckDigit;

  const MsiDecoder({
    super.enabled,
    this.length1,
    this.length2,
    this.redundancy,
    this.checkDigits,
    this.checkDigitScheme,
    this.reportCheckDigit,
  });

  factory MsiDecoder.fromMap(Map<String, dynamic> map) => MsiDecoder(
        enabled: map['enabled'] as bool?,
        length1: map['length1'] as int?,
        length2: map['length2'] as int?,
        redundancy: map['redundancy'] as bool?,
        checkDigits: map['checkDigits'] != null
            ? CheckDigit.fromValue(map['checkDigits'] as String)
            : null,
        checkDigitScheme: map['checkDigitScheme'] != null
            ? CheckDigitScheme.fromValue(map['checkDigitScheme'] as String)
            : null,
        reportCheckDigit: map['reportCheckDigit'] as bool?,
      );

  Map<String, dynamic> toMap() => {
        'enabled': enabled,
        'length1': length1,
        'length2': length2,
        'redundancy': redundancy,
        'checkDigits': checkDigits?.value,
        'checkDigitScheme': checkDigitScheme?.value,
        'reportCheckDigit': reportCheckDigit,
      };
}

/// OCR-A decoder configuration.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
class OcrADecoder extends BaseDecoder {
  final OcrAVariant? ocrAVariant;

  const OcrADecoder({super.enabled, this.ocrAVariant});

  factory OcrADecoder.fromMap(Map<String, dynamic> map) => OcrADecoder(
        enabled: map['enabled'] as bool?,
        ocrAVariant: map['ocrAVariant'] != null
            ? OcrAVariant.fromValue(map['ocrAVariant'] as String)
            : null,
      );

  Map<String, dynamic> toMap() => {'enabled': enabled, 'ocrAVariant': ocrAVariant?.value};
}

/// OCR-B decoder configuration.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
class OcrBDecoder extends BaseDecoder {
  final OcrBVariant? ocrBVariant;

  const OcrBDecoder({super.enabled, this.ocrBVariant});

  factory OcrBDecoder.fromMap(Map<String, dynamic> map) => OcrBDecoder(
        enabled: map['enabled'] as bool?,
        ocrBVariant: map['ocrBVariant'] != null
            ? OcrBVariant.fromValue(map['ocrBVariant'] as String)
            : null,
      );

  Map<String, dynamic> toMap() => {'enabled': enabled, 'ocrBVariant': ocrBVariant?.value};
}

/// Signature decoder configuration.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
class SignatureDecoder extends BaseDecoder {
  /// Width (pixels) of the captured signature image.
  final int? width;

  /// Height (pixels) of the captured signature image.
  final int? height;

  /// Output image format.
  final SignatureImageFormat? format;

  /// JPEG quality (1–100) when format is JPEG.
  final int? jpegQuality;

  /// Bits per pixel for the output image.
  final SignatureImageBitsPerPixel? bpp;

  const SignatureDecoder({
    super.enabled,
    this.width,
    this.height,
    this.format,
    this.jpegQuality,
    this.bpp,
  });

  factory SignatureDecoder.fromMap(Map<String, dynamic> map) => SignatureDecoder(
        enabled: map['enabled'] as bool?,
        width: map['width'] as int?,
        height: map['height'] as int?,
        format: map['format'] != null
            ? SignatureImageFormat.fromValue(map['format'] as String)
            : null,
        jpegQuality: map['jpegQuality'] as int?,
        bpp: map['bpp'] != null
            ? SignatureImageBitsPerPixel.fromValue(map['bpp'] as String)
            : null,
      );

  Map<String, dynamic> toMap() => {
        'enabled': enabled,
        'width': width,
        'height': height,
        'format': format?.value,
        'jpegQuality': jpegQuality,
        'bpp': bpp?.value,
      };
}

/// TriOptic 39 decoder configuration.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
class TriOptic39Decoder extends BaseDecoder {
  final bool? redundancy;

  const TriOptic39Decoder({super.enabled, this.redundancy});

  factory TriOptic39Decoder.fromMap(Map<String, dynamic> map) => TriOptic39Decoder(
        enabled: map['enabled'] as bool?,
        redundancy: map['redundancy'] as bool?,
      );

  Map<String, dynamic> toMap() => {'enabled': enabled, 'redundancy': redundancy};
}

/// UK Postal decoder configuration.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
class UkPostalDecoder extends BaseDecoder {
  final bool? reportCheckDigit;

  const UkPostalDecoder({super.enabled, this.reportCheckDigit});

  factory UkPostalDecoder.fromMap(Map<String, dynamic> map) => UkPostalDecoder(
        enabled: map['enabled'] as bool?,
        reportCheckDigit: map['reportCheckDigit'] as bool?,
      );

  Map<String, dynamic> toMap() =>
      {'enabled': enabled, 'reportCheckDigit': reportCheckDigit};
}

/// UPC-A decoder configuration.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
class UpcaDecoder extends BaseDecoder {
  final bool? reportCheckDigit;
  final Preamble? preamble;

  const UpcaDecoder({super.enabled, this.reportCheckDigit, this.preamble});

  factory UpcaDecoder.fromMap(Map<String, dynamic> map) => UpcaDecoder(
        enabled: map['enabled'] as bool?,
        reportCheckDigit: map['reportCheckDigit'] as bool?,
        preamble: map['preamble'] != null
            ? Preamble.fromValue(map['preamble'] as String)
            : null,
      );

  Map<String, dynamic> toMap() => {
        'enabled': enabled,
        'reportCheckDigit': reportCheckDigit,
        'preamble': preamble?.value,
      };
}

/// UPC-E0 decoder configuration.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
class Upce0Decoder extends BaseDecoder {
  final bool? reportCheckDigit;
  final Preamble? preamble;
  final bool? convertToUpca;

  const Upce0Decoder({super.enabled, this.reportCheckDigit, this.preamble, this.convertToUpca});

  factory Upce0Decoder.fromMap(Map<String, dynamic> map) => Upce0Decoder(
        enabled: map['enabled'] as bool?,
        reportCheckDigit: map['reportCheckDigit'] as bool?,
        preamble: map['preamble'] != null
            ? Preamble.fromValue(map['preamble'] as String)
            : null,
        convertToUpca: map['convertToUpca'] as bool?,
      );

  Map<String, dynamic> toMap() => {
        'enabled': enabled,
        'reportCheckDigit': reportCheckDigit,
        'preamble': preamble?.value,
        'convertToUpca': convertToUpca,
      };
}

/// UPC-E1 decoder configuration.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
class Upce1Decoder extends BaseDecoder {
  final bool? reportCheckDigit;
  final Preamble? preamble;
  final bool? convertToUpca;

  const Upce1Decoder({super.enabled, this.reportCheckDigit, this.preamble, this.convertToUpca});

  factory Upce1Decoder.fromMap(Map<String, dynamic> map) => Upce1Decoder(
        enabled: map['enabled'] as bool?,
        reportCheckDigit: map['reportCheckDigit'] as bool?,
        preamble: map['preamble'] != null
            ? Preamble.fromValue(map['preamble'] as String)
            : null,
        convertToUpca: map['convertToUpca'] as bool?,
      );

  Map<String, dynamic> toMap() => {
        'enabled': enabled,
        'reportCheckDigit': reportCheckDigit,
        'preamble': preamble?.value,
        'convertToUpca': convertToUpca,
      };
}

/// UPC/EAN shared parameters decoder configuration.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
class UpcEanParamsDecoder extends BaseDecoder {
  /// Whether to decode Bookland EAN.
  final bool? booklandCode;

  /// Output format for Bookland EAN.
  final BooklandFormat? booklandFormat;

  /// Whether to convert DataBar to UPC/EAN.
  final bool? convertDataBarToUpcEan;

  /// Whether to decode UPC coupon codes.
  final bool? couponCode;

  /// Whether to report linear decode component of composite barcodes.
  final bool? linearDecode;

  /// Whether to verify random-weight check digits.
  final bool? randomWeightCheckDigit;

  final SecurityLevel? securityLevel;

  /// Whether to decode 2-digit supplementals.
  final bool? supplemental2;

  /// Whether to decode 5-digit supplementals.
  final bool? supplemental5;

  final SupplementalMode? supplementalMode;

  /// Number of decode retries for supplemental barcodes.
  final int? supplementalRetries;

  final CouponReport? couponReport;

  /// Whether to zero-extend EAN-8 to EAN-13.
  final bool? eanZeroExtend;

  final bool? reducedQuietZone;

  const UpcEanParamsDecoder({
    super.enabled,
    this.booklandCode,
    this.booklandFormat,
    this.convertDataBarToUpcEan,
    this.couponCode,
    this.linearDecode,
    this.randomWeightCheckDigit,
    this.securityLevel,
    this.supplemental2,
    this.supplemental5,
    this.supplementalMode,
    this.supplementalRetries,
    this.couponReport,
    this.eanZeroExtend,
    this.reducedQuietZone,
  });

  factory UpcEanParamsDecoder.fromMap(Map<String, dynamic> map) => UpcEanParamsDecoder(
        enabled: map['enabled'] as bool?,
        booklandCode: map['booklandCode'] as bool?,
        booklandFormat: map['booklandFormat'] != null
            ? BooklandFormat.fromValue(map['booklandFormat'] as String)
            : null,
        convertDataBarToUpcEan: map['convertDataBarToUpcEan'] as bool?,
        couponCode: map['couponCode'] as bool?,
        linearDecode: map['linearDecode'] as bool?,
        randomWeightCheckDigit: map['randomWeightCheckDigit'] as bool?,
        securityLevel: map['securityLevel'] != null
            ? SecurityLevel.fromValue(map['securityLevel'] as String)
            : null,
        supplemental2: map['supplemental2'] as bool?,
        supplemental5: map['supplemental5'] as bool?,
        supplementalMode: map['supplementalMode'] != null
            ? SupplementalMode.fromValue(map['supplementalMode'] as String)
            : null,
        supplementalRetries: map['supplementalRetries'] as int?,
        couponReport: map['couponReport'] != null
            ? CouponReport.fromValue(map['couponReport'] as String)
            : null,
        eanZeroExtend: map['eanZeroExtend'] as bool?,
        reducedQuietZone: map['reducedQuietZone'] as bool?,
      );

  Map<String, dynamic> toMap() => {
        'enabled': enabled,
        'booklandCode': booklandCode,
        'booklandFormat': booklandFormat?.value,
        'convertDataBarToUpcEan': convertDataBarToUpcEan,
        'couponCode': couponCode,
        'linearDecode': linearDecode,
        'randomWeightCheckDigit': randomWeightCheckDigit,
        'securityLevel': securityLevel?.value,
        'supplemental2': supplemental2,
        'supplemental5': supplemental5,
        'supplementalMode': supplementalMode?.value,
        'supplementalRetries': supplementalRetries,
        'couponReport': couponReport?.value,
        'eanZeroExtend': eanZeroExtend,
        'reducedQuietZone': reducedQuietZone,
      };
}

/// US Planet decoder configuration.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
class UsPlanetDecoder extends BaseDecoder {
  final bool? reportCheckDigit;

  const UsPlanetDecoder({super.enabled, this.reportCheckDigit});

  factory UsPlanetDecoder.fromMap(Map<String, dynamic> map) => UsPlanetDecoder(
        enabled: map['enabled'] as bool?,
        reportCheckDigit: map['reportCheckDigit'] as bool?,
      );

  Map<String, dynamic> toMap() =>
      {'enabled': enabled, 'reportCheckDigit': reportCheckDigit};
}

/// US PostNet decoder configuration.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
class UsPostNetDecoder extends BaseDecoder {
  final bool? reportCheckDigit;

  const UsPostNetDecoder({super.enabled, this.reportCheckDigit});

  factory UsPostNetDecoder.fromMap(Map<String, dynamic> map) => UsPostNetDecoder(
        enabled: map['enabled'] as bool?,
        reportCheckDigit: map['reportCheckDigit'] as bool?,
      );

  Map<String, dynamic> toMap() =>
      {'enabled': enabled, 'reportCheckDigit': reportCheckDigit};
}

/// WebCode decoder configuration.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
class WebCodeDecoder extends BaseDecoder {
  /// Whether to decode subtype WebCode barcodes.
  final bool? subType;

  const WebCodeDecoder({super.enabled, this.subType});

  factory WebCodeDecoder.fromMap(Map<String, dynamic> map) => WebCodeDecoder(
        enabled: map['enabled'] as bool?,
        subType: map['subType'] as bool?,
      );

  Map<String, dynamic> toMap() => {'enabled': enabled, 'subType': subType};
}