import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:socratea/utils/colors.dart';



class XpBar extends StatelessWidget {
  final int xpPercent;
  final double barWidth;
  XpBar({
    Key? key, required this.xpPercent, this.barWidth = 190,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
            padding: const EdgeInsets.all(0),
            child: LinearPercentIndicator(
              lineHeight: 25,
              percent: xpPercent / 100,
              progressColor: blueColor,
              backgroundColor: Colors.blue.shade100,
              width: barWidth,
              barRadius: const Radius.circular(20),
            )),
      ],
    );
  }
}