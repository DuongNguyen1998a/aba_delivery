import 'package:flutter/material.dart';
import 'package:flutter_aba_delivery_app_getx/controllers/chuyenxe_controller.dart';
import 'package:get/get.dart';

class TuChoiShipmentModal extends StatelessWidget {
  final String atmShipmentId, routeNo;
  final DateTime deliveryDate;

  const TuChoiShipmentModal(
      {Key? key,
      required this.atmShipmentId,
      required this.routeNo,
      required this.deliveryDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ChuyenXeController chuyenXeController =
        Get.find<ChuyenXeController>();
    return LayoutBuilder(
      builder: (context, constraints) => ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        child: Container(
          width: constraints.maxWidth,
          height: constraints.maxHeight * 0.6,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Form(
              key: chuyenXeController.deniedShipmentKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Lí do từ chối',
                        prefixIcon: Icon(Icons.edit),
                      ),
                      validator: (val) {
                        return chuyenXeController
                            .validateReasonDeniedShipment(val!);
                      },
                      onSaved: (val) {
                        chuyenXeController.reasonDeniedShipment.value = val!;
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Obx(
                          () => chuyenXeController.isLoading.value
                              ? const CircularProgressIndicator()
                              : ElevatedButton(
                                  onPressed: () {
                                    chuyenXeController.deniedShipment(
                                      atmShipmentId,
                                      deliveryDate,
                                      routeNo,
                                      chuyenXeController
                                          .reasonDeniedShipment.value,
                                      context,
                                    );
                                  },
                                  child: const Text('Xác nhận'),
                                ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
