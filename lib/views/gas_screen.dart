import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Constants
import '../constants/text_content.dart';
import '../constants/app_routes.dart';

// Controllers
import '../controllers/auth_controller.dart';
import '../controllers/gas_controller.dart';

// Widgets
import '../widgets/app_drawer.dart';

class GasScreen extends StatelessWidget {
  const GasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find<AuthController>();
    GasController gasController = Get.put(GasController());
    // authController = Get.isRegistered<AuthController>()
    //     ? Get.find<AuthController>()
    //     : Get.put(AuthController());
    //
    // gasController = Get.isRegistered<GasController>()
    //     ? Get.find<GasController>()
    //     : Get.put(GasController());

    void signOut() async {
      await authController.signOut();
    }

    void sendRequestGas() {
      gasController.sendRequestGas(context);
    }

    const mTextStyle = TextStyle(
        color: Colors.blueGrey, fontSize: 16, fontWeight: FontWeight.w500);

    return Scaffold(
      appBar: AppBar(
        title: const Text(TextContent.titleGas),
      ),
      drawer: Obx(
        () => AppDrawer(
          fullName: authController.auth.first.fullName,
          position: authController.auth.first.position,
          isBiker: authController.auth.first.isBiker,
          driverId: authController.auth.first.driverId,
          signOut: signOut,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
        child: Form(
          key: gasController.formKeys[0],
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Obx(
                  () => Text(
                    'Số xe : ${gasController.gasLimit.isNotEmpty ? gasController.gasLimit.single.powerUnit : ''}',
                    style: mTextStyle,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Obx(
                  () => Text(
                    'Hạn mức : ${gasController.gasLimit.isNotEmpty ? gasController.gasLimit.single.gasLimit : '0'}',
                    style: mTextStyle,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: TextContent.note,
                    prefixIcon: Icon(Icons.edit),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 1),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 1),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 1),
                    ),
                  ),
                  maxLines: 2,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Ghi chú không được bỏ trống.';
                    }
                    return null;
                  },
                  onSaved: (val) {
                    gasController.note.value = val!;
                  },
                  controller: gasController.noteController,
                ),
                const SizedBox(
                  height: 16,
                ),
                Obx(
                  () => Text(
                    gasController.gasLimit.isNotEmpty
                        ? gasController.convertReqStatusToText(
                            gasController.gasLimit.single.reqStatus ?? 0,
                            gasController.gasLimit.single.checkExists ?? 0)
                        : '',
                    style: mTextStyle,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Obx(
                        () => gasController.isLoadingSendRequest.value
                            ? const Center(child: CircularProgressIndicator())
                            : ElevatedButton(
                                onPressed: () {
                                  sendRequestGas();
                                },
                                child: const Text(
                                  'Gửi\nyêu cầu',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          gasController.fetchGasTicket();
                        },
                        child: const Text(
                          'Xem\nyêu cầu',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          gasController.fetchGasTicketHistory().then(
                              (_) => Get.toNamed(AppRoutes.gasTicketLink));
                        },
                        child: const Text(
                          'Phiếu\ncủa tôi',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
