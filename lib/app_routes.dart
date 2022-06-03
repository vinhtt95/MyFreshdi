import 'package:get/get.dart';

import 'modules/add_transaction/views/add_transaction_view.dart';
import 'modules/home/views/home_page.dart';


abstract class Routes {
  static const HOMEPAGE = '/homepage';
  static const ADD_TRANSACTION = '/add_transaction';
}

/* * Routes cho app
* Dùng được để deep link
! Giá trị truyền vào giống với uri
? https://github.com/jonataslaw/getx/blob/master/documentation/en_US/route_management.md
* */
class AppRoutes {
  static const INITIAL = Routes.HOMEPAGE;
  static final List<GetPage> routes = [
    GetPage(name: Routes.HOMEPAGE, page: () => HomePage()),
    GetPage(name: Routes.ADD_TRANSACTION, page: () => AddTransactionView()),
  ];
}
