import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socratea/providers/user_provider.dart';
import 'package:socratea/screens/DarshBoard.dart';
import 'package:socratea/utils/colors.dart';
import 'package:socratea/utils/styles.dart';
import 'package:socratea/utils/utils.dart';
import 'package:socratea/utils/widgets/xpBar.dart';

import '../resources/firestore_methods.dart';
import '../utils/widgets/basic_button.dart';
import '../utils/widgets/text_feild.dart';
import 'package:socratea/models/user.dart' as model;

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

int classIndex = 0;
int genderIndex = 0;
bool isLoading = false;
List<String> gender = ['male', 'female', 'Prefer Not to Say'];

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _schoolNameController = TextEditingController();
  final TextEditingController _educationNameController =
      TextEditingController();
  final TextEditingController _rollNoController = TextEditingController();
  final TextEditingController _homeStateController = TextEditingController();
  var userData = {};
  var userDetails = {};

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();
      userData = userSnap.data()!;

      setState(() {
        print(userData);
      });
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
    setState(() {
      isLoading = false;
    });
  }
  getUserData() async {
    var userSnap = await FirebaseFirestore.instance
        .collection("userDetails")
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    var userId = userSnap.docs[0]['userId'];
    print(userId.runtimeType);
    var userDetailsSnap = await FirebaseFirestore.instance
        .collection("userDetails").doc(userId).get();
    print(userDetailsSnap.data());
    userDetails = userId.isEmpty? {}: userDetailsSnap.data()!;
    setState(() {
      print(userDetails);
      _schoolNameController.text = userDetails['school']??'';
      _educationNameController.text = userDetails['education']??'';
      _rollNoController.text = userDetails['rollNo']??'';
      _homeStateController.text = userDetails['state']??'';

    });
  }

  @override
  void initState() {
    super.initState();
    getData();
    getUserData();
  }

  //model.User user = Provider.of<UserProvider>(context).getUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: blueColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                height: 200,
                child: Column(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      const CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            NetworkImage('https://i.stack.imgur.com/l60Hf.png'),
                        backgroundColor: Colors.blueAccent,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${userData['fullname']}',
                            style: kDarkTextStyle,
                          ),
                          Text(
                            '${classes[classIndex]}th Grade',
                            style: kDarkTextStyle,
                          ),
                        ],
                      )
                    ]),
                    const SizedBox(
                      height: 20,
                    ),
                    XpBar(
                      xpPercent: 50,
                      barWidth: MediaQuery.of(context).size.width - 100,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Personal Information',
                style: kDarkTextStyle.copyWith(fontSize: 25),
              ),
              const SizedBox(
                height: 20,
              ),
              EditFieldBox(
                label: 'Class: ',
                value: classes[classIndex],
                cupertino: buildPicker(classes),
              ),
              const SizedBox(
                height: 5,
              ),
              EditFieldBox(
                label: 'Gender: ',
                value: gender[genderIndex],
                cupertino: buildPicker(gender),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFieldInput(
                hintText:'School',
                textInputType: TextInputType.text,
                textEditingController: _schoolNameController,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFieldInput(
                hintText: 'Education Board',
                textInputType: TextInputType.text,
                textEditingController: _educationNameController,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFieldInput(
                hintText:'JEE/CUET roll number',
                textInputType: TextInputType.text,
                textEditingController: _rollNoController,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFieldInput(
                hintText:'Home State',
                textInputType: TextInputType.text,
                textEditingController: _homeStateController,
              ),
              const SizedBox(
                height: 10,
              ),
              BasicButton(
                text: "Save",
                onPressed: () => saveUserDetails(
                  widget.uid,
                  userData["username"],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPicker(List listName) {
    return SizedBox(
      height: 150,
      child: CupertinoPicker(
        itemExtent: 50,
        magnification: 1,
        onSelectedItemChanged: (index) {
          setState(() {
            if (listName == classes) {
              classIndex = index;
            } else {
              genderIndex = index;
            }
          });
        },
        children: listName
            .map((item) => Center(
                  child: Text(
                    item,
                    style: kDarkTextStyle,
                  ),
                ))
            .toList(),
      ),
    );
  }

  void saveUserDetails(String uid, String username) async {
    setState(() {
      isLoading = true;
    });
    // start the loading
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection("userDetails")
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      var userId = userSnap.docs[userSnap.docs.length-1]['uid'];
      print(userId);
      // upload to storage and db
      String res = await FireStoreMethods().saveUserDetails(
          classes[classIndex],
          uid,
          gender[genderIndex],
          _schoolNameController.text,
          _educationNameController.text,
          _rollNoController.text,
          _homeStateController.text);
      if (res == "success") {
        setState(() {
          isLoading = false;
        });
        // ignore: use_build_context_synchronously
        showSnackBar(
          context,
          'Updated!',
        );
      } else {
        showSnackBar(context, res);
      }
    } catch (err) {
      setState(() {
        isLoading = false;
      });
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }
}

class EditFieldBox extends StatelessWidget {
  final String label;
  final String value;
  final Widget cupertino;
  const EditFieldBox({
    Key? key,
    required this.label,
    required this.value,
    required this.cupertino,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width * 0.9,
      height: 55,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: blueColor,
      ),
      child: Row(
        children: [
          Text(
            label,
            style: kLightTextStyle.copyWith(fontSize: 17),
          ),
          const SizedBox(width: 10),
          Text(
            value,
            style: kLightTextStyle.copyWith(fontSize: 17),
          ),
          IconButton(
              onPressed: () {
                showCupertinoModalPopup(
                    context: context,
                    builder: (context) => CupertinoActionSheet(
                          actions: [cupertino],
                          cancelButton: CupertinoActionSheetAction(
                            child: const Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ));
              },
              icon: const Icon(
                Icons.edit,
                color: Colors.white,
              )),
        ],
      ),
    );
  }
}
