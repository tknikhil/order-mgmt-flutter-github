import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:order_mgmt_flutter/src/service/service.dart';
import 'package:order_mgmt_flutter/src/presentation/presentation.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    FormTextField emailF =
        FormTextField(inputController: emailController, label: "Username");
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade200,
      body: SingleChildScrollView(
        child: Form(
            key: _formkey,
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: Palette.backgroundGradient,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 60),
                        Text("Login",
                            style: GoogleFonts.oswald(
                                // fontWeight: FontWeight.bold,
                                fontSize: 40,
                                color: Palette.text)),
                        const SizedBox(height: 30),
                        emailF,
                        const SizedBox(height: 30),
                        PasswordTextField(
                            inputController: passwordController,
                            label: "Password"),
                        const SizedBox(height: 30),
                        FormButton(
                          buttonIcon: Icons.login,
                          textcolor: Colors.white,
                          backgroundColor: Colors.brown,
                          borderColor: Colors.brown,
                          text: "Login",
                          heightSize: 50,
                          widthSize: 200,
                          onPressed: () {
                            isLogin(emailController.text,
                                passwordController.text, context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  void isLogin(String username, String password, BuildContext context) {
    var login = LoginService().login(username, password);
    login.then((value) => {
          if (value == "Success")
            {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BottomNavigationBarPage())),
            }
          else
            {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Login Failed "),
              ))
            }
        });
  }

  void clearFieldText() {
    emailController.clear();
    passwordController.clear();
  }
}
