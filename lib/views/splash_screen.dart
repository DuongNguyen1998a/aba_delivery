import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_aba_delivery_app_getx/services/auth_service.dart';
import 'package:get/get.dart';

// App Routes
import '../constants/app_routes.dart';

// Controllers
import '../controllers/auth_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthController authController = Get.find<AuthController>();
  String result = '';

  @override
  void initState() {
    authController.getVersionApp().then((value) => setState(() {result = value;}));
    authController.checkVersionApp().then((value) => {
          if (value)
            {
              authController.reSignedIn().then(
                    (bool result) => result
                        ? Get.offNamed(AppRoutes.homeLink)
                        : Get.offNamed(AppRoutes.authLink),
                  )
            }
          else
            {
              Get.off(
                () => Scaffold(
                  body: SafeArea(
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              './assets/images/img.png',
                            ),
                            fit: BoxFit.cover),
                      ),
                      child: Center(
                        child: SizedBox(
                          height: 150,
                          child: Card(
                            elevation: 8,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Vui lòng xóa app hiện tại và cài đặt app version mới nhất.',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                                    },
                                    child: const Text('Ok'),
                                  ),
                                  Text('Current version: $result'),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            }
        });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  './assets/images/img.png',
                ),
                fit: BoxFit.cover),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Image.asset(
                './assets/images/logo_resize.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
