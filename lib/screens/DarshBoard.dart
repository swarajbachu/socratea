import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:socratea/screens/chat_area.dart';
import 'package:socratea/utils/colors.dart';

import '../providers/user_provider.dart';
import '../utils/styles.dart';
import '../utils/utils.dart';
import '../utils/widgets/basic_button.dart';


class DashBoard extends StatefulWidget {
  final String uid;
  const DashBoard({Key? key, required this.uid}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  var userData = {};
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
    UserProvider refresh = UserProvider();
    refresh.refreshUser();
    getData();
    setState(() {
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(
          'assets/logo.svg',
          color: primaryColor,
          height: 60,
        ),
          backgroundColor: blueColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Welcome Back ${userData['fullName']}',style: kDarkTextStyle.copyWith(fontSize: MediaQuery.of(context).size.width*0.065),),
              const SizedBox(height: 2,),
              Text('so where were we?',style: kDarkTextStyle.copyWith(fontSize: 20,color: Colors.grey.shade700),),
              const SizedBox(height: 20,),
              Text('  Your Recommended Careers',style: kDarkTextStyle.copyWith(fontSize: 15),),
              const SizedBox(height: 10,),
              Container(
                padding: const EdgeInsets.all(20),
                alignment: Alignment.topLeft,
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kLightColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: const [
                    PredictedCourse(courseName: 'Engineering', percentage: '70',),
                    PredictedCourse(courseName: 'Arts', percentage: '60',),
                    PredictedCourse(courseName: 'Commerce', percentage: '50',),
                    PredictedCourse(courseName: 'Design', percentage: '30',),
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              Text(' Not Satisfied witht the results?',style: kDarkTextStyle.copyWith(fontSize: 20,color: Colors.grey.shade700),),
              const SizedBox(height: 10,),
              BasicButton(text: 'Try Again', onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const ChatArea())),),
              const SizedBox(height: 20,),
              Text(' Your Recommended Colleges',style: kDarkTextStyle.copyWith(fontSize: 15),),
              const SizedBox(height: 10,),
              Container(
                height: 150,
                padding: const EdgeInsets.all(20),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text('Unlock College Recommendations with Socratea Pro',style: kDarkTextStyle.copyWith(fontSize: 15,color: Colors.grey.shade700,),textAlign: TextAlign.center,),
              )
            ],
          )
        ),
      ),

    );
  }
}



class PredictedCourse extends StatelessWidget {
  final String courseName;
  final String percentage;
  const PredictedCourse({
    Key? key, required this.courseName, required this.percentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: Row(
        children: [
          Text('${courseName}',style: kDarkTextStyle.copyWith(fontSize: 17,color: Colors.black87),),
          const Spacer(),
          CircleAvatar(
            radius: 10,
            backgroundColor: Colors.green.shade900,
          ),
          const SizedBox(width: 5,),
          Text('${percentage}%',style: kDarkTextStyle.copyWith(fontSize: 17,color: Colors.black87),),
        ],
      ),
    );
  }
}
