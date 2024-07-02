import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remontada/Constants/Constants.dart';
import 'package:remontada/Constants/Provider_Methods.dart';
import 'package:remontada/Models/News_Model.dart';

class NewsData extends StatelessWidget {
  NewsData({super.key, this.news});
  final News? news;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                        ))
                  ],
                ),
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/fnews.jpg'))),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      news!.title!,
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Credit :${news!.credit}',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Consumer<RemontadaModel>(
                      builder: (context, v, child) {
                        return Text(
                          news!.content!.long.toString(),
                          style: TextStyle(fontSize: v.font_size),
                        );
                      },
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
