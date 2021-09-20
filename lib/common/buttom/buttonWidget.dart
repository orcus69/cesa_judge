import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {

  final String text;
  final Color color;
  final Color textColor;
  final VoidCallback onClicked;
  final bool? isLoading;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
    required this.color,
    required this.textColor,
    this.isLoading = false,
    }
    
  ):super(key: key);

  @override
  Widget build(BuildContext context){

    bool isLoaded = isLoading!;
    
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: color,
        minimumSize: Size.fromHeight(50),
        shape: StadiumBorder()
      ),
      child: FittedBox(
        child: isLoading! ? CircularProgressIndicator(color: Colors.white,) : Text(
          text, 
          style: TextStyle(fontSize: 20, color: textColor),
        ),
      ),
      onPressed: onClicked,
    );

  }
}