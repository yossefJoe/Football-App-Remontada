import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:remontada/Constants/Constants.dart';
import 'package:remontada/Presentation/Pages/Bottom_Navigator_Pages/Screens/More_Screen/Widgets/Bottom_Sheet.dart';

class UserInfoWidget extends StatefulWidget {
  const UserInfoWidget({super.key});

  @override
  State<UserInfoWidget> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfoWidget> {
  final imagesdocument = FirebaseFirestore.instance
      .collection('images')
      .doc(FirebaseAuth.instance.currentUser!.uid.toString());

  final imagescollection = FirebaseFirestore.instance.collection('images');

  List<Map<String, String>> data_list = [];
  void get_user_data() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('users').get();
    List<Map<String, String>> display_data = [];
    for (var doc in querySnapshot.docs) {
      String? user_name = doc['displayName'];
      String? user_email = doc['email'];
      String? url = doc['photoURL'];
      String? uid = doc['uid'];
      if (user_name != null &&
          user_email != null &&
          uid == FirebaseAuth.instance.currentUser!.uid) {
        display_data.add({
          'username': user_name,
          'email': user_email,
          'imageurl': url != null ? url : 'null'
        });
      }
    }
    setState(() {
      data_list = display_data;
    });
  }

  @override
  void initState() {
    get_user_data();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return (data_list.isNotEmpty)
        ? Container(
            height: MediaQuery.of(context).size.height * 0.13,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FirebaseAuth.instance.currentUser?.photoURL != null
                    ? Container(
                        width: 70,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            "${data_list[0]['imageurl']}",
                          ),
                        ),
                      )
                    : FutureBuilder(
                        future: imagescollection
                            .where('User_id',
                                isEqualTo:
                                    FirebaseAuth.instance.currentUser!.uid)
                            .get(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasData &&
                              snapshot.data!.docs.isNotEmpty) {
                            return Row(
                              children: [
                                Container(
                                  width: 80.0,
                                  height: 80.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        snapshot.data?.docs[0]
                                            .get('lastImageUrl'),
                                      ),
                                    ),
                                  ),
                                ),
                                CustomIconButton()
                              ],
                            );
                          } else {
                            return ChooseImage();
                          }
                        },
                      ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${data_list[0]['username']}",
                      style: TextStyle(
                          color: theme.brightness == Brightness.light
                              ? Colors.blueGrey
                              : primary_color),
                    ),
                    Text("${data_list[0]['email']}")
                  ],
                )
              ],
            ))
        : Container(
            height: MediaQuery.of(context).size.height * 0.13,
            child: Center(
              child: CircularProgressIndicator(
                color: primary_color,
              ),
            ),
          );
  }
}
