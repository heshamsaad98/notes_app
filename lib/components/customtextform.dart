import 'package:flutter/material.dart';

class CustTextFormSign extends StatelessWidget {
  final String hint;
  final String? Function(String?) vaild;
  final TextEditingController myController;
  const CustTextFormSign({Key? key, required this.hint, required this.myController, required this.vaild}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0,),
      child: TextFormField(
        validator: vaild,
        controller: myController,
        decoration: InputDecoration(
          hintText: hint,
          contentPadding: EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 10.0,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              width: 1,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
