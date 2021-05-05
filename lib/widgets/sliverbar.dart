import 'package:beasy_client/utils/style_color.dart';
import 'package:flutter/material.dart';

import 'inpurs.dart';

class AppBarSliver extends StatelessWidget {
  const AppBarSliver({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
                  height: 120,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30)),
                      color: newColor4),
                  child: Container(
                    margin: EdgeInsets.only(top: 70,left: 20,right: 20),
                    child: Container(
                        child: CustomInput(
                            prefix: Icons.search,
                            hintText: "Search",
                            obscureText: false)),
                  ),
                );
  }
}