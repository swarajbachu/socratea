import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';


class ChatArea extends StatefulWidget {
  const ChatArea({Key? key}) : super(key: key);

  @override
  State<ChatArea> createState() => _ChatAreaState();
}


class _ChatAreaState extends State<ChatArea> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Text('Chat Area'),
    );
  }
}
