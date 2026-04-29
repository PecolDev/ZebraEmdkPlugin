// ================= FILE: key_identifiers.dart =================

/// Identifies a hardware key or button on a Zebra device for use with the
/// MX `KeyMappingMgr` CSP (`KeyIdentifier` parm).
///
/// The [value] of each entry is the exact string accepted by the
/// `KeyIdentifier` parm in the MX XML profile.
///
/// Not all devices have keys for every identifier. Attempting to map a key
/// that is not present on the device will produce an error in the Result XML.
///
/// See: https://techdocs.zebra.com/mx/keymappingmgr/
enum KeyIdentifier {
  // ── Number Keys (MX 4.4+) ───────────────────────────────────────────────
  /// The "0" key.
  zero('0'),

  /// The "1" key.
  one('1'),

  /// The "2" key.
  two('2'),

  /// The "3" key.
  three('3'),

  /// The "4" key.
  four('4'),

  /// The "5" key.
  five('5'),

  /// The "6" key.
  six('6'),

  /// The "7" key.
  seven('7'),

  /// The "8" key.
  eight('8'),

  /// The "9" key.
  nine('9'),

  // ── Alpha Keys (MX 4.4+) ────────────────────────────────────────────────
  /// The "A" key.
  a('A'),

  /// The "B" key.
  b('B'),

  /// The "C" key.
  c('C'),

  /// The "D" key.
  d('D'),

  /// The "E" key.
  e('E'),

  /// The "F" key.
  f('F'),

  /// The "G" key.
  g('G'),

  /// The "H" key.
  h('H'),

  /// The "I" key.
  i('I'),

  /// The "J" key.
  j('J'),

  /// The "K" key.
  k('K'),

  /// The "L" key.
  l('L'),

  /// The "M" key.
  m('M'),

  /// The "N" key.
  n('N'),

  /// The "O" key.
  o('O'),

  /// The "P" key.
  p('P'),

  /// The "Q" key.
  q('Q'),

  /// The "R" key.
  r('R'),

  /// The "S" key.
  s('S'),

  /// The "T" key.
  t('T'),

  /// The "U" key.
  u('U'),

  /// The "V" key.
  v('V'),

  /// The "W" key.
  w('W'),

  /// The "X" key.
  x('X'),

  /// The "Y" key.
  y('Y'),

  /// The "Z" key.
  z('Z'),

  // ── Function Keys (MX 4.4+) ─────────────────────────────────────────────
  /// The "F1" function key.
  f1('F1'),

  /// The "F2" function key.
  f2('F2'),

  /// The "F3" function key.
  f3('F3'),

  /// The "F4" function key.
  f4('F4'),

  /// The "F5" function key.
  f5('F5'),

  /// The "F6" function key.
  f6('F6'),

  /// The "F7" function key.
  f7('F7'),

  /// The "F8" function key.
  f8('F8'),

  /// The "F9" function key.
  f9('F9'),

  /// The "F10" function key.
  f10('F10'),

  /// The "F11" function key.
  f11('F11'),

  /// The "F12" function key.
  f12('F12'),

  // ── Punctuation (MX 4.4+) ───────────────────────────────────────────────
  /// The period / dot key.
  dot('DOT'),

  /// The comma key. (MX 8.3+)
  comma('COMMA'),

  /// The "Star" key (not the asterisk key).
  star('STAR'),

  /// The pound / number-sign ("#") key.
  pound('POUND'),

  // ── Navigation ──────────────────────────────────────────────────────────
  /// The Enter key (may differ from the Return key).
  enter('ENTER'),

  /// The Up-arrow key.
  up('UP'),

  /// The Down-arrow key.
  down('DOWN'),

  /// The Left-arrow key.
  left('LEFT'),

  /// The Right-arrow key.
  right('RIGHT'),

  /// Centre button of a four-way navigational pad. (MX 10.4+)
  navOk('NAV_OK'),

  // ── Editing ─────────────────────────────────────────────────────────────
  /// The Escape / ESC key.
  escape('ESC'),

  /// The Backspace / BKSP key.
  backspace('BACKSPACE'),

  /// The Delete / DEL key. (MX 11.3+)
  delete('DELETE'),

  /// The Insert / INS key. (MX 11.3+)
  insert('INSERT'),

  /// The Space key / spacebar.
  space('SPACE'),

  /// The Return key (may differ from the Enter key).
  returnKey('RETURN'),

  /// The Clear key.
  clear('CLR'),

  /// The Field Exit key.
  fieldExit('FIELD_EXIT'),

  // ── Modifier keys ───────────────────────────────────────────────────────
  /// The Alt modifier/meta key.
  alt('ALT'),

  /// The Control / CTRL modifier/meta key.
  ctrl('CTRL'),

  /// The Shift modifier/meta key.
  shift('SHIFT'),

  /// The Function modifier/meta key. (MX 9.2+)
  func('FUNC'),

  /// The Alpha modifier/meta key. (MX 9.2+)
  alpha('ALPHA'),

  /// The key marked "CL" on some devices. (MX 10.4+)
  cl('CL'),

  /// The key marked "FN" on some devices. (MX 10.4+)
  fn('FN'),

  // ── Colour-coded keys ───────────────────────────────────────────────────
  /// The completely blue key (sometimes called the "Function" key).
  blue('BLUE'),

  /// The completely orange key (sometimes called the "Alpha" key).
  orange('ORANGE'),

  /// The key marked with a "diamond" symbol. (MX 8.3+)
  diamond('DIAMOND'),

  /// The key with a green dot on it.
  green('GREEN'),

  /// The key with a red dot on it.
  red('RED'),

  // ── Volume / brightness ─────────────────────────────────────────────────
  /// The Volume Up key.
  volumeUp('VOLUMEUP'),

  /// The Volume Down key.
  volumeDown('VOLUMEDOWN'),

  /// The key that increases screen brightness. (MX 7.1+, Zebra VC80x)
  brightnessUp('BRIGHTNESSUP'),

  /// The key that decreases screen brightness. (MX 7.1+, Zebra VC80x)
  brightnessDown('BRIGHTNESSDOWN'),

  /// The key that increases keyboard backlight brightness. (MX 8.3+)
  keyLightUp('KEYLIGHTUP'),

  /// The key that decreases keyboard backlight brightness. (MX 8.3+)
  keyLightDown('KEYLIGHTDOWN'),

  // ── Scanner / trigger buttons ────────────────────────────────────────────
  /// The key or button that invokes the device scanner.
  scan('SCAN'),

  /// Usually the upper-most button on the hand grip.
  gripTrigger('GRIP_TRIGGER'),

  /// The lower button on the hand grip when two grip buttons are present. (MX 6.1+)
  gripTrigger2('GRIP_TRIGGER_2'),

  /// Usually the upper-most button on the left side of the device.
  leftTrigger1('LEFT_TRIGGER_1'),

  /// The lower button on the left side when two left buttons are present.
  leftTrigger2('LEFT_TRIGGER_2'),

  /// Usually the upper-most button on the right side of the device.
  rightTrigger1('RIGHT_TRIGGER_1'),

  /// The lower button on the right side when two right buttons are present.
  rightTrigger2('RIGHT_TRIGGER_2'),

  /// Button on the left side of a Zebra MC33 device. (MX 7.2+)
  leftTrigger('LEFT_TRIGGER'),

  /// Button on the right side of a Zebra MC33 device. (MX 7.2+)
  rightTrigger('RIGHT_TRIGGER'),

  /// Button at the top of the keypad on a Zebra MC33 device. (MX 7.2+)
  centerTrigger('CENTER_TRIGGER'),

  /// Button on the front of the handle of a Zebra MC33 device. (MX 7.2+)
  gunTrigger('GUN_TRIGGER'),

  // ── P-buttons ────────────────────────────────────────────────────────────
  /// The button marked "P1". (MX 5.2+)
  p1('P1'),

  /// The button marked "P2". (MX 5.2+)
  p2('P2'),

  /// The button marked "P3". (MX 5.2+)
  p3('P3'),

  /// The button marked "P4". (MX 7.2+)
  p4('P4'),

  /// The button marked "P5". (MX 8.3+)
  p5('P5'),

  /// The button marked "P6". (MX 8.3+)
  p6('P6'),

  // ── External / Bluetooth triggers ────────────────────────────────────────
  /// The button on the rear of the device. (MX 6.1+)
  rearButton('REAR_BUTTON'),

  /// The trigger button on the left side of an external triggering device. (MX 5.2+)
  leftExternalTrigger('LEFT_EXTERNAL_TRIGGER'),

  /// The trigger button on the right side of an external triggering device. (MX 5.2+)
  rightExternalTrigger('RIGHT_EXTERNAL_TRIGGER'),

  /// The primary trigger button on a Bluetooth-connected barcode scanner. (MX 9.2+)
  bluetoothRemoteTrigger1('BLUETOOTH_REMOTE_TRIGGER_1'),

  /// The secondary trigger button on a Bluetooth-connected barcode scanner. (MX 9.2+)
  bluetoothRemoteTrigger2('BLUETOOTH_REMOTE_TRIGGER_2'),

  /// The touch-sensitive navigation pad on a device. (MX 6.2+)
  navPad('NAV_PAD'),

  // ── Macro keys (Zebra VC80x) ─────────────────────────────────────────────
  /// The Zebra VC80x M1 key. (MX 7.1+)
  m1('M1'),

  /// The Zebra VC80x M2 key. (MX 7.1+)
  m2('M2'),

  /// The Zebra VC80x M3 key. (MX 7.1+)
  m3('M3'),

  /// The Zebra VC80x M4 key. (MX 7.1+)
  m4('M4'),

  /// The Zebra VC80x M5 key. (MX 7.1+)
  m5('M5'),

  /// The Zebra VC80x M6 key. (MX 7.1+)
  m6('M6'),

  // ── System / soft keys ───────────────────────────────────────────────────
  /// The headset pick-up / hang-up button.
  headsetHook('HEADSET_HOOK'),

  /// The Back key, button or capacitive button.
  back('BACK'),

  /// The Home key, button or capacitive button.
  home('HOME'),

  /// The Menu key, button or capacitive button.
  menu('MENU'),

  /// The Recent Apps key, button or capacitive button.
  recent('RECENT'),

  /// The Search key, button or capacitive button.
  search('SEARCH'),

  /// The keyboard backlight key or button.
  keyLight('KEYLIGHT'),

  /// The display-screen backlight key or button.
  lamp('LAMP'),

  /// The Power (on/off) key or button.
  power('POWER'),

  // ── Cursor movement ──────────────────────────────────────────────────────
  /// The key that causes the screen to change orientation. (MX 9.2+)
  rotate('ROTATE'),

  /// The key that inputs a plus (+) sign. (MX 9.2+)
  plus('PLUS'),

  /// The key that inputs a minus (-) sign or hyphen. (MX 9.2+)
  minus('MINUS'),

  /// The key that inputs a pause/break command. (MX 9.2+)
  pause('PAUSE'),

  /// The key that moves the cursor to the end of the current page. (MX 9.2+)
  end('END'),

  /// The key that moves the cursor up one page. (MX 9.2+)
  pageUp('PAGEUP'),

  /// The key that moves the cursor down one page. (MX 9.2+)
  pageDown('PAGEDOWN'),

  /// The key that inputs a tab character. (MX 10.2+)
  tab('TAB'),

  // ── Device-specific ──────────────────────────────────────────────────────
  /// Button on the clip-mount accessory for the Zebra WS50. (MX 13.3+)
  doNotDisturb('DO_NOT_DISTURB'),

  /// Recessed emergency-call button on top of the Zebra EM45. (MX 13.5+)
  topButton('TOP_BUTTON'),

  /// Button on the right side of the Zebra EM45. (MX 13.5+)
  rightButton('RIGHT_BUTTON'),

  /// Upper push-to-talk channel-switch button on the Zebra FR55. (MX 14.2+, API 34+)
  channelSwitch('CHANNEL_SWITCH'),

  /// Red emergency-call button on top of the Zebra FR55. (MX 14.2+, API 34+)
  alertButton('ALERT_BUTTON'),

  /// Dedicated emergency-call button on some Zebra devices. (MX 15.0+, API 34+)
  duress('DURESS'),

  /// Used when remapping a key with a custom name. (MX 15.2+, API 34+)
  custom('CUSTOM');

  // ─── Enum infrastructure ────────────────────────────────────────────────
  final String value;

  const KeyIdentifier(this.value);

  static KeyIdentifier fromValue(String value) =>
      KeyIdentifier.values.firstWhere(
        (e) => e.value == value,
        orElse: () => throw ArgumentError('Unknown KeyIdentifier: $value'),
      );
}
