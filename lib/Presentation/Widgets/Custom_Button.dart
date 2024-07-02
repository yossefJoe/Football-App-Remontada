import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onpressed;
  final Color? color;
  final Widget? child;
  final double? width;
  final double? height;
  const CustomButton(
      {super.key,
      this.onpressed,
      this.color,
      this.child,
      this.width,
      this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onPressed: onpressed,
        color: color,
        child: child,
      ),
    );
  }
}
