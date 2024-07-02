import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:remontada/Constants/Api/News_Api.dart';
import 'package:remontada/Constants/Constants.dart';
import 'package:remontada/Presentation/Pages/Bottom_Navigator_Pages/Screens/News_Data.dart';
import 'package:remontada/Presentation/Widgets/Custom_Appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewsList extends StatelessWidget {
  NewsList({super.key, this.type});
  final String? type;

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    String formatted_date = DateFormat('yyyy/M/d').format(today);
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: CustomAppBar(AppLocalizations.of(context)!.news, context),
      body: ListView(
        children: [
          FutureBuilder(
            future: News_Api().getsavednews(type!, '2024/5/18'),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => NewsData(
                                news: snapshot.data![index],
                              ),
                            ));
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.15,
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              tileColor: theme.brightness == Brightness.dark
                                  ? Colors.grey[900]
                                  : Colors.brown[200],
                              leading: theme.brightness == Brightness.dark
                                  ? Image.asset(
                                      "assets/images/news.gif",
                                      height: 70,
                                      width: 70,
                                    )
                                  : Image.asset("assets/images/news2.gif"),
                              title: Text(
                                snapshot.data![index].title.toString(),
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.grey,
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
