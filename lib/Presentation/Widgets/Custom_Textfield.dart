import 'package:flutter/material.dart';
import 'package:remontada/Constants/Constants.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {super.key,
      this.validator,
      this.hinttext,
      this.iconData,
      this.obsecuretext,
      this.keyboardType,
      this.onChanged});
  final String? Function(String?)? validator;
  final Function(String?)? onChanged;
  final String? hinttext;
  final IconData? iconData;
  final bool? obsecuretext;
  final TextInputType? keyboardType;
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextFormField(
        onChanged: onChanged,
        keyboardType: keyboardType,
        obscureText: obsecuretext!,
        cursorColor: quatenary_color,
        validator: validator,
        decoration: InputDecoration(
            hoverColor: Colors.black,
            fillColor: Colors.black,
            focusColor: Colors.black,
            hintStyle: TextStyle(color: primary_color),
            hintText: hinttext,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: quatenary_color),
                borderRadius: BorderRadius.circular(20)),
            disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: quatenary_color),
                borderRadius: BorderRadius.circular(20)),
            icon: Icon(iconData),
            iconColor: quatenary_color,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: quatenary_color),
                borderRadius: BorderRadius.circular(20)),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: quatenary_color),
                borderRadius: BorderRadius.circular(20))),
      ),
    );
  }
}
