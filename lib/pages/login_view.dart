import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  GlobalKey<FormState> _loginFormkey = GlobalKey();

  String? username, password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Login"),
      ),
      body: SafeArea(
        child: buildUi(),
      ),
    );
  }

  Widget buildUi() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _title(),
          _loginForm(),
        ],
      ),
    );
  }

  Widget _title() {
    return const Text(
      "Recip Book",
      style: TextStyle(
        fontSize: 35,
        fontWeight: FontWeight.w300,
      ),
    );
  }

  Widget _loginForm() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.30,
      width: MediaQuery.of(context).size.width * 0.90,
      child: Form(
        key: _loginFormkey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              initialValue: "Favor",
              onSaved: (value) {
                setState(() {
                  username = value;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter a username";
                }
              },
              decoration: const InputDecoration(
                hintText: "Username",
              ),
            ),
            TextFormField(
              initialValue: "dada@123",
              onSaved: (value) {
                setState(() {
                  password = value;
                });
              },
              obscureText: true,
              validator: (value) {
                if (value == null || value.length < 5) {
                  return "Enter a valid password";
                }
              },
              decoration: const InputDecoration(
                hintText: "Password",
              ),
            ),
            loginButton(),
          ],
        ),
      ),
    );
  }

  Widget loginButton() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.60,
      child: ElevatedButton(
        onPressed: () {
          if (_loginFormkey.currentState?.validate() ?? false) {
            _loginFormkey.currentState?.save();
            print("$username - $password");
          }
        },
        child: const Text("Login"),
      ),
    );
  }
}
