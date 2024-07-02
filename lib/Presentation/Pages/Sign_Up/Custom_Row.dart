import 'package:flutter/material.dart';
import 'package:remontada/Presentation/Pages/Sign_In/Sign_In_Page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomRow extends StatelessWidget {
  const CustomRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.ifyouhave,
          style: TextStyle(color: Colors.black),
        ),
        TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return SIgnIn();
                },
              ));
            },
            child: Text(
              AppLocalizations.of(context)!.clickhere,
              style: TextStyle(color: Colors.blue),
            ))
      ],
    );
  }
}
