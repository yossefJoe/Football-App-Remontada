import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChooseImage extends StatelessWidget {
  ChooseImage({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return CircleAvatar(
      radius: 40,
      child: CustomIconButton(),
      backgroundColor:
          theme.brightness == Brightness.dark ? Colors.grey : Colors.blueGrey,
    );
  }
}

class CustomIconButton extends StatelessWidget {
  CustomIconButton({super.key});

  late File file;

  var imageurl;

  final usersCollection = FirebaseFirestore.instance.collection('images');

  Future<void> get_image(ImageSource? source) async {
    var picked = await ImagePicker().pickImage(source: source!);
    if (picked != null) {
      file = File(picked.path);
      var user_uid = FirebaseAuth.instance.currentUser!.uid;
      var image_name = user_uid + basename(picked.path);
      var ref = FirebaseStorage.instance.ref('images').child('$image_name');
      final ListResult result =
          await FirebaseStorage.instance.ref('images').listAll();
      // Delete existing photos that start with user_uid
      for (var item in result.items) {
        if (item.name.startsWith(user_uid)) {
          await item.delete();
        }
      }
      final UploadTask uploadTask = ref.putFile(file);
      final TaskSnapshot downloadUrl = await uploadTask.whenComplete(() => {});
      final String url = await downloadUrl.ref.getDownloadURL();
      await usersCollection
          .doc(user_uid)
          .set({'lastImageUrl': url, 'User_id': user_uid});
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showModalBottomSheet(
          backgroundColor: Colors.blueGrey[900],
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: 200,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(AppLocalizations.of(context)!.chooseimage),
                    ListTile(
                        leading: Icon(Icons.photo_camera),
                        title: Text(AppLocalizations.of(context)!.fromcamera),
                        onTap: () async {
                          get_image(ImageSource.camera);
                        }),
                    ListTile(
                        leading: Icon(Icons.photo_library),
                        title: Text(AppLocalizations.of(context)!.fromgallery),
                        onTap: () async {
                          get_image(ImageSource.gallery);
                        }),
                  ],
                ),
              ),
            );
          },
        );
      },
      icon: Icon(
        Icons.camera_enhance,
        color: Colors.white,
      ),
    );
  }
}
