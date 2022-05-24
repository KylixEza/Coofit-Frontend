import 'package:coofit/presentation/login_page.dart';
import 'package:coofit/provider/profile_provider.dart';
import 'package:coofit/style/style.dart';
import 'package:coofit/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

import '../common/state_enum.dart';
import '../model/user/user_body.dart';
import '../model/user/user_response.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  static const route_name = '/profile_page';

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

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
    Future.microtask(() {
      Provider.of<ProfileProvider>(context, listen: false)
          .getUserDetail();
    });
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
      appBar: buildNavBar(context, 'Profile'),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: _buildPage(context)
      ),
    );
  }

  Widget _buildPage(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, value, child) {
        switch(value.state) {
          case RequestState.Default:
            return Container();
          case RequestState.Empty:
            return _buildProfile(value.user);
          case RequestState.Loading:
            return Center(
              child: Lottie.asset('RedLoading.json', width: 200, height: 200),
            );
          case RequestState.Success: {
            _dialog.hide();
            return Row(
              children: [
                Expanded(
                  child: _buildProfile(value.user),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: _buildEditProfile(value.user),
                )
              ],
            );
          }

          case RequestState.Error:
            _dialog.hide();
            return Center(child: Text(value.message));
        }
      },
    );
  }

  Widget _buildProfile(UserResponse user) {
    return Center(
      child: Wrap(
        children: [
          Card(
            elevation: 8,
            shadowColor: Colors.grey,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  SizedBox(
                    height: 128,
                    width: 128,
                    child: CircleAvatar(backgroundImage: NetworkImage(user.avatar)),
                  ),
                  const SizedBox(width: 64),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user.username, style: coofitTextTheme.headline6),
                      const SizedBox(height: 4),
                      Text(user.email, style: coofitTextTheme.bodyText2),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.stars, color: primaryColor),
                          const SizedBox(width: 8),
                          Text("${user.xp.toString()} XP"),
                          const SizedBox(width: 32),
                          const Icon(Icons.monetization_on, color: Colors.green),
                          Text("Rp${user.coofitWallet.toString()}")
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          GFButton(
            onPressed: () {
              Provider.of<ProfileProvider>(context, listen: false)
                  .logout();
              Future.delayed(const Duration(seconds: 1), () {
                Navigator.pushNamedAndRemoveUntil(context, LoginPage.routeName, (route) => false);
              });
            },
            color: primaryColor,
            fullWidthButton: true,
            text: "Logout",
              textStyle: coofitTextTheme.headline5?.merge(
                  const TextStyle(color: Colors.white)
              )
          )
        ],
      ),
    );
  }

  Widget _buildEditProfile(UserResponse user) {
    return Wrap(
      children: [Container(
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
                const SizedBox(height: 32),
                TextField(
                  controller: _usernameController..text = user.username,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                  ),
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: _emailController..text = user.email,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: _addressController..text = user.address,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Address',
                  ),
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: _phoneNumberController..text = user.phoneNumber,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Phone Number',
                  ),
                ),
                const SizedBox(height: 14),
                GFButton(
                    onPressed: () {
                      final userBody = UserBody(
                        username: _usernameController.text,
                        password: user.password,
                        address: _addressController.text,
                        avatar: user.avatar,
                        coofitWallet: user.coofitWallet,
                        email: _emailController.text,
                        phoneNumber: _phoneNumberController.text,
                        xp: user.coofitWallet,
                      );
                      setState(() {
                        WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
                          _dialog.show(message: 'wait a second');
                        });
                      });
                      Provider.of<ProfileProvider>(context, listen: false)
                          .updateUser(userBody);
                    },
                    color: primaryColor,
                    fullWidthButton: true,
                    text: "Update",
                    textStyle: coofitTextTheme.headline5?.merge(
                        const TextStyle(color: Colors.white)
                    )
                ),
                const SizedBox(height: 14),
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}