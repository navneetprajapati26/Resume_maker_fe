import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resume_maker/screens/auth/screens/register_user.dart';

import '../auth_provider.dart';
import '../register_and_login_user_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registration')),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Enter your email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  // Add more email validation logic here if needed
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Enter your password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  // Add more password validation logic here if needed
                  return null;
                },
              ),
              Consumer<AuthProvider>(builder: (context, authProvider, child) {
                return authProvider.isLoading ? CircularProgressIndicator() :ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Processing Data')),
                      );
                      var user = Login(
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim());

                      authProvider.loginUser(user, context);

                      // Perform actions on successful validation, like registration
                    }
                  },
                  child: Text('Login'),
                );
              }),
              Consumer<AuthProvider>(builder: (context, authProvider, child) {
                return ElevatedButton(
                  onPressed: () {
                    //authProvider.getAllUsers(context);
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>RegistrationScreen()));
                  },
                  child: Text('Register'),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
