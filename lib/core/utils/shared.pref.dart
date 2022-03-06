import 'package:shared_preferences/shared_preferences.dart';



class SharedPref {
  //save user data in local storage.
 static  Future<void> setUserInfo(String user, String profile, String token) async {
    final prefs = await SharedPreferences.getInstance();
    print('user');
    await prefs.setString("user", user);
    await prefs.setString("profile", profile);
    await prefs.setString("token", token);
  }


 static  Future<void> updateUserInfo(String user) async {
   final prefs = await SharedPreferences.getInstance();
   await prefs.setString("user", user);
 }

 static Future<void> setSocketInfo(String socketApiToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("socketToken", socketApiToken);
  }

 static Future<String?> getToken() async {
   final prefs = await SharedPreferences.getInstance();
   return prefs.getString("token");
 }
  static Future<String?> getSocketToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("socketToken");
  }

 static Future<void> removeUserInfo() async {
   final prefs = await SharedPreferences.getInstance();
   await prefs.remove("user");
   await prefs.remove("profile");
   await removeTokens();
 }

 static Future<void> removeTokens() async {
   final prefs = await SharedPreferences.getInstance();
   await prefs.remove("socketToken");
   await prefs.remove("token");
 }

}
