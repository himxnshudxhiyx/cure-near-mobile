import 'package:flutter/services.dart';

class GlobalFunctions {
  static void hideKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }
}
