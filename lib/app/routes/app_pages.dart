import 'package:get/get.dart';
import 'package:seguros_viajes/app/routes/app_routes.dart';
import 'package:seguros_viajes/app/ui/pages/home_page/home_page.dart';
import 'package:seguros_viajes/app/ui/pages/option_configuration_page/option_configuration_page.dart';
import 'package:seguros_viajes/app/ui/pages/splash/splash_page.dart';

abstract class AppPages {
  static final pages = [
    GetPage(name: Routes.home, page: () => HomePage()),
    GetPage(name: Routes.setting, page: () => OptionConfigurationPage()),
    GetPage(name: Routes.splash, page: () => const SplashPage()),
  ];
}
