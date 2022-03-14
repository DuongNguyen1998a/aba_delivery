import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Text Content
import '../constants/text_content.dart';

// Controllers
import '../controllers/payment_order_controller.dart';

class PaymentOrderListImage extends StatelessWidget {
  const PaymentOrderListImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PaymentOrderController poController;
    poController = Get.isRegistered<PaymentOrderController>()
        ? Get.find<PaymentOrderController>()
        : Get.put(PaymentOrderController());
    final widthOfScreen = MediaQuery.of(context).size.width;
    final heightOfScreen = MediaQuery.of(context).size.height;

    return SizedBox(
      width: widthOfScreen * 1,
      height: heightOfScreen * 0.4,
      child: Obx(
        () => poController.isLoadingImage.value
            ? const Center(child: CircularProgressIndicator())
            : !poController.isLoadingImage.value &&
                    poController.paymentOrderDetailImageList.isEmpty
                ? const Center(
                    child: Text(
                      TextContent.noImageFound,
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    key: UniqueKey(),
                    cacheExtent: 10,
                    itemCount: poController.paymentOrderDetailImageList.length,
                    itemBuilder: (context, index) => SizedBox(
                      width: widthOfScreen,
                      child: Image.network(
                        '${TextContent.imageUrl}${poController.paymentOrderDetailImageList[index].attachName}',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
      ),
    );
  }
}
