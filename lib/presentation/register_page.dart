import 'package:coofit/presentation/login_page.dart';
import 'package:coofit/provider/register_provider.dart';
import 'package:coofit/utils/constant.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:provider/provider.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

import '../common/state_enum.dart';
import '../model/user/user_body.dart';
import '../style/style.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  static const routeName = "/register_page";

  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  late TextEditingController _emailController;
  late TextEditingController _addressController;
  late TextEditingController _phoneNumberController;
  late SimpleFontelicoProgressDialog _dialog;

  @override
  void initState() {
    super.initState();
    _dialog = SimpleFontelicoProgressDialog(context: context, barrierDimisable: false);
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _emailController = TextEditingController();
    _addressController = TextEditingController();
    _phoneNumberController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<RegisterProvider>(
        builder: (context, value, child) {
          switch(value.state) {
            case RequestState.Default:
              return child!;
            case RequestState.Empty:
              return child!;
            case RequestState.Loading:
              break;
            case RequestState.Success:
              SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
                CoolAlert.show(
                  context: context,
                  type: CoolAlertType.success,
                  text: 'Your account successfully created!'
                );
              });
              return child!;
            case RequestState.Error:
              _dialog.hide();
              SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
                CoolAlert.show(
                    context: context,
                    type: CoolAlertType.error,
                    text: value.message
                );
              });
              return child!;
          }
          return child!;
        },
        child: Container(
          alignment: Alignment.center,
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0)
            ),
            shadowColor: Colors.grey,
            child: Container(
              width: 720,
              padding: const EdgeInsets.all(32.0),
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
                  const SizedBox(height: 32),
                  TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                    ),
                  ),
                  const SizedBox(height: 14),
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                  const SizedBox(height: 14),
                  TextField(
                    controller: _addressController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Address',
                    ),
                  ),
                  const SizedBox(height: 14),
                  TextField(
                    controller: _phoneNumberController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Phone Number',
                    ),
                  ),
                  const SizedBox(height: 14),
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                  const SizedBox(height: 14),
                  GFButton(
                      onPressed: () {
                        final userBody = UserBody(
                          username: _usernameController.text,
                          password: _passwordController.text,
                          address: _addressController.text,
                          avatar: defaultAvatarUrl,
                          coofitWallet: 0,
                          email: _emailController.text,
                          phoneNumber: _phoneNumberController.text,
                          xp: 0,
                        );
                        setState(() {
                          WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
                            _dialog.show(message: 'wait a second');
                          });
                        });
                        Provider.of<RegisterProvider>(context, listen: false)
                          .addNewUser(userBody);
                      },
                      color: primaryColor,
                      fullWidthButton: true,
                      text: "Register",
                      textStyle: coofitTextTheme.headline5?.merge(
                          const TextStyle(color: Colors.white)
                      )
                  ),
                  const SizedBox(height: 14),
                  RichText(
                    text: TextSpan(
                        style: defaultStyle,
                        children: <TextSpan>[
                          const TextSpan(text: 'Have an account? '),
                          TextSpan(
                              text: 'Login',
                              style: linkStyle,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushReplacementNamed(context, LoginPage.routeName);
                                }
                          )
                        ]
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}