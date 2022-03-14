import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LsghDatePicker extends StatelessWidget {
  final Function openDatePicker;
  final DateTime dateTimeValue;

  const LsghDatePicker({
    Key? key,
    required this.openDatePicker,
    required this.dateTimeValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      margin: const EdgeInsets.all(8),
      child: TextButton(
        onPressed: () {
          openDatePicker();
        },
        child: Text(
          DateFormat('MM / yyyy').format(dateTimeValue),
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Colors.blueGrey,
          ),
        ),
      ),
    );
  }
}
