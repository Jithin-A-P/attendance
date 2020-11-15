import 'package:flutter/material.dart';

class SmallRoundedButton extends StatelessWidget {
  final String title;
  final Color color;
  final Function onPressed;

  SmallRoundedButton({
    this.title,
    this.color,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      color: color,
      borderRadius: BorderRadius.circular(30.0),
      child: MaterialButton(
        onPressed: onPressed,
        minWidth: 150.0,
        height: 32.0,
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
