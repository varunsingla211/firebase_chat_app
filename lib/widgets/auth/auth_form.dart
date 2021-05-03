import 'dart:io';
import 'package:firebase_app/widgets/pickers/user_image_picker.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(String email, String password, String userName,
      bool isLogin, BuildContext ctx, File image) submitFn;
  final bool isLoading;
  AuthForm(this.submitFn, this.isLoading);
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formkey = GlobalKey<FormState>();
  var isLogin = true;
  String userEmail = '';
  String password = '';
  String userName = '';
  var userImage;
  void pickedImage(File image) {
    userImage = image;
  }

  void trySubmit() {
    final isValid = _formkey.currentState.validate();
    if (userImage == null && !isLogin) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('pick an image')));
    }

    if (isValid) {
      _formkey.currentState.save();
      FocusScope.of(context).unfocus(); // to close the keyboard
      widget.submitFn(userEmail, password, userName, isLogin, context, userImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if(!isLogin) UserImagePicker(pickedImage),
                  TextFormField(
                    key: ValueKey('email'),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Email address",
                    ),
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return 'Enter Valid';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      userEmail = value;
                    },
                  ),
                  TextFormField(
                    key: ValueKey('username'),
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(labelText: "Username"),
                    onSaved: (value) {
                      userName = value;
                    },
                  ),
                  TextFormField(
                    key: ValueKey('password'),
                    decoration: InputDecoration(labelText: "Password"),
                    obscureText: true,
                    validator: (value) {
                      if (value.isEmpty || value.length < 7) {
                        return 'eneter valid';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      password = value;
                    },
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  if (widget.isLoading) CircularProgressIndicator(),
                  if (!widget.isLoading)
                    TextButton(
                      onPressed: trySubmit,
                      child: Text('Login'),
                    ),
                  if (widget.isLoading) CircularProgressIndicator(),
                  if (!widget.isLoading)
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isLogin = !isLogin;
                        });
                      },
                      child: Text('signup'),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
