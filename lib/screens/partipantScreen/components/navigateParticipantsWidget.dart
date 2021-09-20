import 'package:flutter/material.dart';

class NavigateParticipantsWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClickedNext;
  final VoidCallback onClickedPrevious;

  const NavigateParticipantsWidget({
    Key? key,
    required this.text,
    required this.onClickedNext,
    required this.onClickedPrevious,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: onClickedPrevious, 
          icon: Icon(Icons.navigate_before, color: Colors.white,),
          iconSize: 48,
        ),

        Text(
          text,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          textAlign: TextAlign.center,
        ),

        IconButton(
          onPressed: onClickedNext, 
          icon: Icon(Icons.navigate_next, color: Colors.white,),
          iconSize: 48,
        ),

      ],
    );
  }
}