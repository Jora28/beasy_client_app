import 'package:beasy_client/pages/usual_user/home_page_user.dart';
import 'package:beasy_client/services/beasyApi.dart';
import 'package:beasy_client/utils/enums.dart';
import 'package:beasy_client/utils/helpers.dart';
import 'package:beasy_client/widgets/buttons.dart';
import 'package:beasy_client/widgets/inpurs.dart';
import 'package:flutter/material.dart';

class SingInPage extends StatefulWidget {
  final String name;
  SingInPage({this.name});

  @override
  _SingInPageState createState() => _SingInPageState();
}

class _SingInPageState extends State<SingInPage> {
  String email;
  String password;
  bool _showSingInOrSingUp = false;

  final _formStateSingIn = GlobalKey<FormState>();
  final _formStateSingUp = GlobalKey<FormState>();

  void _onSignIn() async {
    if (!_formStateSingIn.currentState.validate()) {
      return;
    }
    _formStateSingIn.currentState.save();
    var res = await BeasyApi()
        .profileServices
        .signIn(email: email, password: password);

    if (res) {
      if (BeasyApi().profileServices.user.userType == UserType.UsualUser) {
        Navigator.of(context).pushReplacementNamed(HomePageUser.routeName);
      } else {
        Navigator.of(context)
            .pushReplacementNamed(HomePageUser.routeName);
      }
    }
  }

  getData() async {
    await BeasyApi().companyServices.getCompany();
    print(BeasyApi().companyServices.curentUserCompany.companyStreams[0].queue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(50, 65, 85, 1), body: _bodySingIn());
  }

  Widget _bodySingIn() {
    return SingleChildScrollView(
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
    );
  }
}
