import 'package:beasy_client/models/user_models/user.dart';
import 'package:beasy_client/services/beasyApi.dart';
import 'package:beasy_client/utils/helpers.dart';
import 'package:beasy_client/utils/sharedpreferences.dart';
import 'package:beasy_client/utils/style_color.dart';
import 'package:beasy_client/widgets/buttons.dart';
import 'package:flutter/material.dart';
import '../../widgets/stak_card.dart';
import '../signin_signup/onBoard.dart';

class UserProfilePage extends StatefulWidget {
  static final routeName = "UserProfilePage";

  UserProfilePage({Key key}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  User user = BeasyApi().profileServices.user;
  double screenWidth;
  double screenHeight;
  final Duration duration = const Duration(milliseconds: 150);
  bool _isSideMenuOpen = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor:
            _isSideMenuOpen ? myBackgroundColor : myBackgroundColor,
        body: Stack(children: [_sideMenu(), _body()]),
      ),
    );
  }

  Widget _sideMenu() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        //decoration: BoxDecoration(),
        width: MediaQuery.of(context).size.width * 0.5,
        margin: EdgeInsets.symmetric(vertical: 50),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
                child: Row(
              children: [
                Container(
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 25,
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 10),
                ),
                Container(
                    child: Text(user.name??"Jora" + " " + user.surname??"helll",
                        style: TextStyle(color: Colors.white, fontSize: 16)))
              ],
            )),
            Container(
                child: Row(
              children: [
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(
                      Icons.email,
                      color: Colors.white,
                      size: 25,
                    )),
                Flexible(
                  child: Container(
                    child: Text(
                      user.email,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                      maxLines: 2,
                    ),
                  ),
                ),
              ],
            )),
            Container(
                child: Row(
              children: [
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(
                      Icons.phone,
                      color: Colors.white,
                      size: 25,
                    )),
                Text("+374-98-966-976",
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ],
            )),
            Container(
                child: Row(
              children: [
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(
                      Icons.settings,
                      color: Colors.white,
                      size: 25,
                    )),
                Text("Settings",
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ],
            )),
            InkWell(
              onTap: () async {
                var singOut = await BeasyApi().profileServices.singOut();
                if (singOut) {
                  SaveUserData.saveLogged(false);
                  Navigator.of(context).popAndPushNamed(OnBoard.routeName);
                }
              },
              child: Container(
                  child: Row(
                children: [
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Icon(
                        Icons.logout,
                        color: Colors.white,
                        size: 25,
                      )),
                  Text("Log out",
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ],
              )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _body() {
    return AnimatedPositioned(
      duration: duration,
      top: _isSideMenuOpen ? 0 : 0.1 * screenHeight,
      bottom: _isSideMenuOpen ? 0 : 0.1 * screenWidth,
      left: _isSideMenuOpen ? 0 : 0.6 * screenWidth,
      right: _isSideMenuOpen ? 0 : -0.4 * screenWidth,
      child: Material(
        elevation: 5,
        borderRadius:
            _isSideMenuOpen ? null : BorderRadius.all(Radius.circular(20)),
        child: Stack(children: [
          Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.35),
            decoration: BoxDecoration(
                color: myBackgroundColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50))),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: 10,
                  ),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        _isSideMenuOpen = !_isSideMenuOpen;
                      });
                    },
                    icon: Icon(Icons.menu),
                    color: Colors.black,
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage("assets/user_photo.jpg"))),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                user.name,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              child: Text(user.surname,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Container(
                              child: Text(
                                  stringFromUserType(user.userType)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                user.companyId == null
                    ? Container(
                        child: CustumButton(
                          text: "Create Buisnes",
                          onTap: () {
                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (context) => CreateBuisnesPage()));
                          },
                        ),
                      )
                    : Container(
                        margin: EdgeInsets.only(top: 30),
                        child: Text(
                          "My Buisness",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ))
              ],
            ),
          ),
          if (user.companyId != null)
            Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.3),
                child: ListView.builder(
                    itemCount: BeasyApi()
                        .companyServices
                        .curentUserCompany
                        .companyStreams
                        .length,
                    itemBuilder: (context, index) {
                      var stack = BeasyApi()
                          .companyServices
                          .curentUserCompany
                          .companyStreams[index];
                      return StackCard(
                        companyStream: stack,
                      );
                    }))
        ]),
      ),
    );
  }
}
