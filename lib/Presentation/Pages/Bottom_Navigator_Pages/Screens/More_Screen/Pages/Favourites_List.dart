import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:remontada/Constants/Constants.dart';
import 'package:remontada/Presentation/Pages/Bottom_Navigator_Pages/Screens/More_Screen/Pages/Favourite_National.dart';
import 'package:remontada/Presentation/Pages/Bottom_Navigator_Pages/Screens/More_Screen/Pages/Favourite_Team.dart';
import 'package:remontada/Presentation/Widgets/Custom_Appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Favourites extends StatefulWidget {
  Favourites({super.key});

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, String>> _dataList = [];
  List<Map<String, String>> _filteredDataList = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    QuerySnapshot querySnapshot =
        await _firestore.collection('favourites').get();
    List<Map<String, String>> tempList = [];
    for (var doc in querySnapshot.docs) {
      String? teamname = doc['teamname'];
      String? teamlogo = doc['teamlogo'];
      String? uid = doc['uid'];
      if (teamname != null &&
          teamlogo != null &&
          uid == FirebaseAuth.instance.currentUser!.uid) {
        tempList.add({'teamname': teamname, 'teamlogo': teamlogo});
      }
    }
    setState(() {
      _dataList = tempList;
      _filteredDataList = tempList;
    });
  }

  void _filterData(String searchTerm) {
    List<Map<String, String>> filteredList = _dataList
        .where((element) =>
            element['teamname']!.toLowerCase().contains(searchTerm))
        .toList();
    setState(() {
      _filteredDataList = filteredList;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.brightness == Brightness.light
          ? Colors.indigo
          : Colors.grey[700],
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => FavouriteTeam(),
                ));
              },
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ))
        ],
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.favourites,
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
        backgroundColor: Colors.blueGrey[900],
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: TextFormField(
                onChanged: (value) {
                  _filterData(value);
                },
                cursorColor: theme.brightness == Brightness.light
                    ? Colors.blueGrey[900]
                    : Colors.grey,
                decoration: InputDecoration(
                  filled: true,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  hintText: AppLocalizations.of(context)!.search,
                  fillColor: theme.brightness == Brightness.light
                      ? Colors.cyan
                      : Colors.grey[900],
                  disabledBorder: InputBorder.none,
                  suffixIcon: Icon(
                    Icons.search,
                    color: theme.brightness == Brightness.light
                        ? Colors.white
                        : primary_color,
                  ),
                ),
              ),
            ),
            const SizedBox(
                height:
                    10), // Add some spacing between the TextFormField and the ListView
            Expanded(
              // Expanded should be directly inside the Column
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _filteredDataList
                    .length, // Use _filteredDataList.length directly
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      tileColor: theme.brightness == Brightness.light
                          ? Colors.cyan
                          : Colors.grey[900],
                      leading: Image.network(_filteredDataList[index]
                          ['teamlogo']!), // Display team logo
                      title: Text(_filteredDataList[index]
                          ['teamname']!), // Display team name
                      trailing: Image.asset(
                        'assets/images/heart.png',
                        height: 40,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
