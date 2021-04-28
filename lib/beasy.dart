import 'package:beasy_client/pages/signin_signup/onBoard.dart';
import 'package:beasy_client/pages/usual_user/home_page_user.dart';
import 'package:beasy_client/pages/usual_user/worker_info_page.dart';
import 'package:beasy_client/utils/style_color.dart';
import 'package:flutter/material.dart';

class BeasyClient extends StatelessWidget {
  const BeasyClient({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OnBoard(),
      theme: ThemeData(
        primaryColor: newColor4, 
        accentColor: newColor4
        ),
      routes: {
        OnBoard.routeName: (c) => OnBoard(),
        HomePageUser.routeName: (c) => HomePageUser(),
        HomePageUser.routeName: (c) => HomePageUser(),
        WorkerInfoPage.routeName:(c)=>WorkerInfoPage()
      },
    );
  }
}
