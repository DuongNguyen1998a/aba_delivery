import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LicenseItem extends StatelessWidget {
  final String atmShipmentId,
      customerCode,
      startTime,
      dateOfFiling,
      statusManager,
      created;
  final Function onItemClick;

  const LicenseItem({
    Key? key,
    required this.atmShipmentId,
    required this.customerCode,
    required this.startTime,
    required this.dateOfFiling,
    required this.statusManager,
    required this.created,
    required this.onItemClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const mTextStyle600 = TextStyle(
      fontWeight: FontWeight.w600,
      color: Colors.blueGrey,
      fontSize: 14,
    );
    const mTextStyle500 = TextStyle(
      fontWeight: FontWeight.w500,
      color: Colors.blueGrey,
      fontSize: 14,
    );

    return GestureDetector(
      onTap: () {
        onItemClick();
      },
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                '$atmShipmentId $customerCode',
                textAlign: TextAlign.center,
                style: mTextStyle600,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Chuyến ngày: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(startTime))}',
                style: mTextStyle500,
              ),
              Text(
                'Ngày hẹn nộp: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(dateOfFiling))}',
                style: mTextStyle500,
              ),
              Text(
                'Trạng thái: $statusManager',
                style: mTextStyle500,
              ),
              Text(
                'Tạo lúc: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(created))}',
                style: mTextStyle500,
                textAlign: TextAlign.right,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
