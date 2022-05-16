import 'dart:async';

import 'package:coofit/common/state_enum.dart';
import 'package:coofit/model/login/login_body.dart';
import 'package:coofit/presentation/home_page.dart';
import 'package:coofit/presentation/register_page.dart';
import 'package:coofit/provider/login_provider.dart';
import 'package:coofit/utils/validator.dart';
import 'package:coofit/widgets/footer.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:provider/provider.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

import '../style/style.dart';
import '../utils/route_observer.dart';
import '../utils/validator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  static const routeName = "/login_page";

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with RouteAware {

  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  late SimpleFontelicoProgressDialog _dialog;

  @override
  void initState() {
    super.initState();
    _dialog = SimpleFontelicoProgressDialog(context: context, barrierDimisable: false);
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (context, value, child) {
        if(value.isLogin) {
          Navigator.pushNamedAndRemoveUntil(context, HomePage.routeName, (route) => false);
        } else {
          child!;
        }
        return child!;
      },
      child: Scaffold(
        bottomNavigationBar: buildCoofitFooter(),
        body: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(vertical: 32.0),
          child: _buildLoginProcess(),
        )
      ),
    );
  }

  Widget _buildLoginProcess() {
    return Consumer<LoginProvider>(
        builder: (context, data, child) {
          switch(data.state) {
            case RequestState.Loading:
            break;
            case RequestState.Default:
              return child!;
            case RequestState.Empty:
              return child!;
            case RequestState.Success:
              if (data.isExist) {
                Future.delayed(Duration.zero, () async {
                  _dialog.hide();
                  Navigator.pushNamedAndRemoveUntil(context, HomePage.routeName, (route) => false);
                });
              } else {
                  SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
                    _dialog.hide();
                    CoolAlert.show(
                      context: context,
                      type: CoolAlertType.error,
                      text: 'Check your username or password',
                      onConfirmBtnTap: () => Navigator.pop(context)
                    );
                  });
                return child!;
              }
              break;
            case RequestState.Error:
              return Center(child: Text(data.message));
            default:
              return child!;
          }
          return child!;
        },
        child: Card(
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
                ),
                const SizedBox(height: 20),
                TextFormField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
                const SizedBox(height: 14),
                GFButton(
                    onPressed: () {
                      final loginBody = LoginBody(
                          username: _usernameController.text,
                          password: _passwordController.text
                      );
                      print(loginBody);
                      WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
                        _dialog.show(message: 'wait a second');
                      });
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
                                Navigator.pushNamed(context, RegisterPage.routeName);
                              }
                        )
                      ]
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _passwordController.dispose();
    _usernameController.dispose();
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}