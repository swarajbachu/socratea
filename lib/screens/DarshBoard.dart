import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:socratea/utils/colors.dart';

import '../utils/styles.dart';


class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
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
      body: Container(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(' Welcome Back Tanisha',style: kDarkTextStyle.copyWith(fontSize: 25),),
            const SizedBox(height: 2,),
            Text('  so where were we?',style: kDarkTextStyle.copyWith(fontSize: 20,color: Colors.grey.shade700),),
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
            GestureDetector(
              onTap: (){},
              child: Container(

                decoration: BoxDecoration(
                  color: blueColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 13,horizontal: 20),
                child: Text('Try again',style: kLightTextStyle.copyWith(fontSize: 15),),
              ),
            ),
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
