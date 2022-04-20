import 'package:zartech/checkout/chekout_page.dart';
import 'package:zartech/login/login_page.dart';
import 'package:auto_route/auto_route.dart';

import 'home/home_page.dart';
import 'splash/splash_page.dart';

@MaterialAutoRouter(replaceInRouteName: 'Page,Route', routes: <AutoRoute>[
  AutoRoute(page: SplashPage, initial: true),
  AutoRoute(page: LoginPage),
  AutoRoute(page: HomePage),
  AutoRoute(page: CheckoutPage),
])
class $AppRouter {}
