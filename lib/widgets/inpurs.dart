import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final String hintText;
  final IconData prefix;

  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType type;

  CustomInput({
    this.hintText,
    this.prefix,
    this.onSaved,
    this.validator,
    this.controller,
    this.obscureText = false,
    this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: TextFormField(
        keyboardType: type,
        validator: validator,
        onSaved: onSaved,
        cursorColor: Colors.white,
        textAlignVertical: TextAlignVertical.center,
        controller: controller,
        obscureText: obscureText,
        style: TextStyle(
            fontSize: 18, color: Colors.white, fontWeight: FontWeight.w300),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(7),
          prefixIcon: Icon(
            prefix,
            color: Colors.white,
            size: 20,
          ),
          isDense: true,
          filled: true,
          fillColor: Colors.white.withOpacity(0.1),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none),
          focusColor: Colors.white,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.white),
          labelStyle: TextStyle(
              fontWeight: FontWeight.w300, fontSize: 18, color: Colors.white),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              borderSide: BorderSide(color: Colors.grey.withOpacity(0))),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              borderSide: BorderSide(color: Colors.grey.withOpacity(0))),
        ),
      ),
    );
  }
}
