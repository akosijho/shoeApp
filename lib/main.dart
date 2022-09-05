import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_shoe_app/app/app.locator.dart';
import 'package:flutter_shoe_app/app/app.router.dart';
import 'package:flutter_shoe_app/utils/my_theme_data.dart';
import 'package:flutter_shoe_app/views/splash_screen/splash_screen_view_model.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'core/services/navigation/navigation_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  //Get.put(MyAppController());
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async {
        final SplashScreenViewModel splashScreenViewModel = locator<SplashScreenViewModel>();
    runApp(GetMaterialApp(
      theme:MyThemes.light,
     darkTheme: MyThemes.dark,
      // themeMode: ThemeMode.system,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: locator<NavigationService>().navigatorKey,
      title: "Shoe App",
      onDispose:() => splashScreenViewModel.disposeStreams(),
    ));
  });
}
