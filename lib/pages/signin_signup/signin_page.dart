import 'package:beasy_client/pages/usual_user/home_page_user.dart';
import 'package:beasy_client/services/beasyApi.dart';
import 'package:beasy_client/utils/enums.dart';
import 'package:beasy_client/utils/helpers.dart';
import 'package:beasy_client/utils/sharedpreferences.dart';
import 'package:beasy_client/widgets/buttons.dart';
import 'package:beasy_client/widgets/inpurs.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class SingInPage extends StatefulWidget {
  final String name;
  SingInPage({this.name});

  @override
  _SingInPageState createState() => _SingInPageState();
}

class _SingInPageState extends State<SingInPage> {
  String email;
  String password;
  bool isloading = false;
  final _formStateSingIn = GlobalKey<FormState>();

  void _onSignIn() async {
    if (!_formStateSingIn.currentState.validate()) {
      return;
    }
    _formStateSingIn.currentState.save();
    var res = await BeasyApi()
        .profileServices
        .signIn(email: email, password: password);
    setState(() {
      isloading = true;
    });
    if (res == false) {
      print(res);
      Fluttertoast.showToast(
        msg: "'Can't Sing in. Please check your email/password",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey.withOpacity(0.5),
        textColor: Colors.white,
        fontSize: 16,
      );
    }



    if (res) {
      var a = await BeasyApi().profileServices.getUserData();
      SaveUserData.saveLogged(true);
      SaveUserData.saveUserCurrentId(a.id);
      if (BeasyApi().profileServices.user.userType == UserType.UsualUser) {
        Navigator.of(context).pushReplacementNamed(HomePageUser.routeName);
      } else {
        Navigator.of(context).pushReplacementNamed(HomePageUser.routeName);
      }
    }

    setState(() {
      isloading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
            backgroundColor: Color.fromRGBO(50, 65, 85, 1),
            body: _bodySingIn()),
        if (isloading) Center(child: CircularProgressIndicator())
      ],
    );
  }

  Widget _bodySingIn() {
    return KeyboardDismisser(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
          child: Form(
            key: _formStateSingIn,
            child: Column(
              children: [
                Container(
                    child: Text("Sing In ${widget.name}",
                        style: TextStyle(color: Colors.white, fontSize: 18))),
                Container(
                  // margin: EdgeInsets.symmetric(vertical: 10),
                  child: CustomInput(
                    prefix: Icons.person_outline,
                    hintText: "Email",
                    onSaved: (v) => this.email = v,
                    validator: (v) => v.isEmpty
                        ? "Email is required!"
                        : isValidEmail(v)
                            ? null
                            : "Invalid email",
                  ),
                ),
                Container(
                  // margin: EdgeInsets.symmetric(vertical: 10),
                  child: CustomInput(
                    prefix: Icons.lock_outline,
                    hintText: "Password",
                    onSaved: (v) => this.password = v,
                    validator: (v) => v.isEmpty ? "Password is required" : null,
                    obscureText: true,
                  ),
                ),
                Container(
                  //margin: EdgeInsets.symmetric(vertical: 20),
                  child: CustumButton(
                    text: "Sign In",
                    onTap: _onSignIn,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
