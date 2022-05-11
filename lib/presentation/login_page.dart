import 'package:coofit/common/state_enum.dart';
import 'package:coofit/model/login/login_body.dart';
import 'package:coofit/presentation/home_page.dart';
import 'package:coofit/presentation/register_page.dart';
import 'package:coofit/provider/login_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:provider/provider.dart';
import 'package:coofit/di/injection.dart' as di;
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

import '../style/style.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  static const routeName = "/login_page";

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  late TextEditingController _usernameController;
  String _username = "";

  late TextEditingController _passwordController;
  String _password = "";

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(vertical: 32.0),
          child: _buildLoginProcess(),
        )
    );
  }

  Widget _buildLoginProcess() {
    return Consumer<LoginProvider>(
        builder: (context, data, child) {
          if (data.state == RequestState.Loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (data.state == RequestState.Success) {
            if (data.isExist) {
             SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
               Navigator.pushReplacementNamed(context, HomePage.routeName);
             });
             return Container();
            } else {
              return const Center(child: Text('User Not Found :('));
            }
          } else if (data.state == RequestState.Error) {
            return Center(child: Text(data.message));
          } else {
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0)
              ),
              shadowColor: Colors.grey,
              child: Container(
                width: 720,
                padding: const EdgeInsets.all(48.0),
                child: Column(
                  children:  [
                    Image.asset("images/main_logo.jpg", height: 80, width: 80),
                    const SizedBox(height: 16),
                    const Text(
                      "Coofit",
                      style: TextStyle(
                          color: Colors.red,
                          fontFamily: "poppins",
                          fontSize: 42,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(height: 48),
                    TextField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Username',
                      ),
                      onChanged: (text) {
                        setState(() {
                          _username = text;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                      onChanged: (text) {
                        setState(() {
                          _password = text;
                        });
                      },
                    ),
                    const SizedBox(height: 14),
                    GFButton(
                        onPressed: () {
                          final loginBody = LoginBody(
                              username: _usernameController.text,
                              password: _passwordController.text
                          );
                          print(loginBody);
                          Provider.of<LoginProvider>(context, listen: false).login(loginBody);
                        },
                        color: primaryColor,
                        fullWidthButton: true,
                        text: "Login",
                        textStyle: coofitTextTheme.headline5?.merge(
                            const TextStyle(color: Colors.white)
                        )
                    ),
                    const SizedBox(height: 14),
                    RichText(
                      text: TextSpan(
                          style: defaultStyle,
                          children: <TextSpan>[
                            const TextSpan(text: 'Do not have any account? '),
                            TextSpan(
                                text: 'Register',
                                style: linkStyle,
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.popAndPushNamed(context, RegisterPage.routeName);
                                  }
                            )
                          ]
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        }
    );
  }
}