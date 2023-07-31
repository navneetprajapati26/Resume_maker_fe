import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth/auth_provider.dart';
import '../make_resume/make_resume_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthProvider>(builder: (context, authProvider, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Text(
              authProvider.myString!,
            )),
            MaterialButton(
              onPressed: () {
                authProvider.getUserByID();
              },
              child: Text("get by id"),
            ),
            MaterialButton(
              onPressed: () {
               Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MakeResumeFormScreen()));
              },
              child: Text("Resume Form"),
            )
          ],
        );
      }),
    );
  }
}
