import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth_provider.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({Key? key}) : super(key: key);

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {

  void initState() {
    getUserByID();
    // TODO: implement initState
    super.initState();
  }

  Future<void> getUserByID() async {
    final carouserlController = Provider.of<AuthProvider>(context, listen: false);
    carouserlController.getUserByID();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer<AuthProvider>(builder: (context, authProvider, child) {
          return authProvider.userInfo != null ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ListTile(
                title: Text("Name"),
                subtitle: Text(authProvider.userInfo!.name!),
              ),
              ListTile(
                title: Text("Email"),
                subtitle: Text(authProvider.userInfo!.email!),
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: authProvider.userInfo!.resumes!.length,
                      itemBuilder: (context, index) {

                        return ListTile(
                          title: Text(index.toString()),
                          subtitle: Text(authProvider.userInfo!.resumes![index]),
                        );
                      }))
            ],
          ) : Center(child: CircularProgressIndicator());
        }),
      ),
    );
  }
}
