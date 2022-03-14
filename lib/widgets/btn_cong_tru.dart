import 'package:flutter/material.dart';

class BtnCongTru extends StatelessWidget {
  final bool checkBoxValue;
  final String checkBoxTitle;
  final int currentValue;
  final Function onMinus;
  final Function onPlus;
  final Function onChangedCheckBox;

  const BtnCongTru({
    Key? key,
    required this.checkBoxValue,
    required this.checkBoxTitle,
    required this.currentValue,
    required this.onMinus,
    required this.onChangedCheckBox,
    required this.onPlus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
            value: checkBoxValue,
            onChanged: (bool? value) {
              onChangedCheckBox(value);
            }),
        Text(checkBoxTitle),
        IconButton(
          onPressed: () {
            onMinus();
          },
          icon: const Icon(Icons.remove),
        ),
        Text(
          currentValue.toString(),
        ),
        IconButton(
          onPressed: () {
            onPlus();
          },
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
