import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

/* RxDouble opcionToCubaA = 60.0.obs;
  RxDouble opcionToCubaB = 72.0.obs;
  RxDouble opcionToWorldA = 72.0.obs;
  RxDouble opcionToWorldC = 84.0.obs; */

/* const double _opcionToCubaA = 60.0;
const double _opcionToCubaB = 72.0;
const double _opcionToWorldA = 72.0;
const double _opcionToWorldC = 84.0; */

class SharePreferenceService {
  // static SharePreferenceService get to => Get.find<SharePreferenceService>();
  static SharePreferenceService? _instance;
  static late SharedPreferences _prefs;

  SharePreferenceService._();

  static Future<SharePreferenceService> getInstance() async {
    _instance ??= SharePreferenceService._();
    _prefs = await SharedPreferences.getInstance();
    return _instance!;
  }

  dynamic _getData(String key) {
    // Retrieve data from shared preferences
    var value = _prefs.get(key);
    // Return the data that we retrieve from shared preferences
    return value;
  }

  void _saveData(String key, dynamic value) {
    // Save data to shared preferences
    if (value is String) {
      _prefs.setString(key, value);
    } else if (value is int) {
      _prefs.setInt(key, value);
    } else if (value is double) {
      _prefs.setDouble(key, value);
    } else if (value is bool) {
      _prefs.setBool(key, value);
    } else if (value is List<String>) {
      _prefs.setStringList(key, value);
    }
  }

  double get opcionToCubaA => _getData('opcionToCubaA') ?? 0.0;
  set opcionToCubaA(double value) => _saveData('opcionToCubaA', value);

  double get opcionToCubaB => _getData('opcionToCubaB') ?? 0.0;
  set opcionToCubaB(double value) => _saveData('opcionToCubaB', value);

  double get opcionToWorldA => _getData('opcionToWorldA') ?? 0.0;
  set opcionToWorldA(double value) => _saveData('opcionToWorldA', value);

  double get opcionToWorldC => _getData('opcionToWorldC') ?? 0.0;
  set opcionToWorldC(double value) => _saveData('opcionToWorldC', value);
}
