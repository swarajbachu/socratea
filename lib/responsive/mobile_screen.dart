import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socratea/providers/user_provider.dart';

import '../utils/colors.dart';
import '../utils/utils.dart';


class MobileScreenLayout extends StatefulWidget {
  final String uid;
  const MobileScreenLayout({Key? key, required this.uid}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
  late PageController pageController;// for tabs animation

  var userData ={};
  bool isLoading = false;

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


  @override
  void initState() {
    getData();
    super.initState();
    pageController = PageController();
  }

  addData() async{
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page) {
    //Animating Page
    pageController.jumpToPage(page);
  }
  int index = 0;
  GlobalKey<CurvedNavigationBarState> navigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: homeScreenItems[index],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: navigationKey,
        backgroundColor: Colors.transparent,
        color: kDarkPrimaryColor,
        buttonBackgroundColor: blueColor,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        items: const <Widget>[
          Icon(Icons.home, size: 30,color: primaryColor),
          Icon(Icons.chat_bubble, size: 30,color: primaryColor),
          Icon(Icons.person, size: 30,color: primaryColor),
        ],
        onTap: (index) {
          setState(() {
            this.index = index;
          });
        },
      ),
    );
  }
}
