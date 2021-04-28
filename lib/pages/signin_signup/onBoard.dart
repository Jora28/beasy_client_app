import 'package:beasy_client/pages/signin_signup/signin_page.dart';
import 'package:beasy_client/pages/signin_signup/singup_page.dart';
import 'package:beasy_client/pages/usual_user/home_page_user.dart';
import 'package:beasy_client/services/beasyApi.dart';
import 'package:beasy_client/utils/enums.dart';
import 'package:flutter/material.dart';

class OnBoard extends StatefulWidget {
  static final routeName = "OnBoard";

  OnBoard({Key key}) : super(key: key);

  @override
  _OnBoardState createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> with SingleTickerProviderStateMixin {
  TabController _controller;
  int _currentIndex = 0;
  List<String> choices = ['User', 'Buisnes'];

  String email;
  String password;

  final _formState = GlobalKey<FormState>();

  void _onSign() async {
    if (!_formState.currentState.validate()) {
      return;
    }
    _formState.currentState.save();
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
  void initState() {
    super.initState();

    _controller = TabController(vsync: this, length: 2, initialIndex: 0);
    _controller.addListener(() {
      setState(() {
        _currentIndex = _controller.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(50, 65, 85, 1),
      body: _body(),
    );
  }

  Widget _body() {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
      child: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Column(
          children: [
            Container(
              child: TabBar(
                indicatorColor: Colors.cyan,
                unselectedLabelColor: Colors.grey,
                labelColor: Colors.cyan,
                controller: _controller,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: [
                  Tab(
                    child: Text(
                      'Sing In',
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Sing Up',
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: TabBarView(
              controller: _controller,
              children: [SingInPage(), SignUpPage()],
            )),
          ],
        ),
      ),
    );
  }
}
