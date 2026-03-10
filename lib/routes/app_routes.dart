import 'package:get/get.dart';
import 'package:todo_listapp/routes/app_pages.dart';

import '../modules/auth/view/login_view.dart';
import '../modules/auth/view/signup_view.dart';
import '../modules/tasks/view/task_list_view.dart';



class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.login, page: () => LoginView()),
    GetPage(name: AppRoutes.signup, page: () => SignupView()),
    GetPage(name: AppRoutes.tasks, page: () => TaskListView()),
  ];
}