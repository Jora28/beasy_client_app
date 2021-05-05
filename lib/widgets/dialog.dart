import 'package:flutter/material.dart';

class CustomDialogBox extends StatefulWidget {
  final String title, descriptions, text;
  final Image img;

  const CustomDialogBox({ this.title, this.descriptions, this.text, this.img});

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }
  contentBox(context){
    return Stack(
      children: <Widget>[
        Center(
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(color: Colors.black,offset: Offset(0,10),
                blurRadius: 10
                ),
              ]
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(widget.title,style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
                SizedBox(height: 15,),
                Text(widget.descriptions,style: TextStyle(fontSize: 14),textAlign: TextAlign.center,),
                SizedBox(height: 22,),
                Align(
                  alignment: Alignment.bottomRight,
                  child: FlatButton(
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                      child: Text(widget.text,style: TextStyle(fontSize: 18),)),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 0.0,
            right: 0.0,
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 20,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Image.asset("assets/user_photo.jpg")
              ),
            ),
        ),
      ],
    );
  }
}