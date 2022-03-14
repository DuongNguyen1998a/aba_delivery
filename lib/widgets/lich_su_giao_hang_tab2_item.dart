import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Text Content
import '../constants/text_content.dart';

class LichSuGiaoHangTab2Item extends StatelessWidget {
  final String atmShipmentId, customerCode, startTime, deliveryTime;
  final int isRightTime;
  final Function onItemClick;

  const LichSuGiaoHangTab2Item({
    Key? key,
    required this.atmShipmentId,
    required this.customerCode,
    required this.startTime,
    required this.deliveryTime,
    required this.isRightTime,
    required this.onItemClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        child: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            Text(
              atmShipmentId,
              textAlign: TextAlign.center,
              style: mTextStyle,
            ),
            Text(
              customerCode,
              textAlign: TextAlign.center,
              style: mTextStyle,
            ),
            const Divider(
              color: Colors.orangeAccent,
              height: 1,
              thickness: 1.5,
            ),
            Text(
              '${TextContent.duKien} ${DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.parse(startTime))}',
              style: mTextStyle,
            ),
            Text(
              '${TextContent.hoanThanh} ${DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.parse(deliveryTime))}',
              style: mTextStyle,
            ),
            const Divider(
              color: Colors.orangeAccent,
              height: 1.5,
              thickness: 1.5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                isRightTime == 1 ? TextContent.rightTime : TextContent.notRightTime,
                style: TextStyle(
                  color: isRightTime == 1 ? Colors.green : Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}
