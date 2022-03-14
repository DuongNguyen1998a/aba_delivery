import 'package:flutter/material.dart';

class YearMonthPicker extends StatelessWidget {
  const YearMonthPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 80,
      child: LayoutBuilder(
        builder: (context, constraints) => ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          child: Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight * 0.5,
            color: Colors.white,
            child: ListView.builder(
              itemCount: 12,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('${index + 1}'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
