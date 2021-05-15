import 'package:flutter/material.dart';
import 'package:smart_gardern_app/components/text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final Icon icon;
  final ValueChanged<String> onChanged;
  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
        child: TextField(
      onChanged: onChanged,
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
