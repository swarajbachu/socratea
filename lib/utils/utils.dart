import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socratea/screens/DarshBoard.dart';

import '../screens/ProfileScreen.dart';


// for picking up image from gallery
pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file = await _imagePicker.pickImage(source: source);
  if (_file != null) {
    return await _file.readAsBytes();
  }
  print('No Image Selected');
}

// for displaying snackbars
showSnackBar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

List<String> classes = ['11','12',];


List<Widget> homeScreenItems = [
  DashBoard(uid: FirebaseAuth.instance.currentUser!.uid),
  const Text('Chat Area'),
  ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid,),
];


