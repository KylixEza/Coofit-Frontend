import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHelper {

  final Future<SharedPreferences> sharedPreference;

  PreferenceHelper({required this.sharedPreference});

  static const UID ='UID';

  Future<String> getUid() async {
    final prefs = await sharedPreference;
    return prefs.getString(UID) ?? "";
  }

  void setUid(String uid) async {
    final prefs = await sharedPreference;
    prefs.setString(UID, uid);
  }
}