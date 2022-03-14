import 'package:flutter/material.dart';

class HomeHeaderButton extends StatelessWidget {
  final bool btnValue;
  final String btnContent;
  final Function btnClick;
  const HomeHeaderButton({Key? key, required this.btnContent, required this.btnValue, required this.btnClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        btnValue ? null : btnClick();
      },
      child: Text(
        btnContent,
        style: TextStyle(
          color: btnValue ? Colors.white : Colors.black,
        ),
      ),
      style: ElevatedButton.styleFrom(
        primary: btnValue ? Colors.green : Colors.white,
      ),
    );
  }
}
