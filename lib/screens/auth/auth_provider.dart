import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:resume_maker/screens/auth/register_and_login_user_model.dart';
import 'package:resume_maker/screens/home/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utilis/api_service.dart';
import '../bottom_bar/bottem_bar_screen.dart';

class AuthProvider with ChangeNotifier {

  bool isLoading = false;

  String? _myString;
  String? get myString => _myString;

  User? _userInfo;
  User? get userInfo => _userInfo;

  final apiService = ApiService(baseUrl: 'https://resume-app-backend.onrender.com');

  Future<void> registerUser(RegisterUser user, BuildContext context) async {
    print("-------------------------------------");
    isLoading = true;
    notifyListeners();
    apiService.post('/api/user/singup', user.toJson()).then((data) {
      isLoading = false;
      print(data);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(data["message"])),
      );

      notifyListeners();
    }).catchError((error) {
      print('Error: $error');
      isLoading = false;
    });
  }

  Future<void> loginUser(Login user, BuildContext context) async {
    print("-------------------------------------");
    isLoading = true;
    notifyListeners();

    apiService.post('/api/user/login', user.toJson()).then((data) async {
      isLoading = false;
      final json = User.fromJson(data);
      print(json.email!);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(json.email!)),);
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>BottomBar()));
      setMyString(json.sId!);

      notifyListeners();
    }).catchError((error) {
      isLoading = false;
      print('Error: $error');
    });
  }

  Future<void> getAllUsers(BuildContext context) async {
    apiService.get("/api/user").then((value) {
      print(value);
    }).catchError((err) {
      print(err);
    });
  }

  Future<void> getUserByID() async{
    apiService.get("/api/user/"+_myString!).then((data) {
      print(data);
      _userInfo = User.fromJson(data);
      notifyListeners();
    }).catchError((err) {
      print(err);
    });
  }

  Future<void> setMyString(String value) async {
    _myString = value;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("myKey", value);
  }

  Future<void> loadMyString() async {
    print("in loadMyString");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? stringValue = prefs.getString("myKey") ?? 'NoLogin';
    _myString = stringValue;
    notifyListeners();
   // return stringValue;
  }

}

