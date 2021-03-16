import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foodshelf/controllers/user_controller.dart';
import 'package:foodshelf/helpers/utility.dart';
import 'package:foodshelf/screens/auth/login.dart';
import 'package:foodshelf/utility/brand_colors.dart';
import 'package:foodshelf/widgets/appbar_widget.dart';
import 'package:foodshelf/widgets/button_widget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class NewPasswordPage extends StatefulWidget {
  static const routeName = '/NewPassword';

  @override
  _NewPasswordPageState createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends StateMVC<NewPasswordPage> {
  UserController _con = new UserController();

  _NewPasswordPageState() : super(UserController()) {
    _con = controller;
  }

  FlutterSecureStorage storage = getIt<FlutterSecureStorage>();
  String uuid;

  getID() async {
    uuid = await storage.read(key: 'uid');
    print(uuid);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getID();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          alignment: Alignment.topCenter,
          image: Image.asset('assets/images/png/background.png').image,
        ),
      ),
      child: Scaffold(
        appBar: AppBarWidget(),
        key: _con.scaffoldKey,
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('New Password',
                  style: TextStyle(fontSize: 30, fontFamily: 'Bold')),
              SizedBox(height: 10),
              Text('Create a password, which isn\'t easy to guess',
                  style: TextStyle(fontSize: 16, fontFamily: 'Regular')),
              SizedBox(height: 30),
              Text('New Password',
                  style: TextStyle(fontSize: 18, fontFamily: 'Medium')),
              TextField(
                  keyboardType: TextInputType.text,
                  enableSuggestions: true,
                  obscureText: true,
                  cursorColor: BrandColors.colorAccent,
                  onChanged: (String input) => _con.user.password = input,
                  decoration: InputDecoration(
                      hintText: '***************',
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                      )),
                  style: TextStyle(fontSize: 16)),
              SizedBox(height: 30),
              Text('Confirm Password',
                  style: TextStyle(fontSize: 18, fontFamily: 'Medium')),
              TextField(
                  keyboardType: TextInputType.text,
                  enableSuggestions: true,
                  obscureText: true,
                  cursorColor: BrandColors.colorAccent,
                  onChanged: (String input) =>
                      _con.user.passwordConfirmation = input,
                  decoration: InputDecoration(
                      hintText: '***************',
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                      )),
                  style: TextStyle(fontSize: 16)),
              SizedBox(height: 30),
              ButtonWidget(
                  color: BrandColors.colorAccent,
                  onPressed: () async {
                    getID();
                    // _con.resetPass(_con.user.password,
                    //     _con.user.passwordConfirmation, int.parse(uuid));
                  },
                  title: 'Next'),
            ],
          ),
        ),
      ),
    );
  }
}
