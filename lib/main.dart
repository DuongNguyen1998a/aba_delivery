import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// Themes
import '../constants/light_theme.dart';
// Controllers
import '../controllers/auth_controller.dart';
import '../controllers/location_controller.dart';
import '../views/auth_screen.dart';
// Screens
import '../views/home_screen.dart';
import '../views/splash_screen.dart';
// App Routes
import 'constants/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);

  // PackageInfo packageInfo = await PackageInfo.fromPlatform();
  // //var versionAppResponse = await AuthService.checkVersionApp();
  // var versionAppResponse = '1.0.1+3';
  //
  // debugPrint(packageInfo.buildNumber);
  // debugPrint(packageInfo.version);
  //
  // if (versionAppResponse != '${packageInfo.version}+${packageInfo.buildNumber}') {
  //   debugPrint('Wrong version.');
  //   Get.to(const
  // }
  // else {
  //   debugPrint('Right version');
  // }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // call auth controller to re sign in
    final AuthController authController = Get.put(AuthController());
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: () => GetMaterialApp(
        theme: LightTheme().lightTheme,
        localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
        home: FutureBuilder(
          future: authController.reSignedIn(),
          builder: (context, AsyncSnapshot snapShot) {
            if (snapShot.hasData && snapShot.data) {
              return const HomeScreen();
            } else if (snapShot.hasError && !snapShot.data) {
              return const AuthScreen();
            } else {
              return const SplashScreen();
            }
          },
        ),
        builder: (context, widget) {
          // Init Controllers
          Get.put(LocationController());
          ScreenUtil.setContext(context);
          return MediaQuery(
            //Setting font does not change with system font size
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: widget!,
          );
        },
        getPages: AppRoutes.pages,
        debugShowCheckedModeBanner: false,
        //smartManagement: SmartManagement.keepFactory,
      ),
    );
  }
}
