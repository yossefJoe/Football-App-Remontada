import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:remontada/Constants/Provider_Methods.dart';
import 'package:remontada/Presentation/Pages/Bottom_Navigator_Pages/Screens/More_Screen/Widgets/Leagues_Widget.dart';
import 'package:remontada/Presentation/Pages/Bottom_Navigator_Pages/Screens/News_List.dart';

class NewsScreen extends StatelessWidget {
  NewsScreen({super.key});
  List logos = [
    'spanish.png',
    'epl.png',
    'fifa.png',
    'cl.png',
  ];

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      body: ListView(
        children: [
          Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Consumer<RemontadaModel>(
                builder: (context, v, child) {
                  return GridView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: logos.length,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          v.choose_news(index);
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => NewsList(
                              type: v.default_news,
                            ),
                          ));
                          ;
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: theme.brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.blueGrey,
                              borderRadius: BorderRadius.circular(20)),
                          margin: EdgeInsets.all(20),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image.asset(
                              'assets/images/${logos[index]}',
                              fit: BoxFit.contain,
                            ),
                          )),
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.width * 0.4,
                        ),
                      );
                    },
                  );
                },
              ))
        ],
      ),
    );
  }
}
