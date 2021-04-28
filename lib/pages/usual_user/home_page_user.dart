import 'package:beasy_client/pages/usual_user/search_queue_page.dart';
import 'package:beasy_client/pages/usual_user/user_profile_page.dart';
import 'package:flutter/material.dart';

class HomePageUser extends StatefulWidget {
  static final routeName = "HomePageUser";
  @override
  _HomePageUserState createState() => _HomePageUserState();
}

class _HomePageUserState extends State<HomePageUser> {
  int sectionIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: sectionIndex,
        items: [
          BottomNavigationBarItem(label: "Streams", icon: Icon(Icons.menu)),
          BottomNavigationBarItem(label: "Profile", icon: Icon(Icons.person)),
        ],
        onTap: (index) {
          setState(() {
            sectionIndex = index;
          });
        },
      ),
      body: _body(),
    );
  }

  Widget _body() {
    switch (sectionIndex) {
      case 0:
        return SearchQueuePage();
        break;
      case 1:
        return UserProfilePage();
        break;
      default:
        return SearchQueuePage();
    }
  }
}
