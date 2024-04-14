import 'dart:io';

import 'package:flutter/foundation.dart';

class PlatformUtils {
  static bool _isWeb() {
    // 通过kIsWeb变量判断是否为web环境!
    return kIsWeb == true;
  }

  static bool _isPhone() {
    return _isWeb() ? false : Platform.isAndroid || Platform.isIOS;
  }

  static bool _isPc () {
    return _isWeb() ? false : Platform.isWindows || Platform.isMacOS || Platform.isLinux;
  }

  static bool _isFuchsia() {
    return _isWeb() ? false : Platform.isFuchsia;
  }

  static bool get isWeb => _isWeb();

  static bool get isPhone => _isPhone();

  static bool get isPc => _isPc();

  static bool get isFuchsia => _isFuchsia();
}