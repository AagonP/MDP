import 'package:flutter/material.dart';
import '../../../../components/text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  final String? hintText;
  final Icon? icon;

  final controller;
  final validator;
  const RoundedInputField({
    Key? key,
    this.hintText,
    this.icon,
    this.controller,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
        child: TextFormField(
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      decoration: InputDecoration(
          icon: icon,
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.white,
          ),
          border: InputBorder.none // no line under hint text
          ),
    ));
  }
}
