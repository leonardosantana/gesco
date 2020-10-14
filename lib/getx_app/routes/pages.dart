

import 'package:gesco/app/order/new_order/new_order_page.dart';
import 'package:gesco/getx_app/build/detailed_build/detailed_build_page.dart';
import 'package:gesco/getx_app/build/new_build/new_build_page.dart';
import 'package:gesco/getx_app/home_page/home_page.dart';
import 'package:gesco/getx_app/routes/routes.dart';
import 'package:gesco/ui/application_page.dart';
import 'package:get/get.dart';

class Pages{
  static final routes = [
    GetPage(name: Routes.INITIAL, page:()=>ApplicationPage()),
    GetPage(name: Routes.HOME, page:()=>HomePage()),
    GetPage(name: Routes.DETAILED_BUILD, page:()=>DetailedBuildPage()),
    GetPage(name: Routes.NEW_BUILD, page:()=>NewBuildPage()),
    GetPage(name: Routes.NEW_ORDER, page:()=>NewOrderPage()),
  ];
}