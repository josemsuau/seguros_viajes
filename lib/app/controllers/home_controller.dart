
import 'package:get/get.dart';
import 'package:seguros_viajes/app/controllers/communtravel_controller.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find<HomeController>();
  // final CommuntravelController communTravelController = CommuntravelController();

  RxInt pageView = RxInt(0);
  RxBool visibilityBottomCuba = RxBool(true);
  RxBool visibilityBottomWorld = RxBool(true);

  void changeVisibilityBottom(int type){
    if (type == 1) {
      visibilityBottomCuba.value = true;
      visibilityBottomWorld.value = false;
    } else if(type == 2){
      visibilityBottomCuba.value = false;
      visibilityBottomWorld.value = true;
    }
  }  

  void clearDataView (CommuntravelController _){
    _.infoDate.value = '';
    _.infoImporte.value = '';
    _.stateRadioA.value = false;
    _.stateRadioB.value = false;
    _.stateRadioC.value = false;
    _.valueStatusPersonMore.value = '1';
    _.infoImporteTotal.value = '';
  }
}
  