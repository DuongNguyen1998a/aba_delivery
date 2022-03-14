import 'package:flutter/material.dart';

// Widgets
import '../widgets/payment_order_list_image.dart';
import '../widgets/payment_order_list_detail.dart';

class DeNghiThanhToanDetailScreen extends StatelessWidget {
  const DeNghiThanhToanDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            PaymentOrderListImage(),
            PaymentOrderListDetail(),
          ],
        ),
      ),
    );
  }
}
