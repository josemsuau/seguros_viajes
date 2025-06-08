
import 'package:get/get.dart';
import '../controllers/communtravel_controller.dart';


class CommuntravelBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommuntravelController>(() => CommuntravelController());
  }
}