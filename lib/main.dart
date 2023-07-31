import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resume_maker/screens/auth/auth_provider.dart';
import 'package:resume_maker/screens/auth/screens/login_user.dart';
import 'package:resume_maker/screens/auth/screens/register_user.dart';
import 'package:resume_maker/screens/auth/screens/user_info.dart';
import 'package:resume_maker/screens/bottom_bar/bottem_bar_provider.dart';
import 'package:resume_maker/screens/bottom_bar/bottem_bar_screen.dart';
import 'package:resume_maker/screens/home/home_screen.dart';
import 'package:resume_maker/screens/make_resume/make_resume_provider.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  @override
  Widget build(BuildContext context) {
    final scrollbarTheme = ScrollbarThemeData(
      thumbVisibility: MaterialStateProperty.all(true),
    );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_)=>BottomBarProvider()),
        ChangeNotifierProvider(create: (_)=>MakeResumeProvider())
      ],
      child: MaterialApp(
          theme: ThemeData.light().copyWith(scrollbarTheme: scrollbarTheme),
          darkTheme: ThemeData.dark().copyWith(scrollbarTheme: scrollbarTheme),
          debugShowCheckedModeBanner: false,
          title: 'Flutter PDF Demo',
          //home:RegistrationScreen(),
          home: AuthenticationWrapper()),
    );
  }
}

class AuthenticationWrapper extends StatefulWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  State<AuthenticationWrapper> createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends State<AuthenticationWrapper> {
  void initState() {
    loadMyString();
    // TODO: implement initState
    super.initState();
  }

  Future<void> loadMyString() async {
    final carouserlController =
        Provider.of<AuthProvider>(context, listen: false);
    carouserlController.loadMyString();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, authProvider, child) {
      // ignore: unnecessary_null_comparison
      return authProvider.myString! != null
          ? authProvider.myString! == "NoLogin"
              ? LoginScreen()
              : BottomBar()
          : Center(child: CircularProgressIndicator());
    });
  }
}
