import 'package:beasy_client/models/user_models/user.dart';
import 'package:beasy_client/pages/usual_user/home_page_user.dart';
import 'package:beasy_client/services/beasyApi.dart';
import 'package:beasy_client/utils/enums.dart';
import 'package:beasy_client/utils/helpers.dart';
import 'package:beasy_client/widgets/buttons.dart';
import 'package:beasy_client/widgets/cheack_box.dart';
import 'package:beasy_client/widgets/inpurs.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String email;
  String password;
  bool valuecheakBoxUser = false;

  User user = User();
  final _formStateSingUp = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(50, 65, 85, 1), body: _bodySingUp());
  }

  Future<void> _onSignUp() async {
    if (!_formStateSingUp.currentState.validate()) {
      return;
    }
    _formStateSingUp.currentState.save();
    await BeasyApi().profileServices.createUser(
          email: email,
          password: password,
        );
    user.email = email;

    user.userType = UserType.UsualUser;

    await BeasyApi().profileServices.postUser(user);

    if (BeasyApi().profileServices.user.userType == UserType.CompanyOwner) {
      Navigator.of(context).pushNamed(HomePageUser.routeName);
    } else {
      print("usual user");
    }
  }

  Widget _bodySingUp() {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
        child: Form(
          key: _formStateSingUp,
          child: Column(
            children: [
              Container(
                child: Column(
                  children: [
                    CustomInput(
                      prefix: Icons.person_outline,
                      hintText: 'Name',
                      onSaved: (v) => user.name = v,
                      validator: (v) => v.isEmpty ? 'Name is Empty' : null,
                    ),
                    CustomInput(
                      prefix: Icons.person_outline,
                      hintText: 'Sure Name',
                      onSaved: (v) => user.surname = v,
                      validator: (v) => v.isEmpty ? 'Sure Name is Empty' : null,
                    ),
                    CustomInput(
                      prefix: Icons.email_outlined,
                      hintText: 'Email',
                      onSaved: (v) => email = v,
                      validator: (v) => v.isEmpty
                          ? "Email is required!"
                          : isValidEmail(v)
                              ? null
                              : "Invalid email",
                    ),
                    CustomInput(
                      prefix: Icons.lock_outline,
                      hintText: 'Password',
                      onSaved: (v) => this.password = v,
                      validator: (v) =>
                          v.isEmpty ? "Password is required" : null,
                      obscureText: true,
                    ),
                    CustomInput(
                      prefix: Icons.lock_outline,
                      hintText: 'Reapit Password',
                      onSaved: (v) => this.password = v,
                      validator: (v) =>
                          v.isEmpty ? "Password is required" : null,
                      obscureText: true,
                    ),
                  ],
                ),
              ),
              CustumButton(
                text: "Sign Up",
                onTap: _onSignUp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
