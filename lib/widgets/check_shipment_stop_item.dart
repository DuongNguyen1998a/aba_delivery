import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheckShipmentStopItem extends StatelessWidget {
  final String storeCode, storeName, addressLine;

  const CheckShipmentStopItem({
    Key? key,
    required this.storeCode,
    required this.storeName,
    required this.addressLine,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const mTextStyle = TextStyle(
      fontWeight: FontWeight.w600,
      color: Colors.blueGrey,
    );
    const mTextStyle16 = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: Colors.blueGrey,
    );
    const mTextStyle14 = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: Colors.blueGrey,
    );
    return Card(
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              storeCode,
              style: mTextStyle16,
              textAlign: TextAlign.center,
            ),
            Text(
              storeName,
              style: mTextStyle14,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              addressLine,
              style: mTextStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
