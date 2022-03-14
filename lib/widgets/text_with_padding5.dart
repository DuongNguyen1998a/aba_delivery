import 'package:flutter/material.dart';

class TextWithPadding5 extends StatelessWidget {
  final String value;
  final TextStyle mTextStyle;
  final TextAlign textAlign;

  const TextWithPadding5(
      {Key? key,
      required this.value,
      required this.mTextStyle,
      required this.textAlign})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Text(
        value,
        textAlign: textAlign,
        style: mTextStyle,
      ),
    );
  }
}
