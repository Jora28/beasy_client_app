import 'package:beasy_client/pages/signin_signup/onBoard.dart';
import 'package:beasy_client/pages/usual_user/book_page.dart';
import 'package:beasy_client/pages/usual_user/home_page_user.dart';
import 'package:beasy_client/pages/usual_user/worker_info_page.dart';
import 'package:beasy_client/utils/sharedpreferences.dart';
import 'package:beasy_client/utils/style_color.dart';
import 'package:flutter/material.dart';

class BeasyClient extends StatefulWidget {
  const BeasyClient({Key key}) : super(key: key);

  @override
  _BeasyClientState createState() => _BeasyClientState();
}
class _BeasyClientState extends State<BeasyClient> {

  bool isUserLogged;

  getUserLogged()async{
    await SaveUserData.getLoggedIn().then((value){
      setState(() {
        isUserLogged = false;
      });
    });
  }
  @override
  void initState() { 
    getUserLogged();
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:isUserLogged != null
          ? isUserLogged
              ? HomePageUser()
              : OnBoard()
          : Container(
              child: Center(
                child: OnBoard(),
              ),
            ),
      theme: ThemeData(
        primaryColor: newColor4, 
        accentColor: newColor4
        ),
      routes: {
        OnBoard.routeName: (c) => OnBoard(),
        HomePageUser.routeName: (c) => HomePageUser(),
        HomePageUser.routeName: (c) => HomePageUser(),
        WorkerInfoPage.routeName:(c)=>WorkerInfoPage(),
        BookPage.routeName:(c)=>BookPage()
      },
    );
  }
}
