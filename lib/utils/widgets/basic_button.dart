import 'package:flutter/material.dart';

import '../colors.dart';
import '../styles.dart';


class BasicButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  const BasicButton({
    Key? key, required this.text,required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(

        decoration: BoxDecoration(
          color: blueColor,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(vertical: 13,horizontal: 20),
        child: Text(text,style: kLightTextStyle.copyWith(fontSize: 15),),
      ),
    );
  }
}