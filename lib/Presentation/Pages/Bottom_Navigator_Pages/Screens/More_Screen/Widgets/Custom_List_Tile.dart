import 'package:flutter/material.dart';
import 'package:remontada/Constants/Constants.dart';

class CustomListTile extends StatelessWidget {
  CustomListTile(
      {super.key,
      this.leading,
      this.title,
      this.onTap,
      this.trailingTrueorFalse,
      this.SignoutTrueorFalse,
      this.timezone});
  final IconData? leading;
  final String? title;
  final VoidCallback? onTap;
  final bool? trailingTrueorFalse;
  final bool? SignoutTrueorFalse;
  final bool? timezone;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.07,
        child: ListTile(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          onTap: onTap,
          leading: Icon(
            leading,
            color: SignoutTrueorFalse == true
                ? theme.brightness == Brightness.dark
                    ? Colors.red
                    : Colors.black
                : Colors.white,
          ),
          trailing: trailingTrueorFalse == true
              ? timezone == true
                  ? FittedBox(
                      child: Row(
                        children: [
                          Text(
                            "3GMT+  ",
                            style: TextStyle(color: primary_color),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                          )
                        ],
                      ),
                    )
                  : Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    )
              : null,
          title: Text(
            title!,
            style: TextStyle(
                color: SignoutTrueorFalse == true
                    ? theme.brightness == Brightness.dark
                        ? Colors.red
                        : Colors.black
                    : Colors.white,
                fontSize: 20),
          ),
          tileColor: theme.brightness == Brightness.dark
              ? Colors.grey[850]
              : Colors.blueGrey,
        ),
      ),
    );
  }
}
