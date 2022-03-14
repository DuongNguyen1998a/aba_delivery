import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LichSuGiaoHangTab1Item extends StatelessWidget {
  final String atmShipmentId, transDate, status;
  final double salary;
  final Function onItemClick;

  const LichSuGiaoHangTab1Item({
    Key? key,
    required this.atmShipmentId,
    required this.transDate,
    required this.status,
    required this.salary,
    required this.onItemClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.currency(locale: 'vi_VN');

    const mTextStyle = TextStyle(
      color: Colors.blueGrey,
      fontWeight: FontWeight.w600,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat('dd/MM/yyyy').format(DateTime.parse(transDate)),
                style: mTextStyle,
              ),
              Text(
                atmShipmentId,
                style: mTextStyle,
              ),
              Text(
                status,
                style: mTextStyle,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    formatCurrency.format(salary),
                    style: const TextStyle(
                      color: Colors.orangeAccent,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
